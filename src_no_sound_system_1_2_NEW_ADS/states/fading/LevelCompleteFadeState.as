package states.fading
{
   import entities.helpers.HelpersManager;
   import flash.geom.Point;
   import game_utils.SaveManager;
   import interfaces.panels.CoinsPanel;
   import interfaces.panels.ExperiencePanel;
   import interfaces.panels.ItemsPanel;
   import interfaces.panels.fading.RedPanel;
   import interfaces.texts.GameText;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Sprite;
   import states.*;
   
   public class LevelCompleteFadeState implements IState
   {
       
      
      protected var container:Sprite;
      
      protected var redPanel:RedPanel;
      
      protected var delayCounter:int;
      
      protected var TWEENS_COMPLETE:Boolean;
      
      protected var IS_SECRET_LEVEL:Boolean;
      
      protected var levelCompleteText:GameText;
      
      protected var top_indexes:Array;
      
      protected var panelContainer:Sprite;
      
      protected var experiencePanels:Vector.<ExperiencePanel>;
      
      protected var newCatUnlockedText:GameText;
      
      protected var IS_NEW_CAT_UNLOCKED:Boolean;
      
      protected var IS_EXPERIENCE_INCREASE:Boolean;
      
      protected var itemsPanel:ItemsPanel;
      
      protected var timeText:GameText;
      
      protected var timeValueText:GameText;
      
      protected var perfectText:GameText;
      
      protected var coinsPanel:CoinsPanel;
      
      protected var time_in:Number;
      
      protected var time_out:Number;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var counter3:int;
      
      protected var counter4:int;
      
      protected var progression:int;
      
      protected var record_counter1:int;
      
      protected var record_counter2:int;
      
      protected var total_time:int;
      
      protected var cat_counter:int;
      
      public function LevelCompleteFadeState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         this.delayCounter = 0;
         this.time_in = 0.5;
         this.time_out = 0.25;
         this.counter1 = this.counter2 = this.counter3 = this.counter4 = 0;
         this.progression = 0;
         this.cat_counter = 0;
         this.TWEENS_COMPLETE = false;
         if(Utils.CurrentLevel == 251 || Utils.CurrentLevel == 252 || Utils.CurrentLevel == 253)
         {
            this.IS_SECRET_LEVEL = true;
         }
         else
         {
            this.IS_SECRET_LEVEL = false;
         }
         if(game.fadingOut)
         {
            game.FADE_IN_FLAG = false;
            this.container = new Sprite();
            this.container.scaleX = this.container.scaleY = Utils.GFX_SCALE;
            Utils.rootMovie.addChild(this.container);
            this.redPanel = new RedPanel(RedPanel.RIGHT_LEFT,RedPanel.FADE_OUT,this.time_in,this.time_out);
            this.container.addChild(this.redPanel);
            this.init();
            this.itemsPanel.levelComplete();
         }
         else
         {
            Utils.rootMovie.setChildIndex(this.container,Utils.rootMovie.numChildren - 1);
         }
      }
      
      protected function checkHelpers() : void
      {
         var i:int = 0;
         var temp_array:Array = null;
         this.experiencePanels = null;
         this.top_indexes = null;
         this.panelContainer = null;
         this.IS_EXPERIENCE_INCREASE = false;
         for(i = 0; i < Utils.LEVEL_EXP.length; i++)
         {
            if(Utils.LEVEL_EXP[i] > 0)
            {
               this.IS_EXPERIENCE_INCREASE = true;
            }
         }
         if(this.IS_EXPERIENCE_INCREASE)
         {
            this.panelContainer = new Sprite();
            this.container.addChild(this.panelContainer);
            this.top_indexes = new Array();
            temp_array = new Array();
            this.experiencePanels = new Vector.<ExperiencePanel>();
            for(i = 0; i < Utils.LEVEL_EXP.length; i++)
            {
               temp_array.push(new Point(i,Utils.LEVEL_EXP[i]));
            }
            temp_array.sortOn("y",Array.NUMERIC | Array.DESCENDING);
            this.top_indexes.push(temp_array[0].x);
            if(temp_array[1].y > 0)
            {
               this.top_indexes.push(temp_array[1].x);
            }
            if(temp_array[2].y > 0)
            {
               this.top_indexes.push(temp_array[2].x);
            }
            for(i = 0; i < this.top_indexes.length; i++)
            {
               this.experiencePanels.push(new ExperiencePanel(HelpersManager.ArrayIndexToInventoryIndex(this.top_indexes[i]),48,true,temp_array[i].y));
            }
            for(i = 0; i < this.experiencePanels.length; i++)
            {
               this.panelContainer.addChild(this.experiencePanels[i]);
               this.experiencePanels[i].x = i * 64;
               this.experiencePanels[i].y = 0;
               this.panelContainer.visible = false;
               if(this.experiencePanels.length == 2)
               {
                  this.panelContainer.pivotX = 32;
               }
               else if(this.experiencePanels.length == 3)
               {
                  this.panelContainer.pivotX = 64;
               }
            }
         }
      }
      
      public function updateState(game:Game) : void
      {
         var i:* = undefined;
         var j:int = 0;
         var done_amount:int = 0;
         var is_evolution:Boolean = false;
         ++this.total_time;
         Utils.rootMovie.setChildIndex(this.container,Utils.rootMovie.numChildren - 1);
         this.redPanel.update();
         this.updateRecord();
         if(game.fadingOut)
         {
            if(this.delayCounter++ == 1)
            {
               this.redPanel.startAnimation();
               this.tweensIn();
            }
            ++this.counter1;
            if(this.counter1 > 25)
            {
               ++this.counter2;
               if(this.counter2 > 4)
               {
                  this.counter2 = 0;
                  this.timeText.alpha += 0.3;
                  if(this.timeText.alpha >= 1)
                  {
                     this.timeText.alpha = 1;
                  }
                  this.timeValueText.alpha = this.timeText.alpha;
                  this.perfectText.alpha = this.timeText.alpha;
               }
            }
            this.coinsPanel.alpha = this.timeText.alpha;
            if(this.redPanel.stateMachine.currentState == "IS_FADE_IN_STATE" && this.TWEENS_COMPLETE && this.timeText.alpha >= 1 && this.progression == 0)
            {
               ++this.progression;
               this.itemsPanel.levelComplete();
            }
            else if(this.progression == 1)
            {
               if(this.IS_NEW_CAT_UNLOCKED)
               {
                  ++this.progression;
                  this.newCatTweensIn();
                  this.TWEENS_COMPLETE = false;
               }
               else if(this.IS_EXPERIENCE_INCREASE)
               {
                  this.progression = 100;
               }
               else
               {
                  this.progression = 4;
               }
            }
            else if(this.progression == 2)
            {
               if(this.TWEENS_COMPLETE)
               {
                  ++this.progression;
                  this.TWEENS_COMPLETE = false;
               }
            }
            else if(this.progression == 3)
            {
               if(this.cat_counter++ == 60)
               {
                  this.delayCounter = 0;
                  game.FADE_OUT_FLAG = true;
               }
            }
            else if(this.progression == 4)
            {
               if(this.itemsPanel.stateMachine.currentState == "IS_ANIMATION_OVER_STATE")
               {
                  this.delayCounter = 0;
                  game.FADE_OUT_FLAG = true;
               }
            }
            else if(this.progression == 100)
            {
               if(this.counter3++ > 15)
               {
                  this.panelContainer.visible = true;
                  this.panelContainer.alpha = 0;
                  this.counter3 = this.counter4 = 0;
                  ++this.progression;
               }
            }
            else if(this.progression == 101)
            {
               if(this.counter4++ > 1)
               {
                  this.panelContainer.alpha += 0.3;
                  this.itemsPanel.alpha -= 0.3;
                  this.counter4 = 0;
                  if(this.panelContainer.alpha >= 1)
                  {
                     this.panelContainer.alpha = 10;
                     this.itemsPanel.visible = false;
                     this.counter3 = this.counter4 = 0;
                     ++this.progression;
                     for(i = 0; i < this.experiencePanels.length; i++)
                     {
                        this.experiencePanels[i].setIncreaseExp();
                     }
                  }
               }
            }
            else if(this.progression == 102)
            {
               done_amount = 0;
               for(i = 0; i < this.experiencePanels.length; i++)
               {
                  this.experiencePanels[i].update();
                  if(this.experiencePanels[i].IS_EXP_INCREASE_DONE)
                  {
                     done_amount++;
                  }
               }
               if(done_amount >= this.experiencePanels.length)
               {
                  this.saveExperienceIncrease();
                  is_evolution = false;
                  for(i = 0; i < this.experiencePanels.length; i++)
                  {
                     if(this.experiencePanels[i].IS_EVOLUTION)
                     {
                        is_evolution = true;
                        Utils.Slot.gameVariables[this.experiencePanels[i].INDEX] = 0;
                        ++Utils.Slot.playerInventory[this.experiencePanels[i].INDEX];
                        if(Utils.Slot.playerInventory[this.experiencePanels[i].INDEX] > 3)
                        {
                           Utils.Slot.playerInventory[this.experiencePanels[i].INDEX] = 3;
                        }
                     }
                  }
                  if(!is_evolution)
                  {
                     this.progression = 103;
                     this.counter4 = 0;
                  }
                  else
                  {
                     this.counter4 = 0;
                     SaveManager.SaveGameVariables();
                     SaveManager.SaveInventory();
                     this.progression = 110;
                  }
               }
            }
            else if(this.progression == 103)
            {
               for(i = 0; i < this.experiencePanels.length; i++)
               {
                  this.experiencePanels[i].update();
               }
               if(this.counter4++ > 15)
               {
                  this.progression = 4;
               }
            }
            else if(this.progression == 110)
            {
               for(i = 0; i < this.experiencePanels.length; i++)
               {
                  this.experiencePanels[i].update();
               }
               if(this.counter4++ >= 90)
               {
                  this.progression = 4;
               }
            }
            this.itemsPanel.update();
         }
         else
         {
            if(this.delayCounter >= 0)
            {
               ++this.delayCounter;
            }
            if(this.delayCounter >= 30 && (this.total_time >= 180 || !Utils.IS_NEW_RECORD))
            {
               this.delayCounter = -1;
               this.redPanel.startAnimation();
               if(!this.IS_NEW_CAT_UNLOCKED)
               {
                  this.tweensOut();
               }
               else
               {
                  this.catTweensOut();
               }
            }
            if(this.redPanel.stateMachine.currentState == "IS_FADE_OUT_STATE" && this.TWEENS_COMPLETE)
            {
               game.removeFader();
            }
         }
         if(this.panelContainer != null && this.itemsPanel != null)
         {
            this.panelContainer.x = this.itemsPanel.x;
            this.panelContainer.y = this.itemsPanel.y;
         }
         if(!Utils.PERFECT_GAME)
         {
            if(this.perfectText != null)
            {
               this.perfectText.visible = false;
            }
         }
         if(Utils.IS_SECRET_EXIT)
         {
            if(this.perfectText != null)
            {
               this.perfectText.visible = true;
            }
         }
      }
      
      protected function saveExperienceIncrease() : void
      {
         var i:int = 0;
         for(i = 0; i < this.experiencePanels.length; i++)
         {
            Utils.Slot.gameVariables[this.experiencePanels[i].INDEX] = this.experiencePanels[i].NEW_EXP_TO_SAVE;
         }
         SaveManager.SaveGameVariables();
      }
      
      protected function newCatTweensIn() : void
      {
         var tween:Tween = null;
         this.newCatUnlockedText.visible = true;
         tween = new Tween(this.newCatUnlockedText,0.8,Transitions.EASE_OUT_BACK);
         tween.moveTo(int(Utils.WIDTH * 0.5),this.newCatUnlockedText.y);
         tween.roundToInt = true;
         tween.delay = 0.75;
         Starling.juggler.add(tween);
         tween = new Tween(this.levelCompleteText,this.time_in,Transitions.LINEAR);
         tween.moveTo(int(this.levelCompleteText.x - Utils.WIDTH),this.levelCompleteText.y);
         tween.roundToInt = true;
         tween.delay = 0.75;
         Starling.juggler.add(tween);
         tween = new Tween(this.itemsPanel,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.itemsPanel.x - Utils.WIDTH),this.itemsPanel.y);
         tween.roundToInt = true;
         tween.delay = 0.75;
         Starling.juggler.add(tween);
         tween = new Tween(this.timeText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.timeText.x - Utils.WIDTH),this.timeText.y);
         tween.roundToInt = true;
         tween.delay = 0.75;
         Starling.juggler.add(tween);
         tween = new Tween(this.perfectText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.perfectText.x - Utils.WIDTH),this.perfectText.y);
         tween.roundToInt = true;
         tween.delay = 0.75;
         Starling.juggler.add(tween);
         tween = new Tween(this.timeValueText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.timeValueText.x - Utils.WIDTH),this.timeValueText.y);
         tween.roundToInt = true;
         tween.delay = 0.75;
         Starling.juggler.add(tween);
      }
      
      protected function tweensIn() : void
      {
         var tween:Tween = null;
         this.TWEENS_COMPLETE = false;
         tween = new Tween(this.levelCompleteText,0.8,Transitions.EASE_OUT_BACK);
         tween.moveTo(int(Utils.WIDTH * 0.5),this.levelCompleteText.y);
         tween.roundToInt = true;
         tween.delay = 0.1;
         Starling.juggler.add(tween);
         tween = new Tween(this.itemsPanel,0.8,Transitions.EASE_OUT_BACK);
         tween.moveTo(int(Utils.WIDTH * 0.5),this.itemsPanel.y);
         tween.roundToInt = true;
         tween.delay = 0.3;
         Starling.juggler.add(tween);
         this.coinsPanel.updateAmount();
         this.counter1 = this.counter2 = this.counter3 = this.counter4 = 0;
         tween.onComplete = this.tweenComplete;
      }
      
      protected function tweensOut() : void
      {
         var tween:Tween = null;
         this.TWEENS_COMPLETE = false;
         tween = new Tween(this.levelCompleteText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.levelCompleteText.x - Utils.WIDTH),this.levelCompleteText.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.itemsPanel,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.itemsPanel.x - Utils.WIDTH),this.itemsPanel.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.timeText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.timeText.x - Utils.WIDTH),this.timeText.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.perfectText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.perfectText.x - Utils.WIDTH),this.perfectText.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.coinsPanel,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.coinsPanel.x - Utils.WIDTH),this.coinsPanel.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.timeValueText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.timeValueText.x - Utils.WIDTH),this.timeValueText.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween.onComplete = this.tweenComplete;
      }
      
      protected function catTweensOut() : void
      {
         var tween:Tween = null;
         this.TWEENS_COMPLETE = false;
         tween = new Tween(this.newCatUnlockedText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.newCatUnlockedText.x - Utils.WIDTH),this.newCatUnlockedText.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.coinsPanel,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.coinsPanel.x - Utils.WIDTH),this.coinsPanel.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween.onComplete = this.tweenComplete;
      }
      
      private function tweenComplete() : void
      {
         this.TWEENS_COMPLETE = true;
      }
      
      protected function init() : void
      {
         this.levelCompleteText = new GameText(StringsManager.GetString("level_clear"),GameText.TYPE_BIG);
         this.levelCompleteText.pivotX = int(this.levelCompleteText.WIDTH * 0.5);
         this.levelCompleteText.pivotY = 0;
         this.levelCompleteText.x = int(Utils.WIDTH + Utils.WIDTH * 0.5);
         this.levelCompleteText.y = int(Utils.HEIGHT * 0.25);
         this.container.addChild(this.levelCompleteText);
         this.newCatUnlockedText = new GameText(StringsManager.GetString("cat_unlocked"),GameText.TYPE_BIG);
         this.newCatUnlockedText.pivotX = int(this.newCatUnlockedText.WIDTH * 0.5);
         this.newCatUnlockedText.pivotY = 0;
         this.newCatUnlockedText.x = int(Utils.WIDTH + Utils.WIDTH * 0.5);
         this.newCatUnlockedText.y = int(Utils.HEIGHT * 0.2);
         this.container.addChild(this.newCatUnlockedText);
         this.newCatUnlockedText.visible = false;
         this.itemsPanel = new ItemsPanel(Utils.WIDTH,Utils.HEIGHT);
         this.itemsPanel.x = int(Utils.WIDTH + Utils.WIDTH * 0.5);
         this.itemsPanel.y = int(Utils.HEIGHT * 0.5);
         this.container.addChild(this.itemsPanel);
         this.coinsPanel = new CoinsPanel();
         this.coinsPanel.x = this.coinsPanel.y = 4;
         if(Utils.IS_IPHONE_X)
         {
            this.coinsPanel.x = Utils.X_SCREEN_MARGIN;
            this.coinsPanel.y = 5;
         }
         this.coinsPanel.alpha = 0;
         this.container.addChild(this.coinsPanel);
         this.timeText = new GameText(StringsManager.GetString("time"),GameText.TYPE_SMALL_WHITE);
         this.timeText.pivotX = int(0);
         this.timeText.pivotY = int(this.timeText.HEIGHT * 0.5);
         this.timeText.x = int(Utils.WIDTH * 0.5 - (this.timeText.WIDTH + 8));
         this.timeText.y = int(Utils.HEIGHT * 0.8);
         this.timeText.alpha = 0;
         this.container.addChild(this.timeText);
         if(Utils.IS_SECRET_EXIT)
         {
            this.perfectText = new GameText(StringsManager.GetString("secret_exit"),GameText.TYPE_SMALL_WHITE,false,false,false,false,false,true);
         }
         else
         {
            this.perfectText = new GameText(StringsManager.GetString("perfect"),GameText.TYPE_SMALL_WHITE,false,false,false,true);
         }
         this.perfectText.pivotX = int(0);
         this.perfectText.pivotY = int(this.perfectText.HEIGHT * 0.5);
         this.perfectText.x = int(Utils.WIDTH * 0.5 - this.perfectText.WIDTH * 0.5);
         this.perfectText.y = this.timeText.y + this.timeText.HEIGHT + 4;
         this.perfectText.alpha = 0;
         this.container.addChild(this.perfectText);
         this.timeValueText = new GameText(this.getTimeString(),GameText.TYPE_SMALL_WHITE);
         this.timeValueText.pivotX = int(0);
         this.timeValueText.pivotY = int(this.timeValueText.HEIGHT * 0.5);
         this.timeValueText.x = int(this.timeText.x + this.timeText.WIDTH + 16);
         this.timeValueText.y = int(Utils.HEIGHT * 0.8);
         this.timeValueText.alpha = 0;
         this.container.addChild(this.timeValueText);
         var total_length:int = this.timeValueText.x + this.timeValueText.WIDTH - this.timeText.x;
         var center_amount:int = int((Utils.WIDTH - total_length) * 0.5);
         this.timeText.x = int(center_amount);
         this.timeValueText.x = int(this.timeText.x + this.timeText.WIDTH + 16);
         this.record_counter1 = this.record_counter2 = 0;
         this.total_time = 0;
         if(Utils.IS_SECRET_EXIT)
         {
            this.timeText.visible = false;
            this.timeValueText.visible = false;
         }
         this.checkHelpers();
      }
      
      public function exitState(game:Game) : void
      {
         var i:int = 0;
         this.top_indexes = null;
         if(this.experiencePanels != null)
         {
            for(i = 0; i < this.experiencePanels.length; i++)
            {
               this.panelContainer.removeChild(this.experiencePanels[i]);
               this.experiencePanels[i].destroy();
               this.experiencePanels[i].dispose();
               this.experiencePanels[i] = null;
            }
            this.experiencePanels = null;
         }
         if(this.top_indexes != null)
         {
            this.top_indexes = null;
         }
         if(this.panelContainer != null)
         {
            this.container.addChild(this.panelContainer);
            this.panelContainer.dispose();
            this.panelContainer = null;
         }
         this.container.removeChild(this.timeValueText);
         this.timeValueText.destroy();
         this.timeValueText.dispose();
         this.timeValueText = null;
         this.container.removeChild(this.perfectText);
         this.perfectText.destroy();
         this.perfectText.dispose();
         this.perfectText = null;
         this.container.removeChild(this.timeText);
         this.timeText.destroy();
         this.timeText.dispose();
         this.timeText = null;
         this.container.removeChild(this.coinsPanel);
         this.coinsPanel.destroy();
         this.coinsPanel.dispose();
         this.coinsPanel = null;
         this.container.removeChild(this.itemsPanel);
         this.itemsPanel.destroy();
         this.itemsPanel.dispose();
         this.itemsPanel = null;
         this.container.removeChild(this.levelCompleteText);
         this.levelCompleteText.destroy();
         this.levelCompleteText.dispose();
         this.levelCompleteText = null;
         this.container.removeChild(this.newCatUnlockedText);
         this.newCatUnlockedText.destroy();
         this.newCatUnlockedText.dispose();
         this.newCatUnlockedText = null;
         this.container.removeChild(this.redPanel);
         this.redPanel.destroy();
         this.redPanel.dispose();
         this.redPanel = null;
         Utils.rootMovie.removeChild(this.container);
         this.container.dispose();
         this.container = null;
      }
      
      protected function getTimeString() : String
      {
         var string:String = null;
         return Utils.GetFormattedTimeString(Utils.GetLevelTimeSeconds());
      }
      
      protected function updateRecord() : void
      {
         var ttw:int = 0;
         if(Utils.IS_NEW_RECORD)
         {
            ++this.record_counter1;
            ttw = 10;
            if(this.timeValueText.visible)
            {
               ttw = 20;
            }
            if(this.record_counter1 > ttw)
            {
               this.record_counter1 = 0;
               this.timeValueText.visible = !this.timeValueText.visible;
            }
         }
      }
   }
}
