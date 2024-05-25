package levels
{
   import com.distriqt.extension.adverts.Adverts;
   import com.distriqt.extension.adverts.InterstitialAd;
   import com.distriqt.extension.adverts.builders.AdRequestBuilder;
   import com.distriqt.extension.adverts.events.FullScreenContentEvent;
   import entities.*;
   import entities.bullets.*;
   import entities.enemies.*;
   import entities.helpers.HelpersManager;
   import entities.npcs.*;
   import entities.particles.*;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.*;
   import game_utils.AnalyticsManager;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.LevelTimer;
   import game_utils.QuestsManager;
   import game_utils.SaveManager;
   import game_utils.StateMachine;
   import interfaces.Hud;
   import interfaces.SoundHud;
   import levels.backgrounds.*;
   import levels.cameras.*;
   import levels.collisions.*;
   import levels.cutscenes.*;
   import levels.decorations.DecorationsManager;
   import levels.groups.*;
   import levels.items.*;
   import sprites.particles.ItemExplosionParticleSprite;
   import starling.core.Starling;
   import starling.display.Button;
   import starling.display.Sprite;
   import starling.events.KeyboardEvent;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.textures.*;
   import states.MapState;
   
   public class Level
   {
      
      public static var GAME_OVER_AD_FLAG:Boolean = false;
      
      public static var ADS_COUNTER:int = 0;
      
      public static var interstitial:InterstitialAd = null;
       
      
      public var LEVEL_LOADED:Boolean;
      
      public var GAME_OVER_FLAG:Boolean;
      
      public var LEVEL_WON_FLAG:Boolean;
      
      public var EXIT_FLAG:Boolean;
      
      public var CHANGE_ROOM_FLAG:Boolean;
      
      public var BLOCK_FLAG:Boolean;
      
      public var IS_SECRET_LEVEL:Boolean;
      
      public var MINIGAME_FLAG:Boolean;
      
      public var freezeLevelCounter:int;
      
      public var freezeLevelTimeout:int;
      
      public var SUB_LEVEL:int;
      
      public var SECRET_EXIT:int;
      
      public var ALLOW_CAT_BUTTON:Boolean;
      
      public var levelMap:MovieClip;
      
      public var levelData:LevelData;
      
      public var levelPhysics:LevelPhysics;
      
      public var map:XML;
      
      public var scriptsManager:ScriptsManager;
      
      public var backgroundsManager:BackgroundsManager;
      
      public var darkManager:DarkManager;
      
      public var itemsManager:ItemsManager;
      
      public var collisionsManager:CollisionsManager;
      
      public var decorationsManager:DecorationsManager;
      
      public var enemiesManager:EnemiesManager;
      
      public var helpersManager:HelpersManager;
      
      public var particlesManager:ParticlesManager;
      
      public var topParticlesManager:ParticlesManager;
      
      public var bulletsManager:BulletsManager;
      
      public var groupsManager:GroupsManager;
      
      public var npcsManager:NPCsManager;
      
      public var hero:Hero;
      
      protected var heroes:Array;
      
      protected var restore_music_counter:int;
      
      public var level_tick:uint;
      
      public var core_tick:uint;
      
      public var music_counter:int;
      
      public var cutscenesManager:CutscenesManager;
      
      public var camera:ScreenCamera;
      
      public var stateMachine:StateMachine;
      
      public var counter1:int;
      
      public var counter2:int;
      
      public var counter3:int;
      
      public var hud:Hud;
      
      public var soundHud:SoundHud;
      
      public var leftPressed:Boolean;
      
      public var rightPressed:Boolean;
      
      public var BLOCK_INPUT:Boolean;
      
      public var touches:Vector.<Touch>;
      
      public var wasLastLeft:Boolean;
      
      public var wasLastRight:Boolean;
      
      public var IS_DARK:Boolean;
      
      protected var _ad_counter:int;
      
      public var fishing_level_will_initialize_ads:Boolean = false;
      
      internal var __hint_counter:int = 0;
      
      public function Level()
      {
         var __preload:Boolean = false;
         super();
         this.LEVEL_LOADED = true;
         this.ALLOW_CAT_BUTTON = true;
         this._ad_counter = 120;
         Utils.CheckPause = false;
         Utils.NoMusicBeingPlayed = false;
         this.GAME_OVER_FLAG = this.LEVEL_WON_FLAG = this.EXIT_FLAG = this.CHANGE_ROOM_FLAG = this.BLOCK_FLAG = this.BLOCK_INPUT = this.IS_SECRET_LEVEL = this.MINIGAME_FLAG = false;
         this.SECRET_EXIT = 0;
         this.freezeLevelCounter = 0;
         this.freezeLevelTimeout = 20;
         Utils.GameOverOn = false;
         Utils.IsInstaGameOver = false;
         this.restore_music_counter = -1;
         this.level_tick = 0;
         this.core_tick = 0;
         this.music_counter = 0;
         Utils.WIND_X_VEL = ButterflyItem.CAUGHT_COUNTER = DarkCoinItem.CAUGHT_COUNTER = Utils.SEA_LEVEL = Utils.SAND_LEVEL = 0;
         Utils.IS_DARK = Utils.IS_LAVA = Utils.IS_GOLDEN_CAT = false;
         Utils.INVENTORY_NOTIFICATION_ID = Utils.INVENTORY_NOTIFICATION_ACTION = Utils.EXIT_DIRECTION = -1;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.leftPressed = this.rightPressed = false;
         this.touches = null;
         if(Utils.RESET_LEVEL_STATS)
         {
            Utils.RESET_LEVEL_STATS = false;
            if(Utils.CurrentLevel < 10000)
            {
               Utils.ResetGameplay();
            }
            LevelTimer.getInstance().startTimer();
         }
         Utils.ResetFlags();
         Utils.gameMovie = new Sprite();
         Utils.gameMovie.x = Utils.gameMovie.y = 0;
         Utils.gameMovie.scaleX = Utils.gameMovie.scaleY = Utils.GFX_SCALE;
         Utils.rootMovie.addChild(Utils.gameMovie);
         Utils.backgroundWorld = new Sprite();
         Utils.backgroundWorld.x = Utils.backgroundWorld.y = 0;
         Utils.backWorld = new Sprite();
         Utils.backWorld.x = Utils.backWorld.y = 0;
         Utils.darkWorld = new Sprite();
         Utils.darkWorld.x = Utils.darkWorld.y = 0;
         Utils.world = new Sprite();
         Utils.world.x = Utils.world.y = 0;
         Utils.topWorld = new Sprite();
         Utils.topWorld.x = Utils.topWorld.y = 0;
         Utils.foregroundWorld = new Sprite();
         Utils.foregroundWorld.x = Utils.foregroundWorld.y = 0;
         Utils.gameMovie.addChild(Utils.backgroundWorld);
         Utils.gameMovie.addChild(Utils.backWorld);
         Utils.gameMovie.addChild(Utils.world);
         Utils.gameMovie.addChild(Utils.topWorld);
         Utils.gameMovie.addChild(Utils.darkWorld);
         Utils.gameMovie.addChild(Utils.foregroundWorld);
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_INTRO_STATE","CUTSCENE_START_ACTION","IS_CUTSCENE_STATE");
         this.stateMachine.setRule("IS_PLAYING_STATE","CUTSCENE_START_ACTION","IS_CUTSCENE_STATE");
         this.stateMachine.setRule("IS_CUTSCENE_STATE","CUTSCENE_END_ACTION","IS_PLAYING_STATE");
         this.stateMachine.setRule("IS_PLAYING_STATE","EXIT_LEVEL_ACTION","IS_EXITING_LEVEL_STATE");
         this.stateMachine.setRule("IS_PLAYING_STATE","END_ACTION","IS_LEVEL_END_STATE");
         this.stateMachine.setFunctionToState("IS_INTRO_STATE",this.introState);
         this.stateMachine.setFunctionToState("IS_PLAYING_STATE",this.playingState);
         this.stateMachine.setFunctionToState("IS_CUTSCENE_STATE",this.cutsceneState);
         this.stateMachine.setFunctionToState("IS_EXITING_LEVEL_STATE",this.exitLevelState);
         this.stateMachine.setFunctionToState("IS_LEVEL_END_STATE",this.endState);
         if(this.fishing_level_will_initialize_ads == false)
         {
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
      
      public function urlLoaded(evt:Event) : void
      {
         this.map = new XML(evt.currentTarget.data);
         this.levelLoaded();
      }
      
      public function levelLoaded() : void
      {
      }
      
      public function init() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT] == 2)
         {
            if(Utils.Slot.playerInventory[LevelItems.ITEM_EVIL_CAT] == 0)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT] = 0;
            }
         }
         this.levelData = new LevelData(this);
         this.levelPhysics = new LevelPhysics(this);
         this.scriptsManager = new ScriptsManager(this);
         this.backgroundsManager = new BackgroundsManager(this);
         this.darkManager = new DarkManager(this);
         this.itemsManager = new ItemsManager(this);
         this.collisionsManager = new CollisionsManager(this);
         this.decorationsManager = new DecorationsManager(this);
         this.enemiesManager = new EnemiesManager(this);
         this.helpersManager = new HelpersManager(this);
         this.particlesManager = new ParticlesManager(this,Utils.world);
         this.topParticlesManager = new ParticlesManager(this,Utils.topWorld);
         this.bulletsManager = new BulletsManager(this);
         this.groupsManager = new GroupsManager(this);
         this.npcsManager = new NPCsManager(this);
         this.cutscenesManager = new CutscenesManager(this);
         this.initHeroes();
         this.hero = this.heroes[Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]];
         this.hero.refreshSprite();
         this.camera = this.getCamera();
         this.collisionsManager.postInit();
         this.itemsManager.postInit();
         this.enemiesManager.postInit();
         this.helpersManager.postInit();
         this.soundHud = new SoundHud(this);
         this.hud = new Hud(this);
         this.soundHud.showPause();
         this.soundHud.enablePause();
         if(Utils.IS_ON_WINDOWS)
         {
            Utils.rootStage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownListener);
            Utils.rootStage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpListener);
         }
         else
         {
            Starling.current.touchProcessor.cancelTouches();
            Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onClick);
         }
         this.stateMachine.setState("IS_INTRO_STATE");
         this.levelMap = null;
      }
      
      public function exitLevel() : void
      {
         var i:int = 0;
         if(Adverts.service.interstitials.isSupported)
         {
            if(interstitial != null)
            {
               interstitial.removeEventListener(FullScreenContentEvent.SHOW,this.openedHandler);
               interstitial.removeEventListener(FullScreenContentEvent.DISMISSED,this.closedHandler);
            }
         }
         Utils.NoMusicBeingPlayed = false;
         if(Utils.IS_ON_WINDOWS)
         {
            Utils.rootStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownListener);
            Utils.rootStage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpListener);
         }
         else
         {
            Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onClick);
         }
         this.touches = null;
         this.soundHud.destroy();
         this.soundHud = null;
         this.hud.destroy();
         this.hud = null;
         this.camera.destroy();
         this.camera = null;
         for(i = 0; i < this.heroes.length; i++)
         {
            this.heroes[i].destroy();
            this.heroes[i] = null;
         }
         this.heroes = null;
         this.hero = null;
         this.cutscenesManager.destroy();
         this.cutscenesManager = null;
         this.npcsManager.destroy();
         this.npcsManager = null;
         this.bulletsManager.destroy();
         this.bulletsManager = null;
         this.topParticlesManager.destroy();
         this.topParticlesManager = null;
         this.particlesManager.destroy();
         this.particlesManager = null;
         this.groupsManager.destroy();
         this.groupsManager = null;
         this.helpersManager.destroy();
         this.helpersManager = null;
         this.enemiesManager.destroy();
         this.enemiesManager = null;
         this.decorationsManager.destroy();
         this.decorationsManager = null;
         this.collisionsManager.destroy();
         this.collisionsManager = null;
         this.itemsManager.destroy();
         this.itemsManager = null;
         this.darkManager.destroy();
         this.darkManager = null;
         this.backgroundsManager.destroy();
         this.backgroundsManager = null;
         this.scriptsManager.destroy();
         this.scriptsManager = null;
         this.levelPhysics.destroy();
         this.levelPhysics = null;
         this.levelData.destroy();
         this.levelData = null;
         Utils.gameMovie.removeChild(Utils.topWorld);
         Utils.gameMovie.removeChild(Utils.darkWorld);
         Utils.gameMovie.removeChild(Utils.world);
         Utils.gameMovie.removeChild(Utils.backWorld);
         Utils.gameMovie.removeChild(Utils.backgroundWorld);
         Utils.gameMovie.removeChild(Utils.foregroundWorld);
         Utils.topWorld.dispose();
         Utils.topWorld = null;
         Utils.darkWorld.dispose();
         Utils.darkWorld = null;
         Utils.world.dispose();
         Utils.world = null;
         Utils.backWorld.dispose();
         Utils.backWorld = null;
         Utils.backgroundWorld.dispose();
         Utils.backgroundWorld = null;
         Utils.foregroundWorld.dispose();
         Utils.foregroundWorld = null;
         Utils.rootMovie.removeChild(Utils.gameMovie);
         Utils.gameMovie.dispose();
         Utils.gameMovie = null;
         this.stateMachine.destroy();
         this.stateMachine = null;
      }
      
      public function getCamera() : ScreenCamera
      {
         return new GameCamera(this);
      }
      
      public function allowEvent() : void
      {
      }
      
      public function update() : void
      {
         var i:int = 0;
         --this._ad_counter;
         if(this._ad_counter == 0)
         {
            this.checkAds();
         }
         if(this.__hint_counter++ == 360)
         {
         }
         --Utils.HintCounter;
         if(Utils.HintCounter <= 0)
         {
            Utils.HintCounter = 0;
         }
         if(Utils.CheckPause)
         {
            Utils.CheckPause = false;
            if(!this.GAME_OVER_FLAG && !this.LEVEL_WON_FLAG)
            {
               Utils.PauseOn = true;
            }
         }
         if(this.level_tick > 0)
         {
            ++this.level_tick;
         }
         if(this.level_tick == 20)
         {
            if(Utils.FORCE_NOTIFICATION > 0)
            {
               if(Utils.FORCE_NOTIFICATION == 1)
               {
                  Utils.INVENTORY_NOTIFICATION_ID = LevelItems.ITEM_GACHA_1;
                  Utils.INVENTORY_NOTIFICATION_ACTION = 1;
               }
               Utils.FORCE_NOTIFICATION = 0;
            }
         }
         ++this.core_tick;
         if(this.restore_music_counter > -1)
         {
            if(this.restore_music_counter++ == 100)
            {
               this.restore_music_counter = -1;
               SoundSystem.StopMusic(true);
               this.playMusic();
            }
         }
         if(this.music_counter > -1)
         {
            ++this.music_counter;
            if(this.music_counter == 5)
            {
               this.music_counter = -1;
               this.playMusic();
            }
         }
         if(!Utils.IS_ON_WINDOWS)
         {
            this.processInput();
         }
         if(!Utils.FreezeOn)
         {
            this.cutscenesManager.update();
            this.backgroundsManager.update();
            this.groupsManager.update();
            this.collisionsManager.update();
            this.decorationsManager.update();
            this.enemiesManager.update();
            this.helpersManager.update();
            this.npcsManager.update();
            this.bulletsManager.update();
            this.hero.update();
            this.collisionsManager.postUpdate();
            this.particlesManager.update();
            this.topParticlesManager.update();
            this.itemsManager.update();
            this.darkManager.update();
            for(i = 0; i < this.heroes.length; i++)
            {
               if(this.heroes[i] != this.hero)
               {
                  this.heroes[i].sprite.visible = false;
               }
            }
         }
         else
         {
            if(this.freezeLevelTimeout > 0)
            {
               ++this.freezeLevelCounter;
               if(this.freezeLevelCounter >= this.freezeLevelTimeout && this.hero.stateMachine.currentState != "IS_GAME_OVER_STATE")
               {
                  Utils.FreezeOn = false;
               }
            }
            this.cutscenesManager.update();
            this.backgroundsManager.updateFreeze();
            this.hero.updateFreeze();
            this.particlesManager.updateFreeze();
            this.topParticlesManager.updateFreeze();
            this.itemsManager.updateFreeze();
         }
         this.camera.update();
         this.backgroundsManager.updateScreenPositions(this.camera);
         this.itemsManager.updateScreenPositions(this.camera);
         this.collisionsManager.updateScreenPositions(this.camera);
         this.decorationsManager.updateScreenPositions(this.camera);
         this.enemiesManager.updateScreenPositions(this.camera);
         this.helpersManager.updateScreenPositions(this.camera);
         this.npcsManager.updateScreenPositions(this.camera);
         this.bulletsManager.updateScreenPositions(this.camera);
         this.hero.updateScreenPosition(this.camera);
         this.cutscenesManager.updateScreenPositions(this.camera);
         this.particlesManager.updateScreenPositions(this.camera);
         this.topParticlesManager.updateScreenPositions(this.camera);
         this.darkManager.updateScreenPositions(this.camera);
         this.hud.update();
         this.soundHud.update();
         this.cutscenesManager.postUpdate();
         this.topParticlesManager.updatePostScreenPositions(this.camera);
      }
      
      public function playMusic() : void
      {
         SoundSystem.PlayMusic(this.getMusicName(),-1,false,false);
      }
      
      public function getMusicName() : String
      {
         return "";
      }
      
      public function changeHelper(index:int, isRandom:Boolean = false) : void
      {
         if(index != 0)
         {
            SoundSystem.PlaySound("item_pop");
            this.helpersManager.changeHelper(index);
         }
      }
      
      public function changeCat(index:int, is_with_effect:Boolean = true, _forced:Boolean = false) : void
      {
         var was_cat_stunned:Boolean = false;
         var stun_counter_1:int = 0;
         var stun_counter_2:int = 0;
         var frame_counter:Number = NaN;
         var frame_speed:Number = NaN;
         var cat_x:int = 0;
         var cat_y:int = 0;
         var cat_dir:int = 0;
         var bubble_state:int = 0;
         var bubble_counter_1:int = 0;
         var bubble_counter_2:int = 0;
         if(_forced == false)
         {
            if(index != 0)
            {
               if(index == 4)
               {
                  if(LevelItems.HasItem(LevelItems.ITEM_SMALL_CAT) == false)
                  {
                     return;
                  }
               }
               else if(index == 2)
               {
                  if(LevelItems.HasItem(LevelItems.ITEM_EVIL_CAT) == false)
                  {
                     return;
                  }
               }
               else
               {
                  if(index != 3)
                  {
                     return;
                  }
                  if(LevelItems.HasItem(LevelItems.ITEM_WATER_CAT) == false)
                  {
                     return;
                  }
               }
            }
         }
         if(index != Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT])
         {
            Utils.QUEST_CAT_CHANGED_FLAG = true;
            was_cat_stunned = false;
            cat_x = this.hero.xPos;
            cat_y = this.hero.yPos;
            cat_dir = this.hero.DIRECTION;
            bubble_state = this.hero.BUBBLE_STATE;
            bubble_counter_1 = this.hero.bubble_counter_1;
            bubble_counter_2 = this.hero.bubble_counter_2;
            this.hero.setInvisible();
            this.hero.IS_GOLD = false;
            this.hero.updateScreenPosition(this.camera);
            this.hero.xVel = this.hero.yVel = 0;
            this.hero.setInvisible();
            if(this.hero.stunHandler.IS_STUNNED)
            {
               was_cat_stunned = true;
               stun_counter_1 = this.hero.stunHandler.stun_counter_1;
               stun_counter_2 = this.hero.stunHandler.stun_counter_2;
               frame_counter = this.hero.stunHandler.frame_counter;
               frame_speed = this.hero.stunHandler.frame_speed;
            }
            this.hero = this.heroes[index];
            this.hero.sprite.visible = true;
            this.hero.xPos = cat_x;
            this.hero.yPos = cat_y;
            this.hero.DIRECTION = cat_dir;
            this.hero.xVel = this.hero.yVel = 0;
            this.hero.IS_RUN_ALLOWED = true;
            this.hero.stateMachine.setState("IS_STANDING_STATE");
            this.hero.BUBBLE_STATE = bubble_state;
            this.hero.bubble_counter_1 = bubble_counter_1;
            this.hero.bubble_counter_2 = bubble_counter_2;
            if(Utils.SEA_LEVEL > 0 && this.hero.yPos > Utils.SEA_LEVEL)
            {
               this.hero.setInsideWater();
            }
            else
            {
               this.hero.IS_IN_WATER = false;
               this.hero.water_friction = 1;
               this.hero.timeOutsideWater = 0;
            }
            if(was_cat_stunned)
            {
               this.hero.stunHandler.stun();
               this.hero.stunHandler.stun_counter_1 = stun_counter_1;
               this.hero.stunHandler.stun_counter_2 = stun_counter_2;
               this.hero.stunHandler.frame_counter = frame_counter;
               this.hero.stunHandler.frame_speed = frame_speed;
            }
            if(is_with_effect)
            {
               SoundSystem.PlaySound("item_pop");
               this.topParticlesManager.pushParticle(new ItemExplosionParticleSprite(),this.hero.xPos + this.hero.WIDTH * 0.5,this.hero.yPos + this.hero.HEIGHT * 0.5,0,0,0);
            }
            Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT] = index;
            SaveManager.SaveGameVariables();
            this.hero.refreshSprite();
         }
      }
      
      public function equipItem(index:int, isRandom:Boolean = false) : void
      {
         Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] = index;
         SaveManager.SaveGameVariables();
      }
      
      public function freezeAction(_timeout:int = 40) : void
      {
         if(Utils.FreezeOn)
         {
            if(_timeout < this.freezeLevelTimeout)
            {
               return;
            }
         }
         Utils.FreezeOn = true;
         this.freezeLevelCounter = 0;
         this.freezeLevelTimeout = _timeout;
      }
      
      public function won() : void
      {
         this.LEVEL_WON_FLAG = true;
         this.stateMachine.performAction("END_ACTION");
         AnalyticsManager.TrackEvent("level","won",Utils.CurrentLevel);
         if(Utils.CurrentLevel == 5 || Utils.CurrentLevel == 13 || Utils.CurrentLevel == 21 || Utils.CurrentLevel == 29 || Utils.CurrentLevel == 37 || Utils.CurrentLevel == 45 || Utils.CurrentLevel == 53 || Utils.CurrentLevel == 61 || Utils.CurrentLevel == 69 || Utils.CurrentLevel == 77)
         {
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_FINISH_VILLAGE_LEVEL_WITH_ANY_CAT);
         }
         else if(this.SECRET_EXIT < 1)
         {
            if(Utils.QUEST_ENEMY_DEFEATED_FLAG == false)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_DEFEATING_ANY_ENEMIES);
            }
            if(Utils.QUEST_HERO_GAME_OVER_FLAG == false)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_DYING);
            }
            if(Utils.QUEST_HERO_DAMAGE_FLAG == false)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_TAKING_ANY_DAMAGE);
            }
            if(Hero.GetCurrentCat() == Hero.CAT_PASCAL)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_FINISH_NORMAL_LEVEL_WITH_PASCAL);
            }
            if(Hero.GetCurrentCat() == Hero.CAT_ROSE)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_FINISH_NORMAL_LEVEL_WITH_ROSE);
            }
            if(Hero.GetCurrentCat() == Hero.CAT_RIGS)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_FINISH_NORMAL_LEVEL_WITH_RIGS);
            }
            if(Utils.QUEST_HERO_JUMP_FLAG == false)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_JUMPING);
            }
            if(Utils.PlayerCoins == 0)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_ANY_COIN);
            }
            if(Utils.QUEST_BELL_COLLECTED_FLAG == false)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_COLLECTING_ANY_BELL);
            }
            if(Utils.QUEST_CAT_CHANGED_FLAG == false)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_WITHOUT_CHANGING_CAT);
            }
            if(Utils.GetLevelTimeSeconds() <= 60)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_NORMAL_LEVEL_COMPLETED_UNDER_60_SECONDS_BY_ANY_CAT);
            }
         }
      }
      
      public function exit() : void
      {
         this.stateMachine.performAction("EXIT_LEVEL_ACTION");
      }
      
      public function gameOver() : void
      {
         this.GAME_OVER_FLAG = true;
         Level.GAME_OVER_AD_FLAG = true;
         this.stateMachine.performAction("END_ACTION");
      }
      
      public function checkAds() : void
      {
         if(Level.GAME_OVER_AD_FLAG || MapState.AD_MUST_BE_SERVED == 1)
         {
            Level.GAME_OVER_AD_FLAG = false;
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 0 && Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GAME_SESSIONS] >= 2 || Utils.CurrentLevel >= 8 || MapState.AD_MUST_BE_SERVED == 1)
               {
                  if(Level.ADS_COUNTER == 0 || MapState.AD_MUST_BE_SERVED == 1)
                  {
                     MapState.AD_MUST_BE_SERVED = 0;
                     if(Adverts.service.interstitials.isSupported)
                     {
                        if(interstitial.isLoaded())
                        {
                           interstitial.show();
                        }
                     }
                  }
                  Level.ADS_COUNTER = 0;
               }
            }
         }
      }
      
      public function playingState() : void
      {
         var i:int = 0;
      }
      
      public function introState() : void
      {
         this.startCutscene(new LevelIntroCutscene(this,this.scriptsManager.initialEntryType));
      }
      
      public function cutsceneState() : void
      {
      }
      
      public function exitLevelState() : void
      {
         this.startCutscene(new LevelOutroCutscene(this));
      }
      
      public function endState() : void
      {
      }
      
      public function headPound() : void
      {
         this.camera.shake(2);
         this.backgroundsManager.shake();
         this.decorationsManager.shake();
         this.collisionsManager.shake();
         this.enemiesManager.shake();
         this.helpersManager.shake();
      }
      
      public function startCutscene(cutscene:Cutscene) : void
      {
         this.blockInput();
         LevelTimer.getInstance().startPause();
         if(cutscene.IS_BLACK_BANDS)
         {
            this.hud.startCutscene();
            this.helpersManager.startCutscene();
         }
         this.stateMachine.performAction("CUTSCENE_START_ACTION");
         this.cutscenesManager.addCutscene(cutscene);
      }
      
      public function endCutscene(cutscene:Cutscene) : void
      {
         this.stateMachine.performAction("CUTSCENE_END_ACTION");
         this.allowInput();
         LevelTimer.getInstance().endPause();
         if(cutscene.IS_BLACK_BANDS)
         {
            this.hud.endCutscene();
            this.helpersManager.endCutscene();
         }
      }
      
      public function deactive() : void
      {
      }
      
      public function blockInput() : void
      {
         this.BLOCK_INPUT = true;
         this.leftPressed = false;
         this.rightPressed = false;
      }
      
      public function allowInput() : void
      {
         this.BLOCK_INPUT = false;
      }
      
      public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         array.push(new Point(0.8,1));
         array.push(new Point(0.8,1));
         array.push(new Point(1,1));
         array.push(new Point(1,1));
         return array;
      }
      
      public function getForegroundMultipliers() : Point
      {
         return new Point(1.2,1.2);
      }
      
      public function setCameraBehaviours() : void
      {
      }
      
      protected function processInput() : void
      {
         var i:int = 0;
         this.rightPressed = this.leftPressed = false;
         if(this.BLOCK_INPUT)
         {
            return;
         }
         var isLastLeft:Boolean = false;
         var isLastRight:Boolean = false;
         if(this.touches != null)
         {
            for(i = 0; i < this.touches.length; i++)
            {
               if(this.touches[i] != null)
               {
                  if(this.touches[i].phase != "ended")
                  {
                     if(this.touches[i].globalX <= Utils.SCREEN_WIDTH * 0.5)
                     {
                        isLastRight = false;
                        isLastLeft = true;
                     }
                     else
                     {
                        isLastRight = true;
                        isLastLeft = false;
                     }
                  }
               }
            }
         }
         if(isLastRight)
         {
            this.rightPressed = true;
            if(!this.wasLastRight)
            {
               this.hero.rightPressed();
            }
         }
         if(isLastLeft)
         {
            this.leftPressed = true;
            if(!this.wasLastLeft)
            {
               this.hero.leftPressed();
            }
         }
         this.wasLastLeft = this.leftPressed;
         this.wasLastRight = this.rightPressed;
      }
      
      public function onClick(event:TouchEvent) : void
      {
         if(this.BLOCK_INPUT || event.target is Button)
         {
            return;
         }
         this.touches = event.getTouches(Utils.rootStage);
      }
      
      public function setQuestionMarkCutscene(index:int = 0) : void
      {
      }
      
      public function isCatChangeAllowed() : Boolean
      {
         return true;
      }
      
      protected function keyDownListener(event:KeyboardEvent) : void
      {
         if(this.BLOCK_INPUT)
         {
            return;
         }
         switch(event.keyCode)
         {
            case Utils.KEY_LEFT:
            case 65:
            case 97:
               if(!this.leftPressed)
               {
                  this.leftPressed = true;
                  this.hero.leftPressed();
               }
               break;
            case Utils.KEY_RIGHT:
            case 68:
            case 100:
               if(!this.rightPressed)
               {
                  this.rightPressed = true;
                  this.hero.rightPressed();
               }
         }
      }
      
      public function refreshCatSprite() : void
      {
         this.hero.refreshSprite();
      }
      
      protected function keyUpListener(event:KeyboardEvent) : void
      {
         if(this.BLOCK_INPUT)
         {
            return;
         }
         switch(event.keyCode)
         {
            case Utils.KEY_LEFT:
            case 65:
            case 97:
               this.leftPressed = false;
               break;
            case Utils.KEY_RIGHT:
            case 68:
            case 100:
               this.rightPressed = false;
               break;
            case 49:
            case 50:
            case 51:
            case 52:
            case 53:
            case 54:
            case 55:
            case 56:
               break;
            case 57:
               this.camera.lockCameraDebug(this.camera.x,this.camera.y);
               break;
            case Utils.KEY_SPACE:
               this.hero.setEmotionParticle(Entity.EMOTION_WORRIED);
               this.debugAction();
         }
      }
      
      public function debugAction() : void
      {
      }
      
      public function restoreLevelMusicAfterButterflies() : void
      {
         if(this.stateMachine.currentState == "IS_PLAYING_STATE")
         {
            if(ButterflyItem.CAUGHT_COUNTER >= 5)
            {
               SoundSystem.PlayMusic("butterflies_complete");
               this.restore_music_counter = 0;
            }
            else
            {
               SoundSystem.StopMusic(true);
               this.playMusic();
            }
         }
      }
      
      public function levelStart() : void
      {
         this.collisionsManager.levelStart();
         this.level_tick = 1;
      }
      
      protected function initHeroes() : void
      {
         this.heroes = new Array();
         this.heroes.push(new GreyCatHero(this,this.scriptsManager.initialXPos,this.scriptsManager.initialYPos,this.scriptsManager.initialDirection));
         this.heroes.push(new BigCatHero(this,this.scriptsManager.initialXPos,this.scriptsManager.initialYPos,this.scriptsManager.initialDirection));
         this.heroes.push(new EvilCatHero(this,this.scriptsManager.initialXPos,this.scriptsManager.initialYPos,this.scriptsManager.initialDirection));
         this.heroes.push(new WaterCatHero(this,this.scriptsManager.initialXPos,this.scriptsManager.initialYPos,this.scriptsManager.initialDirection));
         this.heroes.push(new SmallCatHero(this,this.scriptsManager.initialXPos,this.scriptsManager.initialYPos,this.scriptsManager.initialDirection));
         this.heroes.push(new GlideCatHero(this,this.scriptsManager.initialXPos,this.scriptsManager.initialYPos,this.scriptsManager.initialDirection));
      }
      
      public function unlockGate() : void
      {
      }
      
      public function customEvent(type:int = 0) : void
      {
      }
      
      public function getBackgroundId() : int
      {
         return BackgroundsManager.KITTY_HOUSE_ROOF;
      }
      
      public function restoreTextLabels() : void
      {
         this.hud.dialogsManager.restoreTextLabels();
      }
      
      public function rateAndroid() : void
      {
         var npc:NPC = this.npcsManager.getRateMeNPC();
         npc.rateThanks();
         Utils.Slot.gameVariables[GameSlot.VARIABLE_RATE_GAME] = 1;
         SaveManager.SaveGameVariables();
      }
      
      internal function openedHandler(event:FullScreenContentEvent) : void
      {
         SoundSystem.StopMusic(true,true);
         SoundSystem.Update();
      }
      
      internal function closedHandler(event:FullScreenContentEvent) : void
      {
         this.preloadInterstitial();
         SoundSystem.PlayMusic(this.getMusicName(),-1,true,false);
      }
   }
}
