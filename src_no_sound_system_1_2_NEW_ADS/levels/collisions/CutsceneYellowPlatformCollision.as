package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import game_utils.CollisionId;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   
   public class CutsceneYellowPlatformCollision extends Collision
   {
       
      
      public var hero_xDiff:Number;
      
      public var entity:Entity;
      
      protected var oldXPos:Number;
      
      protected var path_start_x:int;
      
      protected var path_end_x:int;
      
      protected var path_start_y:int;
      
      protected var path_end_y:int;
      
      protected var time:Number;
      
      protected var time_tick:Number;
      
      protected var time_start:Number;
      
      protected var time_diff:Number;
      
      protected var stateMachine:StateMachine;
      
      protected var IS_A_TO_B:Boolean;
      
      protected var ORIGINAL_IS_A_TO_B:Boolean;
      
      protected var IS_HORIZONTAL:Boolean;
      
      protected var _entities:Vector.<CollisionId>;
      
      public function CutsceneYellowPlatformCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos);
         sprite = new YellowPlatformCollisionSprite();
         Utils.world.addChild(sprite);
         WIDTH = 64;
         HEIGHT = 8;
         this.ORIGINAL_IS_A_TO_B = this.IS_A_TO_B = true;
         aabb.x = 0 - 2;
         aabb.y = -2;
         aabb.width = 64 + 4;
         aabb.height = 12;
         this.hero_xDiff = 0;
         this.entity = null;
         this.oldXPos = 0;
         this.time = 0;
         this.time_tick = 0;
         this.fetchScripts();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_WAITING_STATE","MOVE_ACTION","IS_MOVING_STATE");
         this.stateMachine.setRule("IS_MOVING_STATE","STOP_ACTION","IS_WAITING_STATE");
         this.stateMachine.setFunctionToState("IS_WAITING_STATE",this.waitingState);
         this.stateMachine.setFunctionToState("IS_MOVING_STATE",this.movingState);
         this.stateMachine.setState("IS_WAITING_STATE");
         this._entities = new Vector.<CollisionId>();
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this._entities.length; i++)
         {
            if(this._entities[i] != null)
            {
               this._entities[i].destroy();
               this._entities[i] = null;
            }
         }
         this._entities = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
         Utils.world.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var x_diff:Number = NaN;
         super.update();
         for(i = 0; i < this._entities.length; i++)
         {
            if(this._entities[i] != null)
            {
               if(this._entities[i].entity != null)
               {
                  if(this._entities[i].IS_COLLIDING)
                  {
                     x_diff = xPos - this.oldXPos;
                     this._entities[i].entity.xPos += x_diff;
                  }
               }
            }
         }
         this.oldXPos = xPos;
      }
      
      override public function checkEntitiesCollision() : void
      {
         var entityAABB:Rectangle = null;
         var entity:Entity = null;
         var index:int = 0;
         var i:int = 0;
         var thisAABB:Rectangle = getAABB();
         index = this.getCollisionIndex(level.hero);
         if(index < 0)
         {
            this._entities.push(new CollisionId(level.hero));
            index = this.getCollisionIndex(level.hero);
         }
         entityAABB = new Rectangle(this._entities[index].entity.xPos + this._entities[index].entity.aabbPhysics.x,this._entities[index].entity.yPos + this._entities[index].entity.aabbPhysics.y,this._entities[index].entity.aabbPhysics.width,this._entities[index].entity.aabbPhysics.height);
         if(entityAABB.intersects(thisAABB) && this._entities[index].entity.allowPlatformCollision(this))
         {
            this._entities[index].entity.yPos = yPos - (this._entities[index].entity.aabbPhysics.y + this._entities[index].entity.aabbPhysics.height);
            this._entities[index].entity.yVel = 0;
            this._entities[index].entity.setOnPlatform(this);
            this._entities[index].IS_COLLIDING = true;
         }
         else if(this._entities[index].IS_COLLIDING)
         {
            this._entities[index].entity.IS_ON_PLATFORM = false;
            this._entities[index].IS_COLLIDING = false;
         }
         for(i = 0; i < level.enemiesManager.enemies.length; i++)
         {
            if(level.enemiesManager.enemies[i] != null)
            {
               index = this.getCollisionIndex(level.enemiesManager.enemies[i]);
               if(index < 0)
               {
                  this._entities.push(new CollisionId(level.enemiesManager.enemies[i]));
                  index = this.getCollisionIndex(level.enemiesManager.enemies[i]);
               }
               entityAABB = new Rectangle(this._entities[index].entity.xPos + this._entities[index].entity.aabbPhysics.x,this._entities[index].entity.yPos + this._entities[index].entity.aabbPhysics.y,this._entities[index].entity.aabbPhysics.width,this._entities[index].entity.aabbPhysics.height);
               if(entityAABB.intersects(thisAABB) && this._entities[index].entity.allowPlatformCollision(this))
               {
                  this._entities[index].entity.yPos = yPos - (this._entities[index].entity.aabbPhysics.y + this._entities[index].entity.aabbPhysics.height);
                  this._entities[index].entity.yVel = 0;
                  this._entities[index].entity.setOnPlatform(this);
                  this._entities[index].entity.colliding_platform = this;
                  this._entities[index].IS_COLLIDING = true;
               }
               else if(this._entities[index].IS_COLLIDING)
               {
                  this._entities[index].entity.IS_ON_PLATFORM = false;
                  this._entities[index].entity.colliding_platform = null;
                  this._entities[index].IS_COLLIDING = false;
               }
            }
         }
      }
      
      override public function getMidXPos() : Number
      {
         return xPos + WIDTH * 0.5;
      }
      
      protected function getCollisionIndex(entity:Entity) : int
      {
         var i:int = 0;
         for(i = 0; i < this._entities.length; i++)
         {
            if(this._entities[i] != null)
            {
               if(this._entities[i].entity == entity)
               {
                  return i;
               }
            }
         }
         return -1;
      }
      
      protected function deleteEntityIndex(entity:Entity) : void
      {
         var i:int = 0;
         for(i = 0; i < this._entities.length; i++)
         {
            if(this._entities[i] != null)
            {
               if(this._entities[i].entity == entity)
               {
                  this._entities[i].destroy();
                  this._entities[i] = null;
               }
            }
         }
      }
      
      protected function waitingState() : void
      {
         counter1 = 0;
      }
      
      protected function movingState() : void
      {
         this.time_tick = 0;
         if(this.IS_HORIZONTAL)
         {
            if(this.IS_A_TO_B)
            {
               this.time_start = this.path_start_x;
               this.time_diff = this.path_end_x - this.path_start_x;
            }
            else
            {
               this.time_start = this.path_end_x;
               this.time_diff = this.path_start_x - this.path_end_x;
            }
         }
         else if(this.IS_A_TO_B)
         {
            this.time_start = this.path_start_y;
            this.time_diff = this.path_end_y - this.path_start_y;
         }
         else
         {
            this.time_start = this.path_end_y;
            this.time_diff = this.path_start_y - this.path_end_y;
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         this.stateMachine.setState("IS_WAITING_STATE");
         this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B;
      }
      
      protected function fetchScripts() : void
      {
         var i:int = 0;
         var point:Point = new Point(xPos,yPos);
         var area_enemy:Rectangle = new Rectangle(xPos,yPos,WIDTH,Utils.TILE_HEIGHT);
         var area:Rectangle = new Rectangle();
         for(i = 0; i < level.scriptsManager.verPathScripts.length; i++)
         {
            if(level.scriptsManager.verPathScripts[i] != null)
            {
               area.x = level.scriptsManager.verPathScripts[i].x;
               area.y = level.scriptsManager.verPathScripts[i].y;
               area.width = level.scriptsManager.verPathScripts[i].width;
               area.height = level.scriptsManager.verPathScripts[i].height;
               if(area.intersects(area_enemy))
               {
                  this.IS_HORIZONTAL = false;
                  this.path_start_y = level.scriptsManager.verPathScripts[i].y;
                  this.path_end_y = area.y + level.scriptsManager.verPathScripts[i].height;
                  if(Math.abs(yPos - this.path_start_y) < Math.abs(yPos - this.path_end_y))
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = true;
                  }
                  else
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = false;
                  }
                  this.time = int((this.path_end_y - this.path_start_y) / 32) * 0.5;
                  if(this.time < 1)
                  {
                     this.time = 1;
                  }
               }
            }
         }
         for(i = 0; i < level.scriptsManager.horPathScripts.length; i++)
         {
            if(level.scriptsManager.horPathScripts[i] != null)
            {
               area.x = level.scriptsManager.horPathScripts[i].x;
               area.y = level.scriptsManager.horPathScripts[i].y;
               area.width = level.scriptsManager.horPathScripts[i].width;
               area.height = level.scriptsManager.horPathScripts[i].height;
               if(area.intersects(area_enemy))
               {
                  this.IS_HORIZONTAL = true;
                  this.path_start_x = level.scriptsManager.horPathScripts[i].x;
                  this.path_end_x = area.x + level.scriptsManager.horPathScripts[i].width;
                  if(Math.abs(xPos + WIDTH * 0.5 - this.path_start_x) < Math.abs(xPos + WIDTH * 0.5 - this.path_end_x))
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = true;
                  }
                  else
                  {
                     this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = false;
                  }
                  this.time = int((this.path_end_x - this.path_start_x) / 32) * 0.5;
                  if(this.time < 1)
                  {
                     this.time = 1;
                  }
               }
            }
         }
      }
   }
}
