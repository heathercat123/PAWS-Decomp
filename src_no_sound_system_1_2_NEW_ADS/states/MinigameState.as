package states
{
   import game_utils.GameSlot;
   import game_utils.LevelTimer;
   import interfaces.panels.PausePanel;
   import minigames.*;
   
   public class MinigameState implements IState
   {
       
      
      public var GET_OUT_FLAG:Boolean;
      
      public var choice:int;
      
      protected var counter_1:int;
      
      protected var minigame:Minigame;
      
      protected var CURRENT_STATE:int;
      
      public var pausePanel:PausePanel;
      
      public function MinigameState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         this.GET_OUT_FLAG = false;
         this.choice = -1;
         this.CURRENT_STATE = 0;
         if(Utils.MINIGAME_ID == 1)
         {
            this.minigame = new GachaponMinigame();
         }
         else if(Utils.MINIGAME_ID == 2)
         {
            this.minigame = new FlappyBatMinigame();
         }
         else
         {
            this.minigame = new MegaPangMinigame();
         }
         this.minigame.init();
         this.pausePanel = new PausePanel();
         SoundSystem.PlayMusic("arcade_start");
         game.enterMinigameState();
      }
      
      public function updateState(game:Game) : void
      {
         if(this.CURRENT_STATE == 0)
         {
            this.minigame.update();
            if(this.minigame.GET_OUT_FLAG && this.choice < 0)
            {
               this.getOut();
            }
            else if(Utils.PauseOn)
            {
               this.pauseState();
            }
         }
         else if(this.CURRENT_STATE == 1)
         {
            this.pausePanel.update();
            if(this.pausePanel.GET_OUT_FLAG)
            {
               if(this.pausePanel.CONTINUE_FLAG)
               {
                  this.pausePanel.hide();
                  LevelTimer.getInstance().endPause();
                  Utils.PauseOn = false;
                  this.playState();
               }
               else if(this.pausePanel.QUIT_FLAG)
               {
                  this.getOut();
               }
            }
         }
         else if(this.CURRENT_STATE == 2)
         {
            this.minigame.update();
         }
         game.updateMinigameState();
      }
      
      protected function getOut() : void
      {
         this.CURRENT_STATE = 2;
         this.GET_OUT_FLAG = true;
         this.choice = 0;
         Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_5_9;
         if(Utils.MINIGAME_ID == 1)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 4;
         }
         else if(Utils.MINIGAME_ID == 2)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 5;
         }
         else
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 3;
         }
      }
      
      protected function pauseState() : void
      {
         this.CURRENT_STATE = 1;
         if(Utils.IS_ANDROID)
         {
            this.pausePanel.destroy();
            this.pausePanel.dispose();
            this.pausePanel = null;
            this.pausePanel = new PausePanel();
         }
         this.pausePanel.popUp();
         LevelTimer.getInstance().startPause();
      }
      
      protected function playState() : void
      {
         this.CURRENT_STATE = 0;
      }
      
      public function exitState(game:Game) : void
      {
         this.minigame.destroy();
         this.minigame = null;
         this.pausePanel.destroy();
         this.pausePanel.dispose();
         this.pausePanel = null;
         game.exitMinigameState();
      }
   }
}
