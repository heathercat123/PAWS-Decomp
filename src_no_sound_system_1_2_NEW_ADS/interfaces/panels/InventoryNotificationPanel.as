package interfaces.panels
{
   import entities.Easings;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import interfaces.texts.GameText;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class InventoryNotificationPanel extends Sprite
   {
       
      
      protected var bluePanel:BluePanel;
      
      protected var textContainer:Sprite;
      
      protected var item_image:Image;
      
      protected var quest_completed_text:GameText;
      
      protected var item_name_text:GameText;
      
      protected var item_action_text:GameText;
      
      protected var WIDTH:int;
      
      protected var HEIGHT:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var fade_counter:int;
      
      protected var stateMachine:StateMachine;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      public function InventoryNotificationPanel()
      {
         super();
         this.bluePanel = new BluePanel(128,18);
         addChild(this.bluePanel);
         this.x = this.y = 100;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         this.fade_counter = 0;
         this.item_image = null;
         this.item_name_text = new GameText("",GameText.TYPE_SMALL_WHITE);
         this.item_action_text = new GameText("",GameText.TYPE_SMALL_WHITE);
         this.quest_completed_text = new GameText(StringsManager.GetString("quest_completed"),GameText.TYPE_SMALL_WHITE);
         this.textContainer = new Sprite();
         addChild(this.textContainer);
         this.textContainer.addChild(this.item_action_text);
         this.textContainer.addChild(this.item_name_text);
         addChild(this.quest_completed_text);
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_OFF_STATE","ITEM_NOTIFICATION_ACTION","IS_INIT_GFX_STATE");
         this.stateMachine.setRule("IS_INIT_GFX_STATE","END_ACTION","IS_APPEARING_STATE");
         this.stateMachine.setRule("IS_APPEARING_STATE","END_ACTION","IS_ON_STATE");
         this.stateMachine.setRule("IS_ON_STATE","END_ACTION","IS_DISAPPEARING_STATE");
         this.stateMachine.setRule("IS_DISAPPEARING_STATE","END_ACTION","IS_OFF_STATE");
         this.stateMachine.setFunctionToState("IS_OFF_STATE",this.offState);
         this.stateMachine.setFunctionToState("IS_INIT_GFX_STATE",this.initGfxState);
         this.stateMachine.setFunctionToState("IS_APPEARING_STATE",this.appearingState);
         this.stateMachine.setFunctionToState("IS_ON_STATE",this.onState);
         this.stateMachine.setFunctionToState("IS_DISAPPEARING_STATE",this.disappearingState);
         this.stateMachine.setState("IS_OFF_STATE");
      }
      
      public function update() : void
      {
         if(this.stateMachine.currentState == "IS_OFF_STATE")
         {
            if(Utils.INVENTORY_NOTIFICATION_ID > -1)
            {
               this.stateMachine.performAction("ITEM_NOTIFICATION_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_APPEARING_STATE")
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               this.stateMachine.performAction("END_ACTION");
            }
            this.y = int(Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time));
         }
         else if(this.stateMachine.currentState == "IS_ON_STATE")
         {
            if(Utils.INVENTORY_QUEST_NOTIFICATION)
            {
               if(this.fade_counter++ > 60)
               {
                  if(this.counter_2++ > 3)
                  {
                     this.counter_2 = 0;
                     this.quest_completed_text.alpha -= 0.3;
                     this.item_image.alpha = this.item_name_text.alpha = this.item_action_text.alpha = 1 - this.quest_completed_text.alpha;
                     if(this.item_image.alpha >= 1)
                     {
                        this.item_image.alpha = this.item_name_text.alpha = this.item_action_text.alpha = 1;
                        this.quest_completed_text.visible = false;
                        Utils.INVENTORY_QUEST_NOTIFICATION = false;
                     }
                  }
               }
            }
            else
            {
               ++this.counter_1;
               if(this.counter_1 >= 120)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_DISAPPEARING_STATE")
         {
            if(this.counter_1++ > 3)
            {
               this.counter_1 = 0;
               this.alpha -= 0.3;
               if(this.alpha <= 0)
               {
                  this.alpha = 0;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      protected function offState() : void
      {
         this.visible = false;
         this.alpha = 1;
         this.touchable = false;
         this.counter_1 = this.counter_2 = 0;
      }
      
      public function destroy() : void
      {
         if(this.item_image != null)
         {
            this.textContainer.removeChild(this.item_image);
            this.item_image.dispose();
            this.item_image = null;
         }
         this.textContainer.removeChild(this.item_name_text);
         this.textContainer.removeChild(this.item_action_text);
         removeChild(this.quest_completed_text);
         this.quest_completed_text.destroy();
         this.item_name_text.destroy();
         this.item_action_text.destroy();
         this.quest_completed_text.dispose();
         this.item_name_text.dispose();
         this.item_action_text.dispose();
         this.quest_completed_text = null;
         this.item_name_text = null;
         this.item_action_text = null;
         removeChild(this.textContainer);
         this.textContainer.dispose();
         this.textContainer = null;
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
      }
      
      protected function initGfxState() : void
      {
         var item_type:int = Utils.INVENTORY_NOTIFICATION_ID;
         if(item_type == LevelItems.ITEM_COIN)
         {
            if(Utils.INVENTORY_NOTIFICATION_AMOUNT == 1)
            {
               this.item_name_text.updateText("" + Utils.INVENTORY_NOTIFICATION_AMOUNT + " " + StringsManager.GetString("shop_title_4"));
            }
            else
            {
               this.item_name_text.updateText("" + Utils.INVENTORY_NOTIFICATION_AMOUNT + " " + StringsManager.GetString("shop_title_4_plural"));
            }
         }
         else
         {
            this.item_name_text.updateText(StringsManager.GetString("shop_title_" + item_type));
         }
         if(Utils.INVENTORY_NOTIFICATION_ACTION < 0)
         {
            this.item_action_text.updateText(StringsManager.GetString("item_action_lost"));
         }
         else
         {
            this.item_action_text.updateText(StringsManager.GetString("item_action_obtained"));
         }
         if(this.item_image != null)
         {
            this.textContainer.removeChild(this.item_image);
            this.item_image.dispose();
            this.item_image = null;
         }
         this.item_image = new Image(TextureManager.hudTextureAtlas.getTexture(LevelItems.GetInventoryNotificationIconImage(item_type)));
         this.item_image.touchable = false;
         this.item_image.y = -3;
         this.textContainer.addChild(this.item_image);
         this.item_name_text.x = 0;
         this.item_image.x = this.item_name_text.WIDTH + 3;
         this.item_action_text.x = this.item_image.x + this.item_image.width + 2;
         var __text_width:int = int(this.item_action_text.x + this.item_action_text.WIDTH);
         var __width:int = int(this.item_action_text.x + this.item_action_text.WIDTH);
         if(__width < this.quest_completed_text.WIDTH && Utils.INVENTORY_QUEST_NOTIFICATION)
         {
            __width = this.quest_completed_text.WIDTH;
         }
         var blue_panel_width:int = __width + 16;
         if(blue_panel_width <= 128)
         {
            blue_panel_width = 128;
         }
         this.bluePanel.resizePanel(blue_panel_width,this.bluePanel.HEIGHT);
         var _diff_x:int = int((this.bluePanel.WIDTH - __text_width) * 0.5);
         this.textContainer.x = _diff_x;
         this.textContainer.y = 4;
         Utils.INVENTORY_NOTIFICATION_ID = -1;
         this.x = int((Utils.WIDTH - this.bluePanel.WIDTH) * 0.5);
         this.y = -this.bluePanel.HEIGHT;
         this.visible = true;
         if(Utils.INVENTORY_QUEST_NOTIFICATION)
         {
            this.quest_completed_text.visible = true;
            this.item_image.visible = this.item_name_text.visible = this.item_action_text.visible = true;
            this.item_image.alpha = this.item_name_text.alpha = this.item_action_text.alpha = 0;
            this.fade_counter = 0;
            this.quest_completed_text.x = int((this.bluePanel.WIDTH - this.quest_completed_text.WIDTH) * 0.5);
            this.quest_completed_text.y = this.textContainer.y;
         }
         else
         {
            this.quest_completed_text.visible = false;
         }
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function appearingState() : void
      {
         SoundSystem.PlaySound("item_notification");
         this.t_start = -this.bluePanel.HEIGHT;
         if(Utils.IS_IPHONE_X)
         {
            this.t_diff = this.bluePanel.HEIGHT + 3;
         }
         else
         {
            this.t_diff = this.bluePanel.HEIGHT + 4;
         }
         this.t_time = 0.25;
         this.t_tick = 0;
      }
      
      protected function onState() : void
      {
         this.counter_1 = this.counter_2 = 0;
      }
      
      protected function disappearingState() : void
      {
         this.counter_1 = this.counter_2 = 0;
      }
   }
}
