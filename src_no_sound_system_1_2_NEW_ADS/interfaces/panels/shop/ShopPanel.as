package interfaces.panels.shop
{
   import com.distriqt.extension.inappbilling.InAppBilling;
   import com.distriqt.extension.inappbilling.Purchase;
   import com.distriqt.extension.inappbilling.PurchaseRequest;
   import com.distriqt.extension.inappbilling.events.InAppBillingEvent;
   import com.distriqt.extension.inappbilling.events.PurchaseEvent;
   import game_utils.*;
   import interfaces.buttons.*;
   import interfaces.panels.*;
   import interfaces.texts.*;
   import levels.Level;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class ShopPanel extends Sprite
   {
      
      protected var level:Level;
      
      public var QUIT_FLAG:Boolean;
      
      public var GET_OUT_FLAG:Boolean;
      
      public var IS_SMALL_HUD:Boolean;
      
      public var shopPanelEntering:Boolean;
      
      public var shopPanelExiting:Boolean;
      
      public var shopPanelStaying:Boolean;
      
      protected var refreshInventory:Boolean;
      
      protected var refreshHelpers:Boolean;
      
      public var backgroundQuad:Image;
      
      public var buttonSXContainer:Sprite;
      
      public var itemsButton:GameButton;
      
      public var apparelButton:GameButton;
      
      public var inventoryButton:GameButton;
      
      public var backButton:GameButton;
      
      public var itemsPanel:ShopItemsPanel;
      
      public var apparelPanel:ShopItemsPanel;
      
      public var inventoryPanel:ShopItemsPanel;
      
      public var coinsPanel:ShopItemsPanel;
      
      public var buyPanel:ShopBuyPanel;
      
      public var dialogPanel:DialogPanel;
      
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
      
      public var stateMachine:StateMachine;
      
      protected var ITEM_INDEX:int;
      
      protected var ITEM_PRICE:Number;
      
      protected var REPLY_INDEX:int;
      
      protected var TIER_ITEM_INDEX:int;
      
      protected var UPGRADE_FLAG:Boolean;
      
      protected var LAST_STATE:String = "";
      
      public function ShopPanel(_level:Level)
      {
         super();
         this.level = _level;
         this.QUIT_FLAG = false;
         this.GET_OUT_FLAG = false;
         this.IS_SMALL_HUD = false;
         this.ITEM_INDEX = this.ITEM_PRICE = this.TIER_ITEM_INDEX = 0;
         this.UPGRADE_FLAG = false;
         this.refreshInventory = this.refreshHelpers = false;
         this.shopPanelEntering = false;
         this.shopPanelExiting = false;
         this.shopPanelStaying = false;
         this.counter = 0;
         this.scaleX = this.scaleY = Utils.GFX_SCALE;
         this.evaluatePercentages();
         this.initBackground();
         this.initButtons();
         this.initPanels();
         this.itemsButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.apparelButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.inventoryButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.backButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_ITEM_LIST_STATE","APPAREL_BUTTON_ACTION","IS_APPAREL_LIST_STATE");
         this.stateMachine.setRule("IS_ITEM_LIST_STATE","INVENTORY_BUTTON_ACTION","IS_INVENTORY_LIST_STATE");
         this.stateMachine.setRule("IS_APPAREL_LIST_STATE","ITEM_BUTTON_ACTION","IS_ITEM_LIST_STATE");
         this.stateMachine.setRule("IS_APPAREL_LIST_STATE","INVENTORY_BUTTON_ACTION","IS_INVENTORY_LIST_STATE");
         this.stateMachine.setRule("IS_INVENTORY_LIST_STATE","ITEM_BUTTON_ACTION","IS_ITEM_LIST_STATE");
         this.stateMachine.setRule("IS_INVENTORY_LIST_STATE","APPAREL_BUTTON_ACTION","IS_APPAREL_LIST_STATE");
         this.stateMachine.setRule("IS_COIN_LIST_STATE","ITEM_BUTTON_ACTION","IS_ITEM_LIST_STATE");
         this.stateMachine.setRule("IS_COIN_LIST_STATE","APPAREL_BUTTON_ACTION","IS_APPAREL_LIST_STATE");
         this.stateMachine.setRule("IS_COIN_LIST_STATE","INVENTORY_BUTTON_ACTION","IS_INVENTORY_LIST_STATE");
         this.stateMachine.setRule("IS_ITEM_LIST_STATE","SHOW_ITEM_ACTION","IS_ITEM_STATE");
         this.stateMachine.setRule("IS_APPAREL_LIST_STATE","SHOW_ITEM_ACTION","IS_APPAREL_STATE");
         this.stateMachine.setRule("IS_INVENTORY_LIST_STATE","SHOW_ITEM_ACTION","IS_INVENTORY_STATE");
         this.stateMachine.setRule("IS_COIN_LIST_STATE","PURCHASE_TIER_ACTION","IS_TIER_PROCESSING_STATE");
         this.stateMachine.setRule("IS_TIER_PROCESSING_STATE","MESSAGE_ACTION","IS_MESSAGE_COIN_STATE");
         this.stateMachine.setRule("IS_APPAREL_STATE","PURCHASE_PREMIUM_ACTION","IS_PREMIUM_PROCESSING_STATE");
         this.stateMachine.setRule("IS_PREMIUM_PROCESSING_STATE","MESSAGE_ACTION","IS_MESSAGE_APPAREL_STATE");
         this.stateMachine.setRule("IS_ITEM_STATE","ITEM_BUTTON_ACTION","IS_ITEM_LIST_STATE");
         this.stateMachine.setRule("IS_ITEM_STATE","APPAREL_BUTTON_ACTION","IS_APPAREL_LIST_STATE");
         this.stateMachine.setRule("IS_ITEM_STATE","INVENTORY_BUTTON_ACTION","IS_INVENTORY_LIST_STATE");
         this.stateMachine.setRule("IS_APPAREL_STATE","ITEM_BUTTON_ACTION","IS_ITEM_LIST_STATE");
         this.stateMachine.setRule("IS_APPAREL_STATE","APPAREL_BUTTON_ACTION","IS_APPAREL_LIST_STATE");
         this.stateMachine.setRule("IS_APPAREL_STATE","INVENTORY_BUTTON_ACTION","IS_INVENTORY_LIST_STATE");
         this.stateMachine.setRule("IS_INVENTORY_STATE","ITEM_BUTTON_ACTION","IS_ITEM_LIST_STATE");
         this.stateMachine.setRule("IS_INVENTORY_STATE","APPAREL_BUTTON_ACTION","IS_APPAREL_LIST_STATE");
         this.stateMachine.setRule("IS_INVENTORY_STATE","INVENTORY_BUTTON_ACTION","IS_INVENTORY_LIST_STATE");
         this.stateMachine.setRule("IS_ITEM_STATE","END_ACTION","IS_ITEM_LIST_STATE");
         this.stateMachine.setRule("IS_APPAREL_STATE","END_ACTION","IS_APPAREL_LIST_STATE");
         this.stateMachine.setRule("IS_INVENTORY_STATE","END_ACTION","IS_INVENTORY_LIST_STATE");
         this.stateMachine.setRule("IS_COIN_LIST_STATE","END_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_ITEM_LIST_STATE","END_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_INVENTORY_LIST_STATE","END_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_APPAREL_LIST_STATE","END_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_ITEM_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_APPAREL_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_ITEM_LIST_STATE","MESSAGE_ACTION","IS_MESSAGE_ITEM_STATE");
         this.stateMachine.setRule("IS_ITEM_STATE","MESSAGE_ACTION","IS_MESSAGE_ITEM_STATE");
         this.stateMachine.setRule("IS_COIN_LIST_STATE","MESSAGE_ACTION","IS_MESSAGE_COIN_STATE");
         this.stateMachine.setRule("IS_COIN_STATE","MESSAGE_ACTION","IS_MESSAGE_COIN_STATE");
         this.stateMachine.setRule("IS_APPAREL_LIST_STATE","MESSAGE_ACTION","IS_MESSAGE_APPAREL_STATE");
         this.stateMachine.setRule("IS_APPAREL_STATE","MESSAGE_ACTION","IS_MESSAGE_APPAREL_STATE");
         this.stateMachine.setRule("IS_MESSAGE_ITEM_STATE","END_ACTION","IS_ITEM_LIST_STATE");
         this.stateMachine.setRule("IS_MESSAGE_ITEM_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_MESSAGE_ITEM_STATE","SHOW_COINS_ACTION","IS_COIN_LIST_STATE");
         this.stateMachine.setRule("IS_MESSAGE_COIN_STATE","END_ACTION","IS_COIN_LIST_STATE");
         this.stateMachine.setRule("IS_MESSAGE_COIN_STATE","SHOW_ITEMS_ACTION","IS_ITEM_LIST_STATE");
         this.stateMachine.setRule("IS_MESSAGE_APPAREL_STATE","END_ACTION","IS_APPAREL_LIST_STATE");
         this.stateMachine.setRule("IS_MESSAGE_APPAREL_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_MESSAGE_APPAREL_STATE","SHOW_COINS_ACTION","IS_COIN_LIST_STATE");
         this.stateMachine.setFunctionToState("IS_ITEM_LIST_STATE",this.itemListState);
         this.stateMachine.setFunctionToState("IS_COIN_LIST_STATE",this.coinListState);
         this.stateMachine.setFunctionToState("IS_INVENTORY_LIST_STATE",this.inventoryListState);
         this.stateMachine.setFunctionToState("IS_APPAREL_LIST_STATE",this.apparelListState);
         this.stateMachine.setFunctionToState("IS_ITEM_STATE",this.itemState);
         this.stateMachine.setFunctionToState("IS_APPAREL_STATE",this.apparelState);
         this.stateMachine.setFunctionToState("IS_INVENTORY_STATE",this.inventoryState);
         this.stateMachine.setFunctionToState("IS_QUIT_STATE",this.quitState);
         this.stateMachine.setFunctionToState("IS_MESSAGE_ITEM_STATE",this.messageItemState);
         this.stateMachine.setFunctionToState("IS_MESSAGE_COIN_STATE",this.messageCoinState);
         this.stateMachine.setFunctionToState("IS_MESSAGE_APPAREL_STATE",this.messageApparelState);
         this.stateMachine.setFunctionToState("IS_TIER_PROCESSING_STATE",this.tierProcessingState);
         this.stateMachine.setFunctionToState("IS_PREMIUM_PROCESSING_STATE",this.premiumProcessingState);
         this.stateMachine.setState("IS_COIN_LIST_STATE");
         if(InAppBilling.isSupported)
         {
            InAppBilling.service.addEventListener(PurchaseEvent.PURCHASES_UPDATED,this.purchases_updatedHandler);
            InAppBilling.service.addEventListener(PurchaseEvent.PURCHASE_FAILED,this.purchase_failedHandler);
            InAppBilling.service.addEventListener(InAppBillingEvent.FINISH_SUCCESS,this.finish_successHandler);
         }
      }
      
      public function showCoins() : void
      {
         this.stateMachine.setState("IS_COIN_LIST_STATE");
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.level = null;
         if(InAppBilling.isSupported)
         {
            InAppBilling.service.removeEventListener(PurchaseEvent.PURCHASES_UPDATED,this.purchases_updatedHandler);
            InAppBilling.service.removeEventListener(PurchaseEvent.PURCHASE_FAILED,this.purchase_failedHandler);
            InAppBilling.service.removeEventListener(InAppBillingEvent.FINISH_SUCCESS,this.finish_successHandler);
         }
         this.stateMachine.destroy();
         this.backButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.itemsButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.apparelButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.inventoryButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         removeChild(this.dialogPanel);
         this.dialogPanel.destroy();
         this.dialogPanel.dispose();
         this.dialogPanel = null;
         removeChild(this.buyPanel);
         this.buyPanel.destroy();
         this.buyPanel.dispose();
         this.buyPanel = null;
         removeChild(this.itemsPanel);
         this.itemsPanel.destroy();
         this.itemsPanel.dispose();
         this.itemsPanel = null;
         removeChild(this.apparelPanel);
         this.apparelPanel.destroy();
         this.apparelPanel.dispose();
         this.apparelPanel = null;
         removeChild(this.inventoryPanel);
         this.inventoryPanel.destroy();
         this.inventoryPanel.dispose();
         this.inventoryPanel = null;
         removeChild(this.coinsPanel);
         this.coinsPanel.destroy();
         this.coinsPanel.dispose();
         this.coinsPanel = null;
         this.buttonSXContainer.removeChild(this.backButton);
         this.backButton.destroy();
         this.backButton.dispose();
         this.backButton = null;
         this.buttonSXContainer.removeChild(this.itemsButton);
         this.itemsButton.destroy();
         this.itemsButton.dispose();
         this.itemsButton = null;
         this.buttonSXContainer.removeChild(this.apparelButton);
         this.apparelButton.destroy();
         this.apparelButton.dispose();
         this.apparelButton = null;
         removeChild(this.buttonSXContainer);
         this.buttonSXContainer.dispose();
         this.buttonSXContainer = null;
         removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
      }
      
      public function update() : void
      {
         if(this.stateMachine.currentState != this.LAST_STATE)
         {
            this.LAST_STATE = this.stateMachine.currentState;
         }
         if(this.itemsButton != null)
         {
            this.itemsButton.update();
         }
         if(this.apparelButton != null)
         {
            this.apparelButton.update();
         }
         if(this.inventoryButton != null)
         {
            this.inventoryButton.update();
         }
         if(this.backButton != null)
         {
            this.backButton.update();
         }
         if(this.itemsPanel != null)
         {
            this.itemsPanel.update();
         }
         if(this.coinsPanel != null)
         {
            this.coinsPanel.update();
         }
         if(this.apparelPanel != null)
         {
            this.apparelPanel.update();
         }
         if(this.inventoryPanel != null)
         {
            this.inventoryPanel.update();
         }
         if(this.buyPanel.visible)
         {
            this.buyPanel.update();
         }
         if(this.stateMachine.currentState == "IS_MESSAGE_ITEM_STATE" || this.stateMachine.currentState == "IS_MESSAGE_COIN_STATE" || this.stateMachine.currentState == "IS_MESSAGE_APPAREL_STATE")
         {
            if(this.dialogPanel.DONE)
            {
               if((this.stateMachine.currentState == "IS_MESSAGE_ITEM_STATE" || this.stateMachine.currentState == "IS_MESSAGE_APPAREL_STATE") && this.REPLY_INDEX == 0 && Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
               {
                  this.stateMachine.performAction("SHOW_COINS_ACTION");
               }
               else if(this.stateMachine.currentState == "IS_MESSAGE_COIN_STATE" && this.REPLY_INDEX == 1)
               {
                  this.stateMachine.performAction("SHOW_ITEMS_ACTION");
               }
               else if((this.stateMachine.currentState == "IS_MESSAGE_ITEM_STATE" || this.stateMachine.currentState == "IS_MESSAGE_APPAREL_STATE") && (this.REPLY_INDEX == 3 || this.REPLY_INDEX == 1))
               {
                  this.stateMachine.performAction("QUIT_ACTION");
                  this.dialogPanel.visible = false;
               }
               else
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      protected function clickHandler(event:Event) : void
      {
         var button:Button = null;
         if(this.shopPanelStaying)
         {
            button = Button(event.target);
            if(button.name == "backButton")
            {
               SoundSystem.PlaySound("select");
               this.stateMachine.performAction("END_ACTION");
            }
            else if(button.name == "itemsButton")
            {
               SoundSystem.PlaySound("select");
               this.stateMachine.performAction("ITEM_BUTTON_ACTION");
            }
            else if(button.name == "apparelButton")
            {
               SoundSystem.PlaySound("select");
               this.stateMachine.performAction("APPAREL_BUTTON_ACTION");
            }
            else if(button.name == "inventoryButton")
            {
               SoundSystem.PlaySound("select");
               this.stateMachine.performAction("INVENTORY_BUTTON_ACTION");
            }
         }
      }
      
      public function backButtonAndroid() : void
      {
         SoundSystem.PlaySound("select");
         this.stateMachine.performAction("END_ACTION");
      }
      
      public function showItem(index:int, price:Number) : void
      {
         if(index < 0)
         {
            if(index == -1)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] = 0;
            }
            else
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] = 0;
            }
            SaveManager.SaveGameVariables();
            this.stateMachine.performAction("END_ACTION");
         }
         else
         {
            this.ITEM_INDEX = index;
            this.ITEM_PRICE = price;
            this.stateMachine.performAction("SHOW_ITEM_ACTION");
         }
      }
      
      public function popUp() : void
      {
         var i:int = 0;
         var tween:Tween = null;
         var targetY:int = 0;
         this.refreshInventory = true;
         this.refreshHelpers = true;
         Utils.NoMusicBeingPlayed = false;
         if(Utils.ShopIndex == -1)
         {
            if(Utils.LAST_SHOP_MENU == 0)
            {
               this.stateMachine.setState("IS_ITEM_LIST_STATE");
            }
            else if(Utils.LAST_SHOP_MENU == 1)
            {
               this.stateMachine.setState("IS_APPAREL_LIST_STATE");
            }
            else if(Utils.LAST_SHOP_MENU == 2)
            {
               this.stateMachine.setState("IS_INVENTORY_LIST_STATE");
            }
            else if(Utils.LAST_SHOP_MENU == 3)
            {
               this.stateMachine.setState("IS_COIN_LIST_STATE");
            }
         }
         else
         {
            this.ITEM_INDEX = Utils.ShopIndex;
            this.ITEM_PRICE = this.itemsPanel.getPrice(Utils.ShopIndex);
            this.stateMachine.setState("IS_ITEM_STATE");
            Utils.ShopIndex = -1;
         }
         this.QUIT_FLAG = false;
         this.GET_OUT_FLAG = false;
         this.shopPanelEntering = true;
         this.shopPanelExiting = false;
         this.shopPanelStaying = false;
         this.counter = 0;
         Utils.rootMovie.addChild(this);
         this.visible = true;
         this.backgroundQuad.alpha = 0;
         this.setButtonsTouchable(false);
         tween = new Tween(this.backgroundQuad,0.25,Transitions.EASE_OUT);
         tween.fadeTo(0.8);
         Starling.juggler.add(tween);
         if(this.coinsPanel != null)
         {
            tween = new Tween(this.coinsPanel,0.25,Transitions.EASE_OUT);
            tween.fadeTo(1);
            Starling.juggler.add(tween);
            this.itemsPanel.resetMenus();
         }
         tween = new Tween(this.buttonSXContainer,0.25,Transitions.EASE_OUT);
         tween.moveTo(this.outer_x_margin,0);
         tween.roundToInt = true;
         tween.delay = 0;
         tween.onComplete = this.popUpComplete;
         Starling.juggler.add(tween);
         AnalyticsManager.TrackScreenView("screen_shop");
         this.itemsPanel.xPos = 8;
      }
      
      protected function popOut() : void
      {
         var tween:Tween = null;
         this.shopPanelEntering = false;
         this.shopPanelExiting = true;
         this.shopPanelStaying = false;
         this.counter = 0;
         this.level.refreshCatSprite();
         tween = new Tween(this.backgroundQuad,0.15);
         tween.fadeTo(0);
         Starling.juggler.add(tween);
         if(this.itemsPanel.visible)
         {
            tween = new Tween(this.itemsPanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         else if(this.coinsPanel.visible)
         {
            tween = new Tween(this.coinsPanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         else if(this.buyPanel.visible)
         {
            tween = new Tween(this.buyPanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         else if(this.inventoryPanel.visible)
         {
            tween = new Tween(this.inventoryPanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         else if(this.apparelPanel.visible)
         {
            tween = new Tween(this.apparelPanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         tween = new Tween(this.buttonSXContainer,0.15);
         tween.moveTo(-(this.column_width + this.outer_x_margin),0);
         tween.delay = 0;
         tween.roundToInt = true;
         tween.onComplete = this.popOutComplete;
         Starling.juggler.add(tween);
      }
      
      protected function popUpComplete() : void
      {
         this.shopPanelEntering = false;
         this.shopPanelStaying = true;
         this.setButtonsTouchable(true);
      }
      
      protected function popOutComplete() : void
      {
         this.shopPanelExiting = false;
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
         this.body_percentage = 0.75;
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
         this.outer_x_margin = this.outer_y_margin = int((WIDTH - (this.body_width + this.column_width * 1 + this.inner_margin * 1)) * 0.5);
         this.outer_x_margin += int(Utils.X_SCREEN_MARGIN * 0.5);
         this.body_height = int(HEIGHT - this.outer_y_margin * 2);
         this.button_height = int((this.body_height - this.inner_margin * 3) / 4);
         if(this.button_height < 34)
         {
            this.inner_margin_percentage = 0.1;
            this.body_percentage = 0.8;
            this.body_width = int(WIDTH * this.body_percentage);
            this.column_width = int(WIDTH * this.column_percentage);
            this.inner_margin = int(this.column_width * this.inner_margin_percentage);
            this.outer_x_margin = this.outer_y_margin = int((WIDTH - (this.body_width + this.column_width * 1 + this.inner_margin * 1)) * 0.5);
            this.outer_x_margin += int(Utils.X_SCREEN_MARGIN * 0.5);
            this.body_height = int(HEIGHT - this.outer_y_margin * 2);
            this.button_height = int((this.body_height - this.inner_margin * 3) / 4);
            if(this.button_height < 32)
            {
               this.IS_SMALL_HUD = true;
            }
         }
      }
      
      protected function initBackground() : void
      {
         this.backgroundQuad = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         this.backgroundQuad.width = Utils.WIDTH;
         this.backgroundQuad.height = Utils.HEIGHT;
         this.backgroundQuad.x = 0;
         this.backgroundQuad.y = 0;
         addChild(this.backgroundQuad);
      }
      
      protected function initButtons() : void
      {
         this.buttonSXContainer = new Sprite();
         this.buttonSXContainer.x = -(this.column_width + this.outer_x_margin);
         this.buttonSXContainer.y = 0;
         addChild(this.buttonSXContainer);
         var icon_text:String = "";
         if(this.IS_SMALL_HUD)
         {
            icon_text = "small_";
         }
         this.itemsButton = new GameButton("helper_" + icon_text + "icon",this.column_width,this.button_height);
         this.itemsButton.name = "itemsButton";
         this.itemsButton.x = 0;
         this.itemsButton.y = this.outer_y_margin;
         this.apparelButton = new GameButton("apparel_" + icon_text + "icon",this.column_width,this.button_height);
         this.apparelButton.name = "apparelButton";
         this.apparelButton.x = 0;
         this.apparelButton.y = this.outer_y_margin + this.inner_margin + this.button_height;
         this.inventoryButton = new GameButton("inventory_" + icon_text + "icon",this.column_width,this.button_height);
         this.inventoryButton.name = "inventoryButton";
         this.inventoryButton.x = 0;
         this.inventoryButton.y = this.outer_y_margin + this.inner_margin * 2 + this.button_height * 2;
         this.backButton = new GameButton("back_" + icon_text + "button_icon",this.column_width,this.button_height);
         this.backButton.name = "backButton";
         this.backButton.x = 0;
         this.backButton.y = this.outer_y_margin + this.inner_margin * 3 + this.button_height * 3;
         this.buttonSXContainer.addChild(this.itemsButton);
         this.buttonSXContainer.addChild(this.apparelButton);
         this.buttonSXContainer.addChild(this.inventoryButton);
         this.buttonSXContainer.addChild(this.backButton);
      }
      
      protected function initPanels() : void
      {
         this.itemsPanel = new ShopItemsPanel(this,this.body_width,this.body_height,0);
         this.itemsPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.itemsPanel.y = this.outer_y_margin;
         this.itemsPanel.setArea();
         addChild(this.itemsPanel);
         this.apparelPanel = new ShopItemsPanel(this,this.body_width,this.body_height,3);
         this.apparelPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.apparelPanel.y = this.outer_y_margin;
         this.apparelPanel.setArea();
         addChild(this.apparelPanel);
         this.inventoryPanel = new ShopItemsPanel(this,this.body_width,this.body_height,2);
         this.inventoryPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.inventoryPanel.y = this.outer_y_margin;
         this.inventoryPanel.setArea();
         addChild(this.inventoryPanel);
         this.coinsPanel = new ShopItemsPanel(this,this.body_width,this.body_height,1);
         this.coinsPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.coinsPanel.y = this.outer_y_margin;
         this.coinsPanel.setArea();
         addChild(this.coinsPanel);
         this.buyPanel = new ShopBuyPanel(this,this.body_width,this.body_height);
         this.buyPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.buyPanel.y = this.outer_y_margin;
         addChild(this.buyPanel);
         this.dialogPanel = new DialogPanel();
         addChild(this.dialogPanel);
      }
      
      public function setButtonsTouchable(value:Boolean) : void
      {
         this.backButton.touchable = value;
         this.itemsButton.touchable = value;
         this.apparelButton.touchable = value;
         this.inventoryButton.touchable = value;
         this.itemsPanel.setButtonsTouchable(value);
         this.coinsPanel.setButtonsTouchable(value);
         this.inventoryPanel.setButtonsTouchable(value);
         this.apparelPanel.setButtonsTouchable(value);
      }
      
      protected function itemListState() : void
      {
         Utils.LAST_SHOP_MENU = 0;
         if(this.refreshHelpers)
         {
            this.refreshHelpers = false;
            removeChild(this.itemsPanel);
            this.itemsPanel.destroy();
            this.itemsPanel.dispose();
            this.itemsPanel = null;
            this.itemsPanel = new ShopItemsPanel(this,this.body_width,this.body_height,0);
            this.itemsPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
            this.itemsPanel.y = this.outer_y_margin;
            this.itemsPanel.setArea();
            addChild(this.itemsPanel);
         }
         this.itemsPanel.visible = true;
         this.itemsPanel.alpha = 1;
         this.itemsPanel.updateListAndCoins(0);
         this.coinsPanel.updateListAndCoins(0);
         this.inventoryPanel.updateListAndCoins(0);
         this.apparelPanel.updateListAndCoins(0);
         this.coinsPanel.visible = false;
         this.inventoryPanel.visible = false;
         this.apparelPanel.visible = false;
         this.buyPanel.visible = false;
         this.dialogPanel.visible = false;
         this.coinsPanel.alpha = this.inventoryPanel.alpha = this.apparelPanel.alpha = this.buyPanel.alpha = this.dialogPanel.alpha = 1;
      }
      
      protected function coinListState() : void
      {
         this.coinsPanel.visible = true;
         this.coinsPanel.updateListAndCoins(0);
         if(this.stateMachine.lastState == "IS_ITEM_LIST_STATE")
         {
            this.coinsPanel.xPos = 8;
         }
         this.itemsPanel.visible = false;
         this.buyPanel.visible = false;
         this.dialogPanel.visible = false;
         this.inventoryPanel.visible = false;
         this.apparelPanel.visible = false;
         this.coinsPanel.alpha = this.inventoryPanel.alpha = this.apparelPanel.alpha = this.buyPanel.alpha = this.dialogPanel.alpha = 1;
      }
      
      protected function inventoryListState() : void
      {
         Utils.LAST_SHOP_MENU = 2;
         if(this.refreshInventory)
         {
            this.refreshInventory = false;
            removeChild(this.inventoryPanel);
            this.inventoryPanel.destroy();
            this.inventoryPanel.dispose();
            this.inventoryPanel = null;
            this.inventoryPanel = new ShopItemsPanel(this,this.body_width,this.body_height,2);
            this.inventoryPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
            this.inventoryPanel.y = this.outer_y_margin;
            this.inventoryPanel.setArea();
            addChild(this.inventoryPanel);
         }
         this.inventoryPanel.visible = true;
         this.inventoryPanel.updateListAndCoins(0);
         this.itemsPanel.visible = false;
         this.buyPanel.visible = false;
         this.dialogPanel.visible = false;
         this.apparelPanel.visible = false;
         this.coinsPanel.visible = false;
         this.coinsPanel.alpha = this.inventoryPanel.alpha = this.apparelPanel.alpha = this.buyPanel.alpha = this.dialogPanel.alpha = 1;
      }
      
      protected function apparelListState() : void
      {
         Utils.LAST_SHOP_MENU = 1;
         this.apparelPanel.visible = true;
         this.apparelPanel.updateListAndCoins(0);
         this.itemsPanel.visible = false;
         this.buyPanel.visible = false;
         this.dialogPanel.visible = false;
         this.inventoryPanel.visible = false;
         this.coinsPanel.visible = false;
         this.coinsPanel.alpha = this.inventoryPanel.alpha = this.apparelPanel.alpha = this.buyPanel.alpha = this.dialogPanel.alpha = 1;
      }
      
      public function upgradeButtonPressed(_itemIndex:int) : void
      {
         this.UPGRADE_FLAG = true;
         this.itemState();
      }
      
      public function buyButtonPressed(_reply_index:int) : void
      {
         if(this.stateMachine.currentState != "IS_MESSAGE_ITEM_STATE" && this.stateMachine.currentState != "IS_MESSAGE_COIN_STATE" && this.stateMachine.currentState != "IS_MESSAGE_APPAREL_STATE")
         {
            this.REPLY_INDEX = _reply_index;
            if(this.REPLY_INDEX == 3)
            {
               SoundSystem.PlaySound("select");
               this.stateMachine.performAction("QUIT_ACTION");
            }
            else
            {
               this.stateMachine.performAction("MESSAGE_ACTION");
            }
         }
      }
      
      protected function itemState() : void
      {
         this.coinsPanel.visible = this.itemsPanel.visible = this.apparelPanel.visible = this.inventoryPanel.visible = this.dialogPanel.visible = false;
         this.buyPanel.visible = true;
         this.buyPanel.alpha = 1;
         this.buyPanel.showItem(this.ITEM_INDEX,this.ITEM_PRICE,this.UPGRADE_FLAG);
         this.UPGRADE_FLAG = false;
      }
      
      protected function apparelState() : void
      {
         this.coinsPanel.visible = this.itemsPanel.visible = this.apparelPanel.visible = this.inventoryPanel.visible = this.dialogPanel.visible = false;
         this.buyPanel.visible = true;
         this.buyPanel.alpha = 1;
         this.buyPanel.showItem(this.ITEM_INDEX,this.ITEM_PRICE);
      }
      
      protected function inventoryState() : void
      {
         this.coinsPanel.visible = this.itemsPanel.visible = this.apparelPanel.visible = this.inventoryPanel.visible = this.dialogPanel.visible = false;
         this.buyPanel.visible = true;
         this.buyPanel.alpha = 1;
         this.buyPanel.showItem(this.ITEM_INDEX,this.ITEM_PRICE);
      }
      
      protected function quitState() : void
      {
         this.QUIT_FLAG = true;
         this.popOut();
         this.setButtonsTouchable(false);
      }
      
      protected function messageItemState() : void
      {
         if(this.REPLY_INDEX == 0)
         {
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_bad_1"));
         }
         else if(this.REPLY_INDEX == 2)
         {
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_bad_2"));
         }
         else if(this.REPLY_INDEX == 3)
         {
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_equip"));
         }
         else
         {
            this.itemsPanel.updateListAndCoins(this.ITEM_INDEX);
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_ok"));
         }
         this.dialogPanel.visible = true;
      }
      
      protected function messageCoinState() : void
      {
         if(this.REPLY_INDEX == 0)
         {
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_bad_1"));
         }
         else if(this.REPLY_INDEX == 2)
         {
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_bad_2"));
         }
         else
         {
            this.coinsPanel.updateListAndCoins(this.ITEM_INDEX);
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_ok"));
         }
         this.dialogPanel.visible = true;
      }
      
      protected function messageApparelState() : void
      {
         if(this.REPLY_INDEX == 0)
         {
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_bad_1"));
         }
         else if(this.REPLY_INDEX == 2)
         {
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_bad_2"));
         }
         else
         {
            this.apparelPanel.updateListAndCoins(this.ITEM_INDEX);
            this.dialogPanel.setText(StringsManager.GetString("panel_purchase_ok"));
         }
         this.dialogPanel.visible = true;
      }
      
      protected function premiumProcessingState() : void
      {
         var request:PurchaseRequest = null;
         if(!Utils.IS_ON_WINDOWS)
         {
            if(InAppBilling.isSupported)
            {
               Utils.PURCHASE_ORIGIN = 2;
               this.setButtonsTouchable(false);
               request = new PurchaseRequest();
               request.quantity = 1;
               request.productId = Utils.ANDROID_INAPP_PREMIUM_PRODUCT;
               InAppBilling.service.makePurchase(request);
            }
            else
            {
               this.purchaseError();
            }
         }
      }
      
      protected function tierProcessingState() : void
      {
         var request:PurchaseRequest = null;
         if(Utils.IS_ON_WINDOWS)
         {
            if(this.TIER_ITEM_INDEX == 297)
            {
               this.purchaseSuccessful("com.neutronized.supercattalespaws.inapp_tier1");
            }
            else if(this.TIER_ITEM_INDEX == 298)
            {
               this.purchaseSuccessful("com.neutronized.supercattalespaws.inapp_tier2");
            }
            else
            {
               this.purchaseSuccessful("com.neutronized.supercattalespaws.inapp_tier3");
            }
         }
         else if(InAppBilling.isSupported)
         {
            Utils.PURCHASE_ORIGIN = 2;
            this.setButtonsTouchable(false);
            request = new PurchaseRequest();
            request.quantity = 1;
            if(this.TIER_ITEM_INDEX == 297)
            {
               request.productId = Utils.ANDROID_INAPP_TIER1_PRODUCT;
            }
            else if(this.TIER_ITEM_INDEX == 298)
            {
               request.productId = Utils.ANDROID_INAPP_TIER2_PRODUCT;
            }
            else
            {
               request.productId = Utils.ANDROID_INAPP_TIER3_PRODUCT;
            }
            InAppBilling.service.makePurchase(request);
         }
         else
         {
            this.purchaseError();
         }
      }
      
      private function purchaseSuccessful(_name:String) : void
      {
         var purchase:Boolean = false;
         SoundSystem.PlaySound("purchase");
         if(_name == "com.neutronized.supercattalespaws.inapp_tier2" || _name == Utils.ANDROID_INAPP_TIER2_PRODUCT)
         {
            purchase = true;
            Utils.Slot.playerInventory[LevelItems.ITEM_COIN] += 2000;
         }
         else if(_name == "com.neutronized.supercattalespaws.inapp_tier3" || _name == Utils.ANDROID_INAPP_TIER3_PRODUCT)
         {
            purchase = true;
            Utils.Slot.playerInventory[LevelItems.ITEM_COIN] += 5000;
         }
         else if(_name == "com.neutronized.supercattalespaws.inapp_tier1" || _name == Utils.ANDROID_INAPP_TIER1_PRODUCT)
         {
            purchase = true;
            Utils.Slot.playerInventory[LevelItems.ITEM_COIN] += 500;
         }
         else if(_name == "com.neutronized.supercattalespaws.premium" || _name == Utils.ANDROID_INAPP_PREMIUM_PRODUCT)
         {
            Utils.SetPremium();
            this.buyPanel.equipPremiumHat();
            this.setButtonsTouchable(true);
            this.buyButtonPressed(1);
         }
         if(purchase)
         {
            SettingsPanel.iCloudSaveCoins();
            this.setButtonsTouchable(true);
            SaveManager.SaveInventory();
            this.buyButtonPressed(1);
         }
      }
      
      private function purchaseError() : void
      {
         SoundSystem.PlaySound("error");
         this.setButtonsTouchable(true);
         this.buyButtonPressed(2);
      }
      
      public function purchasePremium() : void
      {
         if(this.stateMachine.currentState != "IS_PREMIUM_PROCESSING_STATE")
         {
            this.stateMachine.performAction("PURCHASE_PREMIUM_ACTION");
         }
      }
      
      public function purchaseTier(_index:int) : void
      {
         if(this.stateMachine.currentState != "IS_TIER_PROCESSING_STATE")
         {
            this.TIER_ITEM_INDEX = _index;
            this.stateMachine.performAction("PURCHASE_TIER_ACTION");
         }
      }
      
      internal function finish_successHandler(event:InAppBillingEvent) : *
      {
         var productIdList:Array = new Array();
         productIdList.push("com.neutronized.supercattalespaws.premium");
         productIdList.push("com.neutronized.supercattalespaws.gate_ticket");
         productIdList.push("com.neutronized.supercattalespaws.inapp_tier1");
         productIdList.push("com.neutronized.supercattalespaws.inapp_tier2");
         productIdList.push("com.neutronized.supercattalespaws.inapp_tier3");
         InAppBilling.service.getProducts(productIdList);
      }
      
      internal function purchase_failedHandler(event:PurchaseEvent) : void
      {
         trace("purchase failed " + event.errorCode);
         trace(event.message);
         if(Boolean(event.data) && event.data.length > 0)
         {
            InAppBilling.service.finishPurchase(event.data[0]);
         }
         this.purchaseError();
      }
      
      internal function purchases_updatedHandler(event:PurchaseEvent) : void
      {
         var purchase:Purchase = null;
         if(Utils.PURCHASE_ORIGIN != 2)
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
                  this.purchaseSuccessful(purchase.productId);
                  InAppBilling.service.finishPurchase(purchase);
                  if(Utils.IS_ANDROID)
                  {
                     if(purchase.productId == Utils.ANDROID_INAPP_TIER1_PRODUCT || purchase.productId == Utils.ANDROID_INAPP_TIER2_PRODUCT || purchase.productId == Utils.ANDROID_INAPP_TIER3_PRODUCT)
                     {
                        InAppBilling.service.consumePurchase(purchase);
                     }
                  }
                  break;
               case Purchase.STATE_RESTORED:
                  if(purchase.productId == Utils.ANDROID_INAPP_TIER1_PRODUCT || purchase.productId == Utils.ANDROID_INAPP_TIER2_PRODUCT || purchase.productId == Utils.ANDROID_INAPP_TIER3_PRODUCT)
                  {
                     InAppBilling.service.consumePurchase(purchase);
                  }
                  break;
               case Purchase.STATE_FAILED:
               case Purchase.STATE_REFUNDED:
               case Purchase.STATE_REMOVED:
               case Purchase.STATE_CANCELLED:
               case Purchase.STATE_NOTALLOWED:
                  InAppBilling.service.finishPurchase(purchase);
                  this.purchaseError();
                  break;
            }
         }
      }
   }
}

