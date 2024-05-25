package interfaces.panels
{
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class SplashHudPanel extends Sprite
   {
       
      
      public var settingsButton:Button;
      
      public var scoresButton:Button;
      
      public var googlePlayButton:Button;
      
      public var achievementsButton:Button;
      
      protected var additional_x_margin:int;
      
      protected var additional_y_margin:int;
      
      public var BUTTONS_IN:Boolean;
      
      public function SplashHudPanel()
      {
         super();
         if(Utils.IS_IPHONE_X)
         {
            this.additional_x_margin = 16;
            this.additional_y_margin = -2;
         }
         else
         {
            this.additional_x_margin = -4;
            this.additional_y_margin = -3;
         }
         this.googlePlayButton = null;
         this.achievementsButton = null;
         this.settingsButton = new Button(TextureManager.hudTextureAtlas.getTexture("optionsButton1"),"",TextureManager.hudTextureAtlas.getTexture("optionsButton2"));
         this.settingsButton.name = "settings";
         Image(Sprite(this.settingsButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.settingsButton.x = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE - (this.settingsButton.width + this.additional_x_margin));
         this.settingsButton.y = this.additional_y_margin;
         addChild(this.settingsButton);
         if(Utils.IS_ANDROID)
         {
            this.scoresButton = new Button(TextureManager.hudTextureAtlas.getTexture("android1Button1"),"",TextureManager.hudTextureAtlas.getTexture("android1Button2"));
         }
         else
         {
            this.scoresButton = new Button(TextureManager.hudTextureAtlas.getTexture("scoresButton1"),"",TextureManager.hudTextureAtlas.getTexture("scoresButton2"));
         }
         Image(Sprite(this.scoresButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.scoresButton.name = "scores";
         this.scoresButton.x = this.settingsButton.x - this.scoresButton.width;
         this.scoresButton.y = this.additional_y_margin;
         addChild(this.scoresButton);
         if(Utils.IS_ANDROID)
         {
            this.googlePlayButton = new Button(TextureManager.hudTextureAtlas.getTexture("googleButton1"),"",TextureManager.hudTextureAtlas.getTexture("googleButton2"));
            Image(Sprite(this.googlePlayButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
            this.googlePlayButton.name = "google";
            this.googlePlayButton.x = int(this.additional_x_margin + 1);
            this.googlePlayButton.y = int(this.additional_y_margin);
            addChild(this.googlePlayButton);
            this.achievementsButton = new Button(TextureManager.hudTextureAtlas.getTexture("android2Button1"),"",TextureManager.hudTextureAtlas.getTexture("android2Button2"));
            Image(Sprite(this.achievementsButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
            this.achievementsButton.name = "achievements";
            this.achievementsButton.x = int(this.scoresButton.x - this.achievementsButton.width + 8);
            this.achievementsButton.y = int(this.additional_y_margin);
            addChild(this.achievementsButton);
         }
         else
         {
            this.achievementsButton = null;
            this.googlePlayButton = null;
         }
         this.BUTTONS_IN = true;
      }
      
      public function showButtons() : void
      {
         ++this.settingsButton.y;
         ++this.scoresButton.y;
         if(this.settingsButton.y >= this.additional_y_margin)
         {
            this.settingsButton.y = this.additional_y_margin;
            this.scoresButton.y = this.settingsButton.y;
            this.BUTTONS_IN = true;
         }
         if(Utils.IS_ANDROID)
         {
            this.googlePlayButton.y = this.achievementsButton.y = this.scoresButton.y;
         }
      }
      
      public function setbuttonsInside() : void
      {
         this.settingsButton.y = this.additional_y_margin;
         this.scoresButton.y = this.settingsButton.y;
         if(Utils.IS_ANDROID)
         {
            this.googlePlayButton.y = this.achievementsButton.y = this.scoresButton.y;
         }
         this.BUTTONS_IN = true;
      }
      
      public function setButtonsOutside() : void
      {
         this.settingsButton.y = -this.settingsButton.height;
         this.scoresButton.y = this.settingsButton.y;
         if(Utils.IS_ANDROID)
         {
            this.googlePlayButton.y = this.achievementsButton.y = this.scoresButton.y;
         }
         this.BUTTONS_IN = false;
      }
      
      public function enableButtons() : void
      {
         this.settingsButton.touchable = true;
         this.scoresButton.touchable = true;
         if(Utils.IS_ANDROID)
         {
            this.googlePlayButton.touchable = this.achievementsButton.touchable = true;
         }
      }
      
      public function disableButtons() : void
      {
         this.settingsButton.touchable = false;
         this.scoresButton.touchable = false;
         if(Utils.IS_ANDROID)
         {
            this.googlePlayButton.touchable = this.achievementsButton.touchable = false;
         }
      }
      
      public function destroy() : void
      {
         removeChild(this.settingsButton);
         this.settingsButton.dispose();
         this.settingsButton = null;
         removeChild(this.scoresButton);
         this.scoresButton.dispose();
         this.scoresButton = null;
         if(this.googlePlayButton != null)
         {
            removeChild(this.googlePlayButton);
            this.googlePlayButton.dispose();
            this.googlePlayButton = null;
         }
         if(this.achievementsButton != null)
         {
            removeChild(this.achievementsButton);
            this.achievementsButton.dispose();
            this.achievementsButton = null;
         }
      }
   }
}
