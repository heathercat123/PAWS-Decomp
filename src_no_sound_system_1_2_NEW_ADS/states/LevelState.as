package states
{
   import flash.desktop.NativeApplication;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.net.*;
   import flash.ui.Keyboard;
   import game_utils.AchievementsManager;
   import game_utils.AnalyticsManager;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.LevelTimer;
   import game_utils.RoomsManager;
   import game_utils.SaveManager;
   import game_utils.StateMachine;
   import interfaces.panels.*;
   import interfaces.panels.shop.ShopPanel;
   import levels.*;
   import levels.worlds.fishing.Level_1_Fishing;
   import levels.worlds.fishing.Level_2_Fishing;
   import levels.worlds.world1.*;
   import levels.worlds.world2.*;
   
   public class LevelState implements IState
   {
      
      public static const LEVEL_1_1_1:int = 0;
      
      public static const LEVEL_1_1_2:int = 1;
      
      public static const LEVEL_1_1_3:int = 2;
      
      public static const LEVEL_1_1_4:int = 3;
      
      public static const LEVEL_1_1_5:int = 4;
      
      public static const LEVEL_1_2_1:int = 5;
      
      public static const LEVEL_1_2_2:int = 6;
      
      public static const LEVEL_1_2_3:int = 7;
      
      public static const LEVEL_1_2_4:int = 8;
      
      public static const LEVEL_1_2_5:int = 9;
      
      public static const LEVEL_1_2_6:int = 10;
      
      public static const LEVEL_1_3_1:int = 11;
      
      public static const LEVEL_1_3_2:int = 12;
      
      public static const LEVEL_1_3_3:int = 13;
      
      public static const LEVEL_1_3_4:int = 14;
      
      public static const LEVEL_1_3_5:int = 15;
      
      public static const LEVEL_1_3_6:int = 117;
      
      public static const LEVEL_1_4_1:int = 16;
      
      public static const LEVEL_1_4_2:int = 17;
      
      public static const LEVEL_1_4_3:int = 18;
      
      public static const LEVEL_1_4_4:int = 19;
      
      public static const LEVEL_1_4_5:int = 20;
      
      public static const LEVEL_1_4_6:int = 104;
      
      public static const LEVEL_1_4_7:int = 105;
      
      public static const LEVEL_1_4_8:int = 106;
      
      public static const LEVEL_1_4_9:int = 107;
      
      public static const LEVEL_1_5_1:int = 21;
      
      public static const LEVEL_1_5_2:int = 22;
      
      public static const LEVEL_1_5_3:int = 23;
      
      public static const LEVEL_1_5_4:int = 24;
      
      public static const LEVEL_1_5_5:int = 25;
      
      public static const LEVEL_1_5_6:int = 26;
      
      public static const LEVEL_1_5_7:int = 27;
      
      public static const LEVEL_1_5_8:int = 85;
      
      public static const LEVEL_1_5_9:int = 86;
      
      public static const LEVEL_1_5_10:int = 87;
      
      public static const LEVEL_1_5_11:int = 108;
      
      public static const LEVEL_1_5_12:int = 109;
      
      public static const LEVEL_1_5_13:int = 110;
      
      public static const LEVEL_1_6_1:int = 28;
      
      public static const LEVEL_1_6_2:int = 29;
      
      public static const LEVEL_1_6_3:int = 30;
      
      public static const LEVEL_1_6_4:int = 31;
      
      public static const LEVEL_1_6_5:int = 32;
      
      public static const LEVEL_1_6_6:int = 33;
      
      public static const LEVEL_1_7_1:int = 34;
      
      public static const LEVEL_1_7_2:int = 35;
      
      public static const LEVEL_1_7_3:int = 36;
      
      public static const LEVEL_1_7_4:int = 37;
      
      public static const LEVEL_1_7_5:int = 111;
      
      public static const LEVEL_1_8_1:int = 38;
      
      public static const LEVEL_1_8_2:int = 39;
      
      public static const LEVEL_1_8_3:int = 40;
      
      public static const LEVEL_1_8_4:int = 41;
      
      public static const LEVEL_1_8_5:int = 42;
      
      public static const LEVEL_1_8_6:int = 43;
      
      public static const LEVEL_2_1_1:int = 44;
      
      public static const LEVEL_2_1_2:int = 45;
      
      public static const LEVEL_2_1_3:int = 46;
      
      public static const LEVEL_2_1_4:int = 47;
      
      public static const LEVEL_2_1_5:int = 48;
      
      public static const LEVEL_2_2_1:int = 49;
      
      public static const LEVEL_2_2_2:int = 50;
      
      public static const LEVEL_2_2_3:int = 51;
      
      public static const LEVEL_2_2_4:int = 52;
      
      public static const LEVEL_2_2_5:int = 53;
      
      public static const LEVEL_2_3_1:int = 54;
      
      public static const LEVEL_2_3_2:int = 55;
      
      public static const LEVEL_2_3_3:int = 56;
      
      public static const LEVEL_2_3_4:int = 57;
      
      public static const LEVEL_2_3_5:int = 58;
      
      public static const LEVEL_2_3_6:int = 59;
      
      public static const LEVEL_2_3_7:int = 60;
      
      public static const LEVEL_2_3_8:int = 61;
      
      public static const LEVEL_2_4_1:int = 62;
      
      public static const LEVEL_2_4_2:int = 63;
      
      public static const LEVEL_2_4_3:int = 64;
      
      public static const LEVEL_2_4_4:int = 65;
      
      public static const LEVEL_2_4_5:int = 66;
      
      public static const LEVEL_2_4_6:int = 67;
      
      public static const LEVEL_2_4_7:int = 68;
      
      public static const LEVEL_2_4_8:int = 69;
      
      public static const LEVEL_2_4_9:int = 112;
      
      public static const LEVEL_2_5_1:int = 70;
      
      public static const LEVEL_2_5_2:int = 71;
      
      public static const LEVEL_2_5_3:int = 72;
      
      public static const LEVEL_2_5_4:int = 73;
      
      public static const LEVEL_2_5_5:int = 74;
      
      public static const LEVEL_2_5_6:int = 75;
      
      public static const LEVEL_2_5_7:int = 76;
      
      public static const LEVEL_2_5_8:int = 77;
      
      public static const LEVEL_2_5_9:int = 78;
      
      public static const LEVEL_2_5_10:int = 79;
      
      public static const LEVEL_2_5_11:int = 100;
      
      public static const LEVEL_2_5_12:int = 101;
      
      public static const LEVEL_2_5_13:int = 102;
      
      public static const LEVEL_2_5_14:int = 103;
      
      public static const LEVEL_2_5_15:int = 113;
      
      public static const LEVEL_2_6_1:int = 80;
      
      public static const LEVEL_2_6_2:int = 81;
      
      public static const LEVEL_2_6_3:int = 82;
      
      public static const LEVEL_2_6_4:int = 83;
      
      public static const LEVEL_2_6_5:int = 84;
      
      public static const LEVEL_2_6_6:int = 114;
      
      public static const LEVEL_2_6_7:int = 115;
      
      public static const LEVEL_2_7_1:int = 88;
      
      public static const LEVEL_2_7_2:int = 89;
      
      public static const LEVEL_2_7_3:int = 90;
      
      public static const LEVEL_2_7_4:int = 91;
      
      public static const LEVEL_2_7_5:int = 92;
      
      public static const LEVEL_2_8_1:int = 93;
      
      public static const LEVEL_2_8_2:int = 94;
      
      public static const LEVEL_2_8_3:int = 95;
      
      public static const LEVEL_2_8_4:int = 96;
      
      public static const LEVEL_2_8_5:int = 97;
      
      public static const LEVEL_2_8_6:int = 98;
      
      public static const LEVEL_2_8_7:int = 99;
      
      public static const LEVEL_2_8_8:int = 116;
      
      public static const LEVEL_3_1_1:int = 69;
      
      public static const LEVEL_3_1_2:int = 70;
      
      public static const LEVEL_3_1_3:int = 71;
      
      public static const LEVEL_3_1_4:int = 72;
      
      public static const LEVEL_3_1_5:int = 73;
      
      public static const LEVEL_3_2_1:int = 74;
      
      public static const LEVEL_3_2_2:int = 75;
      
      public static const LEVEL_3_2_3:int = 76;
      
      public static const LEVEL_3_2_4:int = 77;
      
      public static const LEVEL_3_3_1:int = 78;
      
      public static const LEVEL_3_3_2:int = 79;
      
      public static const LEVEL_3_3_3:int = 80;
      
      public static const LEVEL_3_4_1:int = 81;
      
      public static const LEVEL_3_4_2:int = 82;
      
      public static const LEVEL_3_4_3:int = 83;
      
      public static const LEVEL_3_4_4:int = 110;
      
      public static const LEVEL_3_5_1:int = 84;
      
      public static const LEVEL_3_5_2:int = 85;
      
      public static const LEVEL_3_5_3:int = 86;
      
      public static const LEVEL_3_5_4:int = 87;
      
      public static const LEVEL_3_5_5:int = 88;
      
      public static const LEVEL_3_5_6:int = 89;
      
      public static const LEVEL_3_6_1:int = 90;
      
      public static const LEVEL_3_6_2:int = 91;
      
      public static const LEVEL_3_6_3:int = 92;
      
      public static const LEVEL_3_6_4:int = 93;
      
      public static const LEVEL_3_7_1:int = 94;
      
      public static const LEVEL_3_7_2:int = 95;
      
      public static const LEVEL_3_7_3:int = 96;
      
      public static const LEVEL_3_7_4:int = 97;
      
      public static const LEVEL_3_7_5:int = 98;
      
      public static const LEVEL_3_8_1:int = 99;
      
      public static const LEVEL_3_8_2:int = 100;
      
      public static const LEVEL_3_8_3:int = 103;
      
      public static const LEVEL_3_8_4:int = 104;
      
      public static const LEVEL_3_8_5:int = 105;
      
      public static const LEVEL_3_8_6:int = 106;
      
      public static const LEVEL_3_8_7:int = 107;
      
      public static const LEVEL_3_8_8:int = 108;
      
      public static const LEVEL_3_8_9:int = 109;
      
      public static const LEVEL_1_SECRET_1:int = 1140;
      
      public static const LEVEL_1_SECRET_2:int = 1141;
      
      public static const LEVEL_1_SECRET_3:int = 1142;
      
      public static const LEVEL_2_SECRET_1:int = 1170;
      
      public static const LEVEL_2_SECRET_2:int = 1171;
      
      public static const LEVEL_2_SECRET_3:int = 1172;
      
      public static const LEVEL_3_SECRET_1:int = 1200;
      
      public static const LEVEL_3_SECRET_2:int = 1210;
      
      public static const LEVEL_3_SECRET_3:int = 1220;
      
      public static const LEVEL_3_SECRET_4:int = 1230;
      
      public static const LEVEL_1_FISHING:int = 10000;
      
      public static const LEVEL_2_FISHING:int = 10001;
      
      public static const LEVEL_3_FISHING:int = 10002;
       
      
      public var GET_OUT_FLAG:Boolean;
      
      public var choice:int;
      
      public var level:Level;
      
      public var stateMachine:StateMachine;
      
      public var pausePanel:PausePanel;
      
      public var catPanel:CatPanel;
      
      public var ratePanel:RatePanel;
      
      public var shopPanel:ShopPanel;
      
      public var gameOverPanel:GameOverPanel;
      
      public var doubleCoinsPanel:DoubleCoinsPanel;
      
      protected var FORCE_PAUSE_COUNTER:int;
      
      public function LevelState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         this.FORCE_PAUSE_COUNTER = -1;
         Utils.PERFECT_ROOM = true;
         this.level = this.getLevel();
         this.choice = -1;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_INIT_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","PAUSE_ACTION","IS_PAUSED_STATE");
         this.stateMachine.setRule("IS_PAUSED_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_PAUSED_STATE","QUIT_ACTION","IS_EXITING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","SHOP_ACTION","IS_SHOP_STATE");
         this.stateMachine.setRule("IS_SHOP_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","CAT_ACTION","IS_CAT_STATE");
         this.stateMachine.setRule("IS_CAT_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","GATE_PURCHASE_ACTION","IS_GATE_PURCHASE_STATE");
         this.stateMachine.setRule("IS_GATE_PURCHASE_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","GOLDEN_CAT_ACTION","IS_GOLDEN_CAT_STATE");
         this.stateMachine.setRule("IS_GOLDEN_CAT_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","RATE_ACTION","IS_RATE_STATE");
         this.stateMachine.setRule("IS_RATE_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","MINIGAME_ACTION","IS_MINIGAME_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","REWARD_ADS_ACTION","IS_REWARD_AD_STATE");
         this.stateMachine.setRule("IS_REWARD_AD_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","DOUBLE_COINS_ACTION","IS_DOUBLE_COINS_STATE");
         this.stateMachine.setRule("IS_DOUBLE_COINS_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","LEVEL_WON_ACTION","IS_LEVEL_COMPLETE_STATE");
         this.stateMachine.setRule("IS_LEVEL_COMPLETE_STATE","QUIT_ACTION","IS_EXITING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","LEVEL_EXIT_ACTION","IS_LEVEL_EXIT_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","CHANGE_ROOM_ACTION","IS_CHANGING_ROOM_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","GAME_OVER_ACTION","IS_GAME_OVER_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","REPEAT_ROOM_ACTION","IS_LEVEL_REPEAT_STATE");
         this.stateMachine.setFunctionToState("IS_INIT_STATE",this.initState);
         this.stateMachine.setFunctionToState("IS_UPDATING_STATE",this.updateLevelState);
         this.stateMachine.setFunctionToState("IS_PAUSED_STATE",this.pauseState);
         this.stateMachine.setFunctionToState("IS_SHOP_STATE",this.shopState);
         this.stateMachine.setFunctionToState("IS_CAT_STATE",this.catState);
         this.stateMachine.setFunctionToState("IS_GATE_PURCHASE_STATE",this.gatePurchaseState);
         this.stateMachine.setFunctionToState("IS_GOLDEN_CAT_STATE",this.goldenCatState);
         this.stateMachine.setFunctionToState("IS_RATE_STATE",this.rateState);
         this.stateMachine.setFunctionToState("IS_DOUBLE_COINS_STATE",this.doubleCoinsState);
         this.stateMachine.setFunctionToState("IS_REWARD_AD_STATE",this.rewardAdState);
         this.stateMachine.setFunctionToState("IS_LEVEL_COMPLETE_STATE",this.levelCompleteState);
         this.stateMachine.setFunctionToState("IS_MINIGAME_STATE",this.minigameState);
         this.stateMachine.setFunctionToState("IS_LEVEL_EXIT_STATE",this.levelExitState);
         this.stateMachine.setFunctionToState("IS_LEVEL_REPEAT_STATE",this.levelRepeatState);
         this.stateMachine.setFunctionToState("IS_GAME_OVER_STATE",this.gameOverState);
         this.stateMachine.setFunctionToState("IS_CHANGING_ROOM_STATE",this.changeRoomState);
         this.stateMachine.setFunctionToState("IS_EXITING_STATE",this.exitLevelState);
         this.stateMachine.setState("IS_INIT_STATE");
         game.enterLevelState();
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         }
      }
      
      protected function onKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == Keyboard.BACK)
         {
            event.preventDefault();
            event.stopImmediatePropagation();
            if(this.stateMachine.currentState == "IS_PAUSED_STATE")
            {
               this.pausePanel.continuePanel();
            }
            else if(this.stateMachine.currentState == "IS_SHOP_STATE")
            {
               this.shopPanel.backButtonAndroid();
            }
            else if(this.stateMachine.currentState == "IS_CAT_STATE")
            {
               this.catPanel.backButtonAndroid();
            }
            else if(this.stateMachine.currentState == "IS_RATE_STATE")
            {
               this.ratePanel.backButtonAndroid();
            }
            else if(this.stateMachine.currentState == "IS_UPDATING_STATE")
            {
               if(this.level.soundHud.hudPanel.pauseButton.touchable)
               {
                  Utils.PauseOn = true;
               }
            }
            else if(this.stateMachine.currentState == "IS_REWARD_AD_STATE")
            {
               this.gameOverPanel.backButtonAndroid();
            }
            else if(this.stateMachine.currentState == "IS_DOUBLE_COINS_STATE")
            {
               this.doubleCoinsPanel.backButtonAndroid();
            }
         }
      }
      
      public function onChangeContext(event:Event) : void
      {
      }
      
      public function exitState(game:Game) : void
      {
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.shopPanel.destroy();
         this.shopPanel.dispose();
         this.shopPanel = null;
         this.pausePanel.destroy();
         this.pausePanel.dispose();
         this.pausePanel = null;
         this.catPanel.destroy();
         this.catPanel.dispose();
         this.catPanel = null;
         this.gameOverPanel.destroy();
         this.gameOverPanel.dispose();
         this.gameOverPanel = null;
         this.ratePanel.destroy();
         this.ratePanel.dispose();
         this.ratePanel = null;
         this.level.exitLevel();
         this.level = null;
         game.exitLevelState();
      }
      
      public function updateState(game:Game) : void
      {
         if(this.FORCE_PAUSE_COUNTER > -1)
         {
            ++this.FORCE_PAUSE_COUNTER;
            if(this.FORCE_PAUSE_COUNTER == 20)
            {
               this.FORCE_PAUSE_COUNTER = -1;
               Utils.StartPause();
               Utils.CheckPause = true;
            }
         }
         if(this.stateMachine.currentState != "IS_INIT_STATE")
         {
            if(this.stateMachine.currentState == "IS_UPDATING_STATE")
            {
               this.level.update();
               if(Utils.PauseOn)
               {
                  this.stateMachine.performAction("PAUSE_ACTION");
               }
               else if(Utils.CatOn)
               {
                  this.stateMachine.performAction("CAT_ACTION");
               }
               else if(Utils.ShopOn)
               {
                  this.stateMachine.performAction("SHOP_ACTION");
               }
               else if(Utils.RateOn)
               {
                  this.stateMachine.performAction("RATE_ACTION");
               }
               else if(Utils.GameOverOn && !Utils.IsInstaGameOver)
               {
                  this.stateMachine.performAction("REWARD_ADS_ACTION");
               }
               else if(Utils.DoubleCoinsOn)
               {
                  this.stateMachine.performAction("DOUBLE_COINS_ACTION");
               }
               else if(this.level.LEVEL_WON_FLAG)
               {
                  this.stateMachine.performAction("LEVEL_WON_ACTION");
               }
               else if(this.level.EXIT_FLAG)
               {
                  this.stateMachine.performAction("LEVEL_EXIT_ACTION");
               }
               else if(this.level.CHANGE_ROOM_FLAG)
               {
                  this.stateMachine.performAction("CHANGE_ROOM_ACTION");
               }
               else if(this.level.MINIGAME_FLAG)
               {
                  this.stateMachine.performAction("MINIGAME_ACTION");
               }
               else if(this.level.GAME_OVER_FLAG)
               {
                  if(Utils.IsInstaGameOver)
                  {
                     Utils.LEVEL_LOCAL_PROGRESSION_1 = 0;
                     this.stateMachine.performAction("REPEAT_ROOM_ACTION");
                  }
                  else
                  {
                     this.stateMachine.performAction("GAME_OVER_ACTION");
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_PAUSED_STATE")
            {
               this.FORCE_PAUSE_COUNTER = -1;
               this.pausePanel.update();
               if(this.pausePanel.GET_OUT_FLAG)
               {
                  if(this.pausePanel.CONTINUE_FLAG)
                  {
                     this.pausePanel.hide();
                     if(this.level.stateMachine.currentState == "IS_PLAYING_STATE")
                     {
                        LevelTimer.getInstance().endPause();
                     }
                     Utils.PauseOn = false;
                     this.stateMachine.performAction("END_ACTION");
                  }
                  else if(this.pausePanel.QUIT_FLAG)
                  {
                     this.choice = 1;
                     AnalyticsManager.TrackEvent("level","quit",Utils.CurrentLevel);
                     this.stateMachine.performAction("QUIT_ACTION");
                  }
                  else if(this.pausePanel.REPEAT_FLAG)
                  {
                     this.choice = 2;
                     this.stateMachine.performAction("QUIT_ACTION");
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_SHOP_STATE")
            {
               this.shopPanel.update();
               if(this.shopPanel.GET_OUT_FLAG)
               {
                  this.shopPanel.hide();
                  Utils.ShopOn = false;
                  Utils.PauseOn = false;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState == "IS_CAT_STATE")
            {
               this.catPanel.update();
               if(this.catPanel.GET_OUT_FLAG)
               {
                  this.catPanel.hide();
                  if(this.level.stateMachine.currentState == "IS_PLAYING_STATE")
                  {
                     LevelTimer.getInstance().endPause();
                  }
                  Utils.CatOn = false;
                  this.level.changeCat(this.catPanel.CAT_INDEX);
                  this.level.update();
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState != "IS_GATE_PURCHASE_STATE")
            {
               if(this.stateMachine.currentState != "IS_GOLDEN_CAT_STATE")
               {
                  if(this.stateMachine.currentState == "IS_RATE_STATE")
                  {
                     this.ratePanel.update();
                     if(this.ratePanel.GET_OUT_FLAG)
                     {
                        this.ratePanel.hide();
                        if(this.level.stateMachine.currentState == "IS_PLAYING_STATE")
                        {
                           LevelTimer.getInstance().endPause();
                        }
                        Utils.RateOn = false;
                        this.stateMachine.performAction("END_ACTION");
                     }
                  }
                  else if(this.stateMachine.currentState == "IS_DOUBLE_COINS_STATE")
                  {
                     this.doubleCoinsPanel.update();
                     if(this.doubleCoinsPanel.GET_OUT_FLAG)
                     {
                        if(this.doubleCoinsPanel.CONTINUE_FLAG)
                        {
                           this.level.hero.doubleCoins();
                        }
                        this.doubleCoinsPanel.hide();
                        Utils.DoubleCoinsOn = false;
                        this.stateMachine.performAction("END_ACTION");
                     }
                  }
                  else if(this.stateMachine.currentState == "IS_REWARD_AD_STATE")
                  {
                     this.gameOverPanel.update();
                     if(this.gameOverPanel.GET_OUT_FLAG)
                     {
                        if(this.gameOverPanel.CONTINUE_FLAG)
                        {
                           if(Utils.IsEvent)
                           {
                              this.level.allowEvent();
                           }
                           else
                           {
                              this.level.hero.revive();
                           }
                        }
                        this.gameOverPanel.hide();
                        if(this.level.stateMachine.currentState == "IS_PLAYING_STATE")
                        {
                           LevelTimer.getInstance().endPause();
                        }
                        Utils.GameOverOn = false;
                        this.stateMachine.performAction("END_ACTION");
                     }
                  }
                  else if(this.stateMachine.currentState == "IS_LEVEL_COMPLETE_STATE")
                  {
                     this.level.update();
                     this.choice = 3;
                     this.stateMachine.performAction("QUIT_ACTION");
                  }
                  else if(this.stateMachine.currentState == "IS_GAME_OVER_STATE" || this.stateMachine.currentState == "IS_LEVEL_EXIT_STATE" || this.stateMachine.currentState == "IS_CHANGING_ROOM_STATE")
                  {
                     this.level.update();
                  }
                  else if(this.stateMachine.currentState == "IS_EXITING_STATE")
                  {
                     if(this.choice == 3)
                     {
                        this.level.update();
                     }
                  }
               }
            }
         }
         game.updateLevelState();
      }
      
      public function updateSlotDataAndSave() : void
      {
         var perc__:Number = NaN;
         SettingsPanel.iCloudRestoreCoins();
         if(this.level.SECRET_EXIT >= 1)
         {
            Utils.IS_SECRET_EXIT = true;
         }
         else
         {
            Utils.IS_SECRET_EXIT = false;
         }
         if(!Utils.IS_SECRET_EXIT)
         {
            if(Utils.GetLevelTimeSeconds() < Utils.Slot.levelTime[Utils.CurrentLevel - 1] || Utils.Slot.levelTime[Utils.CurrentLevel - 1] < 0)
            {
               Utils.Slot.levelTime[Utils.CurrentLevel - 1] = Utils.GetLevelTimeSeconds();
               Utils.IS_NEW_RECORD = true;
            }
            if(Utils.PERFECT_GAME)
            {
               Utils.Slot.levelPerfect[Utils.CurrentLevel - 1] = true;
            }
            this.submitScore();
         }
         LevelItems.AddBellsAndCoinsToInventory();
         Utils.Slot.levelItems[Utils.CurrentLevel - 1] |= Utils.PlayerItems;
         if(this.level.SECRET_EXIT == 1)
         {
            if(Utils.CurrentLevel == 3)
            {
               Utils.Slot.levelSeqUnlocked[250] = true;
            }
            else if(Utils.CurrentLevel == 11)
            {
               Utils.Slot.levelSeqUnlocked[251] = true;
            }
         }
         else if(this.level.SECRET_EXIT == 2)
         {
            if(Utils.CurrentLevel == 7)
            {
               Utils.Slot.levelSeqUnlocked[801] = true;
            }
            else if(Utils.CurrentLevel == 13)
            {
               Utils.Slot.levelSeqUnlocked[802] = true;
            }
         }
         else if(!this.level.IS_SECRET_LEVEL)
         {
            Utils.Slot.levelSeqUnlocked[Utils.CurrentLevel] = true;
         }
         SaveManager.SaveSlot();
         if(Utils.Slot.playerInventory[LevelItems.ITEM_BELL] >= 50)
         {
            AchievementsManager.SubmitAchievement("BELLS_1",100);
         }
         else
         {
            perc__ = Utils.Slot.playerInventory[LevelItems.ITEM_BELL] * 100 / 50;
            AchievementsManager.SubmitAchievement("BELLS_1",perc__);
         }
         SettingsPanel.iCloudSaveCoins();
      }
      
      protected function submitScore() : void
      {
         var i:int = 0;
         var perfect_levels_amount:int = 0;
         for(i = 0; i < 50; i++)
         {
            if(Utils.Slot.levelPerfect[i])
            {
               perfect_levels_amount++;
            }
         }
         if(perfect_levels_amount >= 5)
         {
            AchievementsManager.SubmitAchievement("sctp_6");
         }
         if(perfect_levels_amount >= 10)
         {
            AchievementsManager.SubmitAchievement("sctp_7");
         }
         if(perfect_levels_amount >= 15)
         {
            AchievementsManager.SubmitAchievement("sctp_8");
         }
      }
      
      protected function getIOSLeaderboardName() : String
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            return "superCatTales2_world1";
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            return "superCatTales2_world2";
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 2)
         {
            return "superCatTales2_world3";
         }
         return "";
      }
      
      protected function getAndroidLeaderboardName() : String
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            return "CgkI886JwPMDEAIQAQ";
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            return "CgkI886JwPMDEAIQAg";
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 2)
         {
            return "CgkI886JwPMDEAIQAw";
         }
         return "";
      }
      
      protected function getAmazonLeaderboardName() : String
      {
         return "";
      }
      
      protected function initState() : void
      {
         this.pausePanel = new PausePanel();
         this.catPanel = new CatPanel();
         this.shopPanel = new ShopPanel(this.level);
         this.ratePanel = new RatePanel();
         this.ratePanel.level = this.level;
         this.gameOverPanel = new GameOverPanel();
         this.gameOverPanel.level = this.level;
         this.doubleCoinsPanel = new DoubleCoinsPanel();
         this.doubleCoinsPanel.level = this.level;
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function updateLevelState() : void
      {
      }
      
      protected function pauseState() : void
      {
         if(Utils.IS_ANDROID)
         {
            this.pausePanel.destroy();
            this.pausePanel.dispose();
            this.pausePanel = null;
            this.pausePanel = new PausePanel();
         }
         this.level.leftPressed = this.level.rightPressed = false;
         this.pausePanel.popUp();
         LevelTimer.getInstance().startPause();
      }
      
      protected function shopState() : void
      {
         this.shopPanel.popUp();
      }
      
      protected function catState() : void
      {
         this.catPanel.destroy();
         this.catPanel.dispose();
         this.catPanel = null;
         this.catPanel = new CatPanel();
         this.catPanel.popUp();
         LevelTimer.getInstance().startPause();
      }
      
      protected function gatePurchaseState() : void
      {
      }
      
      protected function goldenCatState() : void
      {
         LevelTimer.getInstance().startPause();
      }
      
      protected function rateState() : void
      {
         this.ratePanel.destroy();
         this.ratePanel.dispose();
         this.ratePanel = null;
         this.ratePanel = new RatePanel();
         this.ratePanel.level = this.level;
         this.ratePanel.popUp();
         LevelTimer.getInstance().startPause();
      }
      
      protected function doubleCoinsState() : void
      {
         this.doubleCoinsPanel.destroy();
         this.doubleCoinsPanel.dispose();
         this.doubleCoinsPanel = null;
         this.doubleCoinsPanel = new DoubleCoinsPanel();
         this.doubleCoinsPanel.level = this.level;
         this.doubleCoinsPanel.popUp();
      }
      
      protected function rewardAdState() : void
      {
         this.gameOverPanel.destroy();
         this.gameOverPanel.dispose();
         this.gameOverPanel = null;
         this.gameOverPanel = new GameOverPanel();
         this.gameOverPanel.level = this.level;
         this.gameOverPanel.popUp();
         LevelTimer.getInstance().startPause();
      }
      
      protected function levelCompleteState() : void
      {
      }
      
      protected function levelExitState() : void
      {
         this.GET_OUT_FLAG = true;
         this.choice = 1;
      }
      
      protected function minigameState() : void
      {
         this.GET_OUT_FLAG = true;
         this.choice = 5;
      }
      
      protected function levelRepeatState() : void
      {
         Utils.LEVEL_REPEAT_FLAG = true;
         this.GET_OUT_FLAG = true;
         this.choice = 0;
      }
      
      protected function gameOverState() : void
      {
         this.choice = 4;
         this.GET_OUT_FLAG = true;
      }
      
      protected function changeRoomState() : void
      {
         RoomsManager.EvaluateRoom();
         this.choice = 0;
         this.GET_OUT_FLAG = true;
      }
      
      protected function exitLevelState() : void
      {
         this.GET_OUT_FLAG = true;
      }
      
      protected function getLevel() : Level
      {
         var level_id:int = int(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL]);
         if(level_id == LEVEL_1_1_1)
         {
            return new Level_1_1(1);
         }
         if(level_id == LEVEL_1_1_2)
         {
            return new Level_1_1(2);
         }
         if(level_id == LEVEL_1_1_3)
         {
            return new Level_1_1(3);
         }
         if(level_id == LEVEL_1_1_4)
         {
            return new Level_1_1(4);
         }
         if(level_id == LEVEL_1_1_5)
         {
            return new Level_1_1(5);
         }
         if(level_id == LEVEL_1_2_1)
         {
            return new Level_1_2(1);
         }
         if(level_id == LEVEL_1_2_2)
         {
            return new Level_1_2(2);
         }
         if(level_id == LEVEL_1_2_3)
         {
            return new Level_1_2(3);
         }
         if(level_id == LEVEL_1_2_4)
         {
            return new Level_1_2(4);
         }
         if(level_id == LEVEL_1_3_1)
         {
            return new Level_1_3(1);
         }
         if(level_id == LEVEL_1_3_2)
         {
            return new Level_1_3(2);
         }
         if(level_id == LEVEL_1_3_3)
         {
            return new Level_1_3(3);
         }
         if(level_id == LEVEL_1_3_4)
         {
            return new Level_1_3(4);
         }
         if(level_id == LEVEL_1_3_5)
         {
            return new Level_1_3(5);
         }
         if(level_id == LEVEL_1_3_6)
         {
            return new Level_1_3(6);
         }
         if(level_id == LEVEL_1_4_1)
         {
            return new Level_1_4(1);
         }
         if(level_id == LEVEL_1_4_2)
         {
            return new Level_1_4(2);
         }
         if(level_id == LEVEL_1_4_3)
         {
            return new Level_1_4(3);
         }
         if(level_id == LEVEL_1_4_4)
         {
            return new Level_1_4(4);
         }
         if(level_id == LEVEL_1_4_5)
         {
            return new Level_1_4(5);
         }
         if(level_id == LEVEL_1_4_6)
         {
            return new Level_1_4(6);
         }
         if(level_id == LEVEL_1_4_7)
         {
            return new Level_1_4(7);
         }
         if(level_id == LEVEL_1_4_8)
         {
            return new Level_1_4(8);
         }
         if(level_id == LEVEL_1_4_9)
         {
            return new Level_1_4(9);
         }
         if(level_id == LEVEL_1_5_1)
         {
            return new Level_1_5(1);
         }
         if(level_id == LEVEL_1_5_2)
         {
            return new Level_1_5(2);
         }
         if(level_id == LEVEL_1_5_3)
         {
            return new Level_1_5(3);
         }
         if(level_id == LEVEL_1_5_4)
         {
            return new Level_1_5(4);
         }
         if(level_id == LEVEL_1_5_5)
         {
            return new Level_1_5(5);
         }
         if(level_id == LEVEL_1_5_6)
         {
            return new Level_1_5(6);
         }
         if(level_id == LEVEL_1_5_7)
         {
            return new Level_1_5(7);
         }
         if(level_id == LEVEL_1_5_8)
         {
            return new Level_1_5(8);
         }
         if(level_id == LEVEL_1_5_9)
         {
            return new Level_1_5(9);
         }
         if(level_id == LEVEL_1_5_10)
         {
            return new Level_1_5(10);
         }
         if(level_id == LEVEL_1_5_11)
         {
            return new Level_1_5(11);
         }
         if(level_id == LEVEL_1_5_12)
         {
            return new Level_1_5(12);
         }
         if(level_id == LEVEL_1_5_13)
         {
            return new Level_1_5(13);
         }
         if(level_id == LEVEL_1_6_1)
         {
            return new Level_1_6(1);
         }
         if(level_id == LEVEL_1_6_2)
         {
            return new Level_1_6(2);
         }
         if(level_id == LEVEL_1_6_3)
         {
            return new Level_1_6(3);
         }
         if(level_id == LEVEL_1_6_4)
         {
            return new Level_1_6(4);
         }
         if(level_id == LEVEL_1_6_5)
         {
            return new Level_1_6(5);
         }
         if(level_id == LEVEL_1_6_6)
         {
            return new Level_1_6(6);
         }
         if(level_id == LEVEL_1_7_1)
         {
            return new Level_1_7(1);
         }
         if(level_id == LEVEL_1_7_2)
         {
            return new Level_1_7(2);
         }
         if(level_id == LEVEL_1_7_3)
         {
            return new Level_1_7(3);
         }
         if(level_id == LEVEL_1_7_4)
         {
            return new Level_1_7(4);
         }
         if(level_id == LEVEL_1_7_5)
         {
            return new Level_1_7(5);
         }
         if(level_id == LEVEL_1_8_1)
         {
            return new Level_1_8(1);
         }
         if(level_id == LEVEL_1_8_2)
         {
            return new Level_1_8(2);
         }
         if(level_id == LEVEL_1_8_3)
         {
            return new Level_1_8(3);
         }
         if(level_id == LEVEL_1_8_4)
         {
            return new Level_1_8(4);
         }
         if(level_id == LEVEL_1_8_5)
         {
            return new Level_1_8(5);
         }
         if(level_id == LEVEL_1_8_6)
         {
            return new Level_1_8(6);
         }
         if(level_id == LEVEL_2_1_1)
         {
            return new Level_2_1(1);
         }
         if(level_id == LEVEL_2_1_2)
         {
            return new Level_2_1(2);
         }
         if(level_id == LEVEL_2_1_3)
         {
            return new Level_2_1(3);
         }
         if(level_id == LEVEL_2_1_4)
         {
            return new Level_2_1(4);
         }
         if(level_id == LEVEL_2_2_1)
         {
            return new Level_2_2(1);
         }
         if(level_id == LEVEL_2_2_2)
         {
            return new Level_2_2(2);
         }
         if(level_id == LEVEL_2_2_3)
         {
            return new Level_2_2(3);
         }
         if(level_id == LEVEL_2_2_4)
         {
            return new Level_2_2(4);
         }
         if(level_id == LEVEL_2_2_5)
         {
            return new Level_2_2(5);
         }
         if(level_id == LEVEL_2_3_1)
         {
            return new Level_2_3(1);
         }
         if(level_id == LEVEL_2_3_2)
         {
            return new Level_2_3(2);
         }
         if(level_id == LEVEL_2_3_3)
         {
            return new Level_2_3(3);
         }
         if(level_id == LEVEL_2_3_4)
         {
            return new Level_2_3(4);
         }
         if(level_id == LEVEL_2_3_5)
         {
            return new Level_2_3(5);
         }
         if(level_id == LEVEL_2_3_6)
         {
            return new Level_2_3(6);
         }
         if(level_id == LEVEL_2_3_7)
         {
            return new Level_2_3(7);
         }
         if(level_id == LEVEL_2_3_8)
         {
            return new Level_2_3(8);
         }
         if(level_id == LEVEL_2_4_1)
         {
            return new Level_2_4(1);
         }
         if(level_id == LEVEL_2_4_2)
         {
            return new Level_2_4(2);
         }
         if(level_id == LEVEL_2_4_3)
         {
            return new Level_2_4(3);
         }
         if(level_id == LEVEL_2_4_4)
         {
            return new Level_2_4(4);
         }
         if(level_id == LEVEL_2_4_5)
         {
            return new Level_2_4(5);
         }
         if(level_id == LEVEL_2_4_6)
         {
            return new Level_2_4(6);
         }
         if(level_id == LEVEL_2_4_7)
         {
            return new Level_2_4(7);
         }
         if(level_id == LEVEL_2_4_8)
         {
            return new Level_2_4(8);
         }
         if(level_id == LEVEL_2_4_9)
         {
            return new Level_2_4(9);
         }
         if(level_id == LEVEL_2_5_1)
         {
            return new Level_2_5(1);
         }
         if(level_id == LEVEL_2_5_2)
         {
            return new Level_2_5(2);
         }
         if(level_id == LEVEL_2_5_3)
         {
            return new Level_2_5(3);
         }
         if(level_id == LEVEL_2_5_4)
         {
            return new Level_2_5(4);
         }
         if(level_id == LEVEL_2_5_5)
         {
            return new Level_2_5(5);
         }
         if(level_id == LEVEL_2_5_6)
         {
            return new Level_2_5(6);
         }
         if(level_id == LEVEL_2_5_7)
         {
            return new Level_2_5(7);
         }
         if(level_id == LEVEL_2_5_8)
         {
            return new Level_2_5(8);
         }
         if(level_id == LEVEL_2_5_9)
         {
            return new Level_2_5(9);
         }
         if(level_id == LEVEL_2_5_10)
         {
            return new Level_2_5(10);
         }
         if(level_id == LEVEL_2_5_11)
         {
            return new Level_2_5(11);
         }
         if(level_id == LEVEL_2_5_12)
         {
            return new Level_2_5(12);
         }
         if(level_id == LEVEL_2_5_13)
         {
            return new Level_2_5(13);
         }
         if(level_id == LEVEL_2_5_14)
         {
            return new Level_2_5(14);
         }
         if(level_id == LEVEL_2_5_15)
         {
            return new Level_2_5(15);
         }
         if(level_id == LEVEL_2_6_1)
         {
            return new Level_2_6(1);
         }
         if(level_id == LEVEL_2_6_2)
         {
            return new Level_2_6(2);
         }
         if(level_id == LEVEL_2_6_3)
         {
            return new Level_2_6(3);
         }
         if(level_id == LEVEL_2_6_4)
         {
            return new Level_2_6(4);
         }
         if(level_id == LEVEL_2_6_5)
         {
            return new Level_2_6(5);
         }
         if(level_id == LEVEL_2_6_6)
         {
            return new Level_2_6(6);
         }
         if(level_id == LEVEL_2_6_7)
         {
            return new Level_2_6(7);
         }
         if(level_id == LEVEL_2_7_1)
         {
            return new Level_2_7(1);
         }
         if(level_id == LEVEL_2_7_2)
         {
            return new Level_2_7(2);
         }
         if(level_id == LEVEL_2_7_3)
         {
            return new Level_2_7(3);
         }
         if(level_id == LEVEL_2_7_4)
         {
            return new Level_2_7(4);
         }
         if(level_id == LEVEL_2_7_5)
         {
            return new Level_2_7(5);
         }
         if(level_id == LEVEL_2_8_1)
         {
            return new Level_2_8(1);
         }
         if(level_id == LEVEL_2_8_2)
         {
            return new Level_2_8(2);
         }
         if(level_id == LEVEL_2_8_3)
         {
            return new Level_2_8(3);
         }
         if(level_id == LEVEL_2_8_4)
         {
            return new Level_2_8(4);
         }
         if(level_id == LEVEL_2_8_5)
         {
            return new Level_2_8(5);
         }
         if(level_id == LEVEL_2_8_6)
         {
            return new Level_2_8(6);
         }
         if(level_id == LEVEL_2_8_7)
         {
            return new Level_2_8(7);
         }
         if(level_id == LEVEL_2_8_8)
         {
            return new Level_2_8(8);
         }
         if(level_id == LEVEL_1_SECRET_1)
         {
            return new Level_1_Secret(1);
         }
         if(level_id == LEVEL_1_SECRET_2)
         {
            return new Level_1_Secret(2);
         }
         if(level_id == LEVEL_1_SECRET_3)
         {
            return new Level_1_Secret(3);
         }
         if(level_id == LEVEL_2_SECRET_1)
         {
            return new Level_2_Secret(1);
         }
         if(level_id == LEVEL_2_SECRET_2)
         {
            return new Level_2_Secret(2);
         }
         if(level_id == LEVEL_2_SECRET_3)
         {
            return new Level_2_Secret(3);
         }
         if(level_id == LEVEL_1_FISHING)
         {
            Utils.SetCurrentTime();
            return new Level_1_Fishing(0);
         }
         if(level_id == LEVEL_2_FISHING)
         {
            Utils.SetCurrentTime();
            return new Level_2_Fishing(1);
         }
         return new TestLevel();
      }
   }
}
