package levels.backgrounds
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.background.NightSnowBackgroundParticleSprite;
   import starling.core.Starling;
   import starling.display.Image;
   
   public class MountainSnowNightBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var ORIGINAL_FOG_Y_POS:Number;
      
      protected var FOG_Y_POS:Number;
      
      protected var snow_counter:int;
      
      protected var wind_counter:int;
      
      protected var wind_extra_force:Number;
      
      protected var WIND_GO_FASTER:Boolean;
      
      protected var INIT_SNOW:Boolean;
      
      protected var sky_layer:Image;
      
      public function MountainSnowNightBackground(_level:Level)
      {
         super(_level);
         Starling.current.stage.color = 0;
         this.snow_counter = 0;
         this.wind_counter = int(Math.random() * 10 + 2) * 60;
         this.wind_extra_force = 0;
         this.WIND_GO_FASTER = true;
         this.INIT_SNOW = true;
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_9"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function update() : void
      {
         var pSprite:GameSprite = null;
         super.update();
         if(this.INIT_SNOW)
         {
            this.INIT_SNOW = false;
            this.initSnow();
         }
         if(this.wind_counter-- < 0)
         {
            this.WIND_GO_FASTER = !this.WIND_GO_FASTER;
            if(this.WIND_GO_FASTER)
            {
               SoundSystem.PlaySound("wind_strong_start");
               this.wind_counter = int(Math.random() * 6 + 6) * 60;
            }
            else
            {
               this.wind_counter = int(Math.random() * 3 + 2) * 60;
            }
         }
         if(this.WIND_GO_FASTER)
         {
            this.wind_extra_force += 0.025;
            if(this.wind_extra_force >= 2)
            {
               this.wind_extra_force = 2;
            }
         }
         else
         {
            this.wind_extra_force -= 0.025;
            if(this.wind_extra_force <= 0)
            {
               this.wind_extra_force = 0;
            }
         }
         Utils.WIND_X_VEL = 3 + this.wind_extra_force;
         if(this.snow_counter++ > 0)
         {
            this.snow_counter = -3;
            pSprite = new NightSnowBackgroundParticleSprite();
            pSprite.gfxHandleClip().gotoAndStop(int(Math.random() * 4) + 1);
            pSprite.rotation = int(Math.random() * 4) * (Math.PI * 0.5);
            if(Math.random() * 100 > 50)
            {
               if(pSprite.gfxHandleClip().currentFrame % 2 != 0)
               {
                  pSprite.gfxHandleClip().gotoAndStop(pSprite.gfxHandleClip().currentFrame);
               }
               if(Math.random() * 100 > 50)
               {
                  topParticlesManager.pushParticle(pSprite,level.camera.xPos - level.camera.WIDTH * 0.5,level.camera.yPos - 96 + Math.random() * level.camera.HEIGHT,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
               }
               else
               {
                  topParticlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.yPos - 32,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
               }
            }
            else if(Math.random() * 100 > 50)
            {
               particlesManager.pushParticle(pSprite,level.camera.xPos - level.camera.WIDTH * 0.5,level.camera.yPos - 96 + Math.random() * level.camera.HEIGHT,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
            }
            else
            {
               particlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.yPos - 32,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         layer_static.setChildIndex(this.sky_layer,0);
         backgroundContainer.setChildIndex(layer_static,0);
      }
      
      override public function particles(area:ParticleArea) : void
      {
      }
      
      override public function shake() : void
      {
      }
      
      protected function initSnow() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         for(i = 0; i < 8; i++)
         {
            pSprite = new NightSnowBackgroundParticleSprite();
            pSprite.gfxHandleClip().gotoAndStop(int(Math.random() * 4) + 1);
            pSprite.rotation = int(Math.random() * 4) * (Math.PI * 0.5);
            if(Math.random() * 100 > 50)
            {
               if(pSprite.gfxHandleClip().currentFrame % 2 != 0)
               {
                  pSprite.gfxHandleClip().gotoAndStop(pSprite.gfxHandleClip().currentFrame);
               }
               if(Math.random() * 100 > 50)
               {
                  topParticlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.yPos + Math.random() * level.camera.HEIGHT,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
               }
               else
               {
                  topParticlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.yPos + Math.random() * level.camera.HEIGHT,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
               }
            }
            else if(Math.random() * 100 > 50)
            {
               particlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.yPos + Math.random() * level.camera.HEIGHT,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
            }
            else
            {
               particlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.yPos + Math.random() * level.camera.HEIGHT,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
            }
         }
      }
   }
}
