package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import game_utils.CollisionId;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   
   public class ConvoyBeltCollision extends Collision
   {
       
      
      public var hero_xDiff:Number;
      
      public var entity:Entity;
      
      protected var oldXPos:Number;
      
      protected var _entities:Vector.<CollisionId>;
      
      protected var convoySprites:Vector.<ConvoyBeltCollisionSprite>;
      
      protected var DIRECTION:int;
      
      public function ConvoyBeltCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _DIRECTION:int)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = 8;
         this.DIRECTION = _DIRECTION;
         this.initSprites();
         aabb.x = 0 - 4;
         aabb.y = -4;
         aabb.width = WIDTH + 8;
         aabb.height = 12;
         this.hero_xDiff = 0;
         this.entity = null;
         this.oldXPos = 0;
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
         for(i = 0; i < this.convoySprites.length; i++)
         {
            Utils.topWorld.removeChild(this.convoySprites[i]);
            this.convoySprites[i].destroy();
            this.convoySprites[i].dispose();
            this.convoySprites[i] = null;
         }
         this.convoySprites = null;
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      protected function initSprites() : void
      {
         var i:int = 0;
         var gSprite:ConvoyBeltCollisionSprite = null;
         var amount:int = int(WIDTH / Utils.TILE_WIDTH) - 1;
         this.convoySprites = new Vector.<ConvoyBeltCollisionSprite>();
         for(i = 0; i < amount; i++)
         {
            gSprite = new ConvoyBeltCollisionSprite();
            if(i == amount - 1)
            {
               gSprite.gotoAndStop(1);
               gSprite.scaleX = gSprite.scaleY = -1;
            }
            else
            {
               gSprite.gotoAndStop(2);
            }
            gSprite.gfxHandleClip().gotoAndPlay(1);
            this.convoySprites.push(gSprite);
            if(this.DIRECTION == Entity.RIGHT)
            {
               gSprite.gfxHandleClip().reverseFrames();
            }
            Utils.topWorld.addChild(gSprite);
         }
         sprite = new ConvoyBeltCollisionSprite();
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
         if(this.DIRECTION == Entity.RIGHT)
         {
            sprite.gfxHandleClip().reverseFrames();
         }
         Utils.topWorld.addChild(sprite);
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
                     if(this.DIRECTION == Entity.LEFT)
                     {
                        --this._entities[i].entity.xPos;
                     }
                     else
                     {
                        this._entities[i].entity.xPos += 1;
                     }
                  }
               }
            }
         }
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
         if(entityAABB.intersects(thisAABB) && this._entities[index].entity.allowPlatformCollision(this) && level.hero.stateMachine.currentState != "IS_CLIMBING_STATE")
         {
            this._entities[index].entity.yPos = yPos - (this._entities[index].entity.aabbPhysics.y + this._entities[index].entity.aabbPhysics.height);
            this._entities[index].entity.yVel = 0;
            this._entities[index].entity.setOnPlatform(this);
            this._entities[index].IS_COLLIDING = true;
         }
         else if(this._entities[index].IS_COLLIDING)
         {
            this._entities[index].entity.IS_ON_PLATFORM = false;
            this._entities[index].entity.colliding_platform = null;
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
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         for(i = 0; i < this.convoySprites.length; i++)
         {
            if(i == this.convoySprites.length - 1)
            {
               this.convoySprites[i].x = int(Math.floor(xPos + (i + 2) * 16 - camera.xPos));
            }
            else
            {
               this.convoySprites[i].x = int(Math.floor(xPos + (i + 1) * 16 - camera.xPos));
            }
            if(i == this.convoySprites.length - 1)
            {
               this.convoySprites[i].y = sprite.y + Utils.TILE_HEIGHT;
            }
            else
            {
               this.convoySprites[i].y = sprite.y;
            }
            this.convoySprites[i].updateScreenPosition();
         }
      }
      
      override public function reset() : void
      {
      }
   }
}
