package levels.backgrounds
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.*;
   import sprites.background.SeaReflectionBackgroundSprite;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class SeasideBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var cloudsContainer:Sprite;
      
      protected var clouds:Array;
      
      protected var cloudsData:Array;
      
      protected var cloudStep:int;
      
      protected var reflections:Vector.<SeaReflectionBackgroundSprite>;
      
      protected var reflectionsData1:Vector.<Rectangle>;
      
      protected var reflectionsData2:Vector.<Rectangle>;
      
      protected var small_clouds:Array;
      
      protected var small_cloudsData:Array;
      
      protected var small_cloudStep:int;
      
      public var cloud_y_shift:Number;
      
      protected var sky_layer:Image;
      
      protected var TYPE:int;
      
      public function SeasideBackground(_level:Level, _arg:int = 0)
      {
         var i:int = 0;
         var j:int = 0;
         var image:Image = null;
         var amount:int = 0;
         var obj:DisplayObject = null;
         var sub_obj:DisplayObject = null;
         var mClip:MovieClip = null;
         var layer:Sprite = null;
         var ADD_REFLECTIONS_FLAG:Boolean = false;
         var reflection_yRef:Number = NaN;
         var sprite:SeaReflectionBackgroundSprite = null;
         var rand_y:Number = NaN;
         super(_level);
         this.TYPE = _arg;
         Starling.current.stage.color = 0;
         this.small_clouds = this.clouds = null;
         this.cloudsContainer = null;
         this.pCounter = 0;
         this.cloud_y_shift = 0;
         this.reflections = null;
         this.reflectionsData1 = null;
         this.reflectionsData2 = null;
         if(this.TYPE == 0)
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
            ADD_REFLECTIONS_FLAG = false;
            reflection_yRef = 0;
            if(level.levelData.bg_sea_reflections_y > 0)
            {
               ADD_REFLECTIONS_FLAG = true;
               reflection_yRef = level.levelData.bg_sea_reflections_y;
            }
            if(ADD_REFLECTIONS_FLAG)
            {
               this.reflections = new Vector.<SeaReflectionBackgroundSprite>();
               this.reflectionsData1 = new Vector.<Rectangle>();
               this.reflectionsData2 = new Vector.<Rectangle>();
               amount = 32;
               for(i = 0; i < amount; i++)
               {
                  sprite = new SeaReflectionBackgroundSprite();
                  rand_y = int(Math.random() * 5) * 4;
                  this.reflections.push(sprite);
                  this.reflectionsData1.push(new Rectangle(Math.random() * Utils.WIDTH,reflection_yRef + 2 + rand_y,(rand_y + 1) * 0.25,0));
                  this.reflectionsData2.push(new Rectangle());
                  layer_0.addChild(sprite);
               }
            }
         }
         if(this.TYPE == 1)
         {
            this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_23"));
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
         if(this.reflections != null)
         {
            for(i = 0; i < this.reflections.length; i++)
            {
               layer_0.removeChild(this.reflections[i]);
               this.reflections[i].destroy();
               this.reflections[i].dispose();
               this.reflections[i] = null;
               this.reflectionsData1[i] = null;
               this.reflectionsData2[i] = null;
            }
            this.reflections = null;
            this.reflectionsData1 = null;
            this.reflectionsData2 = null;
         }
         if(this.small_clouds != null)
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
         }
         this.clouds = null;
         this.cloudsData = null;
         if(this.cloudsContainer != null)
         {
            backgroundContainer.removeChild(this.cloudsContainer);
            this.cloudsContainer.dispose();
            this.cloudsContainer = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var time_alive:Number = NaN;
         super.update();
         if(this.TYPE == 0)
         {
            for(i = 0; i < this.cloudsData.length; i++)
            {
               this.cloudsData[i].x -= 0.5;
               if(this.cloudsData[i].x <= -this.cloudStep)
               {
                  this.cloudsData[i].x += this.cloudsData.length * this.cloudStep;
               }
            }
            for(i = 0; i < this.small_cloudsData.length; i++)
            {
               this.small_cloudsData[i].x -= 0.375;
               if(this.small_cloudsData[i].x <= -this.small_cloudStep)
               {
                  this.small_cloudsData[i].x += this.small_cloudsData.length * this.small_cloudStep;
               }
            }
         }
         if(this.reflections != null)
         {
            for(i = 0; i < this.reflectionsData1.length; i++)
            {
               if(this.reflectionsData1[i] != null)
               {
                  if(this.reflections[i].gfxHandleClip().isComplete)
                  {
                     this.reflections[i].visible = false;
                  }
                  --this.reflectionsData1[i].height;
                  this.reflectionsData1[i].x -= 0.02;
                  if(this.reflectionsData1[i].height < 0)
                  {
                     time_alive = (Math.random() * 2 + 1) * 60;
                     this.reflectionsData1[i].x = level.camera.xPos * mult0 + Math.random() * Utils.WIDTH;
                     this.reflectionsData1[i].height = 60 + Math.random() * 90;
                     this.reflections[i].visible = true;
                     this.reflections[i].gfxHandleClip().gotoAndPlay(1);
                  }
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var mult:Number = NaN;
         var screenStep:int = 0;
         super.updateScreenPosition(camera);
         if(this.TYPE == 0)
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
            if(this.reflections != null)
            {
               for(i = 0; i < this.reflections.length; i++)
               {
                  if(this.reflections[i] != null)
                  {
                     mult = this.reflectionsData1[i].width;
                     mult *= 0.05;
                     this.reflections[i].x = int(Math.floor(this.reflectionsData1[i].x - camera.xPos * mult));
                     this.reflections[i].y = int(Math.floor(this.reflectionsData1[i].y));
                  }
               }
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
         var i:int = 0;
         var amount:int = Math.random() * 2 + 3;
         for(i = 0; i < 4; i++)
         {
            if(i < 2)
            {
               level.topParticlesManager.createClusterBubbles(level.camera.xPos + Math.random() * level.camera.HALF_WIDTH,level.camera.yPos + level.camera.HEIGHT + i * Utils.TILE_HEIGHT + 4);
            }
            else
            {
               level.topParticlesManager.createClusterBubbles(level.camera.xPos + level.camera.HALF_WIDTH + Math.random() * level.camera.HALF_WIDTH,level.camera.yPos + level.camera.HEIGHT + i * Utils.TILE_HEIGHT + 4);
            }
         }
      }
   }
}
