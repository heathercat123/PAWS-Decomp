package interfaces.panels.shop
{
   import flash.geom.*;
   import game_utils.*;
   import interfaces.buttons.*;
   import interfaces.panels.*;
   import interfaces.texts.*;
   import sprites.*;
   import sprites.hud.*;
   import starling.animation.*;
   import starling.display.*;
   import starling.events.*;
   import starling.text.*;
   
   public class ShopBuyPanel extends Sprite
   {
      
      public static var SHOP_BUY_PANEL_PURCHASE_REQUEST:Boolean = false;
       
      
      protected var bluePanel:BluePanel;
      
      public var IS_VIP:Boolean;
      
      protected var itemIcon:Image;
      
      protected var itemSprite:GameSprite;
      
      protected var textContainer:Sprite;
      
      protected var titleText:GameText;
      
      protected var priceText:GameText;
      
      protected var descriptionText:GameTextArea;
      
      protected var upgradeButton:BuyButton;
      
      protected var buyButton:BuyButton;
      
      protected var gachaShowcasePanel:GachaShowcasePanel;
      
      protected var additionalInfoText:GameText;
      
      protected var WAS_ALREADY_PURCHASED:Boolean;
      
      protected var IS_RESTORED:Boolean;
      
      protected var star_1:Image;
      
      protected var star_2:Image;
      
      protected var star_3:Image;
      
      protected var mid_x:int;
      
      protected var bottom_mid_y:int;
      
      protected var top_mid_y:int;
      
      protected var WIDTH:int;
      
      protected var HEIGHT:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      public var shopPanel:ShopPanel;
      
      public var INDEX:int;
      
      public var PRICE:Number;
      
      public var LEVEL:int;
      
      public var IS_TIER:Boolean;
      
      public var IS_APPAREL:Boolean;
      
      public var IS_INVENTORY:Boolean;
      
      public var IS_HELPER:Boolean;
      
      public function ShopBuyPanel(_shopPanel:ShopPanel, _width:int, _height:int)
      {
         super();
         this.shopPanel = _shopPanel;
         ShopBuyPanel.SHOP_BUY_PANEL_PURCHASE_REQUEST = false;
         this.IS_VIP = false;
         this.gachaShowcasePanel = null;
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.INDEX = this.PRICE = 0;
         this.LEVEL = 1;
         this.IS_TIER = this.IS_APPAREL = this.IS_INVENTORY = this.WAS_ALREADY_PURCHASED = this.IS_HELPER = this.IS_RESTORED = false;
         this.star_1 = this.star_2 = this.star_3 = null;
         this.mid_x = int(this.WIDTH * 0.5);
         this.bottom_mid_y = int(this.HEIGHT * 0.75);
         this.top_mid_y = int(this.HEIGHT * 0.25);
         this.priceText = null;
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT);
         addChild(this.bluePanel);
         this.bluePanel.drawLine(8,int(this.HEIGHT * 0.5 - 2),this.WIDTH - 16);
         this.initItems();
      }
      
      protected function upgradeClickHandler(event:Event) : void
      {
         SoundSystem.PlaySound("select");
         this.shopPanel.upgradeButtonPressed(this.INDEX);
      }
      
      public function equipPremiumHat() : void
      {
         Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] = this.INDEX;
         AchievementsManager.SubmitAchievement("sctp_1");
         SaveManager.SaveGameVariables();
      }
      
      protected function buyClickHandler(event:Event) : void
      {
         if(!this.IS_TIER)
         {
            if(this.WAS_ALREADY_PURCHASED)
            {
               if(this.IS_APPAREL)
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] = this.INDEX;
                  AchievementsManager.SubmitAchievement("sctp_1");
               }
               else
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] = this.INDEX;
                  if(Utils.Slot.playerInventory[this.INDEX] >= 3)
                  {
                     AchievementsManager.SubmitAchievement("sctp_4");
                  }
               }
               SaveManager.SaveGameVariables();
               this.shopPanel.buyButtonPressed(3);
            }
            else if(Utils.Slot.playerInventory[LevelItems.ITEM_COIN] < this.PRICE)
            {
               this.shopPanel.buyButtonPressed(0);
               SoundSystem.PlaySound("error");
            }
            else if(this.IS_VIP)
            {
               SoundSystem.PlaySound("select");
               this.shopPanel.purchasePremium();
            }
            else
            {
               SoundSystem.PlaySound("purchase");
               Utils.Slot.playerInventory[LevelItems.ITEM_COIN] -= this.PRICE;
               Utils.Slot.playerInventory[this.INDEX] += 1;
               if(this.IS_APPAREL)
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] = this.INDEX;
                  AchievementsManager.SubmitAchievement("sctp_1");
               }
               else
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] = this.INDEX;
                  if(Utils.Slot.playerInventory[this.INDEX] >= 3)
                  {
                     AchievementsManager.SubmitAchievement("sctp_4");
                  }
               }
               SaveManager.SaveGameVariables();
               SaveManager.SaveInventory();
               this.shopPanel.buyButtonPressed(1);
            }
         }
      }
      
      public function resetMenus() : void
      {
      }
      
      public function showItem(index:int, price:Number, _isUpgrade:Boolean = false) : void
      {
         var i:int = 0;
         var __width:Number = NaN;
         var __width_sx:Number = NaN;
         var __width_dx:Number = NaN;
         this.INDEX = index;
         this.PRICE = price;
         if(this.PRICE == -100)
         {
            this.IS_VIP = true;
         }
         else
         {
            this.IS_VIP = false;
         }
         if(this.gachaShowcasePanel != null)
         {
            removeChild(this.gachaShowcasePanel);
            this.gachaShowcasePanel.destroy();
            this.gachaShowcasePanel.dispose();
            this.gachaShowcasePanel = null;
         }
         this.buyButton.updateText(price);
         this.WAS_ALREADY_PURCHASED = this.IS_RESTORED = this.IS_TIER = this.IS_APPAREL = this.IS_INVENTORY = this.IS_HELPER = false;
         if(LevelItems.IsTier(index))
         {
            this.IS_TIER = true;
         }
         else if(LevelItems.IsApparel(index))
         {
            this.IS_APPAREL = true;
         }
         else if(LevelItems.IsInventory(index))
         {
            this.IS_INVENTORY = true;
         }
         else
         {
            this.IS_HELPER = true;
            if(Utils.Slot.playerInventory[index] == 0 || Utils.Slot.playerInventory[index] == 1)
            {
               this.LEVEL = 1;
            }
            else
            {
               this.LEVEL = Utils.Slot.playerInventory[index];
            }
            if(_isUpgrade)
            {
               this.LEVEL += 1;
               if(this.LEVEL == 2)
               {
                  this.PRICE = price * 2;
               }
               else
               {
                  this.PRICE = price * 4;
               }
            }
         }
         if(this.priceText != null)
         {
            this.textContainer.removeChild(this.priceText);
            this.priceText.destroy();
            this.priceText.dispose();
         }
         this.textContainer.removeChild(this.titleText);
         this.titleText.destroy();
         this.titleText.dispose();
         this.textContainer.removeChild(this.descriptionText);
         this.descriptionText.destroy();
         this.descriptionText.dispose();
         if(!this.IS_TIER)
         {
            if(Utils.Slot.playerInventory[index] > 0)
            {
               this.WAS_ALREADY_PURCHASED = true;
            }
            else if(this.IS_VIP && (Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] > 0 || Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] > 0))
            {
               this.WAS_ALREADY_PURCHASED = true;
            }
         }
         if(this.IS_HELPER && _isUpgrade)
         {
            this.WAS_ALREADY_PURCHASED = false;
         }
         if(this.upgradeButton != null)
         {
            this.upgradeButton.removeEventListener(Event.TRIGGERED,this.upgradeClickHandler);
            removeChild(this.upgradeButton);
            this.upgradeButton.destroy();
            this.upgradeButton.dispose();
            this.upgradeButton = null;
         }
         this.buyButton.removeEventListener(Event.TRIGGERED,this.buyClickHandler);
         removeChild(this.buyButton);
         this.buyButton.destroy();
         this.buyButton.dispose();
         var include_upgrade_button:Boolean = false;
         if(this.IS_HELPER && _isUpgrade == false)
         {
            if(Utils.Slot.playerInventory[index] == 1 || Utils.Slot.playerInventory[index] == 2)
            {
               include_upgrade_button = true;
            }
         }
         if(include_upgrade_button)
         {
            __width = int(this.WIDTH - 16 - 5);
            __width_sx = int(__width * 0.33333);
            __width_dx = int(__width - __width_sx);
            this.upgradeButton = new BuyButton(__width_sx,int(this.HEIGHT * 0.5 - 16),false,true);
            this.buyButton = new BuyButton(__width_dx,int(this.HEIGHT * 0.5 - 16),false);
            addChild(this.upgradeButton);
            addChild(this.buyButton);
            this.upgradeButton.x = 8;
            this.buyButton.x = this.upgradeButton.x + __width_sx + 5;
            this.upgradeButton.y = this.buyButton.y = int(this.HEIGHT * 0.5 - 2 + 10);
            this.buyButton.addEventListener(Event.TRIGGERED,this.buyClickHandler);
            this.upgradeButton.addEventListener(Event.TRIGGERED,this.upgradeClickHandler);
         }
         else
         {
            this.buyButton = new BuyButton(this.WIDTH - 16,int(this.HEIGHT * 0.5 - 16),false);
            addChild(this.buyButton);
            this.buyButton.x = 8;
            this.buyButton.y = int(this.HEIGHT * 0.5 - 2 + 10);
            this.buyButton.addEventListener(Event.TRIGGERED,this.buyClickHandler);
         }
         this.buyButton.updatePurchased(this.WAS_ALREADY_PURCHASED,this.IS_APPAREL);
         this.buyButton.visible = true;
         this.destroyStars();
         this.titleText = new GameText(StringsManager.GetString("shop_title_" + index),GameText.TYPE_SMALL_WHITE);
         if(this.IS_HELPER)
         {
            this.star_1 = new Image(TextureManager.hudTextureAtlas.getTexture("star_symbol"));
            this.star_2 = new Image(TextureManager.hudTextureAtlas.getTexture(this.LEVEL >= 2 ? "star_symbol" : "star_symbol_empty"));
            this.star_3 = new Image(TextureManager.hudTextureAtlas.getTexture(this.LEVEL >= 3 ? "star_symbol" : "star_symbol_empty"));
            this.star_1.touchable = this.star_2.touchable = this.star_3.touchable = false;
            this.textContainer.addChild(this.star_1);
            this.textContainer.addChild(this.star_2);
            this.textContainer.addChild(this.star_3);
            this.star_1.y = this.star_2.y = this.star_3.y = this.titleText.y;
            this.star_1.x = this.titleText.x + this.titleText.WIDTH + 6;
            this.star_2.x = this.star_1.x + 11;
            this.star_3.x = this.star_2.x + 11;
         }
         if(this.IS_TIER)
         {
            this.priceText = new GameText("" + this.PRICE,GameText.TYPE_SMALL_WHITE,false);
         }
         else if(this.IS_INVENTORY)
         {
            if(index == LevelItems.ITEM_FISHING_ROD_1)
            {
               this.priceText = new GameText("x1",GameText.TYPE_SMALL_WHITE);
            }
            else
            {
               this.priceText = new GameText("x" + Utils.Slot.playerInventory[index],GameText.TYPE_SMALL_WHITE);
            }
         }
         else if(this.IS_VIP)
         {
            this.priceText = new GameText("vip",GameText.TYPE_SMALL_WHITE,false,false,false,false,false,false,true);
         }
         else
         {
            this.priceText = new GameText("" + this.PRICE,GameText.TYPE_SMALL_WHITE,true);
         }
         if(this.PRICE == 0)
         {
            this.priceText.visible = false;
         }
         else
         {
            this.priceText.visible = true;
         }
         if(this.WAS_ALREADY_PURCHASED)
         {
            this.priceText.visible = false;
            if(this.IS_VIP)
            {
               this.priceText.visible = true;
            }
         }
         if(this.IS_INVENTORY)
         {
            this.priceText.visible = true;
            this.buyButton.visible = false;
         }
         if(this.IS_HELPER)
         {
            this.descriptionText = new GameTextArea(StringsManager.GetString("shop_description_" + index + "_" + this.LEVEL),GameText.TYPE_SMALL_WHITE_SHORT_SPACING,this.WIDTH - 80);
         }
         else
         {
            this.descriptionText = new GameTextArea(StringsManager.GetString("shop_description_" + index),GameText.TYPE_SMALL_WHITE_SHORT_SPACING,this.WIDTH - 80);
         }
         this.titleText.x = 0;
         this.titleText.y = 0;
         this.priceText.pivotX = 0;
         this.priceText.x = this.WIDTH - (68 + this.priceText.WIDTH);
         this.priceText.y = 0;
         this.descriptionText.x = 0;
         this.descriptionText.y = 16;
         this.textContainer.addChild(this.titleText);
         this.textContainer.addChild(this.priceText);
         this.textContainer.addChild(this.descriptionText);
         var text_height:int = 16 + (this.descriptionText.LINES_AMOUNT + 1) * this.descriptionText.line_height;
         if(Utils.EnableFontStrings)
         {
            text_height = this.descriptionText.HEIGHT + this.titleText.HEIGHT;
         }
         this.textContainer.x = 56;
         this.textContainer.y = int(this.top_mid_y - text_height * 0.5);
         if(this.itemIcon != null)
         {
            removeChild(this.itemIcon);
            this.itemIcon.dispose();
         }
         if(this.itemSprite != null)
         {
            removeChild(this.itemSprite);
            this.itemSprite.destroy();
            this.itemSprite.dispose();
            this.itemSprite = null;
         }
         this.additionalInfoText.visible = true;
         if(LevelItems.IsFish(this.INDEX))
         {
            this.additionalInfoText.updateText(StringsManager.GetString("fish_record") + " " + Utils.Slot.fishRecords[this.INDEX]);
         }
         else if(this.INDEX == LevelItems.ITEM_FISHING_ROD_1)
         {
            this.additionalInfoText.updateText(StringsManager.GetString("fishing_rod_level") + " " + Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1]);
         }
         else
         {
            this.additionalInfoText.visible = false;
         }
         if(this.IS_TIER)
         {
            if(index == 297)
            {
               this.itemSprite = new ShopTierSprite();
               this.itemSprite.gotoAndStop(1);
            }
            else if(index == 298)
            {
               this.itemSprite = new ShopTierSprite();
               this.itemSprite.gotoAndStop(2);
            }
            else if(index == 299)
            {
               this.itemSprite = new ShopTierSprite();
               this.itemSprite.gotoAndStop(3);
            }
            this.itemSprite.updateScreenPosition();
            addChild(this.itemSprite);
            this.itemSprite.x = 29;
            this.itemSprite.y = this.top_mid_y - 4;
         }
         else
         {
            if(this.IS_HELPER)
            {
               this.itemIcon = new Image(TextureManager.hudTextureAtlas.getTexture("shopItem_" + index + "_" + this.LEVEL));
            }
            else if(index == LevelItems.ITEM_FISHING_ROD_1)
            {
               this.itemIcon = new Image(TextureManager.hudTextureAtlas.getTexture("shopItem_29_" + Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1]));
            }
            else
            {
               this.itemIcon = new Image(TextureManager.hudTextureAtlas.getTexture("shopItem_" + index));
            }
            this.itemIcon.pivotX = int(this.itemIcon.width * 0.5);
            this.itemIcon.pivotY = int(this.itemIcon.height * 0.5);
            addChild(this.itemIcon);
            this.itemIcon.x = 29;
            this.itemIcon.y = this.top_mid_y - 4;
         }
         if(this.priceText != null)
         {
            this.priceText.visible = true;
         }
         if(this.itemIcon != null)
         {
            this.itemIcon.visible = true;
         }
         if(this.textContainer != null)
         {
            this.textContainer.visible = true;
         }
         if(index == LevelItems.ITEM_GACHA_1)
         {
            this.priceText.visible = false;
            this.itemIcon.visible = false;
            this.textContainer.visible = false;
            this.gachaShowcasePanel = new GachaShowcasePanel(this.WIDTH,this.HEIGHT);
            addChild(this.gachaShowcasePanel);
         }
      }
      
      public function updateAmountText() : void
      {
      }
      
      protected function initItems() : void
      {
         this.textContainer = new Sprite();
         this.titleText = new GameText(StringsManager.GetString("shop_title_1"),GameText.TYPE_SMALL_WHITE);
         this.descriptionText = new GameTextArea(StringsManager.GetString("shop_description_1"),GameText.TYPE_SMALL_WHITE,this.WIDTH - 80);
         this.additionalInfoText = new GameText("hello, these are additional info",GameText.TYPE_SMALL_WHITE);
         this.titleText.x = 0;
         this.titleText.y = 0;
         this.descriptionText.x = 0;
         this.descriptionText.y = 16;
         this.textContainer.addChild(this.titleText);
         this.textContainer.addChild(this.descriptionText);
         addChild(this.additionalInfoText);
         addChild(this.textContainer);
         var text_height:int = 16 + (this.descriptionText.LINES_AMOUNT + 1) * this.descriptionText.line_height;
         this.textContainer.x = 56;
         this.textContainer.y = int(this.top_mid_y - text_height * 0.5);
         this.itemIcon = null;
         this.itemSprite = null;
         if(this.PRICE <= 0)
         {
            this.buyButton = new BuyButton(this.WIDTH - 16,int(this.HEIGHT * 0.5 - 16),true);
         }
         else
         {
            this.buyButton = new BuyButton(this.WIDTH - 16,int(this.HEIGHT * 0.5 - 16),false);
         }
         addChild(this.buyButton);
         this.buyButton.x = 8;
         this.buyButton.y = int(this.HEIGHT * 0.5 - 2 + 10);
         this.additionalInfoText.x = this.buyButton.x;
         this.additionalInfoText.y = this.buyButton.y;
         this.buyButton.addEventListener(Event.TRIGGERED,this.buyClickHandler);
      }
      
      public function destroy() : void
      {
         this.destroyStars();
         if(this.gachaShowcasePanel != null)
         {
            removeChild(this.gachaShowcasePanel);
            this.gachaShowcasePanel.destroy();
            this.gachaShowcasePanel.dispose();
            this.gachaShowcasePanel = null;
         }
         if(this.upgradeButton != null)
         {
            this.upgradeButton.removeEventListener(Event.TRIGGERED,this.upgradeClickHandler);
            removeChild(this.upgradeButton);
            this.upgradeButton.destroy();
            this.upgradeButton.dispose();
            this.upgradeButton = null;
         }
         this.buyButton.removeEventListener(Event.TRIGGERED,this.buyClickHandler);
         removeChild(this.buyButton);
         this.buyButton.destroy();
         this.buyButton.dispose();
         this.buyButton = null;
         if(this.itemIcon != null)
         {
            removeChild(this.itemIcon);
            this.itemIcon.dispose();
            this.itemIcon = null;
         }
         if(this.itemSprite != null)
         {
            removeChild(this.itemSprite);
            this.itemSprite.destroy();
            this.itemSprite.dispose();
            this.itemSprite = null;
         }
         if(this.priceText != null)
         {
            this.textContainer.removeChild(this.priceText);
            this.priceText.destroy();
            this.priceText.dispose();
         }
         removeChild(this.textContainer);
         this.textContainer.removeChild(this.descriptionText);
         this.textContainer.removeChild(this.titleText);
         removeChild(this.additionalInfoText);
         this.descriptionText.destroy();
         this.descriptionText.dispose();
         this.descriptionText = null;
         this.titleText.destroy();
         this.titleText.dispose();
         this.titleText = null;
         this.additionalInfoText.destroy();
         this.additionalInfoText.dispose();
         this.additionalInfoText = null;
         this.textContainer.dispose();
         this.textContainer = null;
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
         this.shopPanel = null;
      }
      
      protected function destroyStars() : void
      {
         if(this.star_1 != null)
         {
            this.textContainer.removeChild(this.star_1);
            this.star_1.dispose();
            this.textContainer.removeChild(this.star_2);
            this.star_2.dispose();
            this.textContainer.removeChild(this.star_3);
            this.star_3.dispose();
            this.star_1 = this.star_2 = this.star_3 = null;
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         if(this.itemSprite != null)
         {
            if(this.itemSprite.gfxHandleClip().isComplete)
            {
               this.itemSprite.gfxHandleClip().setFrameDuration(0,Math.random() * 1.5 + 0.2);
               this.itemSprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         if(this.upgradeButton != null)
         {
            this.upgradeButton.update();
         }
         if(this.buyButton != null)
         {
            this.buyButton.update();
         }
      }
      
      private function purchaseTier(index:int) : void
      {
      }
   }
}
