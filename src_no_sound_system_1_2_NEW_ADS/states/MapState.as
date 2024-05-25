package states
{
   import com.distriqt.extension.adverts.Adverts;
   import com.distriqt.extension.adverts.InterstitialAd;
   import com.distriqt.extension.adverts.builders.AdRequestBuilder;
   import com.distriqt.extension.adverts.events.FullScreenContentEvent;
   import flash.desktop.NativeApplication;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import game_utils.GameSlot;
   import game_utils.StateMachine;
   import interfaces.map.WorldMap;
   import interfaces.panels.PausePanel;
   import interfaces.panels.PremiumPanel;
   import interfaces.panels.QuestPanel;
   import interfaces.panels.UnlockGatePanel;
   import levels.Level;
   
   public class MapState implements IState
   {
      
      public static const HEARTH_REFILL_NOTIFICATION_ID:int = 101;
      
      public static var AD_MUST_BE_SERVED:int = 0;
      
      public static var LOAD_SECONDARY_TEXTURES_FLAG:Boolean = false;
      
      public static var interstitial:InterstitialAd = null;
       
      
      protected var worldMap:WorldMap;
      
      public var stateMachine:StateMachine;
      
      public var GET_OUT_FLAG:Boolean;
      
      public var choice:int;
      
      public var pausePanel:PausePanel;
      
      public var premiumPanel:PremiumPanel;
      
      public var gateUnlockPanel:UnlockGatePanel;
      
      public var questPanel:QuestPanel;
      
      protected var FORCE_PAUSE_COUNTER:int;
      
      public var CHECK_FOR_AD:Boolean;
      
      public var doNotForceMusic:Boolean;
      
      public var IS_AD_ON_SCREEN:Boolean;
      
      public function MapState(isAd:Boolean = false)
      {
         super();
         this.CHECK_FOR_AD = isAd;
         AD_MUST_BE_SERVED = 0;
         if(this.CHECK_FOR_AD)
         {
            AD_MUST_BE_SERVED = 1;
         }
         this.doNotForceMusic = false;
         Utils.IS_SEASONAL = false;
         if(MapState.LOAD_SECONDARY_TEXTURES_FLAG == false)
         {
            MapState.LOAD_SECONDARY_TEXTURES_FLAG = true;
            TextureManager.LoadGachaTextures();
         }
      }
      
      public function enterState(game:Game) : void
      {
         var __preload:Boolean = false;
         this.FORCE_PAUSE_COUNTER = -1;
         this.IS_AD_ON_SCREEN = false;
         Utils.CheckPause = false;
         Utils.SLEEPING_POLLEN_HIT = false;
         this.worldMap = new WorldMap(this);
         this.GET_OUT_FLAG = false;
         Utils.PauseOn = false;
         Utils.FreezeOn = false;
         Utils.PremiumOn = false;
         Utils.GateUnlockOn = false;
         Utils.QuestOn = false;
         this.choice = 0;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_INIT_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","PREMIUM_ACTION","IS_PREMIUM_STATE");
         this.stateMachine.setRule("IS_PREMIUM_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","GATE_ACTION","IS_GATE_UNLOCK_STATE");
         this.stateMachine.setRule("IS_GATE_UNLOCK_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","PAUSE_ACTION","IS_PAUSED_STATE");
         this.stateMachine.setRule("IS_PAUSED_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setRule("IS_PAUSED_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_UPDATING_STATE","QUEST_ACTION","IS_QUEST_STATE");
         this.stateMachine.setRule("IS_QUEST_STATE","END_ACTION","IS_UPDATING_STATE");
         this.stateMachine.setFunctionToState("IS_INIT_STATE",this.initState);
         this.stateMachine.setFunctionToState("IS_UPDATING_STATE",this.updateMapState);
         this.stateMachine.setFunctionToState("IS_PREMIUM_STATE",this.premiumState);
         this.stateMachine.setFunctionToState("IS_GATE_UNLOCK_STATE",this.gateUnlockState);
         this.stateMachine.setFunctionToState("IS_PAUSED_STATE",this.pauseState);
         this.stateMachine.setFunctionToState("IS_QUEST_STATE",this.questState);
         this.stateMachine.setFunctionToState("IS_QUIT_STATE",this.quitState);
         this.stateMachine.setState("IS_INIT_STATE");
         game.enterMapState();
         Level.GAME_OVER_AD_FLAG = false;
         if(Adverts.service.interstitials.isSupported)
         {
            __preload = false;
            if(interstitial == null)
            {
               __preload = true;
            }
            else if(interstitial.isLoaded())
            {
               __preload = false;
            }
            if(__preload)
            {
               interstitial = Adverts.service.interstitials.createInterstitialAd();
               interstitial.setAdUnitId(Utils.ADMOB_INTERSTITIAL_ID_ANDROID);
            }
            interstitial.addEventListener(FullScreenContentEvent.SHOW,this.openedHandler);
            interstitial.addEventListener(FullScreenContentEvent.DISMISSED,this.closedHandler);
            this.preloadInterstitial();
         }
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
            else if(this.stateMachine.currentState == "IS_GATE_UNLOCK_STATE")
            {
               this.gateUnlockPanel.backButtonAndroid();
            }
            else if(this.stateMachine.currentState == "IS_PREMIUM_STATE")
            {
               this.premiumPanel.backButtonAndroid();
            }
            else if(this.stateMachine.currentState == "IS_QUEST_STATE")
            {
               this.questPanel.backButtonAndroid();
            }
            else if(this.stateMachine.currentState == "IS_UPDATING_STATE")
            {
               Utils.PauseOn = true;
            }
         }
      }
      
      protected function preloadInterstitial() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 1 || Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 1)
         {
            return;
         }
         if(Adverts.service.interstitials.isSupported)
         {
            if(interstitial.isLoaded() == false)
            {
               interstitial.load(new AdRequestBuilder().build());
            }
         }
      }
      
      public function onChangeContext(event:Event) : void
      {
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
               this.worldMap.update();
               if(Utils.PauseOn)
               {
                  this.stateMachine.performAction("PAUSE_ACTION");
               }
               else if(Utils.QuestOn)
               {
                  this.stateMachine.performAction("QUEST_ACTION");
               }
               else if(Utils.QuestAvailablePanelOn)
               {
                  this.stateMachine.performAction("GATE_ACTION");
               }
               else if(Utils.PremiumOn)
               {
                  this.stateMachine.performAction("PREMIUM_ACTION");
               }
               else if(Utils.GateUnlockOn)
               {
                  this.stateMachine.performAction("GATE_ACTION");
               }
               else if(this.worldMap.stateMachine.currentState == "IS_CHANGE_MAP_STATE")
               {
                  this.choice = 2;
                  this.stateMachine.performAction("QUIT_ACTION");
               }
               else if(this.worldMap.stateMachine.currentState == "IS_QUIT_STATE")
               {
                  this.choice = 1;
                  Utils.LEVEL_LOCAL_PROGRESSION_1 = Utils.LEVEL_LOCAL_PROGRESSION_2 = 0;
                  Utils.RESET_LEVEL_STATS = true;
                  if(this.worldMap.levelIndex == 1)
                  {
                     Utils.CurrentLevel = 1;
                     if(Utils.Slot.gameProgression[0] == 0)
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_1_1;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                     }
                     else
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_1_2;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                     }
                  }
                  else if(this.worldMap.levelIndex == 2)
                  {
                     Utils.CurrentLevel = 2;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_2_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 251)
                  {
                     Utils.CurrentLevel = 251;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_SECRET_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 252)
                  {
                     Utils.CurrentLevel = 252;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_SECRET_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 253)
                  {
                     Utils.CurrentLevel = 253;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_SECRET_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 3)
                  {
                     Utils.CurrentLevel = 3;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_3_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 4)
                  {
                     Utils.CurrentLevel = 4;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_4_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 5)
                  {
                     Utils.CurrentLevel = 5;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_5_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 6)
                  {
                     Utils.CurrentLevel = 6;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_6_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 7)
                  {
                     Utils.CurrentLevel = 7;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_7_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 8)
                  {
                     Utils.CurrentLevel = 8;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_8_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 9)
                  {
                     Utils.CurrentLevel = 9;
                     if(Utils.Slot.gameProgression[9] == 0)
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_1_1;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                     }
                     else if(Utils.Slot.gameProgression[10] == 0)
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_1_2;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 1;
                     }
                     else
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_1_3;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 2;
                     }
                  }
                  else if(this.worldMap.levelIndex == 10)
                  {
                     Utils.CurrentLevel = 10;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_2_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 11)
                  {
                     Utils.CurrentLevel = 11;
                     if(Utils.Slot.gameProgression[11] == 0)
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_3_1;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                     }
                     else
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_3_2;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                     }
                  }
                  else if(this.worldMap.levelIndex == 12)
                  {
                     Utils.CurrentLevel = 12;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_4_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 13)
                  {
                     Utils.CurrentLevel = 13;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_5_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 14)
                  {
                     Utils.CurrentLevel = 14;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_6_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 15)
                  {
                     Utils.CurrentLevel = 15;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_7_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 16)
                  {
                     Utils.CurrentLevel = 16;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_8_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 17)
                  {
                     Utils.CurrentLevel = 17;
                     if(Utils.Slot.gameProgression[19] == 0)
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_1_4;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                     }
                     else if(Utils.Slot.gameProgression[20] == 0)
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_1_5;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 4;
                     }
                     else
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_1_1;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                     }
                  }
                  else if(this.worldMap.levelIndex == 18)
                  {
                     Utils.CurrentLevel = 18;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_2_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 19)
                  {
                     Utils.CurrentLevel = 19;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_3_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 20)
                  {
                     Utils.CurrentLevel = 20;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_4_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 21)
                  {
                     Utils.CurrentLevel = 21;
                     if(Utils.Slot.gameProgression[23] == 1 && Utils.Slot.gameProgression[24] == 0)
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_5_2;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 9;
                     }
                     else
                     {
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_5_1;
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                     }
                  }
                  else if(this.worldMap.levelIndex == 22)
                  {
                     Utils.CurrentLevel = 22;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_6_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 23)
                  {
                     Utils.CurrentLevel = 23;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_7_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 24)
                  {
                     Utils.CurrentLevel = 24;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_3_8_1;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 802)
                  {
                     Utils.CurrentLevel = LevelState.LEVEL_1_FISHING;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_FISHING;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  else if(this.worldMap.levelIndex == 803)
                  {
                     Utils.CurrentLevel = LevelState.LEVEL_2_FISHING;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_FISHING;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
                  }
                  this.stateMachine.performAction("QUIT_ACTION");
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
                     Utils.PauseOn = false;
                     this.stateMachine.performAction("END_ACTION");
                  }
                  else if(this.pausePanel.QUIT_FLAG)
                  {
                     this.choice = 0;
                     this.stateMachine.performAction("QUIT_ACTION");
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_PREMIUM_STATE")
            {
               this.premiumPanel.update();
               if(this.premiumPanel.GET_OUT_FLAG)
               {
                  this.premiumPanel.hide();
                  Utils.PremiumOn = false;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState == "IS_GATE_UNLOCK_STATE")
            {
               this.gateUnlockPanel.update();
               if(this.gateUnlockPanel.GET_OUT_FLAG)
               {
                  if(this.gateUnlockPanel.CONTINUE_FLAG)
                  {
                     this.gateUnlockPanel.CONTINUE_FLAG = false;
                     this.worldMap.unlockGate();
                  }
                  this.gateUnlockPanel.hide();
                  Utils.GateUnlockOn = false;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState == "IS_QUEST_STATE")
            {
               this.questPanel.update();
               if(this.questPanel.GET_OUT_FLAG)
               {
                  this.questPanel.hide();
                  Utils.QuestOn = false;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         game.updateMapState();
      }
      
      protected function initState() : void
      {
         this.pausePanel = new PausePanel(1);
         this.premiumPanel = new PremiumPanel(1);
         this.gateUnlockPanel = new UnlockGatePanel(1);
         this.questPanel = new QuestPanel(1);
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function updateMapState() : void
      {
      }
      
      protected function premiumState() : void
      {
         SoundSystem.PlaySound("select");
         if(Utils.IS_ANDROID)
         {
            this.premiumPanel.destroy();
            this.premiumPanel.dispose();
            this.premiumPanel = null;
            this.premiumPanel = new PremiumPanel();
         }
         this.premiumPanel.popUp();
      }
      
      protected function gateUnlockState() : void
      {
         SoundSystem.PlaySound("select");
         if(Utils.IS_ANDROID)
         {
            this.gateUnlockPanel.destroy();
            this.gateUnlockPanel.dispose();
            this.gateUnlockPanel = null;
            this.gateUnlockPanel = new UnlockGatePanel();
         }
         this.gateUnlockPanel.popUp();
      }
      
      protected function pauseState() : void
      {
         SoundSystem.PlaySound("select");
         if(Utils.IS_ANDROID)
         {
            this.pausePanel.destroy();
            this.pausePanel.dispose();
            this.pausePanel = null;
            this.pausePanel = new PausePanel(1);
         }
         this.pausePanel.popUp();
      }
      
      protected function questState() : void
      {
         SoundSystem.PlaySound("select");
         if(Utils.IS_ANDROID)
         {
            this.questPanel.destroy();
            this.questPanel.dispose();
            this.questPanel = null;
            this.questPanel = new QuestPanel();
         }
         this.questPanel.popUp();
      }
      
      protected function quitState() : void
      {
         this.GET_OUT_FLAG = true;
      }
      
      public function exitState(game:Game) : void
      {
         if(Adverts.service.interstitials.isSupported)
         {
            if(interstitial != null)
            {
               interstitial.removeEventListener(FullScreenContentEvent.SHOW,this.openedHandler);
               interstitial.removeEventListener(FullScreenContentEvent.DISMISSED,this.closedHandler);
            }
         }
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         this.questPanel.destroy();
         this.questPanel.dispose();
         this.questPanel = null;
         this.gateUnlockPanel.destroy();
         this.gateUnlockPanel.dispose();
         this.gateUnlockPanel = null;
         this.premiumPanel.destroy();
         this.premiumPanel.dispose();
         this.premiumPanel = null;
         this.pausePanel.destroy();
         this.pausePanel.dispose();
         this.pausePanel = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.worldMap.destroy();
         this.worldMap = null;
         game.exitMapState();
      }
      
      public function showInterstitial() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 1 || Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 1)
         {
            return;
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GAME_SESSIONS] <= 1 && Utils.Slot.levelUnlocked[2] == false)
         {
            return;
         }
         if(Utils.MAP_AD_COUNTER == 1)
         {
            AD_MUST_BE_SERVED = 0;
            ++Utils.MAP_AD_COUNTER;
            Utils.PremiumOn = true;
            this.worldMap.updateScreenPositions();
         }
         else if(Adverts.service.interstitials.isSupported)
         {
            if(interstitial.isLoaded())
            {
               AD_MUST_BE_SERVED = 0;
               interstitial.show();
            }
         }
      }
      
      internal function openedHandler(event:FullScreenContentEvent) : void
      {
         SoundSystem.StopMusic(true,true);
         SoundSystem.Update();
         this.IS_AD_ON_SCREEN = true;
         ++Utils.MAP_AD_COUNTER;
         if(Utils.MAP_AD_COUNTER >= 4)
         {
            Utils.MAP_AD_COUNTER = 0;
         }
      }
      
      internal function closedHandler(event:FullScreenContentEvent) : void
      {
         this.preloadInterstitial();
         this.IS_AD_ON_SCREEN = false;
         this.worldMap.music_counter_2 = 0;
         if(Utils.IS_ANDROID)
         {
            Utils.CheckPause = false;
         }
      }
   }
}
