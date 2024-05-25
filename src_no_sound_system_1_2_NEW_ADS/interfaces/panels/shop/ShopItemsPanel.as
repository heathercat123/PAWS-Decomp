package interfaces.panels.shop
{
   import flash.geom.*;
   import game_utils.*;
   import interfaces.buttons.*;
   import interfaces.panels.*;
   import interfaces.texts.*;
   import sprites.*;
   import sprites.hud.*;
   import starling.display.Button;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.*;
   
   public class ShopItemsPanel extends Sprite
   {
       
      
      protected var bluePanel:BluePanel;
      
      public var INDEX:int;
      
      protected var titlePanel:GameText;
      
      protected var coinsPanel:CoinsPanel;
      
      protected var itemsContainer:Sprite;
      
      protected var itemButtons:Array;
      
      protected var ITEMS_WIDTH:Number;
      
      protected var BUTTON_WIDTH:Number;
      
      protected var mid_x:int;
      
      protected var bottom_mid_y:int;
      
      protected var top_mid_y:int;
      
      protected var WIDTH:int;
      
      protected var HEIGHT:int;
      
      protected var STEP_X:int;
      
      protected var STEP_Y:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var items_amount:int;
      
      protected var quadMask:Quad;
      
      protected var area:Rectangle;
      
      public var xPos:Number;
      
      public var xPosWhenTouched:Number;
      
      public var x_key:Number;
      
      public var x_new:Number;
      
      public var x_friction:Number;
      
      public var x_diff:Number;
      
      public var x_freeze:Number;
      
      public var MAX_VEL:Number;
      
      protected var IS_PRESSED:Boolean;
      
      protected var IS_MOVING_RIGHT:Boolean;
      
      protected var LEFT_MARGIN:Number;
      
      protected var RIGHT_MARGIN:Number;
      
      public var shopPanel:ShopPanel;
      
      public function ShopItemsPanel(_shopPanel:ShopPanel, _width:int, _height:int, _index:int = 0)
      {
         super();
         this.shopPanel = _shopPanel;
         this.INDEX = _index;
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.STEP_X = this.STEP_Y = 1;
         this.items_amount = 0;
         this.mid_x = int(this.WIDTH * 0.5);
         this.bottom_mid_y = int(this.HEIGHT * 0.75);
         this.top_mid_y = int(this.HEIGHT * 0.25);
         this.xPos = 8;
         this.x_key = this.x_new = this.x_diff = 0;
         this.x_friction = 0.8;
         this.x_freeze = 1;
         this.MAX_VEL = 8;
         this.IS_PRESSED = false;
         this.IS_MOVING_RIGHT = false;
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT);
         addChild(this.bluePanel);
         if(this.INDEX == 0)
         {
            this.titlePanel = new GameText(StringsManager.GetString("panel_shop_helpers"),GameText.TYPE_BIG);
         }
         else if(this.INDEX == 1)
         {
            this.titlePanel = new GameText(StringsManager.GetString("panel_shop_premium"),GameText.TYPE_BIG);
         }
         else if(this.INDEX == 2)
         {
            this.titlePanel = new GameText(StringsManager.GetString("panel_shop_inventory"),GameText.TYPE_BIG);
         }
         else
         {
            this.titlePanel = new GameText(StringsManager.GetString("panel_shop_apparel"),GameText.TYPE_BIG);
         }
         addChild(this.titlePanel);
         this.titlePanel.x = 8;
         this.titlePanel.y = 9;
         if(Utils.EnableFontStrings)
         {
            this.titlePanel.y = 4;
         }
         if(this.INDEX == 1)
         {
            this.coinsPanel = new CoinsPanel(false);
         }
         else
         {
            this.coinsPanel = new CoinsPanel(true);
            this.coinsPanel.moreCoinsButton.addEventListener(Event.TRIGGERED,this.moreCoins);
         }
         addChild(this.coinsPanel);
         this.coinsPanel.x = this.WIDTH - (this.coinsPanel.WIDTH + 8);
         this.coinsPanel.y = 8;
         this.bluePanel.drawLine(8,this.coinsPanel.y + this.coinsPanel.HEIGHT + 8 - 2,this.WIDTH - 16);
         this.initItems();
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onClickItems);
      }
      
      protected function moreCoins(event:Event) : void
      {
         SoundSystem.PlaySound("select");
         this.shopPanel.showCoins();
      }
      
      public function updateListAndCoins(purchased_index:int) : void
      {
         var i:int = 0;
         var j:int = 0;
         var shopItemButton:ShopItemButton = null;
         var index_offset:int = 0;
         var inventory_slots_amount:int = 0;
         var __amount:int = 0;
         this.coinsPanel.updateAmount();
         this.coinsPanel.x = this.WIDTH - (this.coinsPanel.WIDTH + 8);
         for(i = 0; i < this.itemButtons.length; i++)
         {
            if(this.itemButtons[i] != null)
            {
               this.itemButtons[i].refreshButton();
            }
         }
         if(this.INDEX == 3 || this.INDEX == 0)
         {
            index_offset = 0;
            if(this.INDEX == 3)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] == 0)
               {
                  this.itemButtons[0].alpha = 0.5;
                  this.itemButtons[0].enabled = false;
               }
               else
               {
                  this.itemButtons[0].alpha = 1;
                  this.itemButtons[0].enabled = true;
               }
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == 0)
            {
               this.itemButtons[0].alpha = 0.5;
               this.itemButtons[0].enabled = false;
            }
            else
            {
               this.itemButtons[0].alpha = 1;
               this.itemButtons[0].enabled = true;
            }
            inventory_slots_amount = int(this.itemButtons.length / 2);
            if(this.itemButtons.length % 2 != 0)
            {
               inventory_slots_amount++;
            }
            __amount = 0;
            for(i = 0; i < inventory_slots_amount; i++)
            {
               for(j = 0; j < 2; j++)
               {
                  if(i * 2 + j + index_offset < this.itemButtons.length)
                  {
                     this.itemButtons[i * 2 + j + index_offset].x = this.STEP_X * i;
                     this.itemButtons[i * 2 + j + index_offset].y = this.STEP_Y * j;
                     __amount++;
                  }
               }
            }
            if(__amount % 2 != 0)
            {
               __amount++;
            }
            this.ITEMS_WIDTH = this.STEP_X * (int(__amount / 2) - 1) + this.BUTTON_WIDTH;
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         if(this.coinsPanel.moreCoinsButton != null)
         {
            this.coinsPanel.moreCoinsButton.removeEventListener(Event.TRIGGERED,this.moreCoins);
         }
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onClickItems);
         for(i = 0; i < this.itemButtons.length; i++)
         {
            if(this.itemButtons[i] != null)
            {
               this.itemsContainer.removeChild(this.itemButtons[i]);
               this.itemButtons[i].removeEventListener(Event.TRIGGERED,this.itemClickHandler);
               this.itemButtons[i].destroy();
               this.itemButtons[i].dispose();
               this.itemButtons[i] = null;
            }
         }
         this.itemButtons = null;
         removeChild(this.itemsContainer);
         this.itemsContainer.dispose();
         this.itemsContainer = null;
         this.quadMask.dispose();
         this.quadMask = null;
         removeChild(this.titlePanel);
         this.titlePanel.destroy();
         this.titlePanel.dispose();
         this.titlePanel = null;
         removeChild(this.coinsPanel);
         this.coinsPanel.destroy();
         this.coinsPanel.dispose();
         this.coinsPanel = null;
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
         this.area = null;
         this.shopPanel = null;
      }
      
      public function setArea() : void
      {
         this.area = new Rectangle(this.x,this.y,this.WIDTH,this.HEIGHT);
      }
      
      public function resetMenus() : void
      {
         this.xPos = 8;
      }
      
      public function onClickItems(event:TouchEvent) : void
      {
         var touches:Vector.<Touch> = null;
         var previousPosition:Point = null;
         var position:Point = null;
         var scaled_position:Point = null;
         if(!Utils.ShopOn)
         {
            return;
         }
         var _amount:int = 4;
         if(this.INDEX == 2)
         {
            _amount = 13;
         }
         if(this.items_amount < _amount && !this.IS_PRESSED)
         {
            return;
         }
         try
         {
            touches = event.getTouches(Utils.rootStage);
            previousPosition = touches[touches.length - 1].getPreviousLocation(Utils.rootStage);
            position = touches[touches.length - 1].getLocation(Utils.rootStage);
            scaled_position = new Point(position.x * Utils.GFX_INV_SCALE,position.y * Utils.GFX_INV_SCALE);
            if(touches[touches.length - 1].phase == "began")
            {
               if(this.area.containsPoint(scaled_position))
               {
                  this.x_key = this.x_new = position.x * Utils.GFX_INV_SCALE;
                  this.IS_PRESSED = true;
                  this.xPosWhenTouched = this.xPos;
               }
            }
            else if(touches[touches.length - 1].phase == "moved")
            {
               if(position.x * Utils.GFX_INV_SCALE < this.x_new)
               {
                  this.IS_MOVING_RIGHT = false;
               }
               else
               {
                  this.IS_MOVING_RIGHT = true;
               }
               this.x_new = position.x * Utils.GFX_INV_SCALE;
            }
            else if(touches[touches.length - 1].phase == "ended")
            {
               this.IS_PRESSED = false;
               this.x_diff *= 0.75;
               this.setButtonsEnabled(true);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      protected function initItems() : void
      {
         var shopItemButton:Button = null;
         var i:int = 0;
         var j:int = 0;
         var inventory_slots_amount:int = 0;
         var premiumButton:ShopTierButton = null;
         var doubleCoinsButton:ShopTierButton = null;
         var unlimitedLivesButton:ShopTierButton = null;
         var unlimitedGoldenCatButton:ShopTierButton = null;
         var noAdsButton:ShopTierButton = null;
         var current_index:int = 0;
         var inventoryButton:ShopInventoryButton = null;
         var inventoryItemIndexesToDisplay:Array = null;
         this.itemButtons = new Array();
         this.itemsContainer = new Sprite();
         this.quadMask = new Quad(this.WIDTH - 16,this.HEIGHT - 48);
         this.itemsContainer.mask = this.quadMask;
         addChild(this.itemsContainer);
         this.itemsContainer.x = 8;
         this.itemsContainer.y = 40;
         this.BUTTON_WIDTH = int(this.WIDTH * 0.255);
         if(this.INDEX == 1)
         {
            this.BUTTON_WIDTH = int((this.WIDTH - (16 + 6 * 2)) / 3);
         }
         else if(this.INDEX == 2)
         {
            this.BUTTON_WIDTH = int((this.WIDTH - (16 + 3 * 5)) / 6);
         }
         var BUTTON_HEIGHT:Number = int(this.HEIGHT - 48);
         if(this.INDEX == 2 || this.INDEX == 0 || this.INDEX == 3)
         {
            BUTTON_HEIGHT = int((this.HEIGHT - (48 + 3)) / 2);
         }
         this.STEP_X = this.STEP_Y = this.BUTTON_WIDTH + 6;
         if(this.INDEX == 2 || this.INDEX == 0 || this.INDEX == 3)
         {
            this.STEP_X = this.BUTTON_WIDTH + 3;
            this.STEP_Y = BUTTON_HEIGHT + 3;
         }
         if(this.INDEX == 0)
         {
            ShopList.Init(0,this.itemsContainer,this.itemButtons,this.BUTTON_WIDTH,BUTTON_HEIGHT);
         }
         else if(this.INDEX == 1)
         {
            if(Utils.IS_ANDROID)
            {
               premiumButton = new ShopTierButton("moreCoinsTierShop1Anim_a",InAppProductsManager.GetLocalizedPrice(Utils.ANDROID_INAPP_TIER1_PRODUCT),this.BUTTON_WIDTH,BUTTON_HEIGHT);
            }
            else
            {
               premiumButton = new ShopTierButton("moreCoinsTierShop1Anim_a",InAppProductsManager.GetLocalizedPrice("com.neutronized.supercattalespaws.inapp_tier1"),this.BUTTON_WIDTH,BUTTON_HEIGHT);
            }
            this.itemsContainer.addChild(premiumButton);
            this.itemButtons.push(premiumButton);
            premiumButton.name = "297";
            if(Utils.IS_ANDROID)
            {
               premiumButton = new ShopTierButton("moreCoinsTierShop2Anim_a",InAppProductsManager.GetLocalizedPrice(Utils.ANDROID_INAPP_TIER2_PRODUCT),this.BUTTON_WIDTH,BUTTON_HEIGHT);
            }
            else
            {
               premiumButton = new ShopTierButton("moreCoinsTierShop2Anim_a",InAppProductsManager.GetLocalizedPrice("com.neutronized.supercattalespaws.inapp_tier2"),this.BUTTON_WIDTH,BUTTON_HEIGHT);
            }
            this.itemsContainer.addChild(premiumButton);
            this.itemButtons.push(premiumButton);
            premiumButton.name = "298";
            if(Utils.IS_ANDROID)
            {
               premiumButton = new ShopTierButton("moreCoinsTierShop3Anim_a",InAppProductsManager.GetLocalizedPrice(Utils.ANDROID_INAPP_TIER3_PRODUCT),this.BUTTON_WIDTH,BUTTON_HEIGHT);
            }
            else
            {
               premiumButton = new ShopTierButton("moreCoinsTierShop3Anim_a",InAppProductsManager.GetLocalizedPrice("com.neutronized.supercattalespaws.inapp_tier3"),this.BUTTON_WIDTH,BUTTON_HEIGHT);
            }
            this.itemsContainer.addChild(premiumButton);
            this.itemButtons.push(premiumButton);
            premiumButton.name = "299";
         }
         else if(this.INDEX == 2)
         {
            inventoryItemIndexesToDisplay = LevelItems.GetInventoryItemIndexesToDisplayArray();
            inventory_slots_amount = 12;
            if(inventoryItemIndexesToDisplay.length > 12)
            {
               inventory_slots_amount = int(inventoryItemIndexesToDisplay.length);
               if(inventory_slots_amount % 2 != 0)
               {
                  inventory_slots_amount++;
               }
            }
            for(i = 0; i < inventory_slots_amount / 2; i++)
            {
               for(j = 0; j < 2; j++)
               {
                  current_index = i * 2 + j;
                  if(current_index < inventoryItemIndexesToDisplay.length)
                  {
                     if(inventoryItemIndexesToDisplay[current_index] == LevelItems.ITEM_FISHING_ROD_1)
                     {
                        inventoryButton = new ShopInventoryButton("shopItem_29_" + Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1],1,this.BUTTON_WIDTH,BUTTON_HEIGHT,inventoryItemIndexesToDisplay[current_index]);
                     }
                     else if(inventoryItemIndexesToDisplay[current_index] == LevelItems.ITEM_GACHA_1)
                     {
                        inventoryButton = new ShopInventoryButton("shopItem_90",1,this.BUTTON_WIDTH,BUTTON_HEIGHT,inventoryItemIndexesToDisplay[current_index]);
                     }
                     else
                     {
                        inventoryButton = new ShopInventoryButton("shopItem_" + inventoryItemIndexesToDisplay[current_index],Utils.Slot.playerInventory[inventoryItemIndexesToDisplay[current_index]],this.BUTTON_WIDTH,BUTTON_HEIGHT,inventoryItemIndexesToDisplay[current_index]);
                     }
                  }
                  else
                  {
                     inventoryButton = new ShopInventoryButton(null,-1,this.BUTTON_WIDTH,BUTTON_HEIGHT,-1);
                  }
                  this.itemsContainer.addChild(inventoryButton);
                  this.itemButtons.push(inventoryButton);
               }
            }
         }
         else if(this.INDEX == 3)
         {
            ShopList.Init(3,this.itemsContainer,this.itemButtons,this.BUTTON_WIDTH,BUTTON_HEIGHT);
         }
         if(this.INDEX == 2)
         {
            for(i = 0; i < inventory_slots_amount / 2; i++)
            {
               for(j = 0; j < 2; j++)
               {
                  this.itemButtons[i * 2 + j].x = this.STEP_X * i;
                  this.itemButtons[i * 2 + j].y = this.STEP_Y * j;
                  this.itemButtons[i * 2 + j].alphaWhenDisabled = 1;
                  this.itemButtons[i * 2 + j].addEventListener(Event.TRIGGERED,this.itemClickHandler);
               }
            }
         }
         else if(this.INDEX == 0 || this.INDEX == 3)
         {
            inventory_slots_amount = int(this.itemButtons.length / 2);
            if(this.itemButtons.length % 2 != 0)
            {
               inventory_slots_amount++;
            }
            for(i = 0; i < inventory_slots_amount; i++)
            {
               for(j = 0; j < 2; j++)
               {
                  if(i * 2 + j < this.itemButtons.length)
                  {
                     this.itemButtons[i * 2 + j].x = this.STEP_X * i;
                     this.itemButtons[i * 2 + j].y = this.STEP_Y * j;
                     this.itemButtons[i * 2 + j].alphaWhenDisabled = 1;
                     if(this.itemButtons[i * 2 + j].index != -100)
                     {
                        this.itemButtons[i * 2 + j].addEventListener(Event.TRIGGERED,this.itemClickHandler);
                     }
                  }
               }
            }
         }
         else
         {
            for(i = 0; i < this.itemButtons.length; i++)
            {
               this.itemButtons[i].alphaWhenDisabled = 1;
               this.itemButtons[i].addEventListener(Event.TRIGGERED,this.itemClickHandler);
               this.itemButtons[i].x = this.STEP_X * i;
            }
         }
         this.items_amount = this.itemButtons.length;
         this.LEFT_MARGIN = 8;
         this.RIGHT_MARGIN = this.WIDTH - 8;
         if(this.INDEX == 2)
         {
            this.ITEMS_WIDTH = this.STEP_X * (this.itemButtons.length / 2 - 1) + this.BUTTON_WIDTH;
         }
         else if(this.INDEX == 0 || this.INDEX == 3)
         {
            this.ITEMS_WIDTH = this.STEP_X * (inventory_slots_amount - 1) + this.BUTTON_WIDTH;
         }
         else
         {
            this.ITEMS_WIDTH = this.STEP_X * (this.itemButtons.length - 1) + this.BUTTON_WIDTH;
         }
      }
      
      protected function itemClickHandler(event:Event) : void
      {
         var i:int = 0;
         var shopItemButton:ShopItemButton = null;
         var shopInventoryButton:ShopInventoryButton = null;
         var index:int = int(Button(event.target).name);
         if(this.INDEX == 0 || this.INDEX == 3)
         {
            SoundSystem.PlaySound("select");
            shopItemButton = ShopItemButton(event.target);
            this.shopPanel.showItem(shopItemButton.index,shopItemButton.item_price);
         }
         else if(this.INDEX == 2)
         {
            SoundSystem.PlaySound("select");
            shopInventoryButton = ShopInventoryButton(event.target);
            this.shopPanel.showItem(shopInventoryButton.index,shopInventoryButton.item_amount);
         }
         else
         {
            SoundSystem.PlaySound("select");
            this.shopPanel.purchaseTier(index);
         }
      }
      
      public function getPrice(_inventory_index:int) : int
      {
         var i:int = 0;
         var array_index:int = 0;
         for(i = 0; i < this.itemButtons.length; i++)
         {
            if(this.itemButtons[i] != null)
            {
               if(_inventory_index == int(Button(this.itemButtons[i])))
               {
                  array_index = i;
               }
            }
         }
         return this.itemButtons[array_index].item_price;
      }
      
      public function getIndex(_inventory_index:int) : int
      {
         var i:int = 0;
         var array_index:int = 0;
         for(i = 0; i < this.itemButtons.length; i++)
         {
            if(this.itemButtons[i] != null)
            {
               if(_inventory_index == int(Button(this.itemButtons[i])))
               {
                  array_index = i;
               }
            }
         }
         return int(this.itemButtons[array_index].name);
      }
      
      public function update() : void
      {
         var i:int = 0;
         if(this.visible == false)
         {
            return;
         }
         if(this.coinsPanel != null)
         {
            this.coinsPanel.update();
         }
         if(this.IS_PRESSED)
         {
            this.x_diff = (this.x_new - this.x_key) * this.x_freeze;
            this.x_key += this.x_diff * 0.5;
            this.xPos += this.x_diff * 0.5;
            if(Math.abs(this.xPos - this.xPosWhenTouched) > 8)
            {
               this.setButtonsEnabled(false);
            }
            if(this.xPos > this.LEFT_MARGIN + 32)
            {
               this.xPos = this.LEFT_MARGIN + 32;
            }
            else if(this.xPos + this.ITEMS_WIDTH < this.RIGHT_MARGIN - 32)
            {
               this.xPos = this.RIGHT_MARGIN - 32 - this.ITEMS_WIDTH;
            }
         }
         else
         {
            this.xPos += this.x_diff;
            this.x_diff *= 0.9;
            if(this.xPos > this.LEFT_MARGIN)
            {
               this.xPos -= (this.xPos - this.LEFT_MARGIN) * 0.25;
            }
            else if(this.xPos + this.ITEMS_WIDTH < this.RIGHT_MARGIN)
            {
               this.xPos += (this.RIGHT_MARGIN - (this.xPos + this.ITEMS_WIDTH)) * 0.25;
            }
         }
         for(i = 0; i < this.itemButtons.length; i++)
         {
            if(this.itemButtons[i] != null)
            {
               this.itemButtons[i].update();
            }
         }
         this.itemsContainer.x = int(this.xPos);
         this.quadMask.x = int(-this.xPos + 8);
         if(this.x_freeze < 0)
         {
            this.x_freeze = 0;
         }
         else if(this.x_freeze > 1)
         {
            this.x_freeze = 1;
         }
      }
      
      public function levelComplete() : void
      {
      }
      
      protected function pauseState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = 0;
      }
      
      protected function levelCompleteState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = -10;
      }
      
      public function setButtonsTouchable(value:Boolean) : void
      {
         var i:int = 0;
         for(i = 0; i < this.itemButtons.length; i++)
         {
            if(this.itemButtons[i] != null)
            {
               this.itemButtons[i].touchable = value;
            }
         }
      }
      
      public function setButtonsEnabled(value:Boolean) : void
      {
         var i:int = 0;
         for(i = 0; i < this.itemButtons.length; i++)
         {
            if(this.itemButtons[i] != null)
            {
               if(this.itemButtons[i].index == -100)
               {
                  this.itemButtons[i].enabled = false;
               }
               else if(this.itemButtons[i].alpha >= 1)
               {
                  this.itemButtons[i].enabled = value;
               }
            }
         }
      }
   }
}
