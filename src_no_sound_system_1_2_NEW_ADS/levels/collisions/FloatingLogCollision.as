package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import game_utils.CollisionId;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   
   public class FloatingLogCollision extends Collision
   {
      
      public static var FLOATING_LOG_PLATFORM_COLLISION_ID:int = 40000;
       
      
      protected var bodySprite:GameSprite;
      
      protected var endSprite:GameSprite;
      
      public var hero_xDiff:Number;
      
      public var entity:Entity;
      
      protected var oldXPos:Number;
      
      protected var floatSinCounter:Number;
      
      protected var stateMachine:StateMachine;
      
      protected var veinsSprite:Array;
      
      protected var veinsData:Array;
      
      protected var log_rotation:Number;
      
      protected var log_speed:Number;
      
      protected var _entities:Vector.<CollisionId>;
      
      protected var sound_counter:Number;
      
      public function FloatingLogCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number)
      {
         super(_level,_xPos,_yPos);
         this.sound_counter = 0;
         sprite = new FloatingLogCollisionSprite();
         sprite.gfxHandleClip().gotoAndStop(1);
         Utils.world.addChild(sprite);
         this.bodySprite = new FloatingLogCollisionSprite();
         this.bodySprite.gfxHandleClip().gotoAndStop(2);
         Utils.world.addChild(this.bodySprite);
         this.endSprite = new FloatingLogCollisionSprite();
         this.endSprite.gfxHandleClip().gotoAndStop(1);
         this.endSprite.scaleX = -1;
         Utils.world.addChild(this.endSprite);
         WIDTH = _width;
         HEIGHT = 8;
         aabb.x = 0 - 2;
         aabb.y = 0;
         aabb.width = WIDTH + 4;
         aabb.height = 12;
         this.hero_xDiff = 0;
         this.entity = null;
         this.oldXPos = 0;
         this.floatSinCounter = 0;
         this.log_rotation = this.log_speed = 0;
         this.initVeins();
         COLLISION_ID = FloatingLogCollision.FLOATING_LOG_PLATFORM_COLLISION_ID++;
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
         for(i = 0; i < this.veinsData.length; i++)
         {
            Utils.world.removeChild(this.veinsSprite[i]);
            this.veinsSprite[i].destroy();
            this.veinsSprite[i].dispose();
            this.veinsSprite[i] = null;
            this.veinsData[i] = null;
         }
         this.veinsSprite = null;
         this.veinsData = null;
         Utils.world.removeChild(this.bodySprite);
         Utils.world.removeChild(this.endSprite);
         this.bodySprite.destroy();
         this.bodySprite.dispose();
         this.bodySprite = null;
         this.endSprite.destroy();
         this.endSprite.dispose();
         this.endSprite = null;
         Utils.world.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         var x_diff:Number = NaN;
         super.update();
         this.floatSinCounter += 0.075;
         if(this.floatSinCounter > Math.PI * 2)
         {
            this.floatSinCounter -= Math.PI * 2;
         }
         yPos = int(Math.floor(originalYPos + Math.sin(this.floatSinCounter) * 2));
         if(yPos < originalYPos - 1)
         {
            yPos = originalYPos - 1;
         }
         if(this.entity != null)
         {
            x_diff = xPos - this.oldXPos;
            this.entity.xPos += x_diff;
         }
         this.oldXPos = xPos;
         this.log_speed *= 0.98;
         if(this.log_speed < 0)
         {
            this.log_speed = 0;
         }
         else if(this.log_speed > 0.2)
         {
            this.log_speed = 0.2;
         }
         this.log_rotation += this.log_speed;
         if(this.log_rotation >= Math.PI * 2)
         {
            this.log_rotation -= Math.PI * 2;
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
            this._entities[index].entity.waterfall_counter = 0;
         }
         for(i = 0; i < level.bulletsManager.bullets.length; i++)
         {
            if(level.bulletsManager.bullets[i].sprite != null)
            {
               index = this.getCollisionIndex(level.bulletsManager.bullets[i]);
               if(index < 0)
               {
                  this._entities.push(new CollisionId(level.bulletsManager.bullets[i]));
                  index = this.getCollisionIndex(level.bulletsManager.bullets[i]);
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
                  this._entities[index].entity.waterfall_counter = 0;
               }
            }
            else
            {
               this.deleteEntityIndex(level.bulletsManager.bullets[i]);
            }
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
                  this._entities[index].entity.waterfall_counter = 0;
               }
            }
         }
      }
      
      override public function checkPostUpdateEntitiesCollision() : void
      {
         var i:int = 0;
         var x_diff:Number = NaN;
         for(i = 0; i < this._entities.length; i++)
         {
            if(this._entities[i] != null)
            {
               if(this._entities[i].entity != null)
               {
                  if(this._entities[i].IS_COLLIDING)
                  {
                     if(this._entities[i].entity.stateMachine != null)
                     {
                        if(this._entities[i].entity.stateMachine.currentState == "IS_WALKING_STATE" || this._entities[i].entity.stateMachine.currentState == "IS_RUNNING_STATE")
                        {
                           this._entities[i].entity.waterfall_counter -= 0.1;
                           if(this._entities[i].entity.waterfall_counter < 1)
                           {
                              this._entities[i].entity.waterfall_counter = 1;
                           }
                        }
                        else
                        {
                           this._entities[i].entity.waterfall_counter += 0.2;
                           this.log_speed += 0.005;
                        }
                     }
                     this._entities[i].entity.yPos = yPos - (this._entities[i].entity.aabbPhysics.height + this._entities[i].entity.aabbPhysics.y) + this._entities[i].entity.waterfall_counter + 1;
                  }
               }
            }
         }
         this.sound_counter += this.log_speed;
         if(this.sound_counter >= 1)
         {
            this.sound_counter = 0;
            if(isInsideScreen())
            {
               SoundSystem.PlaySound("red_platform");
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
         var frame_id:int = 0;
         var vAngle:Number = NaN;
         super.updateScreenPosition(camera);
         this.bodySprite.x = sprite.x + 16;
         this.bodySprite.y = sprite.y;
         this.bodySprite.width = WIDTH - 32;
         this.endSprite.x = sprite.x + WIDTH;
         this.endSprite.y = sprite.y;
         this.bodySprite.updateScreenPosition();
         this.endSprite.updateScreenPosition();
         var step:Number = Math.PI / 22;
         for(i = 0; i < this.veinsData.length; i++)
         {
            this.veinsSprite[i].x = sprite.x + this.veinsData[i].x;
            this.veinsSprite[i].y = sprite.y;
            vAngle = this.veinsData[i].y + this.log_rotation;
            while(vAngle >= Math.PI * 2)
            {
               vAngle -= Math.PI * 2;
            }
            if(vAngle >= 0 && vAngle < Math.PI)
            {
               this.veinsSprite[i].visible = true;
               frame_id = int(vAngle / step);
               this.veinsSprite[i].gfxHandleClip().gotoAndStop(frame_id + 1);
            }
            else
            {
               this.veinsSprite[i].visible = false;
            }
         }
      }
      
      protected function initVeins() : void
      {
         var i:int = 0;
         var vSprite:GameSprite = null;
         var amount:int = int((WIDTH - 32) / Utils.TILE_WIDTH);
         this.veinsSprite = new Array();
         this.veinsData = new Array();
         for(i = 0; i < amount; i++)
         {
            vSprite = new FloatingLogVeinCollisionSprite();
            Utils.world.addChild(vSprite);
            this.veinsSprite.push(vSprite);
            this.veinsData.push(new Point((i + 1) * 16,Math.random() * Math.PI * 2));
         }
      }
   }
}
