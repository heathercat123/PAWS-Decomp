package levels.backgrounds
{
   import entities.Easings;
   import entities.particles.ParticlesManager;
   import flash.geom.Point;
   import sprites.GameSprite;
   import sprites.background.NightStarBackgroundSprite;
   import sprites.background.ThunderBackgroundParticleSprite;
   import starling.core.Starling;
   import starling.display.BlendMode;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class MenuBackground
   {
       
      
      public var INTRO_OVER:Boolean;
      
      public var INTRO_ALMOST_OVER:Boolean;
      
      public var backgroundContainer:Sprite;
      
      public var particlesContainer:Sprite;
      
      protected var skyImage:Image;
      
      protected var cloudsLayer0:Sprite;
      
      protected var cloudsLayer1:Sprite;
      
      protected var cloudsLayer2:Sprite;
      
      protected var cloudsLayer3:Sprite;
      
      protected var cloudsImages0:Vector.<Image>;
      
      protected var cloudsImages1:Vector.<Image>;
      
      protected var cloudsImages2:Vector.<Image>;
      
      protected var cloudsImages3:Vector.<Image>;
      
      protected var clouds0_xPos:Number;
      
      protected var clouds1_xPos:Number;
      
      protected var clouds2_xPos:Number;
      
      protected var clouds3_xPos:Number;
      
      protected var counter1:int;
      
      protected var perspective_factor:Number;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var sin_counter_1:Number;
      
      protected var sin_counter_2:Number;
      
      protected var sin_speed_1:Number;
      
      protected var sin_speed_2:Number;
      
      protected var fire_quad_sin:Number;
      
      protected var fireQuad:Quad;
      
      protected var particlesManager:ParticlesManager;
      
      protected var p_counter:int;
      
      protected var w_counter:int;
      
      protected var stars:Vector.<GameSprite>;
      
      protected var stars_positions:Vector.<Point>;
      
      protected var moon:Image;
      
      protected var thunder_counter:int;
      
      protected var thunder_counter_b:int;
      
      protected var thunder_counter_2_b:int;
      
      protected var thunder_counter_3_b:int;
      
      protected var thunderSprite_b:ThunderBackgroundParticleSprite;
      
      public function MenuBackground()
      {
         super();
         Starling.current.stage.color = 6407423;
         this.clouds0_xPos = this.clouds1_xPos = this.clouds2_xPos = this.clouds3_xPos = 0;
         this.sin_counter_1 = Math.random() * Math.PI * 2;
         this.sin_counter_2 = Math.random() * Math.PI * 2;
         this.sin_speed_1 = Math.random() * 0.025 + 0.025;
         this.sin_speed_2 = Math.random() * 0.025 + 0.025;
         this.fire_quad_sin = Math.random() * Math.PI * 2;
         this.p_counter = this.w_counter = 0;
         this.INTRO_OVER = this.INTRO_ALMOST_OVER = false;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         this.backgroundContainer = new Sprite();
         this.backgroundContainer.x = this.backgroundContainer.y = 0;
         this.backgroundContainer.scaleX = this.backgroundContainer.scaleY = Utils.GFX_SCALE;
         Utils.rootMovie.addChild(this.backgroundContainer);
         if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
         {
            this.skyImage = new Image(TextureManager.hudTextureAtlas.getTexture("splash_halloween_sky"));
         }
         else
         {
            this.skyImage = new Image(TextureManager.hudTextureAtlas.getTexture("splash_sky"));
         }
         this.skyImage.touchable = false;
         this.backgroundContainer.addChild(this.skyImage);
         this.skyImage.width = Utils.WIDTH + 1;
         this.skyImage.height = Utils.HEIGHT + 1;
         this.initStars();
         if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
         {
            this.moon = new Image(TextureManager.GetBackgroundTexture().getTexture("background_halloween_moon_1"));
         }
         else
         {
            this.moon = new Image(TextureManager.GetBackgroundTexture().getTexture("background_moon_1"));
         }
         this.moon.touchable = false;
         this.moon.pivotX = this.moon.pivotY = 45;
         this.backgroundContainer.addChild(this.moon);
         this.moon.x = int(Utils.WIDTH * 0.5);
         this.moon.y = 0;
         this.particlesContainer = new Sprite();
         this.fireQuad = new Quad(Utils.WIDTH + 1,int(Utils.HEIGHT * 0.3),16773608);
         this.fireQuad.setVertexAlpha(0,0.25);
         this.fireQuad.setVertexAlpha(1,0.25);
         this.fireQuad.setVertexAlpha(2,0);
         this.fireQuad.setVertexAlpha(3,0);
         this.backgroundContainer.addChild(this.fireQuad);
         this.fireQuad.x = 0;
         this.fireQuad.y = 0;
         this.fireQuad.blendMode = BlendMode.ADD;
         this.initClouds();
         this.backgroundContainer.addChild(this.cloudsLayer0);
         this.backgroundContainer.addChild(this.cloudsLayer1);
         this.backgroundContainer.addChild(this.particlesContainer);
         this.backgroundContainer.addChild(this.cloudsLayer2);
         this.backgroundContainer.addChild(this.cloudsLayer3);
         this.perspective_factor = 1;
         this.counter1 = 0;
         this.particlesManager = new ParticlesManager(null,this.particlesContainer);
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.backgroundContainer.removeChild(this.thunderSprite_b);
         this.thunderSprite_b.destroy();
         this.thunderSprite_b.dispose();
         this.thunderSprite_b = null;
         this.backgroundContainer.removeChild(this.moon);
         this.moon.dispose();
         this.moon = null;
         this.particlesManager.destroy();
         this.particlesManager = null;
         this.backgroundContainer.removeChild(this.skyImage);
         this.skyImage.dispose();
         this.skyImage = null;
         this.backgroundContainer.removeChild(this.particlesContainer);
         this.particlesContainer.dispose();
         this.particlesContainer = null;
         for(i = 0; i < this.cloudsImages0.length; i++)
         {
            this.cloudsLayer0.removeChild(this.cloudsImages0[i]);
            this.cloudsImages0[i].dispose();
            this.cloudsImages0[i] = null;
         }
         this.backgroundContainer.removeChild(this.cloudsLayer0);
         this.cloudsLayer0.dispose();
         this.cloudsImages0 = null;
         for(i = 0; i < this.cloudsImages1.length; i++)
         {
            this.cloudsLayer1.removeChild(this.cloudsImages1[i]);
            this.cloudsImages1[i].dispose();
            this.cloudsImages1[i] = null;
         }
         this.backgroundContainer.removeChild(this.cloudsLayer1);
         this.cloudsLayer1.dispose();
         this.cloudsImages1 = null;
         for(i = 0; i < this.cloudsImages2.length; i++)
         {
            this.cloudsLayer2.removeChild(this.cloudsImages2[i]);
            this.cloudsImages2[i].dispose();
            this.cloudsImages2[i] = null;
         }
         this.backgroundContainer.removeChild(this.cloudsLayer2);
         this.cloudsLayer2.dispose();
         this.cloudsImages2 = null;
         for(i = 0; i < this.cloudsImages3.length; i++)
         {
            this.cloudsLayer3.removeChild(this.cloudsImages3[i]);
            this.cloudsImages3[i].dispose();
            this.cloudsImages3[i] = null;
         }
         this.backgroundContainer.removeChild(this.cloudsLayer3);
         this.cloudsLayer3.dispose();
         this.cloudsImages3 = null;
         this.backgroundContainer.removeChild(this.fireQuad);
         this.fireQuad.dispose();
         this.fireQuad = null;
         Utils.rootMovie.removeChild(this.backgroundContainer);
         this.backgroundContainer.dispose();
         this.backgroundContainer = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var factor:Number = this.perspective_factor;
         for(i = 0; i < this.stars.length; i++)
         {
            this.stars[i].x = int(this.stars_positions[i].x);
            this.stars[i].y = int(this.stars_positions[i].y - factor * 64);
         }
         this.moon.y = int(0 - factor * 64);
         this.cloudsLayer0.y = int(Utils.HEIGHT * (0.62 - factor * 2.5));
         this.cloudsLayer1.y = int(Utils.HEIGHT * (0.66 - factor * 2));
         this.cloudsLayer2.y = int(Utils.HEIGHT * (0.75 - factor * 1.5));
         this.cloudsLayer3.y = int(Utils.HEIGHT * (0.88 - factor * 1.25));
         this.clouds0_xPos -= 0.125;
         if(this.clouds0_xPos < -64)
         {
            this.clouds0_xPos += 64;
         }
         this.cloudsLayer0.x = int(this.clouds0_xPos);
         this.clouds1_xPos -= 0.25;
         if(this.clouds1_xPos < -128)
         {
            this.clouds1_xPos += 128;
         }
         this.cloudsLayer1.x = int(this.clouds1_xPos);
         this.clouds2_xPos -= 0.5;
         if(this.clouds2_xPos < -144)
         {
            this.clouds2_xPos += 144;
         }
         this.cloudsLayer2.x = int(this.clouds2_xPos);
         --this.clouds3_xPos;
         if(this.clouds3_xPos < -184)
         {
            this.clouds3_xPos += 184;
         }
         this.cloudsLayer3.x = int(this.clouds3_xPos);
         this.sin_counter_1 += this.sin_speed_1;
         if(this.sin_counter_1 > Math.PI * 2)
         {
            this.sin_counter_1 -= Math.PI * 2;
            this.sin_speed_1 = Math.random() * 0.04 + 0.025;
         }
         this.sin_counter_2 += this.sin_speed_2;
         if(this.sin_counter_2 > Math.PI * 2)
         {
            this.sin_counter_2 -= Math.PI * 2;
            this.sin_speed_2 = Math.random() * 0.04 + 0.025;
         }
         this.fireQuad.setVertexColor(0,3246335);
         this.fireQuad.setVertexColor(1,3246335);
         this.fireQuad.setVertexColor(2,3246335);
         this.fireQuad.setVertexColor(3,3246335);
         this.fireQuad.setVertexAlpha(0,0.25 + Math.sin(this.sin_counter_1) * 0.125);
         this.fireQuad.setVertexAlpha(1,0.25 + Math.sin(this.sin_counter_2) * 0.125);
         this.fire_quad_sin += 0.01;
         if(this.fire_quad_sin > Math.PI * 2)
         {
            this.fire_quad_sin -= Math.PI * 2;
         }
         if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
         {
            this.thunderSprite_b.visible = false;
         }
         else
         {
            if(this.thunder_counter-- < 0)
            {
               this.thunderSprite_b.visible = true;
               this.thunder_counter = int(2 + Math.random() * 5) * 60;
               this.thunderSprite_b.gfxHandleClip().gotoAndPlay(1);
               this.thunderSprite_b.updateScreenPosition();
               this.thunderSprite_b.x = int(Math.random() * Utils.WIDTH - 32);
               this.thunderSprite_b.y = int(Math.random() * Utils.HEIGHT * 0.125);
            }
            if(this.thunderSprite_b.gfxHandleClip().isComplete)
            {
               this.thunderSprite_b.visible = false;
            }
         }
      }
      
      public function startIntro() : void
      {
         this.perspective_factor = 2;
         this.INTRO_OVER = this.INTRO_ALMOST_OVER = false;
         this.t_start = 1.1;
         this.t_diff = -1.1;
         this.t_time = 2.5;
         this.t_tick = 0;
      }
      
      public function endIntro() : void
      {
         this.INTRO_OVER = this.INTRO_ALMOST_OVER = true;
         this.perspective_factor = 0;
      }
      
      public function updateIntro() : void
      {
         this.t_tick += 1 / 60;
         if(this.t_tick >= this.t_time)
         {
            this.t_tick = this.t_time;
            this.INTRO_OVER = true;
         }
         if(this.t_tick >= this.t_time * 0.8)
         {
            this.INTRO_ALMOST_OVER = true;
         }
         this.perspective_factor = Easings.easeOutQuad(this.t_tick,this.t_start,this.t_diff,this.t_time);
      }
      
      protected function initStars() : void
      {
         var i:int = 0;
         this.stars = new Vector.<GameSprite>();
         this.stars_positions = new Vector.<Point>();
         var flair_index:int = 0;
         if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
         {
            flair_index = 2;
         }
         this.stars.push(new NightStarBackgroundSprite(0,0.5,flair_index));
         this.stars_positions.push(new Point(130,58));
         this.stars.push(new NightStarBackgroundSprite(1,0.5,flair_index));
         this.stars_positions.push(new Point(330,10));
         this.stars.push(new NightStarBackgroundSprite(2,0.5,flair_index));
         this.stars_positions.push(new Point(314,26));
         this.stars.push(new NightStarBackgroundSprite(3,0.5,flair_index));
         this.stars_positions.push(new Point(250,50));
         this.stars.push(new NightStarBackgroundSprite(3,0.5,flair_index));
         this.stars_positions.push(new Point(90,106));
         this.stars.push(new NightStarBackgroundSprite(4,0.5,flair_index));
         this.stars_positions.push(new Point(106,26));
         this.stars.push(new NightStarBackgroundSprite(4,0.5,flair_index));
         this.stars_positions.push(new Point(338,82));
         this.stars.push(new NightStarBackgroundSprite(5,0.5,flair_index));
         this.stars_positions.push(new Point(266,66));
         this.stars.push(new NightStarBackgroundSprite(5,0.5,flair_index));
         this.stars_positions.push(new Point(394,34));
         this.stars.push(new NightStarBackgroundSprite(5,0.5,flair_index));
         this.stars_positions.push(new Point(10,26));
         this.stars.push(new NightStarBackgroundSprite(5,0.5,flair_index));
         this.stars_positions.push(new Point(314,98));
         this.stars.push(new NightStarBackgroundSprite(6,0.5,flair_index));
         this.stars_positions.push(new Point(90,34));
         this.stars.push(new NightStarBackgroundSprite(7,0.5,flair_index));
         this.stars_positions.push(new Point(154,66));
         this.stars.push(new NightStarBackgroundSprite(7,0.5,flair_index));
         this.stars_positions.push(new Point(442,58));
         this.stars.push(new NightStarBackgroundSprite(8,0.5,flair_index));
         this.stars_positions.push(new Point(34,66));
         this.stars.push(new NightStarBackgroundSprite(8,0.5,flair_index));
         this.stars_positions.push(new Point(410,26));
         this.stars.push(new NightStarBackgroundSprite(8,0.5,flair_index));
         this.stars_positions.push(new Point(234,74));
         for(i = 0; i < this.stars.length; i++)
         {
            this.backgroundContainer.addChild(this.stars[i]);
            this.stars[i].x = int(this.stars_positions[i].x);
            this.stars[i].y = int(this.stars_positions[i].y);
         }
         this.thunderSprite_b = new ThunderBackgroundParticleSprite();
         this.backgroundContainer.addChild(this.thunderSprite_b);
         this.thunderSprite_b.visible = false;
         this.thunder_counter = int(2 + Math.random() * 5) * 60;
      }
      
      protected function initClouds() : void
      {
         var i:int = 0;
         var image:Image = null;
         var flairString:String = "";
         if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
         {
            flairString = "halloween_";
         }
         this.cloudsLayer0 = new Sprite();
         this.cloudsLayer1 = new Sprite();
         this.cloudsLayer2 = new Sprite();
         this.cloudsLayer3 = new Sprite();
         this.cloudsImages0 = new Vector.<Image>();
         this.cloudsImages1 = new Vector.<Image>();
         this.cloudsImages2 = new Vector.<Image>();
         this.cloudsImages3 = new Vector.<Image>();
         for(i = 0; i < 2; i++)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("splash_cloud_" + flairString + "layer_0"));
            image.touchable = false;
            this.cloudsImages0.push(image);
            this.cloudsLayer0.addChild(image);
            image.x = i * image.width;
            image.y = 0;
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("splash_cloud_" + flairString + "body_0"));
         image.touchable = false;
         this.cloudsImages0.push(image);
         this.cloudsLayer0.addChild(image);
         image.x = 0;
         image.y = 16;
         image.width = 640;
         image.height = Utils.HEIGHT;
         for(i = 0; i < 2; i++)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("splash_cloud_" + flairString + "layer_1"));
            image.touchable = false;
            this.cloudsImages1.push(image);
            this.cloudsLayer1.addChild(image);
            image.x = i * image.width;
            image.y = 0;
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("splash_cloud_" + flairString + "body_1"));
         image.touchable = false;
         this.cloudsImages1.push(image);
         this.cloudsLayer1.addChild(image);
         image.x = 0;
         image.y = 16;
         image.width = 640;
         image.height = Utils.HEIGHT;
         for(i = 0; i < 2; i++)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("splash_cloud_" + flairString + "layer_2"));
            image.touchable = false;
            this.cloudsImages2.push(image);
            this.cloudsLayer2.addChild(image);
            image.x = i * image.width;
            image.y = 0;
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("splash_cloud_" + flairString + "body_2"));
         image.touchable = false;
         this.cloudsImages2.push(image);
         this.cloudsLayer2.addChild(image);
         image.x = 0;
         image.y = 16;
         image.width = 640;
         image.height = Utils.HEIGHT;
         for(i = 0; i < 2; i++)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("splash_cloud_" + flairString + "layer_3"));
            image.touchable = false;
            this.cloudsImages3.push(image);
            this.cloudsLayer3.addChild(image);
            image.x = i * image.width;
            image.y = 0;
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("splash_cloud_" + flairString + "body_3"));
         image.touchable = false;
         this.cloudsImages3.push(image);
         this.cloudsLayer3.addChild(image);
         image.x = 0;
         image.y = 16;
         image.width = 640;
         image.height = Utils.HEIGHT * 1.5;
      }
   }
}
