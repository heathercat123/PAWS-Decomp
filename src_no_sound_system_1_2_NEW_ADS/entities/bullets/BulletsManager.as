package entities.bullets
{
   import levels.Level;
   import levels.cameras.*;
   import sprites.*;
   import sprites.bullets.*;
   import sprites.particles.*;
   import starling.display.DisplayObject;
   
   public class BulletsManager
   {
       
      
      public var bullets:Array;
      
      public var lastUsedBullet:int;
      
      public var bulletsAmount:int;
      
      public var level:Level;
      
      public function BulletsManager(_level:Level)
      {
         var i:int = 0;
         super();
         this.level = _level;
         this.bullets = new Array();
         this.bulletsAmount = 128;
         this.lastUsedBullet = 0;
         Utils.BEACH_BALL_BOUNCES = 0;
         for(i = 0; i < this.bulletsAmount; i++)
         {
            this.bullets.push(new Bullet(this.level,0,0,0,0));
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.bulletsAmount; i++)
         {
            if(this.bullets[i] != null)
            {
               this.bullets[i].destroy();
               this.bullets[i] = null;
            }
         }
         this.bullets = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.bulletsAmount; i++)
         {
            if(this.bullets[i].sprite != null)
            {
               this.bullets[i].update();
               this.bullets[i].checkEntitiesCollision();
               this.bullets[i].checkCollisionsCollision();
               if(this.bullets[i].dead)
               {
                  this.bullets[i].removeSprite();
               }
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.bulletsAmount; i++)
         {
            if(this.bullets[i].sprite != null)
            {
               this.bullets[i].updateScreenPosition(camera);
            }
         }
      }
      
      public function createBoulder(_xPos:Number, _yPos:Number, _ai:int = 0, _dir:int = 0) : void
      {
         var boulder:BoulderBulletSprite = new BoulderBulletSprite();
         var random_rotation:int = int(Math.random() * 4);
         if(random_rotation == 1)
         {
            boulder.rotation = Math.PI * 0.5;
         }
         else if(random_rotation == 1)
         {
            boulder.rotation = Math.PI;
         }
         else if(random_rotation == 2)
         {
            boulder.rotation = Math.PI * 1.5;
         }
         var bullet:Bullet = this.pushBullet(boulder,_xPos,_yPos,0,0,1,Math.random() * 100 > 50 ? 1 : 0,int(Math.random() * 10 + 10),_ai,_dir);
         bullet.updateScreenPosition(this.level.camera);
      }
      
      public function createComet(_xPos:Number, _yPos:Number) : void
      {
         var comet:CometBulletSprite = new CometBulletSprite();
         if(Math.random() * 100 > 50)
         {
            comet.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            comet.gfxHandleClip().gotoAndStop(2);
         }
         var bullet:Bullet = this.pushBullet(comet,_xPos,_yPos,0,0,1);
         bullet.updateScreenPosition(this.level.camera);
      }
      
      public function pushBullet(sprite:DisplayObject, xPos:Number, yPos:Number, xVel:Number, yVel:Number, friction:Number, foo1:Number = 0, foo2:Number = 0, foo3:Number = 0, foo4:Number = 0) : Bullet
      {
         var i:int = 0;
         do
         {
            i = this.lastUsedBullet++ % this.bulletsAmount;
            if(this.lastUsedBullet >= this.bulletsAmount)
            {
               this.lastUsedBullet = 0;
            }
         }
         while(false);
         
         this.bullets[i].assignNewValues(sprite,xPos,yPos,xVel,yVel,friction,foo1,foo2,foo3,foo4);
         return this.bullets[i];
      }
      
      public function pushBackBullet(sprite:DisplayObject, xPos:Number, yPos:Number, xVel:Number, yVel:Number, friction:Number, foo1:Number = 0, foo2:Number = 0, foo3:Number = 0, foo4:Number = 0) : Bullet
      {
         var bullet:Bullet = this.pushBullet(sprite,xPos,yPos,xVel,yVel,friction,foo1,foo2,foo3,foo4);
         if(bullet != null)
         {
            Utils.world.setChildIndex(bullet.sprite,0);
         }
         return bullet;
      }
   }
}
