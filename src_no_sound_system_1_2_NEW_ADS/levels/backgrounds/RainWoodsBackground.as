package levels.backgrounds
{
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.background.*;
   import sprites.particles.*;
   import starling.core.Starling;
   import starling.display.Image;
   
   public class RainWoodsBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var rain_counter:int;
      
      protected var pollen_counter_1:int;
      
      public var pollen_spawn_time:int;
      
      protected var smoke_counter_1:int;
      
      protected var smoke_counter_2:int;
      
      protected var sky_layer:Image;
      
      public var SPEED:Number;
      
      internal var layer_0_offset:Number;
      
      internal var layer_1_offset:Number;
      
      internal var layer_2_offset:Number;
      
      internal var layer_foreground_offset:Number;
      
      protected var IS_STRONG_RAIN:Boolean;
      
      public function RainWoodsBackground(_level:Level)
      {
         super(_level);
         this.IS_STRONG_RAIN = false;
         Starling.current.stage.color = 9152949;
         this.pCounter = this.pollen_counter_1 = 0;
         this.pollen_spawn_time = this.rain_counter = 0;
         this.layer_0_offset = this.layer_1_offset = this.layer_2_offset = this.layer_foreground_offset = 0;
         this.smoke_counter_1 = this.smoke_counter_2 = 0;
         this.SPEED = 0;
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_19"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
         backgroundContainer.setChildIndex(layer_1_5,backgroundContainer.getChildIndex(layer_2) + 1);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         super.update();
         if(this.rain_counter > -1)
         {
            --this.rain_counter;
            if(this.rain_counter <= 0)
            {
               if(this.IS_STRONG_RAIN)
               {
                  this.rain_counter = 1;
               }
               else
               {
                  this.rain_counter = 3;
               }
               pSprite = new RainStormBackgroundParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  pSprite.gfxHandleClip().gotoAndStop(2);
               }
               if(Math.random() * 100 > 50)
               {
                  particlesManager.pushParticle(pSprite,level.camera.xPos + level.camera.WIDTH * 1.25,level.camera.yPos - 96 + Math.random() * level.camera.HEIGHT,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
               }
               else
               {
                  particlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.yPos - 72,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
               }
            }
         }
      }
      
      public function setScroll(speed:Number = -2) : *
      {
         this.SPEED = speed;
         this.layer_0_offset += speed * mult0;
         if(this.layer_0_offset <= -544)
         {
            this.layer_0_offset += 544;
         }
         this.layer_1_offset += speed * mult1;
         if(this.layer_1_offset <= -264)
         {
            this.layer_1_offset += 264;
         }
         this.layer_2_offset += speed * mult2;
         if(this.layer_2_offset <= -672)
         {
            this.layer_2_offset += 672;
         }
         this.layer_foreground_offset += speed * 1.2;
         if(this.layer_foreground_offset <= -48)
         {
            this.layer_foreground_offset += 48;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         layer_0.x = int(Math.floor(xPos - camera.xPos) * mult0 + this.layer_0_offset);
         layer_0.y = int(Math.floor(yPos - camera.yPos) * mult0_y);
         layer_1.x = int(Math.floor(xPos - camera.xPos) * mult1 + this.layer_1_offset);
         layer_1.y = int(Math.floor(yPos - camera.yPos) * mult1_y);
         layer_2.x = int(Math.floor(xPos - camera.xPos * mult2) + this.layer_2_offset);
         layer_2.y = int(Math.floor(yPos - camera.yPos) * mult2_y);
         layer_foreground.x = int(Math.floor(xPos - camera.xPos * 1.2) + this.layer_foreground_offset);
         layer_foreground.y = int(Math.floor(yPos - camera.yPos * 1.2));
         for(i = 0; i < elements.length; i++)
         {
            if(elements[i] != null)
            {
               elements[i].updateScreenPosition(camera);
            }
         }
         particlesManager.updateScreenPositions(camera);
         topParticlesManager.updateScreenPositions(camera);
         layer_static.setChildIndex(this.sky_layer,0);
         backgroundContainer.setChildIndex(layer_static,0);
      }
      
      public function setStrongRain(isStrong:Boolean = false) : void
      {
         this.IS_STRONG_RAIN = isStrong;
      }
      
      override public function particles(area:ParticleArea) : void
      {
      }
      
      override public function shake() : void
      {
      }
   }
}
