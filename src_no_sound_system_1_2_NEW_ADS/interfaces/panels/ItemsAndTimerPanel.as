package interfaces.panels
{
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import interfaces.texts.GameText;
   import sprites.GameSprite;
   import starling.display.Sprite;
   
   public class ItemsAndTimerPanel extends Sprite
   {
       
      
      protected var bluePanel:BluePanel;
      
      protected var text_container:Sprite;
      
      protected var time:GameText;
      
      protected var best:GameText;
      
      protected var current_time:GameText;
      
      protected var record_time:GameText;
      
      protected var mid_x:int;
      
      protected var bottom_mid_y:int;
      
      protected var top_mid_y:int;
      
      protected var WIDTH:int;
      
      protected var HEIGHT:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var item_container:Sprite;
      
      protected var itemsSprite:Array;
      
      protected var itemAnimations:Array;
      
      protected var animation_index:int;
      
      protected var stateMachine:StateMachine;
      
      protected var IS_FISHING_LEVEL:Boolean;
      
      public function ItemsAndTimerPanel(_width:int, _height:int)
      {
         super();
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.IS_FISHING_LEVEL = false;
         if(Utils.CurrentLevel >= 10000)
         {
            this.IS_FISHING_LEVEL = true;
         }
         this.mid_x = int(this.WIDTH * 0.5);
         this.bottom_mid_y = int(this.HEIGHT * 0.75);
         this.top_mid_y = int(this.HEIGHT * 0.25);
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT);
         this.bluePanel.drawLine(8,this.HEIGHT * 0.5 - 2,this.WIDTH - 16);
         addChild(this.bluePanel);
         this.initItems();
         this.initText();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_PAUSE_STATE","LEVEL_COMPLETE_ACTION","IS_LEVEL_COMPLETE_STATE");
         this.stateMachine.setFunctionToState("IS_PAUSE_STATE",this.pauseState);
         this.stateMachine.setFunctionToState("IS_LEVEL_COMPLETE_STATE",this.levelCompleteState);
         this.stateMachine.setState("IS_PAUSE_STATE");
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.text_container.removeChild(this.record_time);
         this.record_time.destroy();
         this.record_time.dispose();
         this.record_time = null;
         this.text_container.removeChild(this.current_time);
         this.current_time.destroy();
         this.current_time.dispose();
         this.current_time = null;
         this.text_container.removeChild(this.best);
         this.best.destroy();
         this.best.dispose();
         this.best = null;
         this.text_container.removeChild(this.time);
         this.time.destroy();
         this.time.dispose();
         this.time = null;
         removeChild(this.text_container);
         this.text_container.dispose();
         this.text_container = null;
         for(i = 0; i < this.itemsSprite.length; i++)
         {
            this.item_container.removeChild(this.itemsSprite[i]);
            this.itemsSprite[i].destroy();
            this.itemsSprite[i].dispose();
            this.itemsSprite[i] = null;
         }
         this.itemsSprite = null;
         removeChild(this.item_container);
         this.item_container.dispose();
         this.item_container = null;
         this.itemAnimations = null;
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var ttw:int = 0;
         if(this.stateMachine.currentState != "IS_PAUSE_STATE")
         {
            if(this.stateMachine.currentState == "IS_LEVEL_COMPLETE_STATE")
            {
               ++this.counter_2;
               if(this.counter_2 >= 20)
               {
                  this.counter_2 = 0;
                  if(this.animation_index < this.itemAnimations.length)
                  {
                     this.itemsSprite[this.itemAnimations[this.animation_index]].gotoAndStop(2);
                     this.itemsSprite[this.itemAnimations[this.animation_index]].gfxHandleClip().gotoAndPlay(1);
                     ++this.animation_index;
                  }
               }
               if(Utils.IS_NEW_RECORD)
               {
                  ++this.counter_1;
                  ttw = 10;
                  if(this.current_time.visible)
                  {
                     ttw = 20;
                  }
                  if(this.counter_1 > ttw)
                  {
                     this.counter_1 = 0;
                     this.current_time.visible = !this.current_time.visible;
                     this.record_time.visible = !this.record_time.visible;
                  }
               }
            }
         }
         for(i = 0; i < this.itemsSprite.length; i++)
         {
            if(Utils.IS_SEASONAL)
            {
               this.itemsSprite[i].visible = false;
            }
            this.itemsSprite[i].updateScreenPosition();
         }
      }
      
      public function levelComplete() : void
      {
         var i:int = 0;
         this.stateMachine.performAction("LEVEL_COMPLETE_ACTION");
         this.updateTime(Utils.GetLevelTimeSeconds());
         if(Utils.IS_NEW_RECORD)
         {
            this.updateRecord(Utils.GetLevelTimeSeconds());
         }
         for(i = 0; i < 3; i++)
         {
            if(Utils.PlayerItems >> i & 1)
            {
               this.itemAnimations.push(i);
            }
         }
      }
      
      public function updateTime(new_time:int) : void
      {
         var formatted_time_string:String = Utils.GetFormattedTimeString(new_time);
         this.current_time.updateText(formatted_time_string);
         this.time.x = 0;
         this.current_time.x = this.time.x + this.time.WIDTH + 16;
         var time_width:int = int(this.time.WIDTH + 16 + this.current_time.WIDTH);
         this.time.x -= int(time_width * 0.5);
         this.current_time.x -= int(time_width * 0.5);
      }
      
      public function updateRecord(new_time:int) : void
      {
         var formatted_time_string:String = Utils.GetFormattedTimeString(new_time);
         this.record_time.updateText(formatted_time_string);
         this.best.x = 0;
         this.record_time.x = this.best.x + this.best.WIDTH + 16;
         var best_width:int = int(this.best.WIDTH + 16 + this.record_time.WIDTH);
         this.best.x -= int(best_width * 0.5);
         this.record_time.x -= int(best_width * 0.5);
      }
      
      protected function initItems() : void
      {
         var pSprite:GameSprite = null;
         var i:int = 0;
         var step:int = int(this.WIDTH * 0.28);
         this.itemAnimations = new Array();
         this.item_container = new Sprite();
         addChild(this.item_container);
         this.item_container.x = this.mid_x;
         this.item_container.y = this.top_mid_y;
         this.itemsSprite = new Array();
         var index:int = Utils.CurrentLevel - 1;
         if(this.IS_FISHING_LEVEL)
         {
            index = 0;
         }
         var items_amount:int = int(LevelItems.Items[index].length);
         for(i = 0; i < items_amount; i++)
         {
            pSprite = LevelItems.GetItemSprite(LevelItems.Items[index][i]);
            pSprite.gotoAndStop(1);
            pSprite.updateScreenPosition();
            this.item_container.addChild(pSprite);
            pSprite.x = i * step;
            this.itemsSprite.push(pSprite);
            if(LevelItems.HasLevelItemBeenGot(i))
            {
               pSprite.gotoAndStop(3);
               pSprite.updateScreenPosition();
            }
         }
         if(items_amount > 1)
         {
            this.item_container.x -= int(step * 0.5) * (items_amount - 1);
         }
      }
      
      public function updateItems() : void
      {
         if(Utils.PlayerItems & 1)
         {
            this.itemsSprite[0].gotoAndStop(3);
         }
         if(Utils.PlayerItems & 2)
         {
            this.itemsSprite[1].gotoAndStop(3);
         }
         if(Utils.PlayerItems & 4)
         {
            this.itemsSprite[2].gotoAndStop(3);
         }
      }
      
      protected function initText() : void
      {
         this.time = new GameText(StringsManager.GetString("time"),GameText.TYPE_SMALL_WHITE);
         this.best = new GameText(StringsManager.GetString("best"),GameText.TYPE_SMALL_WHITE);
         var best_time:int = int(Utils.Slot.levelTime[Utils.CurrentLevel - 1]);
         this.current_time = new GameText("00:00:00",GameText.TYPE_SMALL_WHITE);
         this.record_time = new GameText(Utils.GetFormattedTimeString(best_time),GameText.TYPE_SMALL_WHITE);
         this.text_container = new Sprite();
         addChild(this.text_container);
         this.text_container.x = this.mid_x;
         this.text_container.y = this.bottom_mid_y;
         this.text_container.addChild(this.time);
         this.time.pivotY = this.time.HEIGHT * 0.5;
         this.time.x = 0;
         this.time.y = -8;
         this.text_container.addChild(this.best);
         this.best.pivotY = this.best.HEIGHT * 0.5;
         this.best.x = 0;
         this.best.y = 8;
         this.text_container.addChild(this.current_time);
         this.current_time.pivotY = this.current_time.HEIGHT * 0.5;
         this.current_time.x = this.time.x + this.time.WIDTH + 16;
         this.current_time.y = this.time.y;
         this.text_container.addChild(this.record_time);
         this.record_time.pivotY = this.current_time.HEIGHT * 0.5;
         this.record_time.x = this.best.x + this.best.WIDTH + 16;
         this.record_time.y = this.best.y;
         var time_width:int = int(this.time.WIDTH + 16 + this.current_time.WIDTH);
         var best_width:int = int(this.best.WIDTH + 16 + this.record_time.WIDTH);
         this.time.x -= int(time_width * 0.5);
         this.current_time.x -= int(time_width * 0.5);
         this.best.x -= int(best_width * 0.5);
         this.record_time.x -= int(best_width * 0.5);
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
         this.animation_index = 0;
      }
   }
}
