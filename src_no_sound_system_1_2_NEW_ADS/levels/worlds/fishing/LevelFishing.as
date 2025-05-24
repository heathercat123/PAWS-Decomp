package levels.worlds.fishing
{
   import com.distriqt.extension.adverts.Adverts;
   import com.distriqt.extension.adverts.builders.AdRequestBuilder;
   import com.distriqt.extension.adverts.events.FullScreenContentEvent;
   import entities.*;
   import entities.fishing.*;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.*;
   import interfaces.panels.FishInfoPanel;
   import interfaces.panels.FishingBarPanel;
   import levels.*;
   import levels.backgrounds.*;
   import levels.cameras.*;
   import levels.cameras.behaviours.*;
   import levels.cutscenes.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class LevelFishing extends Level
   {
      
      public static var FISH_CAUGHT_AMOUNT:int = 0;
      
	  [Embed(source="../../../../maps/fishing/fishing_1_0.xml", mimeType="application/octet-stream")]
      public static const Map1_FishingSpot1_0:Class;
      
	  [Embed(source="../../../../maps/fishing/fishing_1_1.xml", mimeType="application/octet-stream")]
      public static const Map1_FishingSpot1_1:Class;
      
	  [Embed(source="../../../../maps/fishing/fishing_1_2.xml", mimeType="application/octet-stream")]
      public static const Map1_FishingSpot1_2:Class;
      
	  [Embed(source="../../../../maps/fishing/fishing_2_0.xml", mimeType="application/octet-stream")]
      public static const Map2_FishingSpot2_0:Class;
      
	  [Embed(source="../../../../maps/fishing/fishing_2_1.xml", mimeType="application/octet-stream")]
      public static const Map2_FishingSpot2_1:Class;
      
	  [Embed(source="../../../../maps/fishing/fishing_2_2.xml", mimeType="application/octet-stream")]
      public static const Map2_FishingSpot2_2:Class;
      
      public var CUTSCENE_FLAG:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      public var IS_CAST_GOING_UP:Boolean;
      
      protected var CASTING_DISTANCE_X:Number;
      
      protected var CASTING_DISTANCE_Y:Number;
      
      protected var sfx_just_once:Boolean;
      
      public var fStateMachine:StateMachine;
      
      public var fishManager:FishManager;
      
      protected var fishingRodImage:Image;
      
      protected var floater:Image;
      
      protected var lure:Lure;
      
      protected var fish:BaseFish;
      
      protected var fishWire:Vector.<Image>;
      
      protected var floater_xPos:Number;
      
      protected var floater_yPos:Number;
      
      protected var floater_yForce:Number;
      
      protected var floater_original_xPos:Number;
      
      protected var floater_original_yPos:Number;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      protected var t_start_y:Number;
      
      protected var t_diff_y:Number;
      
      protected var t_tick_y:Number;
      
      protected var t_time_y:Number;
      
      protected var alpha_counter_1:Number;
      
      protected var floater_last_yVel:Number;
      
      protected var floater_frame:int;
      
      protected var t_friction:Number;
      
      protected var t_friction_tick:Number;
      
      protected var hudPanel:Sprite;
      
      protected var fishingBarPanel:FishingBarPanel;
      
      protected var fishInfoPanel:FishInfoPanel;
      
      protected var delay_counter:int;
      
      protected var lure_speed_multiplier:Number;
      
      protected var _leftFlag:Boolean;
      
      protected var fight_music_counter:int;
      
      protected var wrong_amount_tick:int;
      
      protected var fight_timer:int;
      
      protected var time_frame_for_boost:int;
      
      protected var boost_cooldown:int;
      
      protected var WAS_FISH_CAUGHT:Boolean;
      
      protected var lure_xForce:Number;
      
      protected var lure_yForce:Number;
      
      protected var ROD_LEVEL:int;
      
      public function LevelFishing(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         var __preload:Boolean = false;
         fishing_level_will_initialize_ads = true;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.WAS_FISH_CAUGHT = false;
         this.sfx_just_once = true;
         this.CASTING_DISTANCE_X = this.CASTING_DISTANCE_Y = 0;
         this.IS_CAST_GOING_UP = true;
         this.alpha_counter_1 = 0;
         this.delay_counter = this.floater_frame = 0;
         this._leftFlag = false;
         this.fish = null;
         this.fishInfoPanel = null;
         this.floater_yForce = 0;
         this.t_start = this.t_diff = this.t_tick = this.t_time = this.t_start_y = this.t_diff_y = this.t_tick_y = this.t_time_y = this.floater_last_yVel = 0;
         this.t_friction = this.t_friction_tick = 0;
         this.lure_xForce = this.lure_yForce = 0;
         this.lure_speed_multiplier = 1;
         this.fight_timer = this.time_frame_for_boost = 0;
         this.ROD_LEVEL = Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1] - 1;
         this.wrong_amount_tick = 0;
         super();
         this.CUTSCENE_FLAG = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 0)
            {
               if(Utils.TIME == Utils.NIGHT)
               {
                  urlRequest = new URLRequest(Utils.ROOT_PATH + "/fishing/fishing_1_2.xml");
               }
               else if(Utils.TIME == Utils.DUSK)
               {
                  urlRequest = new URLRequest(Utils.ROOT_PATH + "/fishing/fishing_1_1.xml");
               }
               else
               {
                  urlRequest = new URLRequest(Utils.ROOT_PATH + "/fishing/fishing_1_0.xml");
               }
            }
            else if(SUB_LEVEL == 1)
            {
               if(Utils.TIME == Utils.NIGHT)
               {
                  urlRequest = new URLRequest(Utils.ROOT_PATH + "/fishing/fishing_2_2.xml");
               }
               else if(Utils.TIME == Utils.DUSK)
               {
                  urlRequest = new URLRequest(Utils.ROOT_PATH + "/fishing/fishing_2_1.xml");
               }
               else
               {
                  urlRequest = new URLRequest(Utils.ROOT_PATH + "/fishing/fishing_2_0.xml");
               }
            }
            else
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/fishing/fishing_1_0.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else if(SUB_LEVEL == 0)
         {
            if(Utils.TIME == Utils.NIGHT)
            {
               map = new XML(new Map1_FishingSpot1_2());
            }
            else if(Utils.TIME == Utils.DUSK)
            {
               map = new XML(new Map1_FishingSpot1_1());
            }
            else
            {
               map = new XML(new Map1_FishingSpot1_0());
            }
         }
         else if(SUB_LEVEL == 1)
         {
            if(Utils.TIME == Utils.NIGHT)
            {
               map = new XML(new Map2_FishingSpot2_2());
            }
            else if(Utils.TIME == Utils.DUSK)
            {
               map = new XML(new Map2_FishingSpot2_1());
            }
            else
            {
               map = new XML(new Map2_FishingSpot2_0());
            }
         }
         else
         {
            map = new XML(new Map1_FishingSpot1_0());
         }
         this.fishManager = new FishManager(this);
         this.fStateMachine = new StateMachine();
         this.fStateMachine.setRule("IS_NOT_FISHING_STATE","STEP_ON_DECK_ACTION","IS_POSITIONING_STATE");
         this.fStateMachine.setRule("IS_POSITIONING_STATE","END_ACTION","IS_CASTING_STATE");
         this.fStateMachine.setRule("IS_CASTING_STATE","END_ACTION","IS_LURE_FLYING_STATE");
         this.fStateMachine.setRule("IS_LURE_FLYING_STATE","START_ACTION","IS_REELING_STATE");
         this.fStateMachine.setRule("IS_REELING_STATE","BITE_ACTION","IS_FIGHTING_STATE");
         this.fStateMachine.setRule("IS_FIGHTING_STATE","WON_ACTION","IS_FISH_CAUGHT_STATE");
         this.fStateMachine.setRule("IS_FIGHTING_STATE","LOST_ACTION","IS_FISH_LOST_STATE");
         this.fStateMachine.setRule("IS_FISH_CAUGHT_STATE","END_ACTION","IS_END_FISHING_STATE");
         this.fStateMachine.setRule("IS_FISH_LOST_STATE","END_ACTION","IS_RETURNING_STATE");
         this.fStateMachine.setRule("IS_REELING_STATE","END_ACTION","IS_END_FISHING_STATE");
         this.fStateMachine.setRule("IS_RETURNING_STATE","END_ACTION","IS_END_FISHING_STATE");
         this.fStateMachine.setRule("IS_END_FISHING_STATE","END_ACTION","IS_NOT_FISHING_STATE");
         this.fStateMachine.setFunctionToState("IS_NOT_FISHING_STATE",this.notFishingState);
         this.fStateMachine.setFunctionToState("IS_POSITIONING_STATE",this.positioningState);
         this.fStateMachine.setFunctionToState("IS_CASTING_STATE",this.castingState);
         this.fStateMachine.setFunctionToState("IS_LURE_FLYING_STATE",this.lureFlyingState);
         this.fStateMachine.setFunctionToState("IS_REELING_STATE",this.reelingState);
         this.fStateMachine.setFunctionToState("IS_FIGHTING_STATE",this.fightingState);
         this.fStateMachine.setFunctionToState("IS_FISH_LOST_STATE",this.fishLost);
         this.fStateMachine.setFunctionToState("IS_FISH_CAUGHT_STATE",this.fishCaughtState);
         this.fStateMachine.setFunctionToState("IS_RETURNING_STATE",this.returningState);
         this.fStateMachine.setFunctionToState("IS_END_FISHING_STATE",this.endFishingState);
         this.fStateMachine.setState("IS_NOT_FISHING_STATE");
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
               interstitial.setAdUnitId(Utils.ADMOB_INTERSTITIAL_FISHING_ID_ANDROID);
            }
            interstitial.addEventListener(FullScreenContentEvent.SHOW,this.openedHandler);
            interstitial.addEventListener(FullScreenContentEvent.DISMISSED,this.closedHandler);
            this.preloadInterstitial();
         }
         if(!Utils.LEVEL_RUNTIME)
         {
            this.levelLoaded();
         }
      }
      
      override public function isCatChangeAllowed() : Boolean
      {
         if(this.fStateMachine.currentState == "IS_NOT_FISHING_STATE")
         {
            return true;
         }
         return false;
      }
      
      override protected function preloadInterstitial() : void
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
      
      override public function levelLoaded() : void
      {
         this.init();
         this.setCameraBehaviours();
         this.fishManager.postInit();
         LEVEL_LOADED = true;
      }
      
      override public function setCameraBehaviours() : void
      {
         camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
      }
      
      override public function init() : void
      {
         var i:int = 0;
         var image:Image = null;
         super.init();
         if(SUB_LEVEL == 2)
         {
            camera.yPos = int(864 + camera.getVerticalOffsetFromGroundLevel() - camera.HEIGHT);
         }
         this.fishingRodImage = new Image(TextureManager.sTextureAtlas.getTexture("fishing_rod"));
         this.fishingRodImage.touchable = false;
         Utils.world.addChild(this.fishingRodImage);
         this.fishingRodImage.visible = false;
         this.fishingRodImage.alpha = 0;
         this.fishWire = new Vector.<Image>();
         for(i = 0; i < 6; i++)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("fishing_wire"));
            image.pivotX = image.pivotY = 3;
            image.touchable = false;
            Utils.world.addChild(image);
            image.visible = false;
            this.fishWire.push(image);
         }
         this.floater = new Image(TextureManager.sTextureAtlas.getTexture("fishing_floater_" + Utils.Slot.playerInventory[LevelItems.ITEM_FISHING_ROD_1]));
         this.floater.pivotX = this.floater.pivotY = 8;
         this.floater.touchable = false;
         Utils.world.addChild(this.floater);
         this.floater.alpha = 0;
         this.lure = new Lure(this,296,157,0);
         this.hudPanel = new Sprite();
         this.hudPanel.scaleX = this.hudPanel.scaleY = Utils.GFX_SCALE;
         Utils.rootMovie.addChild(this.hudPanel);
         this.fishingBarPanel = new FishingBarPanel(this);
         this.hudPanel.addChild(this.fishingBarPanel);
      }
      
      override public function exitLevel() : void
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
         this.hudPanel.removeChild(this.fishingBarPanel);
         this.fishingBarPanel.destroy();
         this.fishingBarPanel.dispose();
         this.fishingBarPanel = null;
         if(this.fishInfoPanel != null)
         {
            this.hudPanel.removeChild(this.fishInfoPanel);
            this.fishInfoPanel.destroy();
            this.fishInfoPanel.dispose();
            this.fishInfoPanel = null;
         }
         Utils.rootMovie.removeChild(this.hudPanel);
         this.hudPanel.dispose();
         this.hudPanel = null;
         this.lure.destroy();
         this.lure = null;
         Utils.world.removeChild(this.floater);
         this.floater.dispose();
         this.floater = null;
         for(i = 0; i < this.fishWire.length; i++)
         {
            Utils.world.removeChild(this.fishWire[i]);
            this.fishWire[i].dispose();
            this.fishWire[i] = null;
         }
         this.fishWire = null;
         Utils.world.removeChild(this.fishingRodImage);
         this.fishingRodImage.dispose();
         this.fishingRodImage = null;
         this.fStateMachine.destroy();
         this.fStateMachine = null;
         this.fishManager.destroy();
         this.fishManager = null;
         super.exitLevel();
      }
      
      public function keyInput(_isLeft:Boolean) : void
      {
         if(this.fStateMachine.currentState == "IS_CASTING_STATE")
         {
            if(this.delay_counter >= 45)
            {
               this.fStateMachine.performAction("END_ACTION");
            }
         }
         else if(this.fStateMachine.currentState == "IS_REELING_STATE")
         {
            this.floater_yForce -= 0.2;
         }
      }
      
      override public function update() : void
      {
         var do_not_update:Boolean = false;
         var _max_value:Number = NaN;
         var _fish_id:int = 0;
         var fish_winning:Boolean = false;
         if(Utils.FreezeOn == false)
         {
            this.fishingBarPanel.update();
            if(this.fStateMachine.currentState == "IS_NOT_FISHING_STATE")
            {
               if(hero.xPos >= 208)
               {
                  SoundSystem.StopMusic();
                  this.fStateMachine.performAction("STEP_ON_DECK_ACTION");
               }
            }
            else if(this.fStateMachine.currentState == "IS_POSITIONING_STATE")
            {
               if(stateMachine.currentState == "IS_PLAYING_STATE")
               {
                  this.fStateMachine.performAction("END_ACTION");
               }
            }
            else if(this.fStateMachine.currentState == "IS_CASTING_STATE")
            {
               ++this.delay_counter;
            }
            else if(this.fStateMachine.currentState == "IS_LURE_FLYING_STATE")
            {
               this.t_tick += 1 / 60;
               ++counter1;
               if(counter1 >= 10)
               {
                  counter1 = 0;
                  this.floater.rotation += Math.PI * 0.5;
               }
               this.floater_xPos = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
               if(this.IS_CAST_GOING_UP)
               {
                  this.t_tick_y += 1 / 60;
                  if(this.t_tick_y >= this.t_time_y)
                  {
                     this.t_tick_y = this.t_time_y;
                  }
                  this.floater_yPos = Easings.easeOutSine(this.t_tick_y,this.t_start_y,this.t_diff_y,this.t_time_y);
                  if(this.t_tick_y >= this.t_time_y)
                  {
                     this.IS_CAST_GOING_UP = false;
                     this.t_start_y = this.floater_yPos;
                     this.t_diff_y = -this.t_diff_y;
                     this.t_tick_y = 0;
                  }
               }
               else
               {
                  this.t_tick_y += 1 / 60;
                  if(this.t_tick_y >= this.t_time_y)
                  {
                     this.t_tick_y = this.t_time_y;
                     this.floater_yPos += this.floater_last_yVel;
                  }
                  else
                  {
                     this.floater_last_yVel = this.floater_yPos;
                     this.floater_yPos = Easings.easeInSine(this.t_tick_y,this.t_start_y,this.t_diff_y,this.t_time_y);
                     this.floater_last_yVel = this.floater_yPos - this.floater_last_yVel;
                  }
                  if(this.floater_yPos >= Utils.SEA_LEVEL)
                  {
                     SoundSystem.PlaySound("enemy_water");
                     if(Utils.TIME == Utils.DUSK)
                     {
                        particlesManager.createSplashParticle(this.floater_xPos,1);
                     }
                     else
                     {
                        particlesManager.createSplashParticle(this.floater_xPos);
                     }
                     this.floater.rotation = 0;
                     this.floater_yForce = 2;
                     this.fStateMachine.performAction("START_ACTION");
                  }
               }
               this.lure.xPos = this.floater_xPos;
               this.lure.yPos = this.floater_yPos;
            }
            else if(this.fStateMachine.currentState == "IS_REELING_STATE")
            {
               if(leftPressed || rightPressed)
               {
                  SoundSystem.PlaySound("reel");
                  this.t_friction_tick += 1 / 60;
                  if(this.t_friction_tick >= 2)
                  {
                     this.t_friction_tick = 2;
                  }
                  this.t_friction = Easings.easeOutQuart(this.t_friction_tick,0,1,2);
                  this._leftFlag = true;
                  this.lure.yVel = -1 * this.t_friction;
                  if(this.lure.yPos <= Utils.SEA_LEVEL + 8)
                  {
                     this.lure_speed_multiplier += 0.01;
                     if(this.lure_speed_multiplier >= 2)
                     {
                        this.lure_speed_multiplier = 2;
                     }
                  }
                  else
                  {
                     this.lure_speed_multiplier = 1;
                  }
                  this.lure.xPos -= this.lure_speed_multiplier * this.t_friction;
                  ++this.floater_frame;
                  hero.sprite.gfxHandle().gotoAndStop(9);
                  hero.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               }
               else
               {
                  fish_winning = true;
                  this.t_friction_tick = 0;
                  if(this._leftFlag)
                  {
                     this._leftFlag = false;
                     this.lure.yVel = 0;
                  }
                  hero.sprite.gfxHandle().gotoAndStop(1);
                  hero.sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
               }
               if(this.lure.xPos <= 320)
               {
                  this.fStateMachine.performAction("END_ACTION");
               }
               this.updateFloaterToLure();
            }
            else if(this.fStateMachine.currentState == "IS_FIGHTING_STATE")
            {
               ++this.fight_timer;
               ++this.fight_music_counter;
               if(this.fight_music_counter == 20)
               {
                  SoundSystem.PlayMusic("fishing_fight");
               }
               this.lure.sxArrow.visible = this.lure.dxArrow.visible = false;
               if(leftPressed || rightPressed)
               {
                  hero.sprite.gfxHandle().gotoAndStop(9);
                  hero.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               }
               else
               {
                  hero.sprite.gfxHandle().gotoAndStop(1);
                  hero.sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
               }
               if(this.fish.stateMachine.currentState == "IS_JUMPING_STATE")
               {
                  this.lure.yPos = this.fish.yPos;
               }
               else
               {
                  if(this.fish.FIGHT_DIRECTION == Entity.RIGHT)
                  {
                     this.lure.sxArrow.visible = true;
                  }
                  else
                  {
                     this.lure.dxArrow.visible = true;
                  }
                  if(this.fish.direction_change_counter <= 15)
                  {
                     this.time_frame_for_boost = 0;
                     this.lure.fightingDirectionAboutToChange();
                     SoundSystem.PlaySound("wiggle");
                  }
                  else
                  {
                     ++this.time_frame_for_boost;
                  }
                  --this.boost_cooldown;
                  if(this.boost_cooldown <= 0)
                  {
                     this.boost_cooldown = 0;
                  }
                  if(leftPressed && this.lure.sxArrow.visible && !rightPressed || rightPressed && this.lure.dxArrow.visible && !leftPressed)
                  {
                     this.t_friction_tick += 1 / 60;
                     if(this.t_friction_tick >= 1)
                     {
                        this.t_friction_tick = 1;
                     }
                     this.t_friction = Easings.easeOutQuart(this.t_friction_tick,0,1,1);
                     this._leftFlag = true;
                     this.lure_xForce -= 0.2 * Math.pow(2,this.ROD_LEVEL) * this.t_friction * (1.1 - this.fish.stamina);
                     this.lure_yForce -= 0.05 * Math.pow(2,this.ROD_LEVEL) * this.t_friction * (1.1 - this.fish.stamina);
                     ++this.floater_frame;
                     _max_value = -(1 + this.ROD_LEVEL * 0.2);
                     if(this.lure_xForce < _max_value)
                     {
                        this.lure_xForce = _max_value;
                     }
                     if(this.lure_xForce < _max_value * 0.5)
                     {
                        SoundSystem.PlaySound("reel");
                     }
                     else
                     {
                        SoundSystem.PlaySound("reel_struggle");
                     }
                     this.fish.correctUserInput();
                     if(this.fight_timer > 30 && this.time_frame_for_boost < 30)
                     {
                        if(this.wrong_amount_tick > 0)
                        {
                           if(this.wrong_amount_tick < 10)
                           {
                              if(this.boost_cooldown == 0)
                              {
                                 this.fish.greatUserInput();
                                 this.boost_cooldown = 120;
                              }
                           }
                           this.wrong_amount_tick = 0;
                        }
                     }
                  }
                  else
                  {
                     if(this.fight_timer > 30)
                     {
                        if(this.fish.direction_change_counter > 15)
                        {
                           ++this.wrong_amount_tick;
                           if(this.wrong_amount_tick == 31)
                           {
                              this.fish.badUserInput();
                              SoundSystem.PlaySound("error");
                           }
                        }
                     }
                     this.t_friction_tick -= 1 / 60;
                     if(this.t_friction_tick <= 0)
                     {
                        this.t_friction_tick = 0;
                     }
                     this.t_friction = Easings.easeOutQuart(this.t_friction_tick,0,1,1);
                     this.lure_xForce -= 0.1 * Math.pow(2,this.ROD_LEVEL) * this.t_friction * (1.1 - this.fish.stamina);
                     this.lure_yForce -= 0.025 * Math.pow(2,this.ROD_LEVEL) * this.t_friction * (1.1 - this.fish.stamina);
                     if(this.lure_xForce < -(1 + this.ROD_LEVEL * 0.2))
                     {
                        this.lure_xForce = -(1 + this.ROD_LEVEL * 0.2);
                     }
                     fish_winning = true;
                     this.lure.yVel = 0;
                     this.fish.wrongUserInput();
                  }
               }
               this.updateFloaterToLure();
               if(this.lure.xPos <= 320 && this.fish.stateMachine.currentState != "IS_JUMPING_STATE")
               {
                  SoundSystem.PlayMusic("butterflies_complete");
                  this.fishManager.spawnNextFish();
                  this.fStateMachine.performAction("WON_ACTION");
               }
               else if(this.fish.IS_ESCAPED)
               {
                  this.fishManager.spawnNextFish();
                  this.fStateMachine.performAction("LOST_ACTION");
               }
            }
            else if(this.fStateMachine.currentState == "IS_RETURNING_STATE")
            {
               if(camera.xPos <= camera.LEFT_MARGIN)
               {
                  ++this.delay_counter;
                  if(this.delay_counter == 20)
                  {
                     hero.setEmotionParticle(Entity.EMOTION_WORRIED);
                  }
                  else if(this.delay_counter >= 80)
                  {
                     this.fStateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(this.fStateMachine.currentState == "IS_FISH_LOST_STATE")
            {
               this.lure_xForce = 0;
               this.lure_yForce = 0;
               if(this.fish != null)
               {
                  if(this.fish.xPos >= camera.xPos + camera.WIDTH + 32)
                  {
                     this.fish.dead = true;
                     this.fish = null;
                     this.fStateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(this.fStateMachine.currentState == "IS_FISH_CAUGHT_STATE")
            {
               this.lure_xForce = this.lure_yForce = this.fish.xForce = this.fish.yForce = 0;
               if(this.delay_counter == 0)
               {
                  if(this.fish.IS_RARE)
                  {
                     AchievementsManager.SubmitAchievement("sctp_2");
                     LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_COIN,CoinPrices.GetFishRareCoinReward(this.fish.RANK));
                  }
                  else if(this.fish.IS_GOLDEN)
                  {
                     AchievementsManager.SubmitAchievement("sctp_3");
                     LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_COIN,CoinPrices.GetFishGoldenCoinReward(this.fish.RANK));
                  }
               }
               if(this.delay_counter >= 0)
               {
                  ++this.delay_counter;
                  if(this.delay_counter == 60)
                  {
                     this.fishInfoPanel.setAppear();
                  }
                  else if(this.delay_counter >= 120)
                  {
                     if(leftPressed || rightPressed)
                     {
                        _fish_id = LevelItems.GetFishItemId(this.fish.TYPE);
                        LevelItems.AddItemToInventoryAndSave(_fish_id);
                        if(this.fish.SIZE > Utils.Slot.fishRecords[_fish_id])
                        {
                           Utils.Slot.fishRecords[_fish_id] = this.fish.SIZE;
                           SaveManager.SaveFishRecords();
                        }
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_FISHING_POINTS] += this.fishInfoPanel.points;
                        AchievementsManager.SubmitScore("fishing",Utils.Slot.gameVariables[GameSlot.VARIABLE_FISHING_POINTS]);
                        SaveManager.SaveGameVariables();
                        this.fishInfoPanel.setDisappear();
                        this.delay_counter = -1;
                        QuestsManager.SubmitQuestAction(QuestsManager.ACTION_CATCH_ANY_FISH);
                        if(_fish_id == LevelItems.ITEM_FISH_RED_JUMPER)
                        {
                           QuestsManager.SubmitQuestAction(QuestsManager.ACTION_CATCH_RED_JUMPER_FISH);
                        }
                        else if(_fish_id == LevelItems.ITEM_FISH_GREEN_CARP)
                        {
                           QuestsManager.SubmitQuestAction(QuestsManager.ACTION_CATCH_GREEN_CARP_FISH);
                        }
                        else if(_fish_id == LevelItems.ITEM_FISH_GOLDFISH)
                        {
                           QuestsManager.SubmitQuestAction(QuestsManager.ACTION_CATCH_GOLDFISH_FISH);
                        }
                        else if(_fish_id == LevelItems.ITEM_FISH_BLOWFISH)
                        {
                           QuestsManager.SubmitQuestAction(QuestsManager.ACTION_CATCH_BLOWFISH_FISH);
                        }
                        else if(_fish_id == LevelItems.ITEM_FISH_CRAB)
                        {
                           QuestsManager.SubmitQuestAction(QuestsManager.ACTION_CATCH_CRAB_FISH);
                        }
                        else if(_fish_id == LevelItems.ITEM_FISH_SQUID)
                        {
                           QuestsManager.SubmitQuestAction(QuestsManager.ACTION_CATCH_SQUID_FISH);
                        }
                        else if(_fish_id == LevelItems.ITEM_FISH_CAT_FISH)
                        {
                           QuestsManager.SubmitQuestAction(QuestsManager.ACTION_CATCH_CAT_FISH);
                        }
                     }
                  }
               }
               else
               {
                  --this.delay_counter;
                  if(this.delay_counter == -30)
                  {
                     this.fish.dead = true;
                     this.fish = null;
                     this.fStateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(this.fStateMachine.currentState == "IS_END_FISHING_STATE")
            {
               if(stateMachine.currentState == "IS_PLAYING_STATE")
               {
                  this.fStateMachine.performAction("END_ACTION");
               }
            }
            do_not_update = false;
            if(this.fish != null)
            {
               if(this.fish.stateMachine.currentState == "IS_JUMPING_STATE")
               {
                  do_not_update = true;
               }
            }
            if(do_not_update)
            {
               this.fishManager.update(this.lure);
            }
            else
            {
               this.lure_xForce *= 0.8;
               this.lure_yForce *= 0.8;
               this.lure.update();
               this.fishManager.update(this.lure);
               if(this.fish != null && this.fStateMachine.currentState != "IS_FISH_LOST_STATE")
               {
                  this.fish.previousXPos = this.fish.xPos;
                  if(Utils.Slot.gameProgression[15] != 2)
                  {
                     if(this.fish.xPos >= this.fish.originalXPos + 64)
                     {
                        this.fish.xPos = this.fish.originalXPos + 64;
                        this.lure.xPos = this.fish.xPos;
                        this.fish.xForce = 0;
                     }
                  }
                  this.lure.xPos += this.lure_xForce + this.fish.xForce;
                  this.lure.yPos += this.lure_yForce + this.fish.yForce;
                  this.fish.xPos = this.lure.xPos;
                  this.fish.yPos = this.lure.yPos;
                  if(this.lure_xForce + this.fish.xForce < 0)
                  {
                     this.fish.DIRECTION = Entity.LEFT;
                  }
                  else
                  {
                     this.fish.DIRECTION = Entity.RIGHT;
                  }
               }
            }
         }
         if(this.fishInfoPanel != null)
         {
            this.fishInfoPanel.update();
         }
         super.update();
         this.updateScreenPositions();
      }
      
      protected function updateFloaterToLure() : void
      {
         this.floater_xPos = this.lure.xPos;
         this.floater_yPos += this.floater_yForce;
         this.floater_yForce += -0.05 * (this.floater_yPos - Utils.SEA_LEVEL);
         if(this.floater_yPos <= Utils.SEA_LEVEL)
         {
            this.floater_yForce *= 0.8;
         }
      }
      
      protected function updateScreenPositions() : void
      {
         var i:int = 0;
         var start_x:Number = NaN;
         var start_y:Number = NaN;
         var end_x:Number = NaN;
         var end_y:Number = NaN;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var step_x:Number = NaN;
         var step_y:Number = NaN;
         if(this.fishingRodImage.visible)
         {
            if(hero.sprite.gfxHandle().frame == 1)
            {
               this.fishingRodImage.x = int(Math.floor(hero.xPos + 12 - camera.xPos));
            }
            else
            {
               this.fishingRodImage.x = int(Math.floor(hero.xPos + 10 - camera.xPos));
            }
            this.fishingRodImage.y = int(Math.floor(hero.yPos + 2 - camera.yPos));
            if(this.fishingRodImage.alpha < 1)
            {
               ++this.alpha_counter_1;
               if(this.alpha_counter_1 > 3)
               {
                  this.alpha_counter_1 = 0;
                  this.fishingRodImage.alpha += 0.25;
               }
            }
            start_x = hero.xPos + 24;
            start_y = hero.yPos + 4;
            end_x = this.floater_xPos;
            end_y = this.floater_yPos;
            diff_x = end_x - start_x;
            diff_y = end_y - start_y;
            step_x = diff_x / 6;
            step_y = diff_y / 6;
            for(i = 0; i < this.fishWire.length; i++)
            {
               this.fishWire[i].visible = true;
               this.fishWire[i].x = int(Math.floor(start_x + step_x * i + step_x * 0.5 - camera.xPos));
               this.fishWire[i].y = int(Math.floor(start_y + step_y * i + step_y * 0.5 - camera.yPos));
            }
         }
         if(this.floater_frame < 8)
         {
            this.floater.scaleX = 1;
         }
         else if(this.floater_frame >= 8)
         {
            this.floater.scaleX = -1;
            if(this.floater_frame >= 16)
            {
               this.floater_frame = 0;
            }
         }
         this.floater.x = int(Math.floor(this.floater_xPos - camera.xPos));
         this.floater.y = int(Math.floor(this.floater_yPos - camera.yPos));
         this.floater.alpha = this.fishingRodImage.alpha;
         this.fishManager.updateScreenPositions(camera);
         this.lure.updateScreenPosition(camera);
      }
      
      protected function notFishingState() : void
      {
         if(this.WAS_FISH_CAUGHT)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_FISHING_POINTS] >= 25)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PREMIUM] == 0 && Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
               {
                  if(LevelFishing.FISH_CAUGHT_AMOUNT == 0)
                  {
                     if(Adverts.service.interstitials.isSupported)
                     {
                        if(interstitial.isLoaded())
                        {
                           interstitial.show();
                        }
                     }
                  }
                  ++LevelFishing.FISH_CAUGHT_AMOUNT;
                  if(LevelFishing.FISH_CAUGHT_AMOUNT >= 3)
                  {
                     LevelFishing.FISH_CAUGHT_AMOUNT = 0;
                  }
               }
            }
            this.WAS_FISH_CAUGHT = false;
         }
      }
      
      protected function positioningState() : void
      {
         startCutscene(new FishingCutscene(this,0));
         this.lure.xPos = this.floater_xPos = this.floater_original_xPos = 296;
         this.lure.yPos = this.floater_yPos = this.floater_original_yPos = 157;
         this.lure.reset();
      }
      
      protected function castingState() : void
      {
         this.WAS_FISH_CAUGHT = false;
         SoundSystem.PlayMusic("fishing");
         this.lure.setAABBPhysics(null);
         this.floater.visible = true;
         this.floater.alpha = 0;
         this.fish = null;
         this.delay_counter = 0;
         this.fishingRodImage.visible = true;
         this.fishingRodImage.alpha = 0;
         this.fishingBarPanel.stateMachine.setState("IS_CAST_APPEARING_STATE");
      }
      
      protected function lureFlyingState() : void
      {
         this.fishingBarPanel.stateMachine.setState("IS_CAST_DISAPPEARING_STATE");
         SoundSystem.PlaySound("cast");
         camera.LEFT_MARGIN = camera.xPos;
         camera.changeHorBehaviour(new LureTargetBehaviour(this,this.lure,true),true);
         camera.changeVerBehaviour(new LureTargetBehaviour(this,this.lure,false),true);
         this.IS_CAST_GOING_UP = true;
         this.CASTING_DISTANCE_X = 32 + (416 + this.ROD_LEVEL * 192) * this.fishingBarPanel.CASTING_POWER;
         this.CASTING_DISTANCE_Y = 32 + (96 + this.ROD_LEVEL * 16) * this.fishingBarPanel.CASTING_POWER;
         this.t_start = this.floater_xPos;
         this.t_start_y = this.floater_yPos;
         this.t_diff = this.CASTING_DISTANCE_X;
         this.t_diff_y = -this.CASTING_DISTANCE_Y;
         this.t_tick = this.t_tick_y = 0;
         this.t_time = Easings.easeOutQuad(this.fishingBarPanel.CASTING_POWER,0.5,1.5 + this.ROD_LEVEL * 0.25 * this.fishingBarPanel.CASTING_POWER,1);
         this.t_time_y = this.t_time * 0.5;
      }
      
      protected function reelingState() : void
      {
         this.t_friction = this.t_friction_tick = 0;
         this.lure.setReeling();
      }
      
      protected function fightingState() : void
      {
         this.fight_music_counter = 0;
         freezeAction(20);
         camera.shake(1);
         this.t_friction_tick = 0;
         this.fishManager.spawn_x = this.fish.originalXPos;
         this.fish.setFighting();
         this.lure.setFighting();
         this.fish.oldXPos = this.fish.xPos = this.lure.xPos;
      }
      
      protected function fishLost() : void
      {
         SoundSystem.StopMusic(true);
         SoundSystem.PlaySound("cat_hurt_game_over");
         camera.shake();
         freezeAction(20);
         this.lure.setCaught();
      }
      
      protected function fishCaughtState() : void
      {
         this.WAS_FISH_CAUGHT = true;
         this.fish.setCaught();
         this.lure.setCaught();
         var ver_tween:VerTweenShiftBehaviour = new VerTweenShiftBehaviour(this);
         ver_tween.y_start = camera.yPos;
         ver_tween.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
         ver_tween.time = 0.75;
         camera.changeVerBehaviour(ver_tween,true);
         this.delay_counter = 0;
         if(this.fishInfoPanel != null)
         {
            this.hudPanel.removeChild(this.fishInfoPanel);
            this.fishInfoPanel.destroy();
            this.fishInfoPanel.dispose();
            this.fishInfoPanel = null;
         }
         this.fishInfoPanel = new FishInfoPanel(this.fish);
         this.hudPanel.addChild(this.fishInfoPanel);
         this.fishInfoPanel.x = int((Utils.WIDTH - this.fishInfoPanel.WIDTH) * 0.5);
         this.fishInfoPanel.y = int((Utils.HEIGHT - this.fishInfoPanel.HEIGHT) * 0.5);
         this.fishInfoPanel.visible = false;
      }
      
      protected function returningState() : void
      {
         this.delay_counter = 0;
         var ver_tween:VerTweenShiftBehaviour = new VerTweenShiftBehaviour(this);
         ver_tween.y_start = camera.yPos;
         ver_tween.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
         ver_tween.time = 0.75;
         var hor_tween:HorTweenShiftBehaviour = new HorTweenShiftBehaviour(this);
         hor_tween.x_start = camera.xPos;
         hor_tween.x_end = camera.LEFT_MARGIN;
         var _time:Number = (hor_tween.x_start - hor_tween.x_end) / 640;
         if(_time < 0.5)
         {
            _time = 0.5;
         }
         else if(_time > 3)
         {
            _time = 3;
         }
         hor_tween.time = _time;
         ver_tween.time = _time;
         camera.changeHorBehaviour(hor_tween);
         camera.changeVerBehaviour(ver_tween,true);
      }
      
      protected function endFishingState() : void
      {
         var i:int = 0;
         SoundSystem.StopMusic();
         startCutscene(new FishingCutscene(this,1));
         var ver_tween:VerTweenShiftBehaviour = new VerTweenShiftBehaviour(this);
         ver_tween.y_start = camera.yPos;
         ver_tween.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
         ver_tween.time = 0.75;
         camera.changeVerBehaviour(ver_tween,true);
         this.lure.sprite.visible = false;
         this.floater.visible = false;
         this.fishingRodImage.visible = false;
         for(i = 0; i < this.fishWire.length; i++)
         {
            this.fishWire[i].visible = false;
         }
      }
      
      override public function setQuestionMarkCutscene(index:int = 0) : void
      {
         if(index == 0)
         {
            startCutscene(new QuestionMarkCutscene(this));
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 1)
         {
            if(Utils.TIME == Utils.DUSK || Utils.TIME == Utils.NIGHT)
            {
               array.push(new Point(0,0));
            }
            else
            {
               array.push(new Point(0.4,0));
            }
            array.push(new Point(0.5,1));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else
         {
            array.push(new Point(0.4,1));
            array.push(new Point(0.5,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         return new Point(1.2,1.2);
      }
      
      override public function getMusicName() : String
      {
         if(SUB_LEVEL == 1)
         {
            if(Utils.TIME == Utils.NIGHT)
            {
               return "outside_sea_night";
            }
            return "outside_sea";
         }
         if(Utils.TIME == Utils.NIGHT || Utils.TIME == Utils.DUSK)
         {
            return "outside_trees_night";
         }
         return "outside_background";
      }
      
      override public function playMusic() : void
      {
         SoundSystem.PlayMusic(this.getMusicName(),-1,false,true);
      }
      
      override public function getBackgroundId() : int
      {
         if(SUB_LEVEL == 0)
         {
            if(Utils.TIME == Utils.NIGHT)
            {
               return BackgroundsManager.STARRY_NIGHT_NO_CLOUDS;
            }
            if(Utils.TIME == Utils.DUSK)
            {
               return BackgroundsManager.KITTY_HOUSE_ROOF;
            }
            return BackgroundsManager.TURNIP_GARDEN;
         }
         if(SUB_LEVEL == 1)
         {
            if(Utils.TIME == Utils.NIGHT)
            {
               return BackgroundsManager.SEASIDE_NIGHT;
            }
            if(Utils.TIME == Utils.DUSK)
            {
               return BackgroundsManager.DESERT;
            }
            return BackgroundsManager.SEASIDE;
         }
         return BackgroundsManager.TURNIP_GARDEN;
      }
      
      public function fishBit(_fish:BaseFish) : void
      {
         this.fish = _fish;
         this.lure.setAABBPhysics(this.fish);
         this.fStateMachine.performAction("BITE_ACTION");
         this.fight_timer = 0;
         this.time_frame_for_boost = 0;
         this.boost_cooldown = 0;
         this.wrong_amount_tick = 0;
         SoundSystem.StopMusic(true);
         SoundSystem.PlaySound("fish_bite");
      }
      
      internal function openedHandler(event:FullScreenContentEvent) : void
      {
         SoundSystem.StopMusic(true,true);
         SoundSystem.Update();
      }
      
      internal function closedHandler(event:FullScreenContentEvent) : void
      {
         this.preloadInterstitial();
         SoundSystem.PlayMusic(this.getMusicName(),-1,true,true);
      }
   }
}

