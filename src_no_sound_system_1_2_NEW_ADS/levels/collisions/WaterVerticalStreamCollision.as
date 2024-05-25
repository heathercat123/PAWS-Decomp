package levels.collisions
{
   import entities.Hero;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.particles.StreamBubbleParticleSprite;
   
   public class WaterVerticalStreamCollision extends Collision
   {
       
      
      public var DIRECTION:int;
      
      protected var intersection_counter:Number;
      
      public function WaterVerticalStreamCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _side:int)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         aabb.x = xPos;
         aabb.y = yPos;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         if(_side == 0)
         {
            this.DIRECTION = -1;
         }
         else
         {
            aabb.y = yPos - HEIGHT;
            this.DIRECTION = 1;
         }
         counter1 = counter2 = 0;
         this.intersection_counter = 0;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
      }
      
      override public function update() : void
      {
         var pSprite:GameSprite = null;
         --counter1;
         if(counter1 < 0)
         {
            counter1 = Math.random() * 10 + 5;
            if(this.DIRECTION < 0)
            {
               pSprite = new StreamBubbleParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  pSprite.gfxHandleClip().gotoAndStop(2);
               }
               level.particlesManager.pushParticle(pSprite,aabb.x + Math.random() * aabb.width,aabb.y + aabb.height,0,-(Math.random() * 2 + 1),1,aabb.y,-1);
            }
            else
            {
               pSprite = new StreamBubbleParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  pSprite.gfxHandleClip().gotoAndStop(2);
               }
               level.particlesManager.pushParticle(pSprite,aabb.x + Math.random() * aabb.width,aabb.y,0,Math.random() * 2 + 1,1,aabb.y + aabb.height,-1);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = level.hero.getAABB();
         if(hero_aabb.intersects(aabb))
         {
            this.intersection_counter += 0.02;
            if(this.intersection_counter >= 10)
            {
               this.intersection_counter = 10;
            }
            if(this.DIRECTION < 0)
            {
               if(Hero.GetCurrentCat() == Hero.CAT_MARA)
               {
                  level.hero.yVel -= 0.02;
               }
               else
               {
                  level.hero.yVel -= this.intersection_counter * 0.08;
               }
            }
            else if(Hero.GetCurrentCat() == Hero.CAT_MARA)
            {
               level.hero.yVel += 0.02;
            }
            else
            {
               level.hero.yVel += this.intersection_counter * 0.08;
            }
         }
         else
         {
            this.intersection_counter = 0;
         }
      }
   }
}
