package interfaces.map
{
   import game_utils.CoinPrices;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.QuestsManager;
   import game_utils.SaveManager;
   import game_utils.StateMachine;
   import interfaces.buttons.MapLevelButton;
   import interfaces.map.coins.*;
   import interfaces.map.cutscenes.*;
   import interfaces.map.decorations.*;
   import interfaces.map.particles.MapParticlesManager;
   import starling.display.Sprite;
   import states.MapState;
   
   public class WorldMap
   {
       
      
      protected var mapState:MapState;
      
      public var mapLoader:MapLoader;
      
      public var mapTiles:MapTiles;
      
      public var mapLevels:MapLevels;
      
      public var mapDecorations:MapDecorations;
      
      public var mapParticlesManager:MapParticlesManager;
      
      public var mapCutscenes:MapCutscenes;
      
      public var mapCoins:MapCoins;
      
      public var mapHud:MapHud;
      
      public var mapCamera:MapCamera;
      
      public var levelIndex:int;
      
      public var stateMachine:StateMachine;
      
      public var music_counter:int;
      
      public var music_counter_2:int;
      
      public var justOnce:Boolean;
      
      protected var pageXPos:Number;
      
      public var buttonToUnlock:MapLevelButton;
      
      protected var ad_counter:int;
      
      protected var QUEST_REWARD_COUNTER:int;
      
      protected var EXTRA_DELAY:int;
      
      protected var _update:int = 0;
      
      public function WorldMap(_mapState:MapState)
      {
         super();
         Utils.IS_GAME_MAP = true;
         this.music_counter_2 = -1;
         this.mapState = _mapState;
         this.QUEST_REWARD_COUNTER = -1;
         this.EXTRA_DELAY = 0;
         var now:Date = new Date();
         if(QuestsManager.GetYearDay(now.date,now.month,now.fullYear) != Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_DAY])
         {
            QuestsManager.LoadNewQuest(now);
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS] == 0 || Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS] == 1)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_ACTION] >= QuestsManager.Quests[Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_INDEX]].amount)
            {
               this.QUEST_REWARD_COUNTER = 0;
               if(Utils.MapFromLevelWon)
               {
                  Utils.MapFromLevelWon = false;
                  this.EXTRA_DELAY = 30;
               }
            }
         }
         this.justOnce = true;
         this.music_counter = 0;
         if(Utils.MAP_AD_COUNTER == 1)
         {
            this.ad_counter = 60;
         }
         else
         {
            this.ad_counter = 180;
         }
         this.pageXPos = 0;
         this.buttonToUnlock = null;
         Utils.gameMovie = new Sprite();
         Utils.gameMovie.x = Utils.gameMovie.y = 0;
         Utils.gameMovie.scaleX = Utils.gameMovie.scaleY = Utils.GFX_SCALE;
         Utils.rootMovie.addChild(Utils.gameMovie);
         Utils.backWorld = new Sprite();
         Utils.backWorld.x = Utils.backWorld.y = 0;
         Utils.world = new Sprite();
         Utils.world.x = Utils.world.y = 0;
         Utils.topWorld = new Sprite();
         Utils.topWorld.x = Utils.topWorld.y = 0;
         Utils.gameMovie.addChild(Utils.backWorld);
         Utils.gameMovie.addChild(Utils.world);
         Utils.gameMovie.addChild(Utils.topWorld);
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_NORMAL_STATE","START_CUTSCENE_ACTION","IS_CUTSCENE_STATE");
         this.stateMachine.setRule("IS_CUTSCENE_STATE","END_CUTSCENE_ACTION","IS_NORMAL_STATE");
         this.stateMachine.setRule("IS_NORMAL_STATE","LEVEL_SELECTION_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_NORMAL_STATE","CHANGE_MAP_ACTION","IS_CHANGE_MAP_STATE");
         this.stateMachine.setRule("IS_CUTSCENE_STATE","CHANGE_MAP_ACTION","IS_CHANGE_MAP_STATE");
         this.stateMachine.setFunctionToState("IS_NORMAL_STATE",this.normalState);
         this.stateMachine.setFunctionToState("IS_CUTSCENE_STATE",this.cutsceneState);
         this.stateMachine.setFunctionToState("IS_QUIT_STATE",this.quitState);
         this.stateMachine.setFunctionToState("IS_CHANGE_MAP_STATE",this.changeMapState);
         this.mapLoader = new MapLoader(this);
         this.mapTiles = new MapTiles(this);
         this.mapLevels = new MapLevels(this);
         this.mapDecorations = new MapDecorations(this);
         this.mapLevels.setOnTop();
         this.mapParticlesManager = new MapParticlesManager(this,Utils.topWorld);
         this.mapCamera = new MapCamera(this);
         this.mapCutscenes = new MapCutscenes(this);
         this.mapCoins = new MapCoins(this);
         this.mapHud = new MapHud(this);
         this.stateMachine.setState("IS_NORMAL_STATE");
         this.levelIndex = 0;
         this.mapCutscenes.init();
         if(this.stateMachine.currentState == "IS_NORMAL_STATE")
         {
            this.music_counter = 0;
            if(Utils.SpeedUpMapMusic)
            {
               Utils.SpeedUpMapMusic = false;
               this.playMapMusic();
               this.justOnce = false;
            }
         }
         else
         {
            this.music_counter = -100000000;
         }
      }
      
      public function playMapMusic() : void
      {
         if(this.mapState.doNotForceMusic)
         {
            SoundSystem.PlayMusic("map");
         }
         else
         {
            SoundSystem.PlayMusic("map",-1,true);
         }
      }
      
      public function restoreTextLabels() : void
      {
         this.mapHud.restoreTextLabels();
      }
      
      public function destroy() : void
      {
         this.buttonToUnlock = null;
         this.mapHud.destroy();
         this.mapHud = null;
         this.mapCoins.destroy();
         this.mapCoins = null;
         this.mapCutscenes.destroy();
         this.mapCutscenes = null;
         this.mapCamera.destroy();
         this.mapCamera = null;
         this.mapParticlesManager.destroy();
         this.mapParticlesManager = null;
         this.mapDecorations.destroy();
         this.mapDecorations = null;
         this.mapLevels.destroy();
         this.mapLevels = null;
         this.mapTiles.destroy();
         this.mapTiles = null;
         this.mapLoader.destroy();
         this.mapLoader = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
         Utils.gameMovie.removeChild(Utils.topWorld);
         Utils.gameMovie.removeChild(Utils.world);
         Utils.gameMovie.removeChild(Utils.backWorld);
         Utils.topWorld.dispose();
         Utils.topWorld = null;
         Utils.world.dispose();
         Utils.world = null;
         Utils.backWorld.dispose();
         Utils.backWorld = null;
         Utils.rootMovie.removeChild(Utils.gameMovie);
         Utils.gameMovie.dispose();
         Utils.gameMovie = null;
      }
      
      public function update() : void
      {
         if(Utils.IS_ANDROID)
         {
            if(Utils.CheckPause)
            {
               Utils.CheckPause = false;
               if(this.stateMachine.currentState == "IS_NORMAL_STATE")
               {
                  Utils.PauseOn = true;
               }
            }
         }
         if(this.justOnce)
         {
            if(this.music_counter++ == 60)
            {
               if(!this.mapState.IS_AD_ON_SCREEN)
               {
                  this.playMapMusic();
               }
               this.justOnce = false;
            }
         }
         if(this.music_counter_2 > -1)
         {
            if(this.music_counter_2++ == 30)
            {
               this.music_counter_2 = -1;
               SoundSystem.PlayMusic("map",-1,true);
            }
         }
         if(this.stateMachine.currentState == "IS_NORMAL_STATE")
         {
            if(this.QUEST_REWARD_COUNTER == 30 + this.EXTRA_DELAY)
            {
               LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_COIN,CoinPrices.GetPrice(CoinPrices.QUEST_REWARD),true,true);
               Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS] = 2;
               if(QuestsManager.WasLastQuestCompletedYesterday())
               {
                  ++Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STREAK];
               }
               else
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STREAK] = 1;
               }
               Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_OLD_DAY] = Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_DAY];
               SaveManager.SaveQuestData();
               SaveManager.SaveInventory(true);
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 0 && this.QUEST_REWARD_COUNTER <= -1 && Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
            {
               if(this.ad_counter == 0)
               {
                  if(this.mapState.CHECK_FOR_AD)
                  {
                     this.mapState.CHECK_FOR_AD = false;
                     this.mapState.showInterstitial();
                  }
               }
               --this.ad_counter;
            }
            if(this.QUEST_REWARD_COUNTER >= 0)
            {
               ++this.QUEST_REWARD_COUNTER;
               if(this.QUEST_REWARD_COUNTER >= 120 + this.EXTRA_DELAY)
               {
                  this.QUEST_REWARD_COUNTER = -1;
               }
            }
         }
         this.mapTiles.update();
         this.mapLevels.update();
         this.mapDecorations.update();
         this.mapCutscenes.update();
         this.mapCoins.update();
         this.mapParticlesManager.update();
         this.mapHud.update();
         this.mapCamera.update();
         this.updateScreenPositions();
      }
      
      public function updateScreenPositions() : void
      {
         this.mapTiles.updateScreenPosition(this.mapCamera);
         this.mapLevels.updateScreenPosition(this.mapCamera);
         this.mapDecorations.updateScreenPosition(this.mapCamera);
         this.mapCutscenes.updateScreenPosition(this.mapCamera);
         this.mapCoins.updateScreenPosition(this.mapCamera);
         this.mapParticlesManager.updateScreenPosition(this.mapCamera);
      }
      
      public function endCutscene() : void
      {
         this.stateMachine.performAction("END_CUTSCENE_ACTION");
         this.music_counter = 30;
      }
      
      public function levelSelected(currentLevel:int) : void
      {
         this.levelIndex = currentLevel;
         this.mapHud.disableInput();
         Utils.IS_GAME_MAP = false;
         this.stateMachine.performAction("LEVEL_SELECTION_ACTION");
      }
      
      public function unlockGate() : void
      {
         this.mapCutscenes.startCutscene(new EnoughBellsMapCutscene(this,this.buttonToUnlock));
      }
      
      public function pageSelected(isSX:Boolean) : void
      {
         if(isSX)
         {
            this.pageXPos = this.mapLoader.mapEndX - Utils.WIDTH;
         }
         else
         {
            this.pageXPos = 24;
         }
         this.stateMachine.performAction("CHANGE_MAP_ACTION");
      }
      
      protected function normalState() : void
      {
         this.mapLevels.enableButtons();
         this.mapCoins.enableButtons();
         this.mapHud.enableInput();
      }
      
      protected function cutsceneState() : void
      {
         this.ad_counter = 0;
         this.mapLevels.disableButtons();
         this.mapCoins.disableButtons();
         this.mapHud.disableInput();
      }
      
      protected function quitState() : void
      {
         Utils.IS_GAME_MAP = false;
         this.mapLevels.disableButtons();
         this.mapCoins.disableButtons();
         Utils.Slot.gameVariables[GameSlot.VARIABLE_MAP] = this.mapCamera.xPos;
         SaveManager.SaveGameVariables();
      }
      
      protected function changeMapState() : void
      {
         this.mapHud.disableInput();
         this.mapLevels.disableButtons();
         this.mapCoins.disableButtons();
         Utils.Slot.gameVariables[GameSlot.VARIABLE_MAP] = this.pageXPos;
         SaveManager.SaveGameVariables();
      }
   }
}
