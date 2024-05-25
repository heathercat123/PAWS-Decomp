package states.fading
{
   import game_utils.GameSlot;
   import interfaces.panels.CoinsPanel;
   import interfaces.panels.ItemsPanel;
   import interfaces.panels.fading.RedPanel;
   import interfaces.texts.GameText;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import states.*;
   
   public class LevelIntroFadeState implements IState
   {
       
      
      protected var container:Sprite;
      
      protected var redPanel:RedPanel;
      
      protected var delayCounter:int;
      
      protected var TWEENS_COMPLETE:Boolean;
      
      protected var IS_SECRET_LEVEL:Boolean;
      
      protected var IS_FISHING_LEVEL:Boolean;
      
      protected var levelText:GameText;
      
      protected var levelTitleText:GameText;
      
      protected var itemsPanel:ItemsPanel;
      
      protected var coinsPanel:CoinsPanel;
      
      protected var bestTime:GameText;
      
      protected var bestTimeValue:GameText;
      
      protected var houseImage:Image;
      
      protected var timeImage:Image;
      
      protected var time_in:Number;
      
      protected var time_out:Number;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var TWEENS_IN_ONCE:Boolean;
      
      protected var TWEENS_OUT_ONCE:Boolean;
      
      public function LevelIntroFadeState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         this.delayCounter = 0;
         this.time_in = 0.5;
         this.time_out = 0.25;
         this.houseImage = null;
         this.TWEENS_IN_ONCE = true;
         this.TWEENS_OUT_ONCE = true;
         this.counter1 = this.counter2 = 0;
         this.IS_SECRET_LEVEL = this.IS_FISHING_LEVEL = false;
         if(Utils.CurrentLevel == 251 || Utils.CurrentLevel == 252 || Utils.CurrentLevel == 253)
         {
            this.IS_SECRET_LEVEL = true;
         }
         if(Utils.CurrentLevel == LevelState.LEVEL_1_FISHING || Utils.CurrentLevel == LevelState.LEVEL_2_FISHING)
         {
            this.IS_FISHING_LEVEL = true;
         }
         this.TWEENS_COMPLETE = false;
         if(game.fadingOut)
         {
            game.FADE_IN_FLAG = false;
            this.container = new Sprite();
            this.container.scaleX = this.container.scaleY = Utils.GFX_SCALE;
            Utils.rootMovie.addChild(this.container);
            this.redPanel = new RedPanel(RedPanel.LEFT_RIGHT,RedPanel.FADE_OUT,this.time_in,this.time_out);
            this.container.addChild(this.redPanel);
            this.init();
         }
         else
         {
            Utils.rootMovie.setChildIndex(this.container,Utils.rootMovie.numChildren - 1);
         }
      }
      
      public function updateState(game:Game) : void
      {
         var i:* = undefined;
         var j:int = 0;
         Utils.rootMovie.setChildIndex(this.container,Utils.rootMovie.numChildren - 1);
         this.redPanel.update();
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
                  this.bestTime.alpha += 0.3;
                  if(this.bestTime.alpha >= 1)
                  {
                     this.bestTime.alpha = 1;
                  }
                  this.bestTimeValue.alpha = this.bestTime.alpha;
               }
            }
            if(this.redPanel.stateMachine.currentState == "IS_FADE_IN_STATE" && this.TWEENS_COMPLETE && this.bestTime.alpha >= 1)
            {
               this.delayCounter = 0;
               game.FADE_OUT_FLAG = true;
            }
            this.coinsPanel.alpha = this.bestTime.alpha;
            if(this.timeImage != null)
            {
               this.timeImage.alpha = this.coinsPanel.alpha;
            }
         }
         else
         {
            if(this.delayCounter++ == 60)
            {
               this.redPanel.startAnimation();
               this.tweensOut();
            }
            if(this.redPanel.stateMachine.currentState == "IS_FADE_OUT_STATE" && this.TWEENS_COMPLETE)
            {
               game.removeFader();
            }
         }
      }
      
      protected function tweensIn() : void
      {
         var tween:Tween = null;
         if(!this.TWEENS_IN_ONCE)
         {
            return;
         }
         this.TWEENS_COMPLETE = false;
         tween = new Tween(this.levelText,0.8,Transitions.EASE_OUT_BACK);
         tween.moveTo(int(Utils.WIDTH * 0.5),this.levelText.y);
         tween.roundToInt = true;
         tween.delay = 0.1;
         Starling.juggler.add(tween);
         tween = new Tween(this.levelTitleText,0.8,Transitions.EASE_OUT_BACK);
         tween.moveTo(int(Utils.WIDTH * 0.5),this.levelTitleText.y);
         tween.roundToInt = true;
         tween.delay = 0.2;
         Starling.juggler.add(tween);
         tween = new Tween(this.itemsPanel,0.8,Transitions.EASE_OUT_BACK);
         tween.moveTo(int(Utils.WIDTH * 0.5),this.itemsPanel.y);
         tween.roundToInt = true;
         tween.delay = 0.3;
         Starling.juggler.add(tween);
         this.counter1 = this.counter2 = 0;
         tween.onComplete = this.tweenComplete;
         this.TWEENS_IN_ONCE = false;
      }
      
      protected function tweensOut() : void
      {
         var tween:Tween = null;
         if(!this.TWEENS_OUT_ONCE)
         {
            return;
         }
         this.TWEENS_COMPLETE = false;
         tween = new Tween(this.levelText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.levelText.x + Utils.WIDTH),this.levelText.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.levelTitleText,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.levelTitleText.x + Utils.WIDTH),this.levelTitleText.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.itemsPanel,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.itemsPanel.x + Utils.WIDTH),this.itemsPanel.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.bestTime,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.bestTime.x + Utils.WIDTH),this.bestTime.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.coinsPanel,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.coinsPanel.x + Utils.WIDTH),this.coinsPanel.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         if(this.IS_FISHING_LEVEL)
         {
            tween = new Tween(this.timeImage,this.time_out,Transitions.LINEAR);
            tween.moveTo(int(this.timeImage.x + Utils.WIDTH),this.timeImage.y);
            tween.roundToInt = true;
            Starling.juggler.add(tween);
         }
         tween = new Tween(this.bestTimeValue,this.time_out,Transitions.LINEAR);
         tween.moveTo(int(this.bestTimeValue.x + Utils.WIDTH),this.bestTimeValue.y);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween.onComplete = this.tweenComplete;
         this.TWEENS_IN_ONCE = false;
      }
      
      private function tweenComplete() : void
      {
         this.TWEENS_COMPLETE = true;
      }
      
      protected function init() : void
      {
         this.levelText = new GameText(this.getLevelString(),GameText.TYPE_BIG);
         this.levelText.pivotX = int(this.levelText.WIDTH * 0.5);
         this.levelText.pivotY = 0;
         this.levelText.x = -int(Utils.WIDTH * 0.5);
         this.levelText.y = int(Utils.HEIGHT * 0.25);
         this.container.addChild(this.levelText);
         if(this.houseImage != null)
         {
            this.houseImage.touchable = false;
            this.levelText.addChild(this.houseImage);
            this.houseImage.x = this.levelText.WIDTH;
            this.houseImage.y = -4;
         }
         this.levelTitleText = new GameText(StringsManager.GetString("level_name_" + Utils.CurrentLevel),GameText.TYPE_SMALL_WHITE);
         this.levelTitleText.pivotX = int(this.levelTitleText.WIDTH * 0.5);
         this.levelTitleText.x = this.levelText.x;
         this.levelTitleText.y = int(this.levelText.y + this.levelText.HEIGHT) + 4;
         this.container.addChild(this.levelTitleText);
         var total_height:int = int(this.levelTitleText.y + this.levelTitleText.HEIGHT - this.levelText.y + 2);
         this.levelText.y -= int(total_height * 0.5);
         this.levelTitleText.y -= int(total_height * 0.5);
         this.itemsPanel = new ItemsPanel(Utils.WIDTH,Utils.HEIGHT);
         this.itemsPanel.x = -int(Utils.WIDTH * 0.5);
         this.itemsPanel.y = int(Utils.HEIGHT * 0.5);
         this.container.addChild(this.itemsPanel);
         if(this.IS_FISHING_LEVEL)
         {
            this.itemsPanel.visible = false;
         }
         this.coinsPanel = new CoinsPanel();
         this.coinsPanel.x = this.coinsPanel.y = 4;
         if(Utils.IS_IPHONE_X)
         {
            this.coinsPanel.x = Utils.X_SCREEN_MARGIN;
            this.coinsPanel.y = 5;
         }
         if(this.IS_FISHING_LEVEL)
         {
            this.timeImage = new Image(TextureManager.hudTextureAtlas.getTexture("time_icon_1"));
            this.timeImage.touchable = false;
            this.container.addChild(this.timeImage);
            if(Utils.IS_IPHONE_X)
            {
               this.timeImage.x = Utils.WIDTH - this.timeImage.width - Utils.X_SCREEN_MARGIN;
            }
            else
            {
               this.timeImage.x = Utils.WIDTH - this.timeImage.width - 4;
            }
            this.timeImage.y = this.coinsPanel.y;
            this.timeImage.alpha = 0;
         }
         else
         {
            this.timeImage = null;
         }
         this.coinsPanel.alpha = 0;
         this.container.addChild(this.coinsPanel);
         if(this.IS_FISHING_LEVEL)
         {
            this.bestTime = new GameText(StringsManager.GetString("fishing_points"),GameText.TYPE_SMALL_WHITE);
         }
         else
         {
            this.bestTime = new GameText(StringsManager.GetString("best_time"),GameText.TYPE_SMALL_WHITE);
         }
         this.bestTime.pivotX = int(0);
         this.bestTime.pivotY = int(this.bestTime.HEIGHT * 0.5);
         this.bestTime.x = int(Utils.WIDTH * 0.5 - (this.bestTime.WIDTH + 8));
         this.bestTime.y = int(Utils.HEIGHT * 0.8);
         this.bestTime.alpha = 0;
         this.container.addChild(this.bestTime);
         this.bestTimeValue = new GameText(this.getTimeString(),GameText.TYPE_SMALL_WHITE);
         this.bestTimeValue.pivotX = int(0);
         this.bestTimeValue.pivotY = int(this.bestTimeValue.HEIGHT * 0.5);
         this.bestTimeValue.x = int(this.bestTime.x + this.bestTime.WIDTH + 16);
         this.bestTimeValue.y = int(Utils.HEIGHT * 0.8);
         this.bestTimeValue.alpha = 0;
         this.container.addChild(this.bestTimeValue);
         var total_length:int = this.bestTimeValue.x + this.bestTimeValue.WIDTH - this.bestTime.x;
         var center_amount:int = int((Utils.WIDTH - total_length) * 0.5);
         this.bestTime.x = int(center_amount);
         this.bestTimeValue.x = int(this.bestTime.x + this.bestTime.WIDTH + 16);
      }
      
      public function exitState(game:Game) : void
      {
         if(this.houseImage != null)
         {
            this.houseImage.dispose();
            this.houseImage = null;
         }
         if(this.timeImage != null)
         {
            this.container.addChild(this.timeImage);
            this.timeImage.dispose();
            this.timeImage = null;
         }
         this.container.removeChild(this.coinsPanel);
         this.coinsPanel.destroy();
         this.coinsPanel.dispose();
         this.coinsPanel = null;
         this.container.removeChild(this.bestTimeValue);
         this.bestTimeValue.destroy();
         this.bestTimeValue.dispose();
         this.bestTimeValue = null;
         this.container.removeChild(this.bestTime);
         this.bestTime.destroy();
         this.bestTime.dispose();
         this.bestTime = null;
         this.container.removeChild(this.itemsPanel);
         this.itemsPanel.destroy();
         this.itemsPanel.dispose();
         this.itemsPanel = null;
         this.container.removeChild(this.levelTitleText);
         this.levelTitleText.destroy();
         this.levelTitleText.dispose();
         this.levelTitleText = null;
         this.container.removeChild(this.levelText);
         this.levelText.destroy();
         this.levelText.dispose();
         this.levelText = null;
         this.container.removeChild(this.redPanel);
         this.redPanel.destroy();
         this.redPanel.dispose();
         this.redPanel = null;
         Utils.rootMovie.removeChild(this.container);
         this.container.dispose();
         this.container = null;
      }
      
      protected function getLevelString() : String
      {
         var string:String = StringsManager.GetString("level_world");
         var world_index:int = 1;
         if(Utils.CurrentLevel <= 8 || Utils.CurrentLevel == 251)
         {
            world_index = 1;
         }
         else if(Utils.CurrentLevel > 8 && Utils.CurrentLevel <= 16 || Utils.CurrentLevel == 252)
         {
            world_index = 2;
         }
         else if(Utils.CurrentLevel > 16 && Utils.CurrentLevel <= 24 || Utils.CurrentLevel == 253)
         {
            world_index = 3;
         }
         else if(Utils.CurrentLevel > 24 && Utils.CurrentLevel <= 32 || Utils.CurrentLevel == 254)
         {
            world_index = 4;
         }
         else if(Utils.CurrentLevel > 32 && Utils.CurrentLevel <= 40 || Utils.CurrentLevel == 255)
         {
            world_index = 5;
         }
         else if(Utils.CurrentLevel > 40 && Utils.CurrentLevel <= 48 || Utils.CurrentLevel == 256)
         {
            world_index = 6;
         }
         if(Utils.CurrentLevel == LevelState.LEVEL_1_FISHING)
         {
            world_index = 1;
         }
         else if(Utils.CurrentLevel == LevelState.LEVEL_2_FISHING)
         {
            world_index = 2;
         }
         var level_index:int = Utils.CurrentLevel - (world_index - 1) * 8;
         if(Utils.CurrentLevel == 5 || Utils.CurrentLevel == 13 || Utils.CurrentLevel == 21 || Utils.CurrentLevel == 29 || Utils.CurrentLevel == 37 || Utils.CurrentLevel == 45)
         {
            if(Utils.EnableFontStrings)
            {
               string += " " + world_index + "-";
               this.houseImage = new Image(TextureManager.hudTextureAtlas.getTexture("titleFont_42"));
            }
            else
            {
               string += " " + world_index + "-*";
            }
         }
         else if(Utils.CurrentLevel == 8 || Utils.CurrentLevel == 16 || Utils.CurrentLevel == 24 || Utils.CurrentLevel == 32 || Utils.CurrentLevel == 40)
         {
            string += " " + world_index + "-^";
         }
         else if(Utils.CurrentLevel >= 251 && Utils.CurrentLevel <= 256)
         {
            string += " " + world_index + "-?";
         }
         else if(this.IS_FISHING_LEVEL)
         {
            string += " " + world_index + "-~";
         }
         else if(level_index == 6 || level_index == 7)
         {
            string += " " + world_index + "-" + (level_index - 1);
         }
         else
         {
            string += " " + world_index + "-" + level_index;
         }
         return string;
      }
      
      protected function getTimeString() : String
      {
         var best_time:int = 0;
         if(this.IS_FISHING_LEVEL)
         {
            best_time = int(Utils.Slot.gameVariables[GameSlot.VARIABLE_FISHING_POINTS]);
         }
         else
         {
            best_time = int(Utils.Slot.levelTime[Utils.CurrentLevel - 1]);
         }
         return Utils.GetFormattedTimeString(best_time);
      }
   }
}
