package interfaces.map
{
   import game_utils.GameSlot;
   import interfaces.panels.InventoryNotificationPanel;
   import interfaces.panels.MapItemsPanel;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class MapHud
   {
       
      
      public var worldMap:WorldMap;
      
      public var pauseButton:Button;
      
      public var questButton:Button;
      
      public var noAdsButton:Button;
      
      protected var notification_icon_0:Image;
      
      protected var notification_icon_1:Image;
      
      public var mapItemsPanel:MapItemsPanel;
      
      public var old_camera_x:Number;
      
      protected var cool_down_counter:int;
      
      public var inventoryNotificationPanel:InventoryNotificationPanel;
      
      protected var additional_x_margin:int;
      
      protected var additional_y_margin:int;
      
      protected var notification_counter:int;
      
      public function MapHud(_worldMap:WorldMap)
      {
         super();
         this.worldMap = _worldMap;
         this.old_camera_x = this.worldMap.mapCamera.x;
         this.notification_counter = 0;
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
         this.pauseButton = new Button(TextureManager.hudTextureAtlas.getTexture("pauseButton1"),"",TextureManager.hudTextureAtlas.getTexture("pauseButton2"));
         Image(Sprite(this.pauseButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.pauseButton.name = "pause";
         this.questButton = new Button(TextureManager.hudTextureAtlas.getTexture("questButton1"),"",TextureManager.hudTextureAtlas.getTexture("questButton2"));
         Image(Sprite(this.pauseButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.questButton.name = "quest";
         this.pauseButton.x = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE - (this.pauseButton.width + this.additional_x_margin));
         this.pauseButton.y = this.additional_y_margin;
         this.noAdsButton = new Button(TextureManager.hudTextureAtlas.getTexture("premiumButton1"),"",TextureManager.hudTextureAtlas.getTexture("premiumButton2"));
         Image(Sprite(this.noAdsButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.noAdsButton.name = "premium";
         this.questButton.x = int(this.pauseButton.x - this.questButton.width);
         this.questButton.y = this.additional_y_margin;
         Utils.gameMovie.addChild(this.pauseButton);
         Utils.gameMovie.addChild(this.questButton);
         Utils.gameMovie.addChild(this.noAdsButton);
         this.inventoryNotificationPanel = new InventoryNotificationPanel();
         Utils.gameMovie.addChild(this.inventoryNotificationPanel);
         this.pauseButton.addEventListener(Event.TRIGGERED,this.onClick);
         this.questButton.addEventListener(Event.TRIGGERED,this.onClick);
         this.noAdsButton.addEventListener(Event.TRIGGERED,this.onClick);
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 1 || Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 1)
         {
            this.noAdsButton.visible = false;
            this.noAdsButton.touchable = false;
         }
         this.mapItemsPanel = new MapItemsPanel();
         Utils.gameMovie.addChild(this.mapItemsPanel);
         this.mapItemsPanel.x = 4 + (this.additional_x_margin + 4);
         this.mapItemsPanel.y = 5 + (this.additional_y_margin + 3);
         this.cool_down_counter = 0;
         this.noAdsButton.x = Utils.WIDTH - (this.noAdsButton.width + 4 + this.additional_x_margin + 4);
         if(Utils.IS_IPHONE_X)
         {
            this.noAdsButton.y = Utils.HEIGHT - (this.noAdsButton.height + 6);
         }
         else
         {
            this.noAdsButton.y = Utils.HEIGHT - (this.noAdsButton.height + 4);
         }
         this.notification_icon_0 = new Image(TextureManager.hudTextureAtlas.getTexture("notification_icon_0"));
         this.notification_icon_1 = new Image(TextureManager.hudTextureAtlas.getTexture("notification_icon_1"));
         this.notification_icon_0.touchable = this.notification_icon_1.touchable = false;
         Utils.gameMovie.addChild(this.notification_icon_0);
         Utils.gameMovie.addChild(this.notification_icon_1);
         this.notification_icon_0.x = this.notification_icon_1.x = this.questButton.x + 20;
         this.notification_icon_0.y = this.notification_icon_1.y = this.questButton.y + 15;
      }
      
      public function restoreTextLabels() : void
      {
      }
      
      protected function onClick(event:Event) : void
      {
         if(this.worldMap.stateMachine.currentState != "IS_NORMAL_STATE")
         {
            return;
         }
         var button:Button = Button(event.target);
         if(button.name == "pause")
         {
            Utils.PauseOn = true;
         }
         else if(button.name == "quest")
         {
            Utils.QuestOn = true;
         }
         else if(button.name == "premium")
         {
            Utils.PremiumOn = true;
         }
      }
      
      public function destroy() : void
      {
         Utils.gameMovie.removeChild(this.notification_icon_0);
         Utils.gameMovie.removeChild(this.notification_icon_1);
         this.notification_icon_0.dispose();
         this.notification_icon_1.dispose();
         this.notification_icon_0 = null;
         this.notification_icon_1 = null;
         Utils.gameMovie.removeChild(this.inventoryNotificationPanel);
         this.inventoryNotificationPanel.destroy();
         this.inventoryNotificationPanel.dispose();
         this.inventoryNotificationPanel = null;
         Utils.gameMovie.removeChild(this.mapItemsPanel);
         this.mapItemsPanel.destroy();
         this.mapItemsPanel.dispose();
         this.mapItemsPanel = null;
         this.questButton.removeEventListener(Event.TRIGGERED,this.onClick);
         this.pauseButton.removeEventListener(Event.TRIGGERED,this.onClick);
         this.noAdsButton.removeEventListener(Event.TRIGGERED,this.onClick);
         Utils.gameMovie.removeChild(this.noAdsButton);
         this.noAdsButton.dispose();
         this.noAdsButton = null;
         Utils.gameMovie.removeChild(this.pauseButton);
         this.pauseButton.dispose();
         this.pauseButton = null;
         Utils.gameMovie.removeChild(this.questButton);
         this.questButton.dispose();
         this.questButton = null;
         this.worldMap = null;
      }
      
      public function update() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS] == 0)
         {
            this.notification_icon_1.visible = false;
            ++this.notification_counter;
            if(this.notification_counter <= 45)
            {
               this.notification_icon_0.visible = true;
            }
            else if(this.notification_counter <= 60)
            {
               this.notification_icon_0.visible = false;
               if(this.notification_counter == 60)
               {
                  this.notification_counter = 0;
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS] == 2)
         {
            this.notification_icon_1.visible = true;
         }
         else
         {
            this.notification_icon_0.visible = this.notification_icon_1.visible = false;
         }
         this.mapItemsPanel.update();
         this.inventoryNotificationPanel.update();
         var new_camera_x:Number = this.worldMap.mapCamera.x;
         var diff_camera_x:int = Math.abs(new_camera_x - this.old_camera_x);
         this.old_camera_x = this.worldMap.mapCamera.x;
         if(Utils.Slot.levelSeqUnlocked[5] == false)
         {
            this.questButton.visible = false;
            this.notification_icon_0.visible = false;
         }
         if(Boolean(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM]) || Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 1)
         {
            this.noAdsButton.visible = false;
            this.noAdsButton.touchable = false;
         }
      }
      
      public function disableInput() : void
      {
         this.pauseButton.touchable = false;
         this.questButton.touchable = false;
         this.noAdsButton.touchable = false;
      }
      
      public function enableInput() : void
      {
         this.pauseButton.touchable = true;
         this.questButton.touchable = true;
         this.noAdsButton.touchable = true;
      }
   }
}
