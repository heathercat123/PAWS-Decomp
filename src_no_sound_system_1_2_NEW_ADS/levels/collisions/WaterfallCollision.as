package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import game_utils.CollisionId;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   
   public class WaterfallCollision extends Collision
   {
      
      public static var WATERFALL_PLATFORM_COLLISION_ID:int = 30000;
       
      
      protected var topSXSide:GameSprite;
      
      protected var topDXSide:GameSprite;
      
      protected var middleSXSide:GameSprite;
      
      protected var middleDXSide:GameSprite;
      
      protected var middleCenter:GameSprite;
      
      public var hero_xDiff:Number;
      
      public var entity:Entity;
      
      protected var oldXPos:Number;
      
      protected var floatSinCounter:Number;
      
      protected var waveSprite:Vector.<GameSprite>;
      
      protected var wave_counter:int;
      
      protected var wave_frame:int;
      
      protected var particle_counter:int;
      
      protected var _entities:Vector.<CollisionId>;
      
      public function WaterfallCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         this.initWaves();
         this.initSprites();
         aabb.x = 0 - 2;
         aabb.y = -2;
         aabb.width = WIDTH + 4;
         aabb.height = 12 + 2;
         this.hero_xDiff = 0;
         this.entity = null;
         this.oldXPos = 0;
         this.floatSinCounter = 0;
         this.wave_counter = this.wave_frame = 0;
         this.particle_counter = 0;
         COLLISION_ID = WaterfallCollision.WATERFALL_PLATFORM_COLLISION_ID++;
         this._entities = new Vector.<CollisionId>();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         ++this.wave_counter;
         if(this.wave_counter > 0)
         {
            this.wave_counter = 0;
            ++this.wave_frame;
            if(this.wave_frame > 15)
            {
               this.wave_frame = 0;
            }
            for(i = 0; i < this.waveSprite.length; i++)
            {
               this.waveSprite[i].gfxHandleClip().gotoAndStop(this.wave_frame + 1);
            }
         }
         if(this.particle_counter++ > 0)
         {
            this.particle_counter = -(Math.random() * 5 + 5);
            level.particlesManager.createDewDroplets(xPos + Math.random() * WIDTH,yPos + HEIGHT);
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
            if(this._entities[index].entity.waterfall_counter > 5)
            {
               SoundSystem.PlaySound("sandpit");
            }
            this._entities[index].entity.IS_ON_PLATFORM = false;
            this._entities[index].entity.colliding_platform = null;
            this._entities[index].IS_COLLIDING = false;
            this._entities[index].entity.waterfall_counter = 0;
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
                     x_diff = Math.abs(this._entities[i].entity.getMidXPos() - (xPos + WIDTH * 0.5));
                     if(this._entities[i].entity.stateMachine.currentState == "IS_WALKING_STATE" || this._entities[i].entity.stateMachine.currentState == "IS_RUNNING_STATE" || x_diff > 28)
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
                     }
                     this._entities[i].entity.yPos = yPos - (this._entities[i].entity.aabbPhysics.height + this._entities[i].entity.aabbPhysics.y) + this._entities[i].entity.waterfall_counter - 1;
                  }
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
         sprite.x = int(Math.floor(xPos + 8 - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         this.topSXSide.x = sprite.x - 8;
         this.topSXSide.y = sprite.y;
         this.topDXSide.x = this.topSXSide.x + WIDTH;
         this.topDXSide.y = this.topSXSide.y;
         this.middleSXSide.x = this.topSXSide.x;
         this.middleSXSide.y = sprite.y;
         this.middleDXSide.x = this.topDXSide.x;
         this.middleDXSide.y = sprite.y;
         this.middleCenter.x = sprite.x;
         this.middleCenter.y = sprite.y + 8;
         sprite.updateScreenPosition();
         this.topSXSide.updateScreenPosition();
         this.topDXSide.updateScreenPosition();
         this.middleSXSide.updateScreenPosition();
         this.middleDXSide.updateScreenPosition();
         this.middleCenter.updateScreenPosition();
         for(i = 0; i < this.waveSprite.length; i++)
         {
            this.waveSprite[i].x = sprite.x - 8;
            this.waveSprite[i].y = int(sprite.y + i * 32);
            this.waveSprite[i].updateScreenPosition();
         }
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
         Utils.world.removeChild(this.topSXSide);
         this.topSXSide.destroy();
         this.topSXSide.dispose();
         this.topSXSide = null;
         Utils.world.removeChild(this.topDXSide);
         this.topDXSide.destroy();
         this.topDXSide.dispose();
         this.topDXSide = null;
         Utils.world.removeChild(this.middleCenter);
         this.middleCenter.destroy();
         this.middleCenter.dispose();
         this.middleCenter = null;
         Utils.world.removeChild(this.middleDXSide);
         this.middleDXSide.destroy();
         this.middleDXSide.dispose();
         this.middleDXSide = null;
         Utils.world.removeChild(this.middleSXSide);
         this.middleSXSide.destroy();
         this.middleSXSide.dispose();
         this.middleSXSide = null;
         Utils.world.removeChild(sprite);
         super.destroy();
      }
      
      protected function initWaves() : void
      {
         var i:int = 0;
         var wSprite:GameSprite = null;
         var amount:int = int(Math.ceil(HEIGHT / 32));
         this.waveSprite = new Vector.<GameSprite>();
         for(i = 0; i < amount; i++)
         {
            wSprite = new WaterfallWaveCollisionSprite();
            wSprite.gfxHandleClip().gotoAndStop(1);
            Utils.world.addChild(wSprite);
            Utils.world.setChildIndex(wSprite,0);
            this.waveSprite.push(wSprite);
         }
      }
      
      protected function initSprites() : void
      {
         sprite = new WaterfallCollisionSprite();
         sprite.gotoAndStop(2);
         Utils.world.addChild(sprite);
         sprite.width = WIDTH - 16;
         this.topSXSide = new WaterfallCollisionSprite();
         this.topSXSide.gotoAndStop(1);
         this.topSXSide.gfxHandleClip().gotoAndPlay(1);
         Utils.world.addChild(this.topSXSide);
         this.topDXSide = new WaterfallCollisionSprite();
         this.topDXSide.scaleX = -1;
         this.topDXSide.gotoAndStop(1);
         this.topDXSide.gfxHandleClip().gotoAndPlay(1);
         Utils.world.addChild(this.topDXSide);
         this.middleSXSide = new WaterfallCollisionSprite();
         this.middleSXSide.gotoAndStop(3);
         this.middleSXSide.height = HEIGHT;
         Utils.world.addChild(this.middleSXSide);
         this.middleDXSide = new WaterfallCollisionSprite();
         this.middleDXSide.scaleX = -1;
         this.middleDXSide.gotoAndStop(3);
         this.middleDXSide.height = HEIGHT;
         Utils.world.addChild(this.middleDXSide);
         this.middleCenter = new WaterfallCollisionSprite();
         this.middleCenter.gotoAndStop(4);
         this.middleCenter.width = WIDTH - 16;
         this.middleCenter.height = HEIGHT - 8;
         Utils.world.addChild(this.middleCenter);
         Utils.world.setChildIndex(sprite,0);
         Utils.world.setChildIndex(this.middleSXSide,0);
         Utils.world.setChildIndex(this.middleDXSide,0);
         Utils.world.setChildIndex(this.middleCenter,0);
      }
   }
}
