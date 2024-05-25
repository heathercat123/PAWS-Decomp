package levels.backgrounds
{
   import flash.geom.Point;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import sprites.particles.PollenBackgroundParticleSprite;
   import sprites.particles.SlowGreySmokeParticleSprite;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import states.LevelState;
   
   public class KittyHouseRoofBackground extends Background
   {
       
      
      protected var TYPE:int;
      
      protected var pCounter:int;
      
      protected var cloudsContainer:Sprite;
      
      protected var clouds:Array;
      
      protected var cloudsData:Array;
      
      protected var cloudStep:int;
      
      protected var small_clouds:Array;
      
      protected var small_cloudsData:Array;
      
      protected var small_cloudStep:int;
      
      protected var tiny_clouds:Array;
      
      protected var tiny_cloudsData:Array;
      
      protected var tiny_cloudStep:int;
      
      protected var pollen_counter_1:int;
      
      public var pollen_spawn_time:int;
      
      protected var smoke_counter_1:int;
      
      protected var smoke_counter_2:int;
      
      protected var sky_layer:Image;
      
      protected var sky_fade_layer:Image;
      
      public function KittyHouseRoofBackground(_level:Level, _type:int = 0)
      {
         var i:int = 0;
         var image:Image = null;
         var amount:int = 0;
         super(_level);
         this.TYPE = _type;
         Starling.current.stage.color = 0;
         this.pCounter = this.pollen_counter_1 = 0;
         this.pollen_spawn_time = 0;
         this.smoke_counter_1 = this.smoke_counter_2 = 0;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_4)
         {
            this.pollen_spawn_time = 20;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_2_1)
         {
            this.pollen_spawn_time = -1;
         }
         this.cloudStep = 128;
         this.small_cloudStep = 96;
         this.tiny_cloudStep = 72;
         amount = int(Utils.WIDTH / this.cloudStep) + 2;
         this.clouds = new Array();
         this.cloudsData = new Array();
         this.cloudsContainer = new Sprite();
         backgroundContainer.addChild(this.cloudsContainer);
         backgroundContainer.setChildIndex(this.cloudsContainer,0);
         for(i = 0; i < amount; i++)
         {
            image = new Image(TextureManager.GetBackgroundTexture().getTexture("yellow_cloud_1"));
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
            image = new Image(TextureManager.GetBackgroundTexture().getTexture("yellow_cloud_2"));
            image.x = i * this.small_cloudStep;
            image.y = 32;
            this.small_cloudsData.push(new Point(i * this.small_cloudStep,32));
            this.cloudsContainer.addChild(image);
            this.small_clouds.push(image);
         }
         if(this.TYPE == 2)
         {
            this.tiny_clouds = new Array();
            this.tiny_cloudsData = new Array();
            amount = int(Utils.WIDTH / this.tiny_cloudStep) + 2;
            for(i = 0; i < amount; i++)
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("yellow_cloud_3"));
               image.x = i * this.tiny_cloudStep;
               image.y = 56;
               this.tiny_cloudsData.push(new Point(i * this.tiny_cloudStep,56));
               this.cloudsContainer.addChild(image);
               this.tiny_clouds.push(image);
            }
         }
         else
         {
            this.tiny_clouds = null;
            this.tiny_cloudsData = null;
         }
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_1"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
         if(this.TYPE == 1)
         {
            this.sky_fade_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("sky_fade_1"));
            this.sky_fade_layer.touchable = false;
            this.sky_fade_layer.width = Utils.WIDTH + 1;
            layer_static.addChild(this.sky_fade_layer);
            this.sky_fade_layer.y = int(Utils.HEIGHT * 0.45);
         }
         else
         {
            this.sky_fade_layer = null;
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.tiny_clouds != null)
         {
            for(i = 0; i < this.tiny_clouds.length; i++)
            {
               this.cloudsContainer.removeChild(this.tiny_clouds[i]);
               this.tiny_clouds[i].dispose();
               this.tiny_clouds[i] = null;
               this.tiny_cloudsData[i] = null;
            }
            this.tiny_clouds = null;
            this.tiny_cloudsData = null;
         }
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
         layer_static.removeChild(this.sky_layer);
         this.sky_layer.dispose();
         this.sky_layer = null;
         if(this.sky_fade_layer != null)
         {
            layer_static.removeChild(this.sky_fade_layer);
            this.sky_fade_layer.dispose();
            this.sky_fade_layer = null;
         }
         backgroundContainer.removeChild(this.cloudsContainer);
         this.cloudsContainer.dispose();
         this.cloudsContainer = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var _pSprite:SlowGreySmokeParticleSprite = null;
         var pSprite:PollenBackgroundParticleSprite = null;
         super.update();
         for(i = 0; i < this.cloudsData.length; i++)
         {
            this.cloudsData[i].x -= 0.5 * 0.75;
            if(this.cloudsData[i].x <= -this.cloudStep)
            {
               this.cloudsData[i].x += this.cloudsData.length * this.cloudStep;
            }
         }
         for(i = 0; i < this.small_cloudsData.length; i++)
         {
            this.small_cloudsData[i].x -= 0.375 * 0.75;
            if(this.small_cloudsData[i].x <= -this.small_cloudStep)
            {
               this.small_cloudsData[i].x += this.small_cloudsData.length * this.small_cloudStep;
            }
         }
         if(this.tiny_cloudsData != null)
         {
            for(i = 0; i < this.tiny_cloudsData.length; i++)
            {
               this.tiny_cloudsData[i].x -= 0.28 * 0.75;
               if(this.tiny_cloudsData[i].x <= -this.tiny_cloudStep)
               {
                  this.tiny_cloudsData[i].x += this.tiny_cloudsData.length * this.tiny_cloudStep;
               }
            }
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_2_1)
         {
            if(this.smoke_counter_1-- < 0)
            {
               this.smoke_counter_1 = 10 + Math.random() * 30;
               _pSprite = new SlowGreySmokeParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  _pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  _pSprite.gfxHandleClip().gotoAndStop(2);
               }
               particlesManager.pushParticle(_pSprite,296 + Math.random() * 32 - 16,140,0,-0.5,1,Math.random() * Math.PI * 2,Math.random() * 180 + 60);
            }
            if(this.smoke_counter_2-- < 0)
            {
               this.smoke_counter_2 = 10 + Math.random() * 30;
               _pSprite = new SlowGreySmokeParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  _pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  _pSprite.gfxHandleClip().gotoAndStop(2);
               }
               particlesManager.pushParticle(_pSprite,720 + Math.random() * 32 - 16,216,0,-0.5,1,Math.random() * Math.PI * 2,Math.random() * 180 + 60);
            }
         }
         if(Utils.CurrentLevel != 8)
         {
            if(this.pollen_spawn_time > -1)
            {
               if(this.pollen_counter_1-- < this.pollen_spawn_time)
               {
                  this.pollen_counter_1 = Math.random() * 30 + 60;
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
                     particlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.HALF_WIDTH + level.camera.HALF_WIDTH,level.camera.yPos + level.camera.HEIGHT + (Math.random() * 2 + 1) * 16,0,0,1,0,0.25 * int(Math.random() * 3),Math.random() * Math.PI * 2);
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
         super.updateScreenPosition(camera);
         this.cloudsContainer.x = 0;
         this.cloudsContainer.y = 0;
         var clouds_offset:int = 0;
         if(this.TYPE == 1)
         {
            clouds_offset = int(Utils.HEIGHT * 0.08);
         }
         for(i = 0; i < this.clouds.length; i++)
         {
            if(this.clouds[i] != null)
            {
               this.clouds[i].x = int(Math.floor(this.cloudsData[i].x));
               this.clouds[i].y = int(Math.floor(this.cloudsData[i].y)) + clouds_offset;
            }
         }
         for(i = 0; i < this.small_clouds.length; i++)
         {
            if(this.small_clouds[i] != null)
            {
               this.small_clouds[i].x = int(Math.floor(this.small_cloudsData[i].x));
               this.small_clouds[i].y = int(Math.floor(this.small_cloudsData[i].y)) + clouds_offset;
            }
         }
         if(this.tiny_clouds != null)
         {
            for(i = 0; i < this.tiny_clouds.length; i++)
            {
               if(this.tiny_clouds[i] != null)
               {
                  this.tiny_clouds[i].x = int(Math.floor(this.tiny_cloudsData[i].x));
                  this.tiny_clouds[i].y = int(Math.floor(this.tiny_cloudsData[i].y)) + clouds_offset;
               }
            }
         }
         backgroundContainer.setChildIndex(layer_static,0);
         layer_static.setChildIndex(this.sky_layer,0);
      }
      
      override public function particles(area:ParticleArea) : void
      {
      }
      
      override public function shake() : void
      {
      }
   }
}
