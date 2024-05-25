package levels.backgrounds
{
   import entities.particles.ParticlesManager;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.background.ThunderBackgroundParticleSprite;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class StarryNightBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var cloudsLayer1:Sprite;
      
      protected var cloudsImages1:Vector.<Image>;
      
      protected var clouds_1_xPos:Number;
      
      protected var clouds_2_xPos:Number;
      
      protected var clouds_3_xPos:Number;
      
      protected var clouds_1_offset:Number;
      
      protected var clouds_2_offset:Number;
      
      protected var clouds_3_offset:Number;
      
      protected var speed_multiplier:Number;
      
      public var pollen_counter:int;
      
      protected var thunder_counter:int;
      
      protected var thunder_counter_2:int;
      
      protected var thunder_counter_3:int;
      
      protected var thunder_counter_b:int;
      
      protected var thunder_counter_2_b:int;
      
      protected var thunder_counter_3_b:int;
      
      protected var thunderSprite_b:ThunderBackgroundParticleSprite;
      
      protected var gradient_value:Number;
      
      protected var thunder_yPos:Number;
      
      protected var IS_THUNDER_VISIBLE:Boolean;
      
      protected var IS_THUNDER_VISIBLE_b:Boolean;
      
      protected var sky_layer:Image;
      
      protected var level_id:int;
      
      protected var TYPE:int;
      
      public function StarryNightBackground(_level:Level, _type:int = 0)
      {
         this.TYPE = _type;
         super(_level);
         Starling.current.stage.color = 808172;
         this.pCounter = 0;
         this.speed_multiplier = 0.5;
         this.gradient_value = 1;
         this.clouds_1_xPos = this.clouds_2_xPos = this.clouds_3_xPos = 0;
         this.clouds_1_offset = this.clouds_2_offset = this.clouds_3_offset = 0;
         this.level_id = Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL];
         if(this.TYPE == 0)
         {
            this.initClouds();
            layer_0.addChild(this.cloudsLayer1);
         }
         else
         {
            this.cloudsLayer1 = null;
         }
         this.thunderSprite_b = new ThunderBackgroundParticleSprite();
         layer_static.addChild(this.thunderSprite_b);
         this.thunderSprite_b.visible = false;
         this.thunder_counter = int(5 + Math.random() * 10) * 60;
         this.pollen_counter = 0;
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_20"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.cloudsLayer1 != null)
         {
            layer_0.removeChild(this.cloudsLayer1);
            for(i = 0; i < this.cloudsImages1.length; i++)
            {
               if(this.cloudsImages1[i] != null)
               {
                  this.cloudsLayer1.removeChild(this.cloudsImages1[i]);
                  this.cloudsImages1[i].dispose();
                  this.cloudsImages1[i] = null;
               }
            }
            this.cloudsLayer1 = null;
            this.cloudsImages1 = null;
         }
         layer_static.removeChild(this.thunderSprite_b);
         this.thunderSprite_b.destroy();
         this.thunderSprite_b.dispose();
         this.thunderSprite_b = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var pSprite:GameSprite = null;
         super.update();
         if(this.cloudsLayer1 != null)
         {
            this.clouds_1_offset -= 0.25 * this.speed_multiplier;
            if(this.clouds_1_offset < -128)
            {
               this.clouds_1_offset += 128;
            }
            this.clouds_2_offset -= 1 * this.speed_multiplier;
            if(this.clouds_2_offset < -184)
            {
               this.clouds_2_offset += 184;
            }
            this.clouds_3_offset -= 2 * this.speed_multiplier;
            if(this.clouds_3_offset < -184)
            {
               this.clouds_3_offset += 184;
            }
         }
         ParticlesManager.GLOBAL_VARIABLE_1 = 1;
         if(this.thunder_counter-- < 0)
         {
            this.thunderSprite_b.visible = true;
            this.thunder_counter = int(5 + Math.random() * 10) * 60;
            this.thunderSprite_b.gfxHandleClip().gotoAndPlay(1);
            this.thunderSprite_b.x = int(Math.random() * Utils.WIDTH - 32);
            this.thunderSprite_b.y = int(Math.random() * Utils.HEIGHT * 0.125);
            layer_static.setChildIndex(this.thunderSprite_b,0);
         }
         if(this.thunderSprite_b.gfxHandleClip().isComplete)
         {
            this.thunderSprite_b.visible = false;
         }
      }
      
      public function setSpeed(_speed:Number) : void
      {
         this.speed_multiplier = _speed;
      }
      
      override public function particles(area:ParticleArea) : void
      {
      }
      
      override public function shake() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.cloudsLayer1 != null)
         {
            this.cloudsLayer1.x = int(this.clouds_1_offset - Math.floor(xPos - camera.xPos) * mult0);
            layer_0.setChildIndex(this.cloudsLayer1,0);
         }
         layer_static.setChildIndex(this.sky_layer,0);
         backgroundContainer.setChildIndex(layer_static,0);
      }
      
      protected function initClouds() : void
      {
         var i:int = 0;
         var image:Image = null;
         var offset_x:Number = NaN;
         this.cloudsLayer1 = new Sprite();
         this.cloudsImages1 = new Vector.<Image>();
         var dark_cloud_1:int = 0;
         var dark_cloud_2:int = 0;
         offset_x = 0;
         for(i = 0; i < 2; i++)
         {
            image = new Image(TextureManager.GetBackgroundTexture().getTexture("starry_night_cloud_layer_1"));
            image.touchable = false;
            this.cloudsImages1.push(image);
            this.cloudsLayer1.addChild(image);
            image.x = i * image.width + offset_x;
            image.y = int(Utils.HEIGHT * 0.6);
         }
         image = new Image(TextureManager.GetBackgroundTexture().getTexture("starry_night_cloud_body_1"));
         image.touchable = false;
         this.cloudsImages1.push(image);
         this.cloudsLayer1.addChild(image);
         image.x = offset_x;
         image.y = 16 + int(Utils.HEIGHT * 0.6);
         image.width = 640;
         image.height = Utils.HEIGHT;
         image = new Image(TextureManager.GetBackgroundTexture().getTexture("starry_night_cloud_body_1"));
         image.touchable = false;
         this.cloudsImages1.push(image);
         this.cloudsLayer1.addChild(image);
         image.x = offset_x;
         image.y = dark_cloud_2 - 144;
         image.width = 640;
         image.height = 128;
      }
   }
}
