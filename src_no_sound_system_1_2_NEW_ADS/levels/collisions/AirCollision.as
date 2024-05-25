package levels.collisions
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.particles.StreamAirParticleSprite;
   
   public class AirCollision extends Collision
   {
       
      
      public var DIRECTION:int;
      
      protected var intersection_counter:Number;
      
      protected var outer_aabb:Rectangle;
      
      protected var ground_level:Number;
      
      protected var additional_power:Number;
      
      public function AirCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _ground_t_level:int)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         aabb.x = xPos;
         aabb.y = yPos;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         this.ground_level = yPos + (_ground_t_level + 1) * Utils.TILE_HEIGHT;
         this.outer_aabb = new Rectangle(xPos - Utils.TILE_WIDTH * 0.5,yPos - Utils.TILE_HEIGHT,WIDTH + Utils.TILE_WIDTH * 1,HEIGHT + Utils.TILE_HEIGHT * 2);
         this.DIRECTION = -1;
         counter1 = counter2 = 0;
         this.intersection_counter = 0;
         this.additional_power = 0;
      }
      
      override public function destroy() : void
      {
         this.outer_aabb = null;
         super.destroy();
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
               pSprite = new StreamAirParticleSprite();
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
               pSprite = new StreamAirParticleSprite();
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
         var power:Number = NaN;
         var hero_aabb:Rectangle = level.hero.getAABB();
         if(!level.hero.IS_IN_AIR)
         {
            if(hero_aabb.intersects(aabb))
            {
               level.hero.setInsideAir(this);
            }
         }
         else if(level.hero.airCollision == this)
         {
            if(!hero_aabb.intersects(this.outer_aabb))
            {
               level.hero.setOutsideAir();
               this.intersection_counter = 0;
               this.additional_power = 0;
            }
            else
            {
               power = this.evaluateCenterDistance(level.hero);
               this.intersection_counter += 0.01;
               if(this.intersection_counter >= 1)
               {
                  this.intersection_counter = 1;
               }
               if(level.hero.yPos >= this.ground_level)
               {
                  this.additional_power += 0.1;
               }
               if(level.hero.stateMachine.currentState != "IS_CLIMBING_STATE" && level.hero.stateMachine.currentState != "IS_DRIFTING_STATE")
               {
                  level.hero.yVel -= power * 0.3 + this.additional_power;
               }
            }
         }
      }
      
      protected function evaluateCenterDistance(entity:Entity) : Number
      {
         var entity_mid_x:Number = entity.xPos + entity.WIDTH * 0.5;
         var center_x:Number = xPos + WIDTH * 0.5;
         var diff_x:Number = Math.abs(center_x - entity_mid_x);
         var HALF_WIDTH:Number = WIDTH * 0.5;
         return 1 - diff_x / HALF_WIDTH;
      }
   }
}
