package levels.collisions
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.BluePlatformCollisionSprite;
   
   public class BluePlatformCollision extends Collision
   {
       
      
      public var entity:Entity;
      
      protected var STATE:int;
      
      protected var STATE_VISIBLE:int;
      
      protected var STATE_TOUCHED:int;
      
      protected var STATE_DISAPPEAR:int;
      
      protected var STATE_INVISIBLE:int;
      
      protected var STATE_APPEAR:int;
      
      protected var TYPE:int;
      
      protected var lastVisibleState:Boolean;
      
      public function BluePlatformCollision(_level:Level, _xPos:Number, _yPos:Number, _type:int)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         sprite = new BluePlatformCollisionSprite();
         Utils.world.addChild(sprite);
         sprite.gfxHandleClip().gotoAndStop(this.TYPE + 1);
         this.STATE_VISIBLE = 0;
         this.STATE_TOUCHED = 1;
         this.STATE_DISAPPEAR = 2;
         this.STATE_INVISIBLE = 3;
         this.STATE_APPEAR = 4;
         this.STATE = this.STATE_VISIBLE;
         if(this.TYPE == 0)
         {
            WIDTH = 48;
            aabb.x = 0 - 4;
            aabb.width = 48 + 8;
         }
         else
         {
            WIDTH = 40;
            aabb.x = 0 - 4;
            aabb.width = 40 + 8;
         }
         HEIGHT = 8;
         aabb.y = -4;
         aabb.height = 12;
         this.entity = null;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         this.entity = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
         if(this.STATE == this.STATE_VISIBLE)
         {
            if(this.entity != null)
            {
               this.STATE = this.STATE_TOUCHED;
               counter1 = 0;
            }
         }
         else if(this.STATE == this.STATE_TOUCHED)
         {
            ++counter1;
            if(counter1 > 10)
            {
               this.STATE = this.STATE_DISAPPEAR;
               counter1 = 0;
               this.lastVisibleState = level.collisionsManager.visibleState;
               sprite.visible = this.lastVisibleState;
            }
         }
         else if(this.STATE == this.STATE_DISAPPEAR)
         {
            if(this.lastVisibleState != level.collisionsManager.visibleState)
            {
               this.lastVisibleState = level.collisionsManager.visibleState;
               SoundSystem.PlaySound("blue_platform");
               sprite.visible = this.lastVisibleState;
            }
            ++counter1;
            if(counter1 > 2)
            {
               counter1 = 0;
               ++counter2;
               if(counter2 > 16)
               {
                  this.STATE = this.STATE_INVISIBLE;
                  counter1 = counter2 = 0;
                  sprite.visible = false;
               }
            }
         }
         else if(this.STATE == this.STATE_INVISIBLE)
         {
            ++counter1;
            if(counter1 > 120)
            {
               this.STATE = this.STATE_APPEAR;
               sprite.visible = true;
               sprite.alpha = 0;
               counter1 = 0;
            }
         }
         else if(this.STATE == this.STATE_APPEAR)
         {
            ++counter1;
            if(counter1 > 2)
            {
               counter1 = 0;
               sprite.alpha += 0.3;
               if(sprite.alpha >= 1)
               {
                  sprite.alpha = 1;
                  this.STATE = this.STATE_VISIBLE;
               }
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var heroAABB:Rectangle = new Rectangle(level.hero.xPos + level.hero.aabbPhysics.x,level.hero.yPos + level.hero.aabbPhysics.y,level.hero.aabbPhysics.width,level.hero.aabbPhysics.height);
         var thisAABB:Rectangle = getAABB();
         if(heroAABB.intersects(thisAABB) && level.hero.yPos + 13 < yPos && level.hero.yVel >= 0 && this.STATE != this.STATE_INVISIBLE)
         {
            level.hero.setOnPlatform(this);
            level.hero.yPos = yPos - level.hero.HEIGHT;
            level.hero.yVel = 0;
            this.entity = level.hero;
            level.hero.IS_ON_ICE = false;
         }
         else if(this.entity != null)
         {
            this.entity = null;
            level.hero.IS_ON_PLATFORM = false;
            level.collisionsManager.checkHeroPlatformsCollision();
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
   }
}
