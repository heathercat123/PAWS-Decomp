package levels.collisions
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.FireballBulletSprite;
   import sprites.collisions.WallCannonCollisionSprite;
   
   public class WallCannonCollision extends Collision
   {
       
      
      protected var IS_RIGHT:Boolean;
      
      public function WallCannonCollision(_level:Level, _xPos:Number, _yPos:Number, _IS_RIGHT:int = 0)
      {
         super(_level,_xPos,_yPos);
         if(_IS_RIGHT == 0)
         {
            this.IS_RIGHT = false;
         }
         else
         {
            this.IS_RIGHT = true;
         }
         sprite = new WallCannonCollisionSprite();
         Utils.topWorld.addChild(sprite);
         sprite.gfxHandleClip().gotoAndStop(1);
         if(this.IS_RIGHT)
         {
            sprite.scaleX = -1;
         }
         WIDTH = 48;
         HEIGHT = 8;
         aabb.x = 0;
         aabb.y = 0;
         aabb.width = 0;
         aabb.height = 0;
         counter1 = 0;
         counter2 = 0;
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
         ++counter1;
         var wait_time:int = 60;
         if(Utils.CurrentLevel == 43 || Utils.CurrentLevel == 44)
         {
            wait_time = 120;
         }
         if(counter1 == wait_time)
         {
            sprite.gfxHandleClip().gotoAndPlay(1);
         }
         else if(counter1 > wait_time)
         {
            if(counter2 == 0)
            {
               if(sprite.gfxHandleClip().currentFrame == 4)
               {
                  if(isInsideScreen())
                  {
                     SoundSystem.PlaySound("fire_ball");
                  }
                  counter2 = 1;
                  if(this.IS_RIGHT)
                  {
                     level.bulletsManager.pushBullet(new FireballBulletSprite(),xPos,yPos,1,0,1,1);
                  }
                  else
                  {
                     level.bulletsManager.pushBullet(new FireballBulletSprite(),xPos,yPos,-1,0,1,1);
                  }
               }
            }
            else if(sprite.gfxHandleClip().isComplete)
            {
               counter1 = counter2 = 0;
               sprite.gfxHandleClip().gotoAndStop(1);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
   }
}
