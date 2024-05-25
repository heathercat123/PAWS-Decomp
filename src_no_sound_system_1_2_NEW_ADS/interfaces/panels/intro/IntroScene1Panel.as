package interfaces.panels.intro
{
   import sprites.intro.GenericIntroSprite;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class IntroScene1Panel extends Sprite
   {
       
      
      protected var sky:Image;
      
      protected var cloudsContainer:Sprite;
      
      protected var cloud1:Image;
      
      protected var cloud2:Image;
      
      protected var sea:Image;
      
      protected var reflections_layer0:Sprite;
      
      protected var reflection_layer0Sprites:Vector.<GenericIntroSprite>;
      
      protected var reflections_layer1:Sprite;
      
      protected var reflection_layer1Sprites:Vector.<GenericIntroSprite>;
      
      protected var reflections_layer2:Sprite;
      
      protected var reflection_layer2Sprites:Vector.<GenericIntroSprite>;
      
      protected var islands:Image;
      
      protected var cat:GenericIntroSprite;
      
      protected var hill:Image;
      
      protected var tree:Image;
      
      protected var bush:Image;
      
      protected var light:Image;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var counter_3:int;
      
      protected var islands_xPos:Number;
      
      protected var cat_xPos:Number;
      
      protected var t_tick_1:Number;
      
      protected var t_start_1:Number;
      
      protected var t_diff_1:Number;
      
      protected var t_time_1:Number;
      
      protected var t_tick_2:Number;
      
      protected var t_start_2:Number;
      
      protected var t_diff_2:Number;
      
      protected var t_time_2:Number;
      
      public function IntroScene1Panel()
      {
         var i:int = 0;
         var gSprite:GenericIntroSprite = null;
         super();
         this.counter_1 = this.counter_2 = this.counter_3 = 0;
         this.sky = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_1_sky"));
         this.sky.width = 400;
         this.sky.touchable = false;
         addChild(this.sky);
         this.sky.x = int(-200);
         this.sky.y = int(-144);
         this.cloudsContainer = new Sprite();
         addChild(this.cloudsContainer);
         this.cloud1 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_1_clouds"));
         this.cloud1.touchable = false;
         this.cloudsContainer.addChild(this.cloud1);
         this.cloud2 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_1_clouds"));
         this.cloud2.touchable = false;
         this.cloudsContainer.addChild(this.cloud2);
         this.cloud2.x = 400;
         this.cloudsContainer.x = -200;
         this.cloudsContainer.y = -10;
         this.sea = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_1_sea"));
         this.sea.width = 400;
         this.sea.touchable = false;
         addChild(this.sea);
         this.sea.x = int(-200);
         this.sea.y = int(-144);
         this.reflections_layer0 = new Sprite();
         this.reflections_layer1 = new Sprite();
         this.reflections_layer2 = new Sprite();
         this.reflection_layer0Sprites = new Vector.<GenericIntroSprite>();
         this.reflection_layer1Sprites = new Vector.<GenericIntroSprite>();
         this.reflection_layer2Sprites = new Vector.<GenericIntroSprite>();
         for(i = 0; i < 20; i++)
         {
            gSprite = new GenericIntroSprite(1);
            this.reflections_layer0.addChild(gSprite);
            gSprite.x = i * 32 + Math.random() * 16;
            this.reflection_layer0Sprites.push(gSprite);
            gSprite.alpha = 0.25;
            gSprite.name = "" + int(Math.random() * 10 + 5);
            if(Math.random() * 100 > 50)
            {
               gSprite.alpha = 0.15;
            }
         }
         for(i = 0; i < 20; i++)
         {
            gSprite = new GenericIntroSprite(1);
            this.reflections_layer1.addChild(gSprite);
            gSprite.x = i * 32 + Math.random() * 16;
            this.reflection_layer1Sprites.push(gSprite);
            gSprite.alpha = 0.5;
            gSprite.name = "" + int(Math.random() * 10 + 5);
            if(Math.random() * 100 > 50)
            {
               gSprite.alpha = 0.4;
            }
         }
         for(i = 0; i < 20; i++)
         {
            gSprite = new GenericIntroSprite(1);
            this.reflections_layer2.addChild(gSprite);
            gSprite.x = i * 32 + Math.random() * 16;
            this.reflection_layer2Sprites.push(gSprite);
            gSprite.name = "" + int(Math.random() * 10 + 5);
            if(Math.random() * 100 > 50)
            {
               gSprite.alpha = 0.9;
            }
         }
         this.reflections_layer0.x = this.reflections_layer1.x = this.reflections_layer2.x = this.sea.x;
         this.reflections_layer0.y = this.sea.y + 160 + 8;
         this.reflections_layer1.y = this.sea.y + 160 + 10;
         this.reflections_layer2.y = this.sea.y + 160 + 16;
         addChild(this.reflections_layer0);
         addChild(this.reflections_layer1);
         addChild(this.reflections_layer2);
         this.islands = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_1_islands"));
         this.islands.x = this.islands_xPos = 60 - 16;
         this.islands.y = -18;
         this.islands.touchable = false;
         addChild(this.islands);
         this.hill = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_1_hill"));
         this.hill.pivotX = this.hill.width;
         this.hill.touchable = false;
         this.hill.x = -10;
         this.hill.y = 41;
         addChild(this.hill);
         this.cat = new GenericIntroSprite(0);
         this.cat.x = -102;
         this.cat.y = -13;
         this.cat.touchable = false;
         addChild(this.cat);
         this.tree = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_1_tree"));
         this.tree.pivotX = this.tree.width;
         this.tree.touchable = false;
         this.tree.x = 0;
         this.tree.y = -144;
         addChild(this.tree);
         this.bush = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_1_bush"));
         this.bush.touchable = false;
         this.bush.x = -16;
         this.bush.y = 14;
         addChild(this.bush);
         this.light = new Image(TextureManager.introTextureAtlas.getTexture("light_reflex_intro"));
         this.light.scaleX = -1;
         this.light.x = Utils.WIDTH * 0.5 + 16;
         this.light.y = -Utils.HEIGHT * 0.5 - 16;
         this.light.alpha = 0.5;
         addChild(this.light);
         this.t_tick_1 = this.t_tick_2 = 0;
         this.t_time_1 = this.t_time_2 = 8;
         this.t_start_1 = this.cat_xPos;
         this.t_diff_1 = -16;
         this.t_start_2 = this.islands_xPos;
         this.t_diff_2 = 16;
         this.startScene();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         removeChild(this.light);
         this.light.dispose();
         this.light = null;
         removeChild(this.bush);
         this.bush.dispose();
         this.bush = null;
         removeChild(this.tree);
         this.tree.dispose();
         this.tree = null;
         removeChild(this.cat);
         this.cat.destroy();
         this.cat.dispose();
         this.cat = null;
         removeChild(this.hill);
         this.hill.dispose();
         this.hill = null;
         removeChild(this.islands);
         this.islands.dispose();
         this.islands = null;
         for(i = 0; i < this.reflection_layer0Sprites.length; i++)
         {
            this.reflections_layer0.removeChild(this.reflection_layer0Sprites[i]);
            this.reflection_layer0Sprites[i].destroy();
            this.reflection_layer0Sprites[i].dispose();
            this.reflection_layer0Sprites[i] = null;
         }
         removeChild(this.reflections_layer0);
         this.reflections_layer0.dispose();
         this.reflections_layer0 = null;
         for(i = 0; i < this.reflection_layer1Sprites.length; i++)
         {
            this.reflections_layer1.removeChild(this.reflection_layer1Sprites[i]);
            this.reflection_layer1Sprites[i].destroy();
            this.reflection_layer1Sprites[i].dispose();
            this.reflection_layer1Sprites[i] = null;
         }
         removeChild(this.reflections_layer1);
         this.reflections_layer1.dispose();
         this.reflections_layer1 = null;
         for(i = 0; i < this.reflection_layer2Sprites.length; i++)
         {
            this.reflections_layer2.removeChild(this.reflection_layer2Sprites[i]);
            this.reflection_layer2Sprites[i].destroy();
            this.reflection_layer2Sprites[i].dispose();
            this.reflection_layer2Sprites[i] = null;
         }
         removeChild(this.reflections_layer2);
         this.reflections_layer2.dispose();
         this.reflections_layer2 = null;
         removeChild(this.sea);
         this.sea.dispose();
         this.sea = null;
         this.cloudsContainer.removeChild(this.cloud1);
         this.cloudsContainer.removeChild(this.cloud2);
         this.cloud1.dispose();
         this.cloud2.dispose();
         this.cloud1 = null;
         this.cloud2 = null;
         removeChild(this.cloudsContainer);
         this.cloudsContainer.dispose();
         this.cloudsContainer = null;
         removeChild(this.sky);
         this.sky.dispose();
         this.sky = null;
      }
      
      public function startScene() : void
      {
         var tween:Tween = null;
         tween = new Tween(this.cat,4,Transitions.LINEAR);
         tween.animate("x",this.cat.x + 32);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.hill,4,Transitions.LINEAR);
         tween.animate("x",this.hill.x + 32);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.tree,4,Transitions.LINEAR);
         tween.animate("x",this.tree.x + 64);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.bush,4,Transitions.LINEAR);
         tween.animate("x",this.bush.x + 64);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.islands,8,Transitions.LINEAR);
         tween.animate("x",this.islands.x - 32);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.reflections_layer0,8,Transitions.LINEAR);
         tween.animate("x",this.reflections_layer0.x - 32);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.reflections_layer1,8,Transitions.LINEAR);
         tween.animate("x",this.reflections_layer1.x - 64);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.reflections_layer2,8,Transitions.LINEAR);
         tween.animate("x",this.reflections_layer2.x - 96);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.light,16,Transitions.LINEAR);
         tween.animate("x",this.light.x - 32);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
      }
      
      public function update() : void
      {
         if(this.counter_1++ > 4)
         {
            this.counter_1 = 0;
            --this.cloudsContainer.x;
         }
         if(this.counter_2++ > 0)
         {
            this.counter_2 = 0;
            if(this.light.alpha <= 0.2)
            {
               this.light.alpha = 0.5;
            }
            else
            {
               this.light.alpha = 0.2;
            }
         }
      }
   }
}
