package interfaces.panels.intro
{
   import entities.Easings;
   import flash.geom.Rectangle;
   import sprites.intro.GenericIntroSprite;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class IntroScene2Panel extends Sprite
   {
       
      
      protected var bgContainer:Sprite;
      
      protected var bg1:Image;
      
      protected var bg2:Image;
      
      protected var cactusContainer:Sprite;
      
      protected var cactus1:Image;
      
      protected var cactus2:Image;
      
      protected var cactus3:Image;
      
      protected var rocksContainer:Sprite;
      
      protected var rock1:Image;
      
      protected var rock2:Image;
      
      protected var rock3:Image;
      
      protected var road:Image;
      
      protected var truckContainer:Sprite;
      
      protected var truckBackWheel:Image;
      
      protected var truckBody:Image;
      
      protected var truckFrontWheel:Image;
      
      protected var particleSprite:Vector.<GenericIntroSprite>;
      
      protected var particleData:Vector.<Rectangle>;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var counter_3:int;
      
      protected var particle_counter:int;
      
      protected var t_tick_1:Number;
      
      protected var t_start_1:Number;
      
      protected var t_diff_1:Number;
      
      protected var t_time_1:Number;
      
      protected var t_tick_2:Number;
      
      protected var t_start_2:Number;
      
      protected var t_diff_2:Number;
      
      protected var t_time_2:Number;
      
      public function IntroScene2Panel()
      {
         super();
         this.counter_1 = this.counter_2 = this.counter_3 = 0;
         this.particle_counter = 0;
         this.bgContainer = new Sprite();
         this.bg1 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_background"));
         this.bg2 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_background"));
         this.bg2.x = 640;
         this.bg1.touchable = this.bg2.touchable = false;
         this.bgContainer.addChild(this.bg1);
         this.bgContainer.addChild(this.bg2);
         this.bgContainer.x = int(-200);
         this.bgContainer.y = int(-144);
         addChild(this.bgContainer);
         this.cactusContainer = new Sprite();
         this.cactus1 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_cactus"));
         this.cactus2 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_cactus"));
         this.cactus3 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_cactus"));
         this.cactus1.touchable = this.cactus2.touchable = this.cactus3.touchable = false;
         this.cactus1.x = 0;
         this.cactus2.x = 500;
         this.cactus3.x = 1000;
         this.cactusContainer.addChild(this.cactus1);
         this.cactusContainer.addChild(this.cactus2);
         this.cactusContainer.addChild(this.cactus3);
         addChild(this.cactusContainer);
         this.cactusContainer.x = int(-200);
         this.cactusContainer.y = -72;
         this.rocksContainer = new Sprite();
         this.rock1 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_rocks"));
         this.rock2 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_rocks"));
         this.rock3 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_rocks"));
         this.rock1.touchable = this.rock2.touchable = this.rock3.touchable = false;
         this.rock2.x = this.rock1.width;
         this.rock3.x = this.rock2.x + this.rock2.width;
         this.rock1.y = this.rock2.y = this.rock3.y = -this.rock1.height;
         this.rocksContainer.addChild(this.rock1);
         this.rocksContainer.addChild(this.rock2);
         this.rocksContainer.addChild(this.rock3);
         this.rocksContainer.x = int(-200);
         this.rocksContainer.y = 35;
         addChild(this.rocksContainer);
         this.road = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_road"));
         this.road.touchable = false;
         this.road.x = -300;
         addChild(this.road);
         this.road.width = 600;
         this.road.y = 35;
         this.truckContainer = new Sprite();
         this.truckBackWheel = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_back_wheel"));
         this.truckBody = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_truck"));
         this.truckFrontWheel = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_2_front_wheel"));
         this.truckBackWheel.touchable = this.truckBody.touchable = this.truckFrontWheel.touchable = false;
         this.truckContainer.addChild(this.truckBackWheel);
         this.truckContainer.addChild(this.truckBody);
         this.truckContainer.addChild(this.truckFrontWheel);
         this.truckContainer.pivotX = this.truckContainer.width;
         this.truckContainer.pivotY = this.truckContainer.height;
         this.truckBackWheel.x = 189;
         this.truckFrontWheel.x = 83;
         this.truckFrontWheel.y = this.truckBackWheel.y = 110;
         addChild(this.truckContainer);
         this.truckContainer.x = -128;
         this.truckContainer.y = 80;
         this.t_start_1 = -128;
         this.t_diff_1 = 160;
         this.t_tick_1 = 0;
         this.t_time_1 = 3;
         this.particleSprite = new Vector.<GenericIntroSprite>();
         this.particleData = new Vector.<Rectangle>();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.particleSprite.length; i++)
         {
            if(this.particleSprite[i] != null)
            {
               removeChild(this.particleSprite[i]);
               this.particleSprite[i].destroy();
               this.particleSprite[i].dispose();
               this.particleSprite[i] = null;
               this.particleData[i] = null;
            }
         }
         this.particleSprite = null;
         this.particleData = null;
         removeChild(this.truckContainer);
         this.truckContainer.removeChild(this.truckFrontWheel);
         this.truckContainer.removeChild(this.truckBody);
         this.truckContainer.removeChild(this.truckBackWheel);
         this.truckFrontWheel.dispose();
         this.truckBody.dispose();
         this.truckBackWheel.dispose();
         this.truckFrontWheel = null;
         this.truckBody = null;
         this.truckBackWheel = null;
         this.truckContainer.dispose();
         this.truckContainer = null;
         removeChild(this.road);
         this.road.dispose();
         this.road = null;
         removeChild(this.rocksContainer);
         this.rocksContainer.removeChild(this.rock3);
         this.rocksContainer.removeChild(this.rock2);
         this.rocksContainer.removeChild(this.rock1);
         this.rock3.dispose();
         this.rock2.dispose();
         this.rock1.dispose();
         this.rock3 = null;
         this.rock2 = null;
         this.rock1 = null;
         this.rocksContainer.dispose();
         this.rocksContainer = null;
         removeChild(this.cactusContainer);
         this.cactusContainer.removeChild(this.cactus3);
         this.cactusContainer.removeChild(this.cactus2);
         this.cactusContainer.removeChild(this.cactus1);
         this.cactus3.dispose();
         this.cactus2.dispose();
         this.cactus1.dispose();
         this.cactus3 = null;
         this.cactus2 = null;
         this.cactus1 = null;
         this.cactusContainer.dispose();
         this.cactusContainer = null;
         removeChild(this.bgContainer);
         this.bgContainer.removeChild(this.bg1);
         this.bgContainer.removeChild(this.bg2);
         this.bg1.dispose();
         this.bg2.dispose();
         this.bg1 = null;
         this.bg2 = null;
         this.bgContainer.dispose();
         this.bgContainer = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var gSprite:GenericIntroSprite = null;
         this.bgContainer.x -= 24;
         if(this.bgContainer.x <= -(640 + 200))
         {
            this.bgContainer.x += 640;
         }
         this.cactusContainer.x -= 6;
         if(this.cactusContainer.x <= -(500 + 200))
         {
            this.cactusContainer.x += 500;
         }
         this.rocksContainer.x -= 8;
         if(this.rocksContainer.x <= -(394 + 200))
         {
            this.rocksContainer.x += 394;
         }
         this.t_tick_1 += 1 / 60;
         if(this.t_tick_1 >= this.t_time_1)
         {
            this.t_tick_1 = this.t_time_1;
         }
         this.truckContainer.x = int(Easings.easeOutBack(this.t_tick_1,this.t_start_1,this.t_diff_1,this.t_time_1));
         ++this.counter_1;
         if(this.counter_1 > 1)
         {
            this.counter_1 = 0;
            if(this.truckBody.y <= 0)
            {
               this.truckBody.y = 1;
            }
            else
            {
               this.truckBody.y = 0;
            }
         }
         if(this.particle_counter-- < 0)
         {
            this.particle_counter = int(Math.random() * 2);
            gSprite = new GenericIntroSprite(2);
            gSprite.alpha = 0.5;
            addChild(gSprite);
            this.particleSprite.push(gSprite);
            this.particleData.push(new Rectangle(this.truckContainer.x - 160 + Math.random() * 128,this.truckContainer.y,Math.random() * Math.PI * 2,0));
         }
         for(i = 0; i < this.particleSprite.length; i++)
         {
            if(this.particleSprite[i] != null)
            {
               this.particleSprite[i].x = this.particleData[i].x;
               this.particleSprite[i].y = this.particleData[i].y + Math.sin(this.particleData[i].width) * 4;
               this.particleData[i].x -= 4;
               this.particleData[i].width += 0.4;
               this.particleSprite[i].visible = !this.particleSprite[i].visible;
            }
         }
      }
   }
}
