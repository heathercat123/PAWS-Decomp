package levels.collisions
{
   import entities.Entity;
   import entities.Hero;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.particles.StreamBubbleParticleSprite;
   
   public class WaterStreamCollision extends Collision
   {
       
      
      public var DIRECTION:int;
      
      protected var intersection_counter:Number;
      
      public function WaterStreamCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _side:int)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         this.DIRECTION = _side;
         aabb.x = xPos;
         aabb.y = yPos;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         if(_side == 1)
         {
            aabb.x = xPos - WIDTH;
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
            if(this.DIRECTION == Entity.RIGHT)
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
               level.particlesManager.pushParticle(pSprite,aabb.x,yPos + Math.random() * aabb.height,Math.random() * 2 + 1,0,1,aabb.x + aabb.width);
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
               level.particlesManager.pushParticle(pSprite,aabb.x + aabb.width,yPos + Math.random() * aabb.height,-(Math.random() * 2 + 1),0,1,aabb.x);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var mult:Number = 1;
         if(Hero.GetCurrentCat() == Hero.CAT_MARA)
         {
            mult = 0.5;
         }
         var hero_aabb:Rectangle = level.hero.getAABB();
         if(hero_aabb.intersects(aabb))
         {
            this.intersection_counter += 0.02;
            if(this.intersection_counter >= 10)
            {
               this.intersection_counter = 10;
            }
            if(this.DIRECTION == Entity.RIGHT)
            {
               if(Hero.GetCurrentCat() == Hero.CAT_MARA)
               {
                  level.hero.xVel += 0.02;
               }
               else
               {
                  level.hero.xVel += this.intersection_counter * 0.1 * mult;
               }
            }
            else if(Hero.GetCurrentCat() == Hero.CAT_MARA)
            {
               level.hero.xVel -= 0.02;
            }
            else
            {
               level.hero.xVel -= this.intersection_counter * 0.1 * mult;
            }
         }
         else
         {
            this.intersection_counter = 0;
         }
      }
   }
}
