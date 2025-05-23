package interfaces.panels
{
   import com.distriqt.extension.inappbilling.InAppBilling;
   import com.distriqt.extension.inappbilling.Purchase;
   import com.distriqt.extension.inappbilling.PurchaseRequest;
   import com.distriqt.extension.inappbilling.events.PurchaseEvent;
   import interfaces.buttons.BuyButton;
   import interfaces.texts.GameText;
   import interfaces.texts.GameTextArea;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Button;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class PremiumPanel extends Sprite
   {
      
      public var GET_OUT_FLAG:Boolean;
      
      public var CONTINUE_FLAG:Boolean;
      
      public var QUIT_FLAG:Boolean;
      
      public var REPEAT_FLAG:Boolean;
      
      public var pausePanelEntering:Boolean;
      
      public var pausePanelExiting:Boolean;
      
      public var pausePanelStaying:Boolean;
      
      public var backgroundQuad:Quad;
      
      public var container:Sprite;
      
      public var backButton:Button;
      
      public var bluePanel:BluePanel;
      
      public var buyButton:BuyButton;
      
      public var titleText:GameText;
      
      public var star_sx:Image;
      
      public var star_dx:Image;
      
      public var feature1Image:Image;
      
      public var feature2Image:Image;
      
      public var feature3Image:Image;
      
      public var feature1Text:GameTextArea;
      
      public var feature2Text:GameTextArea;
      
      public var feature3Text:GameTextArea;
      
      public var counter:int;
      
      protected var body_percentage:Number;
      
      protected var column_percentage:Number;
      
      protected var inner_margin_percentage:Number;
      
      protected var body_height_percentage:Number;
      
      protected var body_width:int;
      
      protected var body_height:int;
      
      protected var column_width:int;
      
      protected var button_height:int;
      
      protected var inner_margin:int;
      
      protected var outer_x_margin:int;
      
      protected var outer_y_margin:int;
      
      protected var sin_counter_1:Number;
      
      protected var sin_counter_2:Number;
      
      protected var sin_counter_3:Number;
      
      protected var sin_counter_4:Number;
      
      protected var sin_speed_1:Number;
      
      protected var sin_speed_2:Number;
      
      protected var sin_speed_3:Number;
      
      protected var sin_speed_4:Number;
      
      public var TYPE:int;
      
      public function PremiumPanel(type:int = 0)
      {
         super();
         this.GET_OUT_FLAG = false;
         this.CONTINUE_FLAG = false;
         this.QUIT_FLAG = false;
         this.REPEAT_FLAG = false;
         this.sin_counter_1 = Math.random() * Math.PI * 2;
         this.sin_counter_2 = Math.random() * Math.PI * 2;
         this.sin_counter_3 = Math.random() * Math.PI * 2;
         this.sin_counter_4 = Math.random() * Math.PI * 2;
         this.sin_speed_1 = Math.random() * 0.025 + 0.025;
         this.sin_speed_2 = Math.random() * 0.025 + 0.025;
         this.sin_speed_3 = Math.random() * 0.025 + 0.025;
         this.sin_speed_4 = Math.random() * 0.025 + 0.025;
         this.pausePanelEntering = false;
         this.pausePanelExiting = false;
         this.pausePanelStaying = false;
         this.counter = 0;
         this.TYPE = type;
         this.visible = false;
         this.scaleX = this.scaleY = Utils.GFX_SCALE;
         this.evaluatePercentages();
         this.initBackground();
         this.initBluePanel();
         this.initText();
         this.initButtons();
         this.buyButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.backButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         if(InAppBilling.isSupported)
         {
            InAppBilling.service.addEventListener(PurchaseEvent.PURCHASES_UPDATED,this.premium_purchases_updatedHandler);
            InAppBilling.service.addEventListener(PurchaseEvent.PURCHASE_FAILED,this.premium_purchase_failedHandler);
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         if(InAppBilling.isSupported)
         {
            InAppBilling.service.removeEventListener(PurchaseEvent.PURCHASES_UPDATED,this.premium_purchases_updatedHandler);
            InAppBilling.service.removeEventListener(PurchaseEvent.PURCHASE_FAILED,this.premium_purchase_failedHandler);
         }
         if(this.visible)
         {
            Utils.rootMovie.removeChild(this);
         }
         this.backButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.buyButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.container.removeChild(this.feature1Image);
         this.container.removeChild(this.feature2Image);
         this.container.removeChild(this.feature3Image);
         this.container.removeChild(this.feature1Text);
         this.container.removeChild(this.feature2Text);
         this.container.removeChild(this.feature3Text);
         this.feature1Text.destroy();
         this.feature2Text.destroy();
         this.feature3Text.destroy();
         this.feature1Text.dispose();
         this.feature2Text.dispose();
         this.feature3Text.dispose();
         this.feature1Image.dispose();
         this.feature2Image.dispose();
         this.feature3Image.dispose();
         this.feature1Image = null;
         this.feature2Image = null;
         this.feature3Image = null;
         this.feature1Text = null;
         this.feature2Text = null;
         this.feature3Text = null;
         this.container.removeChild(this.buyButton);
         this.buyButton.destroy();
         this.buyButton.dispose();
         this.buyButton = null;
         this.container.removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
         this.container.removeChild(this.titleText);
         this.titleText.destroy();
         this.titleText.dispose();
         this.titleText = null;
         this.container.removeChild(this.star_sx);
         this.star_sx.dispose();
         this.star_sx = null;
         this.container.removeChild(this.star_dx);
         this.star_dx.dispose();
         this.star_dx = null;
         this.container.removeChild(this.backButton);
         this.backButton.dispose();
         this.backButton = null;
         removeChild(this.container);
         this.container.dispose();
         this.container = null;
         this.backButton = null;
         removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
      }
      
      public function backButtonAndroid() : void
      {
         this.quitPanel();
      }
      
      public function update() : void
      {
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
         this.sin_counter_3 += this.sin_speed_3;
         if(this.sin_counter_3 > Math.PI * 2)
         {
            this.sin_counter_3 -= Math.PI * 2;
            this.sin_speed_3 = Math.random() * 0.04 + 0.025;
         }
         this.sin_counter_4 += this.sin_speed_4;
         if(this.sin_counter_4 > Math.PI * 2)
         {
            this.sin_counter_4 -= Math.PI * 2;
            this.sin_speed_4 = Math.random() * 0.04 + 0.025;
         }
         this.backgroundQuad.setVertexColor(0,16773608);
         this.backgroundQuad.setVertexColor(1,16773608);
         this.backgroundQuad.setVertexColor(2,16773608);
         this.backgroundQuad.setVertexColor(3,16773608);
         this.backgroundQuad.setVertexAlpha(0,0.75 + Math.sin(this.sin_counter_1) * 0.25);
         this.backgroundQuad.setVertexAlpha(1,0.75 + Math.sin(this.sin_counter_2) * 0.25);
         this.backgroundQuad.setVertexAlpha(2,0.75 + Math.sin(this.sin_counter_3) * 0.25);
         this.backgroundQuad.setVertexAlpha(3,0.75 + Math.sin(this.sin_counter_4) * 0.25);
         this.buyButton.update();
      }
      
      protected function clickHandler(event:Event) : void
      {
         if(this.pausePanelStaying)
         {
            if(DisplayObject(event.target).name == "buyButton")
            {
               SoundSystem.PlaySound("select");
               this.continuePanel();
            }
            else if(DisplayObject(event.target).name == "quitButton")
            {
               this.quitPanel();
            }
         }
      }
      
      public function continuePanel() : void
      {
         var request:PurchaseRequest = null;
         if(this.CONTINUE_FLAG)
         {
            return;
         }
         if(Utils.IS_ON_WINDOWS)
         {
            SoundSystem.PlaySound("selectGo");
            this.CONTINUE_FLAG = true;
            this.popOut();
            this.setButtonsTouchable(false);
         }
         else
         {
            this.setButtonsTouchable(false);
            if(InAppBilling.isSupported)
            {
               Utils.PURCHASE_ORIGIN = 1;
               request = new PurchaseRequest();
               request.quantity = 1;
               request.productId = Utils.ANDROID_INAPP_PREMIUM_PRODUCT;
               InAppBilling.service.makePurchase(request);
            }
            else
            {
               this.quitPanel();
            }
         }
      }
      
      public function quitPanel() : void
      {
         if(this.GET_OUT_FLAG)
         {
            return;
         }
         SoundSystem.PlaySound("selectBack");
         this.CONTINUE_FLAG = true;
         this.popOut();
         this.setButtonsTouchable(false);
      }
      
      public function popUp() : void
      {
         var i:int = 0;
         var tween:Tween = null;
         var targetY:int = 0;
         this.GET_OUT_FLAG = false;
         this.CONTINUE_FLAG = false;
         this.pausePanelEntering = true;
         this.pausePanelExiting = false;
         this.pausePanelStaying = false;
         this.counter = 0;
         Utils.rootMovie.addChild(this);
         this.visible = true;
         this.backgroundQuad.alpha = 0;
         this.buyButton.touchable = false;
         this.backButton.touchable = false;
         tween = new Tween(this.backgroundQuad,0.25,Transitions.EASE_OUT);
         tween.fadeTo(0.8);
         Starling.juggler.add(tween);
         tween = new Tween(this.container,0.25,Transitions.EASE_OUT_BACK);
         tween.moveTo(0,0);
         tween.delay = 0;
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween.onComplete = this.popUpComplete;
      }
      
      protected function popOut() : void
      {
         var tween:Tween = null;
         this.pausePanelEntering = false;
         this.pausePanelExiting = true;
         this.pausePanelStaying = false;
         this.counter = 0;
         tween = new Tween(this.backgroundQuad,0.15);
         tween.fadeTo(0);
         Starling.juggler.add(tween);
         tween = new Tween(this.container,0.15,Transitions.EASE_IN_BACK);
         tween.moveTo(0,int(Utils.HEIGHT));
         tween.delay = 0;
         tween.roundToInt = true;
         tween.onComplete = this.popOutComplete;
         Starling.juggler.add(tween);
      }
      
      protected function popUpComplete() : void
      {
         this.pausePanelEntering = false;
         this.pausePanelStaying = true;
         this.buyButton.touchable = true;
         this.backButton.touchable = true;
      }
      
      protected function popOutComplete() : void
      {
         this.pausePanelExiting = false;
         this.GET_OUT_FLAG = true;
      }
      
      public function hide() : void
      {
         Utils.rootMovie.removeChild(this);
         this.visible = false;
      }
      
      protected function evaluatePercentages() : void
      {
         var WIDTH:int = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE);
         var HEIGHT:int = int(Utils.SCREEN_HEIGHT * Utils.GFX_INV_SCALE);
         WIDTH -= Utils.X_SCREEN_MARGIN;
         HEIGHT -= Utils.Y_SCREEN_MARGIN;
         this.body_percentage = 0.58;
         this.column_percentage = 0.15;
         this.inner_margin_percentage = 0.15;
         if(int(WIDTH * this.column_percentage) < 40)
         {
            this.body_percentage = 0.56;
            this.column_percentage = 0.18;
            this.inner_margin_percentage = 0.12;
         }
         this.body_width = int(WIDTH * this.body_percentage);
         this.column_width = int(WIDTH * this.column_percentage);
         this.inner_margin = int(this.column_width * this.inner_margin_percentage);
         this.outer_x_margin = this.outer_y_margin = int((WIDTH - (this.body_width + this.column_width * 2 + this.inner_margin * 2)) * 0.5);
         this.outer_x_margin += int(Utils.X_SCREEN_MARGIN * 0.5);
         this.body_height = int(HEIGHT - this.outer_y_margin * 2);
         this.button_height = int((this.body_height - this.inner_margin * 2) / 3);
      }
      
      protected function initBackground() : void
      {
         this.backgroundQuad = new Quad(Utils.WIDTH,Utils.HEIGHT,16773608);
         this.backgroundQuad.width = Utils.WIDTH;
         this.backgroundQuad.height = Utils.HEIGHT;
         this.backgroundQuad.x = 0;
         this.backgroundQuad.y = 0;
         addChild(this.backgroundQuad);
         this.container = new Sprite();
         this.container.x = 0;
         this.container.y = Utils.HEIGHT;
         addChild(this.container);
      }
      
      protected function initButtons() : void
      {
         this.backButton = new Button(TextureManager.hudTextureAtlas.getTexture("hud_close_button_1"),"",TextureManager.hudTextureAtlas.getTexture("hud_close_button_2"));
         this.backButton.name = "quitButton";
         this.backButton.pivotX = int(this.backButton.width * 0.6);
         this.backButton.pivotY = int(this.backButton.height * 0.4);
         this.backButton.x = this.bluePanel.x + this.bluePanel.WIDTH - 4;
         this.backButton.y = this.bluePanel.y + 4;
         this.container.addChild(this.backButton);
         this.feature1Image = new Image(TextureManager.hudTextureAtlas.getTexture("premium_feature_1"));
         this.feature2Image = new Image(TextureManager.hudTextureAtlas.getTexture("premium_feature_2"));
         this.feature3Image = new Image(TextureManager.hudTextureAtlas.getTexture("premium_feature_3"));
         this.feature1Image.touchable = this.feature2Image.touchable = this.feature3Image.touchable = false;
         this.feature1Image.pivotX = int(this.feature1Image.width * 0.5);
         this.feature2Image.pivotX = int(this.feature2Image.width * 0.5);
         this.feature3Image.pivotX = int(this.feature3Image.width * 0.5);
         this.feature1Image.pivotY = int(this.feature1Image.height * 0.5);
         this.feature2Image.pivotY = int(this.feature2Image.height * 0.5);
         this.feature3Image.pivotY = int(this.feature3Image.height * 0.5);
         this.feature1Text = new GameTextArea(StringsManager.GetString("panel_premium_text_1"),GameText.TYPE_SMALL_DARK,64,64,true);
         this.feature2Text = new GameTextArea(StringsManager.GetString("panel_premium_text_2"),GameText.TYPE_SMALL_DARK,64,64,true);
         this.feature3Text = new GameTextArea(StringsManager.GetString("panel_premium_text_3"),GameText.TYPE_SMALL_DARK,64,64,true);
         this.feature1Text.pivotX = this.feature2Text.pivotX = this.feature3Text.pivotX = 32;
         this.container.addChild(this.feature1Image);
         this.container.addChild(this.feature2Image);
         this.container.addChild(this.feature3Image);
         this.container.addChild(this.feature1Text);
         this.container.addChild(this.feature2Text);
         this.container.addChild(this.feature3Text);
         this.feature1Image.x = this.feature1Text.x = int(this.bluePanel.x + this.bluePanel.WIDTH * 0.2);
         this.feature2Image.x = this.feature2Text.x = int(this.bluePanel.x + this.bluePanel.WIDTH * 0.5);
         this.feature3Image.x = this.feature3Text.x = int(this.bluePanel.x + this.bluePanel.WIDTH * 0.8);
         this.feature1Image.y = this.feature2Image.y = this.feature3Image.y = int(this.bluePanel.y + 56);
         this.feature1Text.y = this.feature2Text.y = this.feature3Text.y = int(this.feature1Image.y + 16);
         var max_height:int = (this.feature1Text.LINES_AMOUNT + 1) * 6;
         if(this.feature2Text.height > max_height)
         {
            max_height = (this.feature1Text.LINES_AMOUNT + 1) * 6;
         }
         if(this.feature3Text.height > max_height)
         {
            max_height = (this.feature1Text.LINES_AMOUNT + 1) * 6;
         }
         var button_height:int = int(this.bluePanel.HEIGHT - (this.feature1Text.y + max_height + 11));
         this.buyButton = new BuyButton(this.bluePanel.WIDTH - 22,button_height,false,false,true);
         this.buyButton.name = "buyButton";
         this.container.addChild(this.buyButton);
         this.buyButton.x = this.bluePanel.x + 11;
         this.buyButton.y = this.bluePanel.y + this.bluePanel.HEIGHT - this.buyButton.HEIGHT - 11;
      }
      
      protected function initBluePanel() : void
      {
         var temp_text:GameText = new GameText(StringsManager.GetString("panel_premium_vip_title"),GameText.TYPE_BIG);
         var total_width:int = temp_text.WIDTH + 80;
         var targeted_width:int = Utils.WIDTH * 0.67;
         if(targeted_width < total_width)
         {
            targeted_width = total_width;
         }
         this.bluePanel = new BluePanel(targeted_width,Utils.HEIGHT * 0.8,BluePanel.TYPE_C);
         this.bluePanel.x = int((Utils.WIDTH - this.bluePanel.WIDTH) * 0.5);
         this.bluePanel.y = int((Utils.HEIGHT - this.bluePanel.HEIGHT) * 0.5);
         this.container.addChild(this.bluePanel);
         this.bluePanel.drawLine(11,34,this.bluePanel.WIDTH - 22);
      }
      
      protected function initText() : void
      {
         this.titleText = new GameText(StringsManager.GetString("panel_premium_vip_title"),GameText.TYPE_BIG);
         this.titleText.x = this.bluePanel.x + int((this.bluePanel.WIDTH - this.titleText.WIDTH) * 0.5);
         this.titleText.y = this.bluePanel.y + 14;
         this.container.addChild(this.titleText);
         this.star_sx = new Image(TextureManager.hudTextureAtlas.getTexture("starRateHudSpriteAnim_b"));
         this.star_dx = new Image(TextureManager.hudTextureAtlas.getTexture("starRateHudSpriteAnim_b"));
         this.star_sx.pivotX = this.star_dx.pivotX = 4;
         this.star_sx.pivotY = this.star_dx.pivotY = 6;
         this.star_sx.x = this.titleText.x - 28;
         this.star_dx.x = this.titleText.x + this.titleText.WIDTH + 4;
         this.star_sx.y = this.star_dx.y = this.titleText.y - 3;
         this.star_sx.touchable = this.star_dx.touchable = false;
         this.container.addChild(this.star_sx);
         this.container.addChild(this.star_dx);
      }
      
      protected function setButtonsTouchable(value:Boolean) : void
      {
         this.backButton.touchable = value;
      }
      
      protected function unlockSuccessful() : void
      {
         Utils.SetPremium();
         SoundSystem.PlaySound("purchase");
         this.CONTINUE_FLAG = true;
         this.setButtonsTouchable(false);
         this.popOut();
      }
      
      internal function premium_purchases_updatedHandler(event:PurchaseEvent) : void
      {
         var purchase:Purchase = null;
         if(Utils.PURCHASE_ORIGIN != 1)
         {
            return;
         }
         for each(purchase in event.data)
         {
            switch(purchase.transactionState)
            {
               case Purchase.STATE_PURCHASING:
               case Purchase.STATE_DEFERRED:
                  break;
               case Purchase.STATE_PURCHASED:
                  if(purchase.productId == Utils.ANDROID_INAPP_PREMIUM_PRODUCT)
                  {
                     this.unlockSuccessful();
                     this.setButtonsTouchable(false);
                     InAppBilling.service.finishPurchase(purchase);
                  }
                  break;
               case Purchase.STATE_FAILED:
               case Purchase.STATE_REFUNDED:
               case Purchase.STATE_RESTORED:
               case Purchase.STATE_REMOVED:
               case Purchase.STATE_CANCELLED:
               case Purchase.STATE_NOTALLOWED:
                  SoundSystem.PlaySound("error");
                  this.setButtonsTouchable(true);
                  InAppBilling.service.finishPurchase(purchase);
                  break;
            }
         }
      }
      
      internal function premium_purchase_failedHandler(event:PurchaseEvent) : void
      {
         if(Boolean(event.data) && event.data.length > 0)
         {
            InAppBilling.service.finishPurchase(event.data[0]);
         }
         SoundSystem.PlaySound("error");
         this.setButtonsTouchable(true);
      }
   }
}

