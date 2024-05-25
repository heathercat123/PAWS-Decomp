package levels.collisions
{
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.MushroomCollisionSprite;
   import sprites.particles.SnowParticleSprite;
   
   public class MushroomCollision extends Collision
   {
       
      
      protected var anim_start_frame:int;
      
      protected var anim_counter:int;
      
      protected var type:int;
      
      protected var IS_SNOW:Boolean;
      
      public function MushroomCollision(_level:Level, _xPos:Number, _yPos:Number, _type:int)
      {
         super(_level,_xPos,_yPos);
         this.type = _type;
         if(this.type == 1)
         {
            this.IS_SNOW = true;
         }
         sprite = new MushroomCollisionSprite(_type);
         Utils.topWorld.addChild(sprite);
         if(xPos % 2 == 0)
         {
            this.anim_start_frame = 2;
         }
         else
         {
            this.anim_start_frame = 1;
         }
         this.anim_counter = 0;
         WIDTH = HEIGHT = 16;
         aabb.x = 2;
         aabb.y = 2;
         aabb.width = 12;
         aabb.height = 8;
         if(this.type == 2)
         {
            aabb.x = 2 + 1;
            aabb.y = 2 + -2;
            aabb.width = 12 + 14;
            aabb.height = 8;
         }
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         ++this.anim_counter;
         if(this.anim_counter >= 60)
         {
            this.anim_counter = 0;
            ++this.anim_start_frame;
            if(this.anim_start_frame > 2)
            {
               this.anim_start_frame = 1;
            }
         }
         if(sprite.frame == 2)
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               sprite.gotoAndStop(1);
            }
         }
         if(isInsideScreen())
         {
         }
         if(this.type == 1)
         {
            if(!isInsideScreen())
            {
               this.IS_SNOW = true;
               sprite.gotoAndStop(3);
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(sprite.frame == 1)
         {
            sprite.gfxHandleClip().gotoAndStop(this.anim_start_frame);
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = level.hero.getAABB();
         var mushroom_aabb:Rectangle = getAABB();
         if(this.type == 2)
         {
            if(hero_aabb.intersects(mushroom_aabb) && hero_aabb.y + hero_aabb.height < yPos + 8)
            {
               level.hero.bounceCollision();
               sprite.gotoAndStop(2);
               sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         else if(level.hero.stateMachine.currentState == "IS_FALLING_STATE" || level.hero.stateMachine.currentState == "IS_FALLING_RUNNING_STATE")
         {
            if(hero_aabb.intersects(mushroom_aabb) && hero_aabb.y + hero_aabb.height < yPos + 8)
            {
               level.hero.bounceCollision();
               sprite.gotoAndStop(2);
               sprite.gfxHandleClip().gotoAndPlay(1);
               if(this.IS_SNOW)
               {
                  this.blow();
                  this.IS_SNOW = false;
               }
            }
         }
      }
      
      protected function blow() : void
      {
         var pSprite:SnowParticleSprite = null;
         var angle:Number = NaN;
         var i:int = 0;
         var vel:Number = NaN;
         SoundSystem.PlaySound("decoration_blown");
         var _vel:Number = 1.25;
         if(level.hero.xVel < 0)
         {
            _vel = -1.25;
         }
         var max:int = 3;
         if(Math.random() * 100 > 80)
         {
            max = 4;
         }
         for(i = 0; i < max; i++)
         {
            pSprite = new SnowParticleSprite();
            angle = Math.random() * Math.PI * 2;
            if(i % 2 == 0)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            vel = _vel * (i * 0.5 + 1 + Math.random() * 1);
            level.particlesManager.pushParticle(pSprite,xPos + 7,yPos + 6,vel,-(2 + Math.random() * 1),0.98,(int(Math.random() * 2) + (i + 1)) * 0.1);
         }
      }
   }
}
