package levels
{
   import entities.Entity;
   import entities.Hero;
   import entities.SmallCatHero;
   import flash.geom.Rectangle;
   
   public class LevelPhysics
   {
       
      
      public var level:Level;
      
      public var gravity:Number;
      
      public var TOP_MARGIN:Number;
      
      public var LEFT_MARGIN:*;
      
      public var RIGHT_MARGIN:Number;
      
      protected var avoidHorCollision:Boolean;
      
      protected var avoidTopVerCollision:Boolean;
      
      protected var aabb_cloud:Rectangle;
      
      protected var aabb_solid:Rectangle;
      
      protected var last_collision_x_value:int;
      
      public function LevelPhysics(_level:Level)
      {
         super();
         this.level = _level;
         this.gravity = 0.6;
         this.LEFT_MARGIN = 0;
         this.RIGHT_MARGIN = 4096;
         this.TOP_MARGIN = 0;
         this.avoidHorCollision = this.avoidTopVerCollision = false;
         this.last_collision_x_value = 0;
         this.aabb_cloud = new Rectangle();
         this.aabb_solid = new Rectangle();
      }
      
      public function destroy() : void
      {
         this.aabb_solid = null;
         this.aabb_cloud = null;
         this.level = null;
      }
      
      public function collisionDetectionMap(entity:Entity) : void
      {
         var aabb:Rectangle = null;
         if(entity.AVOID_COLLISION_DETECTION)
         {
            return;
         }
         this.avoidHorCollision = this.avoidTopVerCollision = false;
         if(entity is Hero)
         {
            this.TOP_MARGIN = this.level.camera.TOP_MARGIN;
            this.LEFT_MARGIN = this.level.camera.LEFT_MARGIN;
            this.RIGHT_MARGIN = this.level.camera.RIGHT_MARGIN;
            if(this.level.stateMachine.currentState == "IS_EXITING_LEVEL_STATE")
            {
               this.avoidHorCollision = true;
               this.avoidTopVerCollision = true;
               this.level.hero.gravity_friction = 0;
            }
            else if(this.level.hero.stateMachine.currentState == "IS_HOPPING_STATE")
            {
               this.avoidHorCollision = true;
            }
         }
         else
         {
            this.TOP_MARGIN = 0;
            this.LEFT_MARGIN = 0;
            this.RIGHT_MARGIN = 4096;
         }
         this.aabb_cloud.x = entity.xPos + entity.aabbPhysics.x + entity.aabbPhysics.width * 0.5 - 1;
         this.aabb_cloud.y = Math.ceil(entity.yPos) + entity.aabbPhysics.y;
         this.aabb_cloud.width = 2;
         this.aabb_cloud.height = entity.aabbPhysics.height;
         if(entity is Hero)
         {
            this.aabb_solid.x = entity.xPos + entity.aabbPhysics.x;
            this.aabb_solid.y = Math.ceil(entity.yPos) + entity.aabbPhysics.y;
            this.aabb_solid.width = entity.aabbPhysics.width;
            this.aabb_solid.height = entity.aabbPhysics.height;
         }
         else
         {
            this.aabb_solid.x = entity.xPos + entity.aabbPhysics.x;
            this.aabb_solid.y = entity.yPos + entity.aabbPhysics.y;
            this.aabb_solid.width = entity.aabbPhysics.width;
            this.aabb_solid.height = entity.aabbPhysics.height;
         }
         entity.wasOnCloudTile = false;
         if(entity.yVel >= 0)
         {
            aabb = this.aabb_cloud;
            if(this.collision_y_down(entity,aabb))
            {
               entity.groundCollision();
            }
            else if(!this.isEntityOnGround(entity))
            {
               aabb = this.aabb_solid;
               if(this.collision_y_down(entity,this.aabb_solid))
               {
                  entity.groundCollision();
               }
               else
               {
                  entity.noGroundCollision();
               }
            }
         }
         else if(entity.yVel < 0 && !entity.AVOID_CEIL_COLLISION_DETECTION)
         {
            aabb = this.aabb_solid;
            if(!this.avoidTopVerCollision)
            {
               if(this.collision_y_up(entity,this.aabb_solid))
               {
                  entity.ceilCollision();
               }
            }
         }
         aabb = new Rectangle(entity.xPos + entity.aabbPhysics.x,Math.ceil(entity.yPos) + entity.aabbPhysics.y + 2,entity.aabbPhysics.width,entity.aabbPhysics.height - 4);
         if(!entity.wasOnCloudTile && !this.avoidHorCollision)
         {
            if(entity.xVel > 0)
            {
               if(this.collision_x_right(entity,aabb))
               {
                  entity.wallCollision(this.last_collision_x_value);
               }
            }
            else if(entity.xVel < 0)
            {
               if(this.collision_x_left(entity,aabb))
               {
                  entity.wallCollision(this.last_collision_x_value);
               }
            }
         }
         if(entity is Hero && this.level.stateMachine.currentState != "IS_EXITING_LEVEL_STATE")
         {
            if(entity.xPos < this.LEFT_MARGIN)
            {
               entity.xPos = this.LEFT_MARGIN + 1;
               entity.xVel = 0;
            }
            else if(entity.xPos + entity.WIDTH > this.RIGHT_MARGIN)
            {
               entity.xPos = this.RIGHT_MARGIN - entity.WIDTH - 1;
               entity.xVel = 0;
            }
         }
      }
      
      protected function collision_y_down(entity:Entity, aabb:Rectangle) : Boolean
      {
         if(!this.isEntityOnGround(entity))
         {
            return false;
         }
         if(entity.yPos <= this.TOP_MARGIN)
         {
            return false;
         }
         var y_t:int = int((aabb.y + aabb.height) / Utils.TILE_HEIGHT);
         if(this.check_collision_y_down(entity,aabb,y_t))
         {
            return true;
         }
         return false;
      }
      
      protected function check_collision_y_down(entity:Entity, aabb:Rectangle, y_t:int, recursion:Boolean = false) : Boolean
      {
         var i:int = 0;
         var x_t:int = 0;
         var tile_value:int = 0;
         var start_x:int = aabb.x;
         var end_x:int = aabb.width;
         for(i = 0; i < end_x; i++)
         {
            x_t = int((start_x + i) / Utils.TILE_WIDTH);
            tile_value = this.level.levelData.getTileValueAt(x_t,y_t);
            if(this.isCollisionY(tile_value) && this.isGroundTile(x_t,y_t) && this.isInsideCollisionY(aabb,tile_value,x_t,y_t,start_x + i))
            {
               if(this.isCloud(tile_value))
               {
                  this.yCollisionResponse(entity,start_x + i,x_t,y_t,tile_value);
                  entity.wasOnCloudTile = this.isCloud(tile_value);
                  entity.wasOnSlopeTile = this.isSlope(tile_value);
                  return true;
               }
               if(recursion)
               {
                  return false;
               }
               this.yCollisionResponse(entity,start_x + i,x_t,y_t,tile_value);
               entity.wasOnCloudTile = this.isCloud(tile_value);
               entity.wasOnSlopeTile = this.isSlope(tile_value);
               y_t--;
               this.check_collision_y_down(entity,aabb,y_t,true);
               return true;
            }
         }
         return false;
      }
      
      protected function collision_y_up(entity:Entity, aabb:Rectangle) : Boolean
      {
         if(entity.yPos <= this.TOP_MARGIN)
         {
            return true;
         }
         var y_t:int = int(aabb.y / Utils.TILE_HEIGHT);
         if(this.check_collision_y_up(entity,aabb,y_t))
         {
            return true;
         }
         return false;
      }
      
      protected function check_collision_y_up(entity:Entity, aabb:Rectangle, y_t:int, recursion:Boolean = false) : Boolean
      {
         var i:int = 0;
         var x_t:int = 0;
         var tile_value:int = 0;
         var start_x:int = aabb.x - 8;
         var end_x:int = aabb.width + 16;
         for(i = 0; i < end_x; i++)
         {
            x_t = int((start_x + i) / Utils.TILE_WIDTH);
            tile_value = this.level.levelData.getTileValueAt(x_t,y_t);
            if(this.isTopCollisionY(tile_value))
            {
               if(this.isCloud(tile_value))
               {
                  this.yCollisionResponseUp(entity,start_x + i,x_t,y_t,tile_value);
                  entity.wasOnCloudTile = this.isCloud(tile_value);
                  entity.wasOnSlopeTile = this.isSlope(tile_value);
                  return true;
               }
               if(recursion)
               {
                  return false;
               }
               this.yCollisionResponseUp(entity,start_x + i,x_t,y_t,tile_value);
               entity.wasOnCloudTile = this.isCloud(tile_value);
               entity.wasOnSlopeTile = this.isSlope(tile_value);
               y_t++;
               this.check_collision_y_up(entity,aabb,y_t,true);
               return true;
            }
         }
         return false;
      }
      
      protected function collision_x_right(entity:Entity, aabb:Rectangle) : Boolean
      {
         var i:int = 0;
         var x_t:int = 0;
         var y_t:int = 0;
         var top_value:int = 0;
         if(entity.yPos <= this.TOP_MARGIN)
         {
            return false;
         }
         x_t = int((aabb.x + aabb.width) / Utils.TILE_WIDTH);
         var start_y:int = aabb.y;
         var end_y:int = aabb.height;
         for(i = 0; i < end_y; i++)
         {
            y_t = int((start_y + i) / Utils.TILE_HEIGHT);
            top_value = this.level.levelData.getTileValueAt(x_t,y_t - 1);
            if(this.isCollisionX(this.level.levelData.getTileValueAt(x_t,y_t)) && (top_value == 1 || top_value == 0 || top_value == 11 || top_value == 16 || top_value == 12 || top_value == 13 || top_value == 14 || top_value == 5 || top_value == 4))
            {
               entity.xPos = x_t * Utils.TILE_WIDTH - (aabb.width + entity.aabbPhysics.x);
               if(this.level.levelData.getTileValueAt(x_t,y_t) == 13 || this.level.levelData.getTypeTileValueAt(x_t,y_t) == 1)
               {
                  entity.setInIce(true);
               }
               else
               {
                  entity.setInIce(false);
               }
               return true;
            }
         }
         if(aabb.x + aabb.width >= this.RIGHT_MARGIN)
         {
            entity.xPos = this.RIGHT_MARGIN - (aabb.width + entity.aabbPhysics.x);
            return true;
         }
         return false;
      }
      
      protected function collision_x_left(entity:Entity, aabb:Rectangle) : Boolean
      {
         var i:int = 0;
         var y_t:int = 0;
         var top_value:int = 0;
         if(entity.yPos <= this.TOP_MARGIN)
         {
            return false;
         }
         var x_t:int = int(aabb.x / Utils.TILE_WIDTH);
         var start_y:int = aabb.y;
         var end_y:int = aabb.height;
         for(i = 0; i < end_y; i++)
         {
            y_t = int((start_y + i) / Utils.TILE_HEIGHT);
            top_value = this.level.levelData.getTileValueAt(x_t,y_t - 1);
            if(this.isCollisionX(this.level.levelData.getTileValueAt(x_t,y_t)) && (top_value == 1 || top_value == 0 || top_value == 11 || top_value == 16 || top_value == 12 || top_value == 13 || top_value == 14 || top_value == 5 || top_value == 4))
            {
               entity.xPos = (x_t + 1) * Utils.TILE_WIDTH - entity.aabbPhysics.x;
               if(this.level.levelData.getTileValueAt(x_t,y_t) == 13 || this.level.levelData.getTypeTileValueAt(x_t,y_t) == 1)
               {
                  entity.setInIce(true);
               }
               else
               {
                  entity.setInIce(false);
               }
               return true;
            }
         }
         if(aabb.x <= this.LEFT_MARGIN)
         {
            entity.xPos = this.LEFT_MARGIN - entity.aabbPhysics.x;
            return true;
         }
         return false;
      }
      
      protected function yCollisionResponse(entity:Entity, xPos:int, x_t:int, y_t:int, tile_value:int) : void
      {
         var x_diff:int = 0;
         entity.y_vel_at_ground_collision = entity.yVel;
         entity.collision_tile_value = tile_value;
         entity.yVel = 0;
         if(tile_value == 1 || tile_value == 2 || tile_value == 13 || tile_value == 10 || tile_value == 16)
         {
            if(tile_value == 13)
            {
               entity.setInIce(true);
            }
            else
            {
               entity.setInIce(false);
            }
            entity.yPos = y_t * Utils.TILE_HEIGHT - (entity.aabbPhysics.height + entity.aabbPhysics.y);
         }
         else if(tile_value == 4)
         {
            if(this.level.levelData.getTypeTileValueAt(x_t,y_t) == 1)
            {
               entity.setInIce(true);
            }
            else
            {
               entity.setInIce(false);
            }
            x_diff = xPos - x_t * Utils.TILE_WIDTH;
            entity.yPos = y_t * Utils.TILE_HEIGHT - (entity.aabbPhysics.height + entity.aabbPhysics.y) + x_diff;
            entity.slopeCollision(tile_value);
         }
         else if(tile_value == 5)
         {
            if(this.level.levelData.getTypeTileValueAt(x_t,y_t) == 1)
            {
               entity.setInIce(true);
            }
            else
            {
               entity.setInIce(false);
            }
            x_diff = xPos - x_t * Utils.TILE_WIDTH;
            entity.yPos = y_t * Utils.TILE_HEIGHT - (entity.aabbPhysics.height + entity.aabbPhysics.y) + (Utils.TILE_WIDTH - x_diff) - 1;
            entity.slopeCollision(tile_value);
         }
         else if(tile_value == 6)
         {
            if(this.level.levelData.getTypeTileValueAt(x_t,y_t) == 1)
            {
               entity.setInIce(true);
            }
            else
            {
               entity.setInIce(false);
            }
            x_diff = xPos - x_t * Utils.TILE_WIDTH;
            entity.yPos = y_t * Utils.TILE_HEIGHT - (entity.aabbPhysics.height + entity.aabbPhysics.y) + x_diff * 0.5;
            entity.slopeCollision(tile_value);
         }
         else if(tile_value == 7)
         {
            if(this.level.levelData.getTypeTileValueAt(x_t,y_t) == 1)
            {
               entity.setInIce(true);
            }
            else
            {
               entity.setInIce(false);
            }
            x_diff = xPos - x_t * Utils.TILE_WIDTH;
            entity.yPos = y_t * Utils.TILE_HEIGHT - (entity.aabbPhysics.height + entity.aabbPhysics.y) + (x_diff * 0.5 + 8);
            entity.slopeCollision(tile_value);
         }
         else if(tile_value == 8)
         {
            if(this.level.levelData.getTypeTileValueAt(x_t,y_t) == 1)
            {
               entity.setInIce(true);
            }
            else
            {
               entity.setInIce(false);
            }
            x_diff = xPos - x_t * Utils.TILE_WIDTH;
            entity.yPos = y_t * Utils.TILE_HEIGHT - (entity.aabbPhysics.height + entity.aabbPhysics.y) + (Utils.TILE_WIDTH - x_diff * 0.5) - 1;
            entity.slopeCollision(tile_value);
         }
         else if(tile_value == 9)
         {
            if(this.level.levelData.getTypeTileValueAt(x_t,y_t) == 1)
            {
               entity.setInIce(true);
            }
            else
            {
               entity.setInIce(false);
            }
            x_diff = xPos - x_t * Utils.TILE_WIDTH;
            entity.yPos = y_t * Utils.TILE_HEIGHT - (entity.aabbPhysics.height + entity.aabbPhysics.y) + (Utils.TILE_WIDTH - x_diff * 0.5 - 8) - 1;
            entity.slopeCollision(tile_value);
         }
      }
      
      protected function yCollisionResponseUp(entity:Entity, xPos:int, x_t:int, y_t:int, tile_value:int) : void
      {
         entity.yVel = 0;
         entity.yPos = (y_t + 1) * Utils.TILE_HEIGHT - entity.aabbPhysics.y;
      }
      
      protected function isInsideCollisionY(aabb:Rectangle, tile_value:int, x_t:int, y_t:int, xPos:Number) : Boolean
      {
         var x_diff:int = 0;
         if(tile_value == 2 || tile_value == 1 || tile_value == 13 || tile_value == 10 || tile_value == 16)
         {
            return true;
         }
         if(tile_value == 8)
         {
            x_diff = (Utils.TILE_HEIGHT - (xPos - x_t * Utils.TILE_WIDTH)) * 0.5 + 8;
            if(aabb.y + aabb.height >= y_t * Utils.TILE_HEIGHT + x_diff)
            {
               return true;
            }
            return false;
         }
         if(tile_value == 9)
         {
            x_diff = (Utils.TILE_HEIGHT - (xPos - x_t * Utils.TILE_WIDTH)) * 0.5;
            if(aabb.y + aabb.height >= y_t * Utils.TILE_HEIGHT + x_diff)
            {
               return true;
            }
            return false;
         }
         if(tile_value == 7)
         {
            x_diff = (xPos - x_t * Utils.TILE_WIDTH) * 0.5 + 8;
            if(aabb.y + aabb.height >= y_t * Utils.TILE_HEIGHT + x_diff)
            {
               return true;
            }
            return false;
         }
         if(tile_value == 6)
         {
            x_diff = (xPos - x_t * Utils.TILE_WIDTH) * 0.5;
            if(aabb.y + aabb.height >= y_t * Utils.TILE_HEIGHT + x_diff)
            {
               return true;
            }
            return false;
         }
         if(tile_value == 5)
         {
            x_diff = Utils.TILE_HEIGHT - (xPos - x_t * Utils.TILE_WIDTH);
            if(aabb.y + aabb.height >= y_t * Utils.TILE_HEIGHT + x_diff)
            {
               return true;
            }
            return false;
         }
         if(tile_value == 4)
         {
            x_diff = xPos - x_t * Utils.TILE_WIDTH;
            if(aabb.y + aabb.height >= y_t * Utils.TILE_HEIGHT + x_diff)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      protected function isEntityOnGround(entity:Entity) : Boolean
      {
         var x_t:int = int((entity.xPos + entity.aabbPhysics.x + entity.aabbPhysics.width * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((entity.yPos + entity.aabbPhysics.y + entity.aabbPhysics.height + 8) / Utils.TILE_HEIGHT);
         var tile_value:int = this.level.levelData.getTileValueAt(x_t,y_t);
         if(tile_value == 0 || tile_value == 15)
         {
            return false;
         }
         return true;
      }
      
      protected function isCollisionX(value:int) : Boolean
      {
         if(value == 1 || value == 11 || value == 12 || value == 13 || value == 16)
         {
            this.last_collision_x_value = value;
            return true;
         }
         if(value == 14)
         {
            if(this.level.hero is SmallCatHero)
            {
               return false;
            }
            this.last_collision_x_value = value;
            return true;
         }
         return false;
      }
      
      protected function isCollisionY(value:int) : Boolean
      {
         if(value == 1 || value == 2 || value == 4 || value == 5 || value == 6 || value == 7 || value == 8 || value == 9 || value == 13 || value == 14 || value == 10 || value == 16)
         {
            return true;
         }
         return false;
      }
      
      protected function isTopCollisionY(value:int) : Boolean
      {
         if(value == 10)
         {
            return true;
         }
         return false;
      }
      
      protected function isSlopeCollisionY(value:int) : Boolean
      {
         if(value == 4 || value == 5 || value == 6 || value == 7 || value == 8 || value == 9)
         {
            return true;
         }
         return false;
      }
      
      protected function isBelowSlopeTile(x_t:int, y_t:int) : Boolean
      {
         return false;
      }
      
      protected function isCloud(value:int) : Boolean
      {
         if(value == 2 || value == 4 || value == 5 || value == 6 || value == 7 || value == 8 || value == 9)
         {
            return true;
         }
         return false;
      }
      
      protected function isSlope(value:int) : Boolean
      {
         if(value == 4 || value == 5 || value == 6 || value == 7 || value == 8 || value == 9)
         {
            return true;
         }
         return false;
      }
      
      protected function isTeleport(value:int) : Boolean
      {
         if(value == 3)
         {
            return true;
         }
         return false;
      }
      
      protected function isGroundTile(x_t:int, y_t:int) : Boolean
      {
         var tile_value:int = this.level.levelData.getTileValueAt(x_t,y_t);
         var top_tile_value:int = this.level.levelData.getTileValueAt(x_t,y_t - 1);
         if(tile_value != 1 || tile_value != 13)
         {
            return true;
         }
         if(top_tile_value == 0 || top_tile_value >= 4 && top_tile_value <= 10)
         {
            return true;
         }
         return false;
      }
   }
}
