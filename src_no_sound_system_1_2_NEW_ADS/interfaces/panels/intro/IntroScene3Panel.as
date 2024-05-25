package interfaces.panels.intro
{
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class IntroScene3Panel extends Sprite
   {
       
      
      protected var bg:Image;
      
      protected var trees:Image;
      
      protected var bushContainer:Sprite;
      
      protected var bush1:Image;
      
      protected var bush2:Image;
      
      protected var plant1:Image;
      
      protected var plant2:Image;
      
      protected var plant3:Image;
      
      protected var grass:Image;
      
      protected var cat:Image;
      
      protected var enemy:Image;
      
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
      
      public function IntroScene3Panel()
      {
         super();
         this.counter_1 = this.counter_2 = this.counter_3 = 0;
         this.bg = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_background"));
         this.bg.width = 600;
         this.bg.height = 400;
         this.bg.touchable = false;
         addChild(this.bg);
         this.bg.x = int(-300);
         this.bg.y = int(-200);
         this.trees = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_trees"));
         this.trees.touchable = false;
         this.trees.pivotY = this.trees.height;
         this.trees.x = int(-this.trees.width * 0.5 - 32);
         this.trees.y = 32;
         addChild(this.trees);
         this.bushContainer = new Sprite();
         addChild(this.bushContainer);
         this.bush1 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_bush"));
         this.bush1.touchable = false;
         this.bushContainer.addChild(this.bush1);
         this.bush2 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_bush"));
         this.bush2.touchable = false;
         this.bushContainer.addChild(this.bush2);
         this.bush2.x = 640;
         this.bushContainer.pivotY = this.bushContainer.height;
         this.bushContainer.x = -300;
         this.bushContainer.y = 80;
         this.grass = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_grass"));
         this.grass.touchable = false;
         this.grass.width = 600;
         addChild(this.grass);
         this.grass.x = -300;
         this.grass.y = 37;
         this.cat = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_cat"));
         this.cat.pivotX = int(this.cat.width * 0.5);
         this.cat.pivotY = int(this.cat.height);
         addChild(this.cat);
         this.cat.touchable = false;
         this.cat.x = -72;
         this.cat.y = 72;
         this.plant1 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_plant"));
         this.plant2 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_plant"));
         this.plant3 = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_plant"));
         this.plant1.pivotX = this.plant2.pivotX = this.plant3.pivotX = int(this.plant1.width * 0.5);
         this.plant1.pivotY = this.plant2.pivotY = this.plant3.pivotY = int(this.plant1.height);
         addChild(this.plant1);
         addChild(this.plant2);
         addChild(this.plant3);
         this.plant1.touchable = this.plant2.touchable = this.plant3.touchable = false;
         this.plant1.x = -168;
         this.plant1.y = 91;
         this.plant2.x = -17;
         this.plant2.y = 130;
         this.plant3.x = 20;
         this.plant3.y = 79;
         this.enemy = new Image(TextureManager.intro2TextureAtlas.getTexture("scene_3_enemy"));
         this.enemy.pivotX = int(this.enemy.width * 0.5);
         this.enemy.pivotY = 0;
         this.enemy.x = 128;
         this.enemy.y = 0;
         addChild(this.enemy);
         this.startScene();
      }
      
      public function destroy() : void
      {
         removeChild(this.enemy);
         this.enemy.dispose();
         this.enemy = null;
         removeChild(this.plant1);
         removeChild(this.plant2);
         removeChild(this.plant3);
         this.plant1.dispose();
         this.plant2.dispose();
         this.plant3.dispose();
         this.plant1 = null;
         this.plant2 = null;
         this.plant3 = null;
         removeChild(this.cat);
         this.cat.dispose();
         this.cat = null;
         removeChild(this.grass);
         this.grass.dispose();
         this.grass = null;
         this.bushContainer.removeChild(this.bush2);
         this.bushContainer.removeChild(this.bush1);
         this.bush2.dispose();
         this.bush1.dispose();
         this.bush2 = null;
         this.bush1 = null;
         removeChild(this.bushContainer);
         this.bushContainer.dispose();
         this.bushContainer = null;
         removeChild(this.trees);
         this.trees.dispose();
         this.trees = null;
         removeChild(this.bg);
         this.bg.dispose();
         this.bg = null;
      }
      
      public function startScene() : void
      {
         var tween:Tween = null;
         tween = new Tween(this.trees,4,Transitions.LINEAR);
         tween.animate("x",this.trees.x + 128);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.bushContainer,4,Transitions.LINEAR);
         tween.animate("x",this.bushContainer.x + 48);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.cat,4,Transitions.LINEAR);
         tween.animate("x",this.cat.x + 32);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.plant1,4,Transitions.LINEAR);
         tween.animate("x",this.plant1.x + 16);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.plant3,4,Transitions.LINEAR);
         tween.animate("x",this.plant3.x + 16);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.plant2,4,Transitions.LINEAR);
         tween.animate("x",this.plant2.x - 32);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.enemy,4,Transitions.LINEAR);
         tween.animate("x",this.enemy.x - 32);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
      }
      
      public function update() : void
      {
      }
   }
}
