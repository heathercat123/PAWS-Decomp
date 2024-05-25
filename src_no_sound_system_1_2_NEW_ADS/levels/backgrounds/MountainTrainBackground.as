package levels.backgrounds
{
   import entities.particles.ParticlesManager;
   import flash.geom.Point;
   import levels.Level;
   import levels.cameras.*;
   import sprites.particles.GreenLeafBackgroundParticleSprite;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class MountainTrainBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var cloudsContainer:Sprite;
      
      protected var clouds:Array;
      
      protected var cloudsData:Array;
      
      protected var cloudStep:int;
      
      protected var cloud_base_image:Image;
      
      protected var pollen_counter_1:int;
      
      public var pollen_spawn_time:int;
      
      protected var x_offset_1:Number;
      
      protected var x_offset_2:Number;
      
      protected var sky_layer:Image;
      
      public function MountainTrainBackground(_level:Level)
      {
         var i:int = 0;
         var image:Image = null;
         super(_level);
         Starling.current.stage.color = 0;
         this.pCounter = 0;
         this.pollen_counter_1 = 0;
         this.pollen_spawn_time = 0;
         this.x_offset_1 = this.x_offset_2 = 0;
         this.cloudStep = 256;
         var amount:int = int(Utils.WIDTH / this.cloudStep) + 2;
         this.clouds = new Array();
         this.cloudsData = new Array();
         this.cloudsContainer = new Sprite();
         backgroundContainer.addChild(this.cloudsContainer);
         backgroundContainer.setChildIndex(this.cloudsContainer,0);
         for(i = 0; i < amount; i++)
         {
            image = new Image(TextureManager.GetBackgroundTexture().getTexture("mountain_cloud_1"));
            image.x = i * this.cloudStep;
            image.y = int(Utils.HEIGHT * 0.5);
            image.pivotY = image.height;
            this.cloudsData.push(new Point(i * this.cloudStep,int(Utils.HEIGHT * 0.5)));
            this.cloudsContainer.addChild(image);
            this.clouds.push(image);
         }
         this.cloud_base_image = new Image(TextureManager.GetBackgroundTexture().getTexture("mountain_cloud_2"));
         this.cloud_base_image.width = Utils.WIDTH + 2;
         this.cloud_base_image.height = int(Utils.HEIGHT * 0.5 + 2);
         this.cloudsContainer.addChild(this.cloud_base_image);
         this.cloud_base_image.x = 0;
         this.cloud_base_image.y = int(Utils.HEIGHT * 0.5);
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_4"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.cloudsContainer.removeChild(this.cloud_base_image);
         this.cloud_base_image.dispose();
         this.cloud_base_image = null;
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
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GreenLeafBackgroundParticleSprite = null;
         super.update();
         ParticlesManager.GLOBAL_VARIABLE_1 = 4;
         this.pollen_spawn_time = 40;
         for(i = 0; i < this.cloudsData.length; i++)
         {
            this.cloudsData[i].x -= 0.25;
            if(this.cloudsData[i].x <= -this.cloudStep)
            {
               this.cloudsData[i].x += this.cloudsData.length * this.cloudStep;
            }
         }
         if(this.pollen_spawn_time > -1)
         {
            if(this.pollen_counter_1-- < this.pollen_spawn_time)
            {
               this.pollen_counter_1 = Math.random() * 30 + 40;
               pSprite = new GreenLeafBackgroundParticleSprite();
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
                  particlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.HALF_WIDTH + level.camera.HALF_WIDTH,level.camera.yPos + level.camera.HEIGHT + (Math.random() * 2 + 1) * 16,0,0,1,0,0.25 * int(Math.random() * 3),Math.random() * Math.PI * 2);
               }
               else
               {
                  particlesManager.pushParticle(pSprite,level.camera.xPos + level.camera.WIDTH + 16,level.camera.yPos + level.camera.HALF_HEIGHT + Math.random() * level.camera.HALF_HEIGHT,0,0,1,0,0.25 * int(Math.random() * 3),Math.random() * Math.PI * 2);
               }
            }
         }
         this.x_offset_1 += 1;
         this.x_offset_2 += 2;
         if(this.x_offset_1 >= 80)
         {
            this.x_offset_1 -= 80;
         }
         if(this.x_offset_2 >= 160)
         {
            this.x_offset_2 -= 160;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         layer_0.x = int(Math.floor(xPos - camera.xPos) * mult0);
         layer_0.y = int(Math.floor(yPos - camera.yPos) * mult0_y);
         layer_1.x = int(Math.floor(xPos - camera.xPos) * mult1 - this.x_offset_1);
         layer_1.y = int(Math.floor(yPos - camera.yPos) * mult1_y);
         layer_2.x = int(Math.floor(xPos - camera.xPos) * mult2 - this.x_offset_2);
         layer_2.y = int(Math.floor(yPos - camera.yPos) * mult2_y);
         for(i = 0; i < elements.length; i++)
         {
            if(elements[i] != null)
            {
               elements[i].updateScreenPosition(camera);
            }
         }
         particlesManager.updateScreenPositions(camera);
         this.cloudsContainer.x = 0;
         this.cloudsContainer.y = 0;
         for(i = 0; i < this.clouds.length; i++)
         {
            if(this.clouds[i] != null)
            {
               this.clouds[i].x = int(Math.floor(this.cloudsData[i].x));
               this.clouds[i].y = int(Math.floor(this.cloudsData[i].y));
            }
         }
         layer_static.setChildIndex(this.sky_layer,0);
         backgroundContainer.setChildIndex(layer_static,0);
      }
      
      override public function particles(area:ParticleArea) : void
      {
      }
      
      override public function shake() : void
      {
      }
   }
}
