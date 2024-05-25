package interfaces.panels.intro
{
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class IntroCatPanel extends Sprite
   {
       
      
      protected var INDEX:int;
      
      protected var whitePanel:Image;
      
      protected var bottomContainer:Sprite;
      
      protected var bottomImages:Vector.<Image>;
      
      protected var topContainer:Sprite;
      
      protected var topImages:Vector.<Image>;
      
      protected var cat:Image;
      
      protected var cat_name:Image;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var counter_3:int;
      
      protected var additional_x_margin:Number;
      
      protected var additional_y_margin:Number;
      
      public function IntroCatPanel(_INDEX:int = 0)
      {
         var i:int = 0;
         var image:Image = null;
         super();
         this.INDEX = _INDEX;
         this.counter_1 = this.counter_2 = this.counter_3 = 0;
         this.additional_x_margin = this.additional_y_margin = 0;
         this.whitePanel = new Image(TextureManager.hudTextureAtlas.getTexture("intro_white_color_1"));
         this.whitePanel.width = int(Utils.WIDTH + 1);
         this.whitePanel.height = int(Utils.HEIGHT + 1);
         addChild(this.whitePanel);
         this.whitePanel.alpha = 0;
         this.bottomContainer = new Sprite();
         this.bottomImages = new Vector.<Image>();
         addChild(this.bottomContainer);
         this.bottomContainer.x = 0;
         this.bottomContainer.y = Utils.HEIGHT;
         image = new Image(TextureManager.intro2TextureAtlas.getTexture("red_grid"));
         image.touchable = false;
         this.bottomImages.push(image);
         this.bottomContainer.addChild(image);
         image = new Image(TextureManager.intro2TextureAtlas.getTexture("red_grid"));
         image.x = 288;
         image.touchable = false;
         this.bottomImages.push(image);
         this.bottomContainer.addChild(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("redQuad"));
         image.touchable = false;
         this.bottomImages.push(image);
         this.bottomContainer.addChild(image);
         image.x = 0;
         image.y = 16;
         image.width = Utils.WIDTH + 64;
         image.height = Utils.HEIGHT * 0.5;
         this.topContainer = new Sprite();
         this.topImages = new Vector.<Image>();
         addChild(this.topContainer);
         this.topContainer.x = 0;
         this.topContainer.y = 0;
         image = new Image(TextureManager.intro2TextureAtlas.getTexture("red_grid"));
         image.scaleY = -1;
         image.touchable = false;
         this.topImages.push(image);
         this.topContainer.addChild(image);
         image = new Image(TextureManager.intro2TextureAtlas.getTexture("red_grid"));
         image.x = 288;
         image.scaleY = -1;
         image.touchable = false;
         this.topImages.push(image);
         this.topContainer.addChild(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("redQuad"));
         image.touchable = false;
         this.topImages.push(image);
         this.topContainer.addChild(image);
         image.x = -24;
         image.width = Utils.WIDTH + 64;
         image.height = int(Utils.HEIGHT * 0.5);
         image.y = -(image.height + 16);
         if(this.INDEX == 1)
         {
            this.cat = new Image(TextureManager.introTextureAtlas.getTexture("intro_cat_6"));
         }
         else if(this.INDEX == 2)
         {
            this.cat = new Image(TextureManager.introTextureAtlas.getTexture("intro_cat_2"));
         }
         else
         {
            this.cat = new Image(TextureManager.introTextureAtlas.getTexture("intro_cat_0"));
         }
         this.cat.touchable = false;
         this.cat.scaleX = -1;
         this.cat.x = 0;
         this.cat.y = int(Utils.HEIGHT * 0.05);
         addChild(this.cat);
         if(this.INDEX == 1)
         {
            this.cat.pivotX = this.cat.width;
            this.cat.x = int(Utils.WIDTH);
         }
         setChildIndex(this.bottomContainer,numChildren - 1);
         if(this.INDEX == 1)
         {
            this.cat_name = new Image(TextureManager.introTextureAtlas.getTexture("intro_cat_name_6"));
         }
         else if(this.INDEX == 2)
         {
            this.cat_name = new Image(TextureManager.introTextureAtlas.getTexture("intro_cat_name_2"));
         }
         else
         {
            this.cat_name = new Image(TextureManager.introTextureAtlas.getTexture("intro_cat_name_0"));
         }
         this.cat_name.touchable = false;
         this.cat_name.x = Utils.WIDTH;
         this.cat_name.y = int(Utils.HEIGHT * 0.04);
         addChild(this.cat_name);
         if(this.INDEX == 1)
         {
            this.cat_name.x = -this.cat_name.width;
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         removeChild(this.cat_name);
         this.cat_name.dispose();
         this.cat_name = null;
         removeChild(this.cat);
         this.cat.dispose();
         this.cat = null;
         for(i = 0; i < this.topImages.length; i++)
         {
            this.topContainer.removeChild(this.topImages[i]);
            this.topImages[i].dispose();
            this.topImages[i] = null;
         }
         this.topImages = null;
         removeChild(this.topContainer);
         this.topContainer.dispose();
         this.topContainer = null;
         for(i = 0; i < this.bottomImages.length; i++)
         {
            this.bottomContainer.removeChild(this.bottomImages[i]);
            this.bottomImages[i].dispose();
            this.bottomImages[i] = null;
         }
         this.bottomImages = null;
         removeChild(this.bottomContainer);
         this.bottomContainer.dispose();
         this.bottomContainer = null;
         removeChild(this.whitePanel);
         this.whitePanel.dispose();
         this.whitePanel = null;
      }
      
      public function startPanel() : void
      {
         var tween:Tween = new Tween(this.topContainer,0.25,Transitions.EASE_OUT);
         tween.animate("y",int(Utils.HEIGHT * 0.25));
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.bottomContainer,0.25,Transitions.EASE_OUT);
         tween.animate("y",int(Utils.HEIGHT * 0.75));
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.whitePanel,0.25,Transitions.LINEAR);
         tween.fadeTo(0.75);
         Starling.juggler.add(tween);
         if(this.INDEX == 1)
         {
            tween = new Tween(this.cat,0.3,Transitions.EASE_OUT);
            tween.animate("x",int(Utils.WIDTH * 0.45));
            tween.roundToInt = true;
            Starling.juggler.add(tween);
         }
         else if(this.INDEX == 2)
         {
            tween = new Tween(this.cat,0.3,Transitions.EASE_OUT);
            if(Utils.IS_IPAD)
            {
               tween.animate("x",int(Utils.WIDTH * 0.7));
            }
            else
            {
               tween.animate("x",int(Utils.WIDTH * 0.6));
            }
            tween.roundToInt = true;
            Starling.juggler.add(tween);
         }
         else
         {
            tween = new Tween(this.cat,0.3,Transitions.EASE_OUT);
            if(Utils.IS_IPAD)
            {
               tween.animate("x",int(Utils.WIDTH * 0.65));
            }
            else
            {
               tween.animate("x",int(Utils.WIDTH * 0.55));
            }
            tween.roundToInt = true;
            Starling.juggler.add(tween);
         }
         if(Utils.IS_IPHONE_X)
         {
            this.additional_x_margin = 16;
         }
         tween = new Tween(this.cat_name,0.3,Transitions.EASE_OUT);
         if(this.INDEX == 1)
         {
            tween.animate("x",int(this.cat_name.y + this.additional_x_margin));
         }
         else
         {
            tween.animate("x",int(Utils.WIDTH - this.cat_name.width - this.cat_name.y - this.additional_x_margin));
         }
         tween.roundToInt = true;
         Starling.juggler.add(tween);
      }
      
      public function update() : void
      {
         ++this.counter_1;
         if(this.counter_1 >= 15)
         {
            --this.topContainer.x;
            if(this.topContainer.x <= -24)
            {
               this.topContainer.x = 0;
            }
            --this.bottomContainer.x;
            if(this.bottomContainer.x <= -24)
            {
               this.bottomContainer.x = 0;
            }
         }
         if(this.counter_1 >= 18)
         {
            if(this.counter_2++ > 8)
            {
               this.counter_2 = 0;
               if(this.INDEX == 1)
               {
                  --this.cat.x;
               }
               else
               {
                  ++this.cat.x;
               }
            }
         }
      }
   }
}
