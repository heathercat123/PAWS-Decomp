package interfaces.panels
{
   import com.distriqt.extension.inappbilling.InAppBilling;
   import com.distriqt.extension.inappbilling.Purchase;
   import com.distriqt.extension.inappbilling.PurchaseRequest;
   import com.distriqt.extension.inappbilling.events.PurchaseEvent;
   import interfaces.buttons.BalloonButton;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Button;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class UnlockGatePanel extends Sprite
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
      
      public var catImage:Image;
      
      public var continueButton:BalloonButton;
      
      public var backButton:Button;
      
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
      
      public function UnlockGatePanel(type:int = 0)
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
         this.initButtons();
         this.initBluePanel();
         this.continueButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.backButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         if(InAppBilling.isSupported)
         {
            InAppBilling.service.addEventListener(PurchaseEvent.PURCHASES_UPDATED,this.gate_purchases_updatedHandler);
            InAppBilling.service.addEventListener(PurchaseEvent.PURCHASE_FAILED,this.gate_purchase_failedHandler);
         }
      }
      
      public function backButtonAndroid() : void
      {
         this.quitPanel();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         if(InAppBilling.isSupported)
         {
            InAppBilling.service.removeEventListener(PurchaseEvent.PURCHASES_UPDATED,this.gate_purchases_updatedHandler);
            InAppBilling.service.removeEventListener(PurchaseEvent.PURCHASE_FAILED,this.gate_purchase_failedHandler);
         }
         if(this.visible)
         {
            Utils.rootMovie.removeChild(this);
         }
         this.backButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.continueButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.container.removeChild(this.backButton);
         this.backButton.dispose();
         this.backButton = null;
         this.container.removeChild(this.continueButton);
         this.continueButton.destroy();
         this.continueButton.dispose();
         this.continueButton = null;
         this.container.removeChild(this.catImage);
         this.catImage.dispose();
         this.catImage = null;
         removeChild(this.container);
         this.container.dispose();
         this.container = null;
         this.backButton = null;
         removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
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
      }
      
      protected function clickHandler(event:Event) : void
      {
         if(this.pausePanelStaying)
         {
            if(DisplayObject(event.target).name == "continueButton")
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
            this.unlockSuccessful();
            this.setButtonsTouchable(false);
         }
         else
         {
            this.setButtonsTouchable(false);
            if(InAppBilling.isSupported)
            {
               request = new PurchaseRequest();
               request.quantity = 1;
               request.productId = Utils.ANDROID_INAPP_GATE_PRODUCT;
               InAppBilling.service.makePurchase(request);
            }
            else
            {
               this.quitPanel();
            }
         }
      }
      
      protected function unlockSuccessful() : void
      {
         SoundSystem.PlaySound("purchase");
         this.CONTINUE_FLAG = true;
         this.popOut();
      }
      
      public function quitPanel() : void
      {
         if(this.GET_OUT_FLAG)
         {
            return;
         }
         SoundSystem.PlaySound("selectBack");
         this.CONTINUE_FLAG = false;
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
         this.continueButton.touchable = false;
         this.backButton.touchable = false;
         tween = new Tween(this.backgroundQuad,0.25,Transitions.EASE_OUT);
         tween.fadeTo(0.8);
         Starling.juggler.add(tween);
         tween = new Tween(this.container,0.25,Transitions.EASE_OUT_BACK);
         tween.moveTo(0,int(Utils.HEIGHT * 0.4));
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
         this.continueButton.touchable = true;
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
      }
      
      protected function initButtons() : void
      {
         this.container = new Sprite();
         this.container.x = 0;
         this.container.y = Utils.HEIGHT;
         addChild(this.container);
         this.catImage = new Image(TextureManager.introTextureAtlas.getTexture("intro_cat_0"));
         this.catImage.touchable = false;
         this.catImage.scaleX = -1;
         this.catImage.pivotX = this.catImage.width;
         this.container.addChild(this.catImage);
         this.catImage.x = int(Utils.WIDTH * 0.15);
         this.catImage.y = -24;
         if(Utils.IS_IPAD)
         {
            this.catImage.x = int(Utils.WIDTH * 0.05);
         }
         this.continueButton = new BalloonButton(BalloonButton.TYPE_GATE);
         this.continueButton.name = "continueButton";
         this.continueButton.x = this.catImage.x + 108;
         this.continueButton.y = 0;
         this.container.addChild(this.continueButton);
         if(Utils.IS_IPAD)
         {
            this.continueButton.x = this.catImage.x + 96;
         }
         var total_width:int = int(this.continueButton.x - this.catImage.x + 188);
         var x_target:int = int((Utils.WIDTH - total_width) * 0.5);
         var x_diff:int = int(x_target - this.catImage.x);
         this.catImage.x += x_diff;
         this.continueButton.x += x_diff;
         this.catImage.x -= 8;
         this.continueButton.x -= 8;
         this.backButton = new Button(TextureManager.hudTextureAtlas.getTexture("hud_close_button_1"),"",TextureManager.hudTextureAtlas.getTexture("hud_close_button_2"));
         this.backButton.name = "quitButton";
         this.backButton.pivotX = int(this.backButton.width * 0.6);
         this.backButton.pivotY = int(this.backButton.height * 0.4);
         this.backButton.x = this.continueButton.x + 188;
         this.backButton.y = this.continueButton.y;
         this.container.addChild(this.backButton);
      }
      
      protected function initBluePanel() : void
      {
      }
      
      protected function setButtonsTouchable(value:Boolean) : void
      {
         this.continueButton.touchable = value;
         this.backButton.touchable = value;
      }
      
      internal function gate_purchases_updatedHandler(event:PurchaseEvent) : void
      {
         var purchase:Purchase = null;
         for each(purchase in event.data)
         {
            switch(purchase.transactionState)
            {
               case Purchase.STATE_PURCHASING:
               case Purchase.STATE_DEFERRED:
                  break;
               case Purchase.STATE_PURCHASED:
                  if(purchase.productId == Utils.ANDROID_INAPP_GATE_PRODUCT)
                  {
                     this.unlockSuccessful();
                     this.setButtonsTouchable(false);
                     InAppBilling.service.finishPurchase(purchase);
                     InAppBilling.service.consumePurchase(purchase);
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
      
      internal function gate_purchase_failedHandler(event:PurchaseEvent) : void
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

