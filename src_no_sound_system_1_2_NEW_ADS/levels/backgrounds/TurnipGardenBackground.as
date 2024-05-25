package levels.backgrounds
{
   import flash.geom.Point;
   import levels.Level;
   import levels.cameras.*;
   import sprites.particles.GreenLeafBackgroundParticleSprite;
   import sprites.particles.PollenBackgroundParticleSprite;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class TurnipGardenBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var TYPE:int;
      
      protected var cloudsContainer:Sprite;
      
      protected var clouds:Array;
      
      protected var cloudsData:Array;
      
      protected var cloudStep:int;
      
      protected var small_clouds:Array;
      
      protected var small_cloudsData:Array;
      
      protected var small_cloudStep:int;
      
      public var cloud_y_shift:Number;
      
      protected var pollen_counter_1:int;
      
      public var pollen_spawn_time:int;
      
      protected var smoke_counter_1:int;
      
      protected var smoke_counter_2:int;
      
      protected var sky_layer:Image;
      
      public function TurnipGardenBackground(_level:Level, _type:int = 0)
      {
         var i:int = 0;
         var j:int = 0;
         var image:Image = null;
         var amount:int = 0;
         super(_level);
         this.TYPE = _type;
         Starling.current.stage.color = 0;
         this.pCounter = this.pollen_counter_1 = 0;
         this.pollen_spawn_time = 0;
         this.cloud_y_shift = 0;
         this.smoke_counter_1 = this.smoke_counter_2 = 0;
         if(this.TYPE == 1 || this.TYPE == 3 || this.TYPE == 4)
         {
            this.cloudStep = 128;
            this.small_cloudStep = 96;
            amount = int(Utils.WIDTH / this.cloudStep) + 2;
            this.clouds = new Array();
            this.cloudsData = new Array();
            this.cloudsContainer = new Sprite();
            backgroundContainer.addChild(this.cloudsContainer);
            backgroundContainer.setChildIndex(this.cloudsContainer,0);
            for(i = 0; i < amount; i++)
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("sea_cloud_1"));
               image.x = i * this.cloudStep;
               image.y = -4;
               this.cloudsData.push(new Point(i * this.cloudStep,-4));
               this.cloudsContainer.addChild(image);
               this.clouds.push(image);
            }
            this.small_clouds = new Array();
            this.small_cloudsData = new Array();
            amount = int(Utils.WIDTH / this.small_cloudStep) + 2;
            for(i = 0; i < amount; i++)
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("sea_cloud_2"));
               image.x = i * this.small_cloudStep;
               image.y = 32;
               this.small_cloudsData.push(new Point(i * this.small_cloudStep,32));
               this.cloudsContainer.addChild(image);
               this.small_clouds.push(image);
            }
         }
         if(this.TYPE == 1)
         {
            this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_13"));
         }
         else if(this.TYPE == 2)
         {
            this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_24"));
         }
         else
         {
            this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_4"));
         }
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.TYPE == 1 || this.TYPE == 3 || this.TYPE == 4)
         {
            for(i = 0; i < this.small_clouds.length; i++)
            {
               this.cloudsContainer.removeChild(this.small_clouds[i]);
               this.small_clouds[i].dispose();
               this.small_clouds[i] = null;
               this.small_cloudsData[i] = null;
            }
            this.small_clouds = null;
            this.small_cloudsData = null;
            for(i = 0; i < this.clouds.length; i++)
            {
               this.cloudsContainer.removeChild(this.clouds[i]);
               this.clouds[i].dispose();
               this.clouds[i] = null;
               this.cloudsData[i] = null;
            }
            this.clouds = null;
            this.cloudsData = null;
            backgroundContainer.removeChild(this.cloudsContainer);
            this.cloudsContainer.dispose();
            this.cloudsContainer = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var mult:Number = NaN;
         var pSprite:PollenBackgroundParticleSprite = null;
         super.update();
         if(this.TYPE == 1 || this.TYPE == 3 || this.TYPE == 4)
         {
            mult = 0.75;
            for(i = 0; i < this.cloudsData.length; i++)
            {
               this.cloudsData[i].x -= 0.5 * mult;
               if(this.cloudsData[i].x <= -this.cloudStep)
               {
                  this.cloudsData[i].x += this.cloudsData.length * this.cloudStep;
               }
            }
            for(i = 0; i < this.small_cloudsData.length; i++)
            {
               this.small_cloudsData[i].x -= 0.375 * mult;
               if(this.small_cloudsData[i].x <= -this.small_cloudStep)
               {
                  this.small_cloudsData[i].x += this.small_cloudsData.length * this.small_cloudStep;
               }
            }
         }
         if(this.TYPE == 4)
         {
            if(this.pollen_spawn_time > -1)
            {
               if(this.pollen_counter_1-- < this.pollen_spawn_time)
               {
                  this.pollen_counter_1 = Math.random() * 15 + 15;
                  pSprite = new PollenBackgroundParticleSprite();
                  if(Math.random() * 100 > 50)
                  {
                     pSprite.scaleX = -1;
                  }
                  else
                  {
                     pSprite.scaleX = 1;
                  }
                  if(Math.random() * 100 > 50)
                  {
                     particlesManager.pushParticle(pSprite,level.camera.xPos + level.camera.WIDTH,level.camera.yPos + Math.random() * level.camera.HEIGHT,0,0,1,0,0.25 * int(Math.random() * 3),Math.random() * Math.PI * 2);
                  }
                  else
                  {
                     particlesManager.pushParticle(pSprite,level.camera.xPos + level.camera.WIDTH + 16,level.camera.yPos + level.camera.HALF_HEIGHT + Math.random() * level.camera.HALF_HEIGHT,0,0,1,0,0.25 * int(Math.random() * 3),Math.random() * Math.PI * 2);
                  }
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var mult:Number = NaN;
         super.updateScreenPosition(camera);
         if(this.TYPE == 1 || this.TYPE == 3 || this.TYPE == 4)
         {
            this.cloudsContainer.x = 0;
            this.cloudsContainer.y = 0;
            for(i = 0; i < this.clouds.length; i++)
            {
               if(this.clouds[i] != null)
               {
                  this.clouds[i].x = int(Math.floor(this.cloudsData[i].x));
                  this.clouds[i].y = int(Math.floor(this.cloudsData[i].y + this.cloud_y_shift));
               }
            }
            for(i = 0; i < this.small_clouds.length; i++)
            {
               if(this.small_clouds[i] != null)
               {
                  this.small_clouds[i].x = int(Math.floor(this.small_cloudsData[i].x));
                  this.small_clouds[i].y = int(Math.floor(this.small_cloudsData[i].y + this.cloud_y_shift));
               }
            }
         }
         layer_static.setChildIndex(this.sky_layer,0);
         backgroundContainer.setChildIndex(layer_static,0);
      }
      
      override public function particles(area:ParticleArea) : void
      {
         if(area.counter1++ > 0)
         {
            area.counter1 = -(Math.random() * 20 + 5);
            particlesManager.pushParticle(new GreenLeafBackgroundParticleSprite(),area.aabb.x + Math.random() * area.aabb.width,area.aabb.y,0,0,1,0,0.5 * int(Math.random() * 2));
         }
      }
      
      override public function shake() : void
      {
         var i:int = 0;
         var amount:int = Math.random() * 5 + 8;
         for(i = 0; i < amount; i++)
         {
            particlesManager.pushParticle(new GreenLeafBackgroundParticleSprite(),level.camera.xPos + Math.random() * level.camera.WIDTH,level.camera.yPos - (Math.random() * 2 + 1) * 16,0,0,1,0,0.5 * int(Math.random() * 3));
         }
      }
   }
}
