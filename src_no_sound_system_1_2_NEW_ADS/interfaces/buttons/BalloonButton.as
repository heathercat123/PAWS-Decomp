package interfaces.buttons
{
   import game_utils.InAppProductsManager;
   import interfaces.texts.GameText;
   import interfaces.texts.GameTextArea;
   import starling.display.Button;
   import starling.display.Image;
   
   public class BalloonButton extends Button
   {
      
      public static var TYPE_GATE:int = 0;
      
      public static var TYPE_PREMIUM:int = 1;
      
      public static var TYPE_CONTINUE:int = 2;
      
      public static var TYPE_DOUBLE_COINS:int = 3;
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var TYPE:int;
      
      protected var title:GameText;
      
      protected var textBody:GameTextArea;
      
      protected var price:GameText;
      
      protected var adImage:Image;
      
      public function BalloonButton(_type:int)
      {
         var total_height:int = 0;
         var space_height:int = 0;
         var y_pos:int = 0;
         var shift_amount:int = 0;
         super(TextureManager.hudTextureAtlas.getTexture("hud_balloon_button_1"),"",TextureManager.hudTextureAtlas.getTexture("hud_balloon_button_2"));
         this.TYPE = _type;
         if(this.TYPE == TYPE_GATE)
         {
            this.title = new GameText(StringsManager.GetString("panel_unlock_gate_title"),GameText.TYPE_BIG);
         }
         else if(this.TYPE == TYPE_PREMIUM)
         {
            this.title = new GameText(StringsManager.GetString("panel_premium_title"),GameText.TYPE_BIG);
         }
         else if(this.TYPE == TYPE_DOUBLE_COINS)
         {
            this.title = new GameText(StringsManager.GetString("panel_double_coins_title"),GameText.TYPE_BIG);
         }
         else if(Utils.IsEvent)
         {
            this.title = new GameText(StringsManager.GetString("event_panel_1"),GameText.TYPE_BIG);
         }
         else
         {
            this.title = new GameText(StringsManager.GetString("panel_game_over_title"),GameText.TYPE_BIG);
         }
         if(Utils.EnableFontStrings)
         {
            this.title.setColor(8267091);
         }
         this.title.pivotX = int(this.title.WIDTH * 0.5);
         addChild(this.title);
         this.title.x = int(175 * 0.5 + 13);
         this.title.y = 5;
         this.title.touchable = false;
         if(this.TYPE == TYPE_GATE)
         {
            this.textBody = new GameTextArea(StringsManager.GetString("panel_unlock_gate_text"),GameText.TYPE_SMALL_DARK,160,64,true);
         }
         else if(this.TYPE == TYPE_PREMIUM)
         {
            this.textBody = new GameTextArea(StringsManager.GetString("panel_premium_text"),GameText.TYPE_SMALL_DARK,160,64,true);
         }
         else if(this.TYPE == TYPE_DOUBLE_COINS)
         {
            this.textBody = new GameTextArea(StringsManager.GetString("panel_double_coins_text"),GameText.TYPE_SMALL_DARK,160,64,true);
         }
         else if(Utils.IsEvent)
         {
            this.textBody = new GameTextArea(StringsManager.GetString("event_panel_2"),GameText.TYPE_SMALL_DARK,176,64,true);
         }
         else
         {
            this.textBody = new GameTextArea(StringsManager.GetString("panel_game_over_text"),GameText.TYPE_SMALL_DARK,176,64,true);
         }
         if(Utils.EnableFontStrings)
         {
            this.textBody.setColor(8267091);
         }
         this.textBody.x = 13 + 9 - 2;
         this.textBody.y = 24;
         addChild(this.textBody);
         if(this.TYPE == TYPE_CONTINUE)
         {
            this.adImage = new Image(TextureManager.hudTextureAtlas.getTexture("watch_ad"));
            this.adImage.touchable = false;
            addChild(this.adImage);
            this.adImage.pivotX = int(this.adImage.width * 0.5);
            this.adImage.x = 110;
            this.price = null;
            total_height = this.textBody.getLinesHeight() + 5 + this.adImage.height;
            space_height = 67;
            y_pos = 22 + int((space_height - total_height) * 0.5);
            this.textBody.y = y_pos;
            this.adImage.y = this.textBody.y + this.textBody.getLinesHeight() + 5;
            if(Utils.EnableFontStrings)
            {
               this.adImage.y = this.textBody.y + this.textBody.HEIGHT;
            }
         }
         else if(this.TYPE == TYPE_DOUBLE_COINS)
         {
            this.adImage = new Image(TextureManager.hudTextureAtlas.getTexture("watch_ad"));
            this.adImage.touchable = false;
            addChild(this.adImage);
            this.adImage.pivotX = int(this.adImage.width * 0.5);
            this.adImage.x = 110;
            this.price = new GameText("" + int(Utils.PlayerCoins * 2),GameText.TYPE_SMALL_DARK,true);
            this.price.touchable = false;
            addChild(this.price);
            this.price.x = this.adImage.x + this.adImage.width * 0.5 + 6;
            total_height = this.textBody.getLinesHeight() + 5 + this.adImage.height;
            space_height = 67;
            y_pos = 22 + int((space_height - total_height) * 0.5);
            this.textBody.y = y_pos;
            this.adImage.y = this.textBody.y + this.textBody.getLinesHeight() + 5;
            if(Utils.EnableFontStrings)
            {
               this.adImage.y = this.textBody.y + this.textBody.HEIGHT;
            }
            this.price.y = this.adImage.y + 18;
            shift_amount = 6 + this.price.WIDTH;
            this.adImage.x -= int(shift_amount * 0.5);
            this.price.x -= int(shift_amount * 0.5);
         }
         else
         {
            if(this.TYPE == TYPE_PREMIUM)
            {
               if(Utils.IS_ANDROID)
               {
                  this.price = new GameText(InAppProductsManager.GetLocalizedPrice(Utils.ANDROID_INAPP_PREMIUM_PRODUCT),GameText.TYPE_BIG);
               }
               else
               {
                  this.price = new GameText(InAppProductsManager.GetLocalizedPrice("com.neutronized.supercattalespaws.premium"),GameText.TYPE_BIG);
               }
            }
            else if(Utils.IS_ANDROID)
            {
               this.price = new GameText(InAppProductsManager.GetLocalizedPrice(Utils.ANDROID_INAPP_GATE_PRODUCT),GameText.TYPE_BIG);
            }
            else
            {
               this.price = new GameText(InAppProductsManager.GetLocalizedPrice("com.neutronized.supercattalespaws.gate_ticket"),GameText.TYPE_BIG);
            }
            if(Utils.EnableFontStrings)
            {
               this.price.setColor(8267091);
            }
            this.price.pivotX = int(this.price.WIDTH * 0.5);
            addChild(this.price);
            this.price.x = 110 - 10;
            this.price.y = this.textBody.y + this.textBody.getLinesHeight() + 5;
            addChild(this.price);
            if(Utils.EnableFontStrings)
            {
               this.price.y = this.textBody.y + this.textBody.HEIGHT;
            }
            this.adImage = null;
            total_height = this.textBody.getLinesHeight() + 5 + this.price.HEIGHT;
            space_height = 67;
            y_pos = 22 + int((space_height - total_height) * 0.5);
            this.textBody.y = y_pos;
            this.price.y = this.textBody.y + this.textBody.getLinesHeight() + 5;
         }
      }
      
      public function destroy() : void
      {
         removeChild(this.title);
         this.title.destroy();
         this.title.dispose();
         this.title = null;
         removeChild(this.textBody);
         this.textBody.destroy();
         this.textBody.dispose();
         this.textBody = null;
         if(this.price != null)
         {
            removeChild(this.price);
            this.price.destroy();
            this.price.dispose();
            this.price = null;
         }
         if(this.adImage != null)
         {
            removeChild(this.adImage);
            this.adImage.dispose();
            this.adImage = null;
         }
      }
   }
}
