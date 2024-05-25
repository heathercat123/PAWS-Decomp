package levels.backgrounds
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import levels.Level;
   import levels.cameras.*;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class CanyonBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var sky_layer:Image;
      
      protected var cloudsContainer:Sprite;
      
      protected var TYPE:int;
      
      protected var clouds:Array;
      
      protected var cloudsData:Array;
      
      protected var cloudStep:int;
      
      protected var clouds_bottom_image:Image;
      
      protected var sun:Image;
      
      public function CanyonBackground(_level:Level, type:int = 0)
      {
         var obj:DisplayObject = null;
         var sub_obj:DisplayObject = null;
         var mClip:MovieClip = null;
         var layer:Sprite = null;
         var i:int = 0;
         super(_level);
         this.TYPE = type;
         Starling.current.stage.color = 0;
         this.pCounter = 0;
         this.cloudsContainer = null;
         this.clouds = null;
         this.cloudsData = null;
         if(this.TYPE != 2)
         {
            this.initClouds();
         }
         if(this.TYPE == 1)
         {
            this.sun = null;
         }
         else
         {
            this.sun = new Image(TextureManager.GetBackgroundTexture().getTexture("canyon_sun_background"));
            this.sun.touchable = false;
            this.sun.pivotX = this.sun.pivotY = 41;
            this.sun.x = int(Utils.WIDTH * 0.5);
            this.sun.y = 0;
         }
         if(this.TYPE == 1)
         {
            this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_13"));
         }
         else
         {
            this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_21"));
         }
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
         if(this.sun != null)
         {
            layer_static.addChild(this.sun);
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.sun != null)
         {
            layer_static.removeChild(this.sun);
            this.sun.dispose();
            this.sun = null;
         }
         if(this.cloudsContainer != null)
         {
            if(this.clouds_bottom_image != null)
            {
               this.cloudsContainer.removeChild(this.clouds_bottom_image);
               this.clouds_bottom_image.dispose();
               this.clouds_bottom_image = null;
            }
         }
         if(this.clouds != null)
         {
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
         super.update();
         if(this.cloudsData != null)
         {
            for(i = 0; i < this.cloudsData.length; i++)
            {
               this.cloudsData[i].x -= 0.25;
               if(this.cloudsData[i].x <= -this.cloudStep)
               {
                  this.cloudsData[i].x += this.cloudsData.length * this.cloudStep;
               }
            }
         }
         if(this.TYPE == 3)
         {
            layer_0_x_offset += 0.5;
            if(layer_0_x_offset >= 288)
            {
               layer_0_x_offset -= 288;
            }
            layer_0_y_offset += 0.025;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var mult:Number = NaN;
         super.updateScreenPosition(camera);
         if(this.cloudsContainer != null)
         {
            this.cloudsContainer.x = 0;
            this.cloudsContainer.y = 0;
         }
         if(this.clouds != null)
         {
            for(i = 0; i < this.clouds.length; i++)
            {
               if(this.clouds[i] != null)
               {
                  this.clouds[i].x = int(Math.floor(this.cloudsData[i].x));
                  this.clouds[i].y = int(Math.floor(this.cloudsData[i].y));
               }
            }
         }
         layer_static.setChildIndex(this.sky_layer,0);
         backgroundContainer.setChildIndex(layer_static,0);
      }
      
      protected function initClouds() : void
      {
         var i:int = 0;
         var j:int = 0;
         var image:Image = null;
         this.cloudStep = 184;
         var amount:int = int(Utils.WIDTH / this.cloudStep) + 2;
         this.clouds = new Array();
         this.cloudsData = new Array();
         this.cloudsContainer = new Sprite();
         backgroundContainer.addChild(this.cloudsContainer);
         backgroundContainer.setChildIndex(this.cloudsContainer,0);
         var _image_y:Number = 0;
         for(i = 0; i < amount; i++)
         {
            image = new Image(TextureManager.GetBackgroundTexture().getTexture("canyon_mountains_3"));
            image.x = i * this.cloudStep;
            image.y = _image_y = int(Utils.HEIGHT * 0.33);
            this.cloudsData.push(new Point(i * this.cloudStep,int(image.y)));
            this.cloudsContainer.addChild(image);
            this.clouds.push(image);
         }
         this.clouds_bottom_image = new Image(TextureManager.GetBackgroundTexture().getTexture("background_white"));
         this.clouds_bottom_image.width = int(Utils.WIDTH);
         this.clouds_bottom_image.height = int(Utils.HEIGHT * 0.75);
         this.cloudsContainer.addChild(this.clouds_bottom_image);
         this.clouds_bottom_image.x = 0;
         this.clouds_bottom_image.y = _image_y + 32;
      }
      
      override public function particles(area:ParticleArea) : void
      {
         var i:int = 0;
         var amount:int = 0;
         if(level.camera.getCameraOuterRect().intersects(area.aabb))
         {
            if(area.counter1++ > 0)
            {
               area.counter1 = -(int(Math.random() * 2 + 5) * 60);
               amount = Math.random() * 2 + 3;
               for(i = 0; i < 4; i++)
               {
                  particlesManager.createClusterRocks(area.aabb.x + Math.random() * area.aabb.width,level.camera.yPos - (i * Utils.TILE_HEIGHT * 2 + 16));
               }
               level.camera.shake(1,false,30);
            }
         }
      }
      
      override public function shake() : void
      {
         var i:int = 0;
         var amount:int = Math.random() * 2 + 3;
         for(i = 0; i < 4; i++)
         {
            if(i < 2)
            {
               particlesManager.createClusterRocks(level.camera.xPos + Math.random() * level.camera.HALF_WIDTH,level.camera.yPos - (i * Utils.TILE_HEIGHT * 2 + 16));
            }
            else
            {
               particlesManager.createClusterRocks(level.camera.xPos + level.camera.HALF_WIDTH + Math.random() * level.camera.HALF_WIDTH,level.camera.yPos - (i * Utils.TILE_HEIGHT * 2 + 16));
            }
         }
      }
   }
}
