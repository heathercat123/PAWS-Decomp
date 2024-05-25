package states
{
   import com.distriqt.extension.gameservices.GameServices;
   import com.distriqt.extension.gameservices.Service;
   import com.distriqt.extension.gameservices.events.GameServicesEvent;
   import com.distriqt.extension.gameservices.events.LeaderboardEvent;
   import flash.desktop.NativeApplication;
   import flash.desktop.SystemIdleMode;
   import flash.events.KeyboardEvent;
   import flash.geom.*;
   import flash.net.*;
   import flash.system.*;
   import flash.ui.Keyboard;
   import game_utils.*;
   import interfaces.panels.*;
   import levels.*;
   import levels.backgrounds.*;
   import starling.animation.*;
   import starling.core.Starling;
   import starling.display.*;
   import starling.events.*;
   import starling.text.*;
   
   public class SplashState implements IState
   {
      
      protected static var AutenticateJustOnce:Boolean = false;
      
      protected static var SAVE_SESSION:Boolean = true;
       
      
      public var GET_OUT_FLAG:Boolean;
      
      public var choice:int;
      
      public var menuBackground:MenuBackground;
      
      public var gameTitle:GameTitlePanel;
      
      public var playPanel:TapToPlayPanel;
      
      public var splashHudPanel:SplashHudPanel;
      
      public var settingsPanel:SettingsPanel;
      
      public var exitPanel:ExitPanel;
      
      public var whiteFadeImage:Image;
      
      public var stateMachine:StateMachine;
      
      public var container:Sprite;
      
      protected var FLAG_1:Boolean;
      
      protected var FLAG_2:Boolean;
      
      protected var PROGRESSION:int;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var counter3:int;
      
      protected var y_margin:Number;
      
      protected var bounceTween:Tween;
      
      protected var shiftTween:Tween;
      
      protected var lastWay:Boolean;
      
      protected var touch_area_1:Rectangle;
      
      protected var normal_counter:int;
      
      protected var normal_delay:int;
      
      protected var music_counter:int;
      
      protected var justOnce:Boolean;
      
      protected var alpha_mult:Number;
      
      protected var alpha_switch:Boolean;
      
      protected var pumpkinSprite1:MovieClip;
      
      protected var pumpkinSprite2:MovieClip;
      
      protected var pumpkinSprite3:MovieClip;
      
      protected var pumpkinSprite4:MovieClip;
      
      protected var label_counter:int;
      
      public function SplashState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         game.enterSplashState();
         this.GET_OUT_FLAG = false;
         this.choice = 0;
         this.music_counter = 0;
         this.justOnce = true;
         Utils.IS_GAME_MAP = false;
         this.alpha_switch = true;
         this.label_counter = 0;
         this.pumpkinSprite1 = this.pumpkinSprite2 = this.pumpkinSprite3 = this.pumpkinSprite4 = null;
         this.normal_delay = 0;
         this.alpha_mult = 0;
         this.bounceTween = null;
         this.shiftTween = null;
         this.lastWay = false;
         this.FLAG_1 = this.FLAG_2 = false;
         this.PROGRESSION = 0;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.normal_counter = 0;
         this.initBackground();
         this.container = new Sprite();
         this.container.scaleX = this.container.scaleY = Utils.GFX_SCALE;
         this.container.x = this.container.y = 0;
         Utils.rootMovie.addChild(this.container);
         this.touch_area_1 = new Rectangle(Utils.WIDTH - 80,0,80,32);
         this.initTitle();
         this.initPlayPanel();
         this.initButton();
         this.initWhiteFadeElement();
         this.initSettingsPanel();
         this.initExitPanel();
         this.initFlair();
         this.container.setChildIndex(this.splashHudPanel,this.container.numChildren - 1);
         this.container.setChildIndex(this.whiteFadeImage,this.container.numChildren - 1);
         var body_height:Number = Utils.HEIGHT * 0.45 + this.gameTitle.height * 0.5 + this.playPanel.height * 0.5;
         this.y_margin = int((Utils.HEIGHT - body_height) * 0.5);
         this.playPanel.y = int(Utils.HEIGHT - (this.y_margin + 8));
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_INTRO_STATE","END_ACTION","IS_NORMAL_STATE");
         this.stateMachine.setRule("IS_INTRO_STATE","TOUCH_ACTION","IS_INTRO_SHORTCUT_STATE");
         this.stateMachine.setRule("IS_INTRO_SHORTCUT_STATE","END_ACTION","IS_NORMAL_STATE");
         this.stateMachine.setRule("IS_NORMAL_STATE","SETTINGS_ACTION","IS_SETTINGS_STATE");
         this.stateMachine.setRule("IS_SETTINGS_STATE","END_ACTION","IS_NORMAL_STATE");
         this.stateMachine.setRule("IS_NORMAL_STATE","SCORES_ACTION","IS_SCORES_STATE");
         this.stateMachine.setRule("IS_SCORES_STATE","END_ACTION","IS_NORMAL_STATE");
         this.stateMachine.setRule("IS_NORMAL_STATE","BACK_BUTTON_ACTION","IS_EXIT_PANEL_STATE");
         this.stateMachine.setRule("IS_EXIT_PANEL_STATE","END_ACTION","IS_NORMAL_STATE");
         this.stateMachine.setRule("IS_NORMAL_STATE","TOUCH_ACTION","IS_PLAY_STATE");
         this.stateMachine.setRule("IS_PLAY_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_NORMAL_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setFunctionToState("IS_INTRO_STATE",this.introState);
         this.stateMachine.setFunctionToState("IS_INTRO_SHORTCUT_STATE",this.introShortcutState);
         this.stateMachine.setFunctionToState("IS_NORMAL_STATE",this.normalState);
         this.stateMachine.setFunctionToState("IS_PLAY_STATE",this.playState);
         this.stateMachine.setFunctionToState("IS_SETTINGS_STATE",this.settingsState);
         this.stateMachine.setFunctionToState("IS_SCORES_STATE",this.scoresState);
         this.stateMachine.setFunctionToState("IS_EXIT_PANEL_STATE",this.exitPanelState);
         this.stateMachine.setFunctionToState("IS_QUIT_STATE",this.quitState);
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onClick);
         if(GameServices.isSupported)
         {
            GameServices.service.leaderboards.addEventListener(LeaderboardEvent.UI_CLOSED,this.onViewClosed);
            GameServices.service.addEventListener(GameServicesEvent.SIGN_IN_SUCCESS,this.signInSuccessHandler);
            GameServices.service.addEventListener(GameServicesEvent.SIGN_IN_FAILED,this.signInFailedHandler);
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GOOGLE_SIGN_IN] == 1)
         {
            this.setGoogleSignedIn(true);
         }
         else
         {
            this.setGoogleSignedIn(false);
         }
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.addEventListener(flash.events.KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         }
         if(SplashState.SAVE_SESSION)
         {
            ++Utils.Slot.gameVariables[GameSlot.VARIABLE_GAME_SESSIONS];
            SaveManager.SaveGameVariables();
            SplashState.SAVE_SESSION = false;
         }
      }
      
      protected function setGoogleSignedIn(value:Boolean) : void
      {
         if(value)
         {
            this.splashHudPanel.achievementsButton.alpha = 1;
            this.splashHudPanel.scoresButton.alpha = 1;
         }
         else
         {
            this.splashHudPanel.achievementsButton.alpha = 0.5;
            this.splashHudPanel.scoresButton.alpha = 0.5;
         }
      }
      
      public function exitState(game:Game) : void
      {
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         if(GameServices.isSupported)
         {
            GameServices.service.leaderboards.removeEventListener(LeaderboardEvent.UI_CLOSED,this.onViewClosed);
            GameServices.service.removeEventListener(GameServicesEvent.SIGN_IN_SUCCESS,this.signInSuccessHandler);
            GameServices.service.removeEventListener(GameServicesEvent.SIGN_IN_FAILED,this.signInFailedHandler);
         }
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onClick);
         if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
         {
            Utils.juggler.remove(this.pumpkinSprite1);
            Utils.juggler.remove(this.pumpkinSprite2);
            Utils.juggler.remove(this.pumpkinSprite3);
            Utils.juggler.remove(this.pumpkinSprite4);
            this.container.removeChild(this.pumpkinSprite1);
            this.container.removeChild(this.pumpkinSprite2);
            this.container.removeChild(this.pumpkinSprite3);
            this.container.removeChild(this.pumpkinSprite4);
            this.pumpkinSprite1.dispose();
            this.pumpkinSprite2.dispose();
            this.pumpkinSprite3.dispose();
            this.pumpkinSprite4.dispose();
            this.pumpkinSprite1 = this.pumpkinSprite2 = this.pumpkinSprite3 = this.pumpkinSprite4 = null;
         }
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.container.removeChild(this.playPanel);
         this.playPanel.destroy();
         this.playPanel.dispose();
         this.playPanel = null;
         this.exitPanel.destroy();
         this.exitPanel.dispose();
         this.exitPanel = null;
         this.settingsPanel.destroy();
         this.settingsPanel.dispose();
         this.settingsPanel = null;
         this.touch_area_1 = null;
         this.container.removeChild(this.whiteFadeImage);
         this.whiteFadeImage.dispose();
         this.whiteFadeImage = null;
         if(Utils.IS_ANDROID)
         {
            this.splashHudPanel.achievementsButton.removeEventListener(Event.TRIGGERED,this.buttonClickHandler);
            this.splashHudPanel.googlePlayButton.removeEventListener(Event.TRIGGERED,this.buttonClickHandler);
            if(GameServices.isSupported)
            {
               if(!GameServices.service.isServiceSupported(Service.GOOGLE_PLAY_GAME_SERVICES))
               {
                  this.splashHudPanel.googlePlayButton.enabled = false;
               }
            }
            else
            {
               this.splashHudPanel.googlePlayButton.enabled = false;
            }
         }
         this.splashHudPanel.settingsButton.removeEventListener(Event.TRIGGERED,this.buttonClickHandler);
         this.splashHudPanel.scoresButton.removeEventListener(Event.TRIGGERED,this.buttonClickHandler);
         this.container.removeChild(this.splashHudPanel);
         this.splashHudPanel.destroy();
         this.splashHudPanel.dispose();
         this.splashHudPanel = null;
         this.container.removeChild(this.gameTitle);
         this.gameTitle.destroy();
         this.gameTitle.dispose();
         this.gameTitle = null;
         this.touch_area_1 = null;
         this.bounceTween = null;
         this.shiftTween = null;
         this.menuBackground.destroy();
         this.menuBackground = null;
         Utils.rootMovie.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         game.exitSplashState();
      }
      
      public function updateState(game:Game) : void
      {
         if(this.justOnce)
         {
            if(this.music_counter++ == 120)
            {
               this.music_counter = 121;
               SoundSystem.PlayMusic("splash");
               this.justOnce = false;
            }
         }
         this.menuBackground.update();
         this.gameTitle.update();
         if(this.stateMachine.currentState != "IS_INTRO_STATE")
         {
            this.playPanel.update();
         }
         if(this.stateMachine.currentState == "IS_INTRO_STATE")
         {
            if(this.PROGRESSION == 0)
            {
               this.menuBackground.updateIntro();
               if(this.menuBackground.INTRO_ALMOST_OVER)
               {
                  this.counter1 = 0;
                  ++this.PROGRESSION;
               }
            }
            else if(this.PROGRESSION == 1)
            {
               this.menuBackground.updateIntro();
               this.gameTitle.visible = true;
               this.gameTitle.lightUp();
               SoundSystem.PlaySound("title_appear");
               this.counter1 = 0;
               ++this.PROGRESSION;
            }
            else if(this.PROGRESSION == 2)
            {
               this.menuBackground.updateIntro();
               if(this.menuBackground.INTRO_OVER && !this.gameTitle.IS_LIGHTED_UP)
               {
                  this.counter1 = 0;
                  ++this.PROGRESSION;
               }
            }
            else if(this.PROGRESSION == 3)
            {
               if(this.counter1++ >= 60)
               {
                  ++this.PROGRESSION;
                  this.counter1 = 0;
                  this.shiftTween = new Tween(this.gameTitle,1,Transitions.EASE_OUT);
                  this.shiftTween.delay = 0;
                  this.shiftTween.moveTo(int(Utils.WIDTH * 0.5),int(this.y_margin + this.gameTitle.height * 0.5));
                  this.shiftTween.roundToInt = true;
                  this.shiftTween.onComplete = this.tween1Complete;
                  Starling.juggler.add(this.shiftTween);
               }
            }
            else if(this.PROGRESSION == 4)
            {
               this.splashHudPanel.showButtons();
               ++this.counter1;
               if(this.counter1 > 3)
               {
                  this.counter1 = 0;
                  this.playPanel.alpha += 0.2;
                  if(this.playPanel.alpha >= 1)
                  {
                     this.playPanel.alpha = 1;
                     if(this.splashHudPanel.BUTTONS_IN)
                     {
                        this.PROGRESSION = 5;
                     }
                  }
                  if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
                  {
                     this.pumpkinSprite1.alpha = this.pumpkinSprite2.alpha = this.pumpkinSprite3.alpha = this.pumpkinSprite4.alpha = this.playPanel.alpha;
                  }
               }
            }
            else if(this.PROGRESSION == 5)
            {
               this.stateMachine.performAction("END_ACTION");
               ++this.PROGRESSION;
            }
         }
         else if(this.stateMachine.currentState == "IS_INTRO_SHORTCUT_STATE")
         {
            ++this.counter2;
            this.normal_delay = 20;
            if(this.counter2 >= 10)
            {
               ++this.counter1;
               if(this.counter1 >= 3)
               {
                  this.counter1 = 0;
                  this.whiteFadeImage.alpha -= 0.2;
                  if(this.whiteFadeImage.alpha <= 0)
                  {
                     this.whiteFadeImage.alpha = 0;
                     this.whiteFadeImage.visible = false;
                     this.stateMachine.performAction("END_ACTION");
                  }
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_NORMAL_STATE")
         {
            ++this.normal_delay;
            if(this.counter1-- <= 0)
            {
               this.counter1 = int(Math.random() * 3 + 1) * 60;
               this.gameTitle.blink(this.lastWay);
               this.lastWay = !this.lastWay;
            }
            ++this.normal_counter;
            if(this.normal_counter >= 900)
            {
               this.choice = 1;
               this.stateMachine.performAction("QUIT_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_SCORES_STATE")
         {
            this.stateMachine.performAction("END_ACTION");
         }
         else if(this.stateMachine.currentState == "IS_SETTINGS_STATE")
         {
            this.settingsPanel.update();
            if(this.settingsPanel.GET_OUT_FLAG)
            {
               this.settingsPanel.hide();
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_EXIT_PANEL_STATE")
         {
            this.exitPanel.update();
            if(this.exitPanel.GET_OUT_FLAG)
            {
               if(this.exitPanel.EXIT_GAME)
               {
                  NativeApplication.nativeApplication.exit();
               }
               this.exitPanel.hide();
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_PLAY_STATE")
         {
            ++this.counter1;
            ++this.counter2;
            if(this.counter2 >= 40)
            {
               this.choice = 0;
               this.stateMachine.performAction("QUIT_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_QUIT_STATE")
         {
         }
         game.updateSplashState();
      }
      
      protected function introState() : void
      {
         SoundSystem.PlaySound("wind_breeze");
         this.music_counter = -160;
         this.FLAG_1 = this.FLAG_2 = false;
         this.PROGRESSION = 0;
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.gameTitle.visible = false;
         this.menuBackground.startIntro();
         this.splashHudPanel.setButtonsOutside();
         this.normal_delay = 30;
         this.playPanel.alpha = 0;
         if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
         {
            this.pumpkinSprite1.alpha = this.pumpkinSprite2.alpha = this.pumpkinSprite3.alpha = this.pumpkinSprite4.alpha = this.playPanel.alpha;
         }
      }
      
      protected function introShortcutState() : void
      {
         this.music_counter = 0;
         this.counter1 = this.counter2 = 0;
         this.whiteFadeImage.visible = true;
         if(this.bounceTween != null)
         {
            Starling.juggler.remove(this.bounceTween);
            this.bounceTween = null;
         }
         if(this.shiftTween != null)
         {
            Starling.juggler.remove(this.shiftTween);
            this.shiftTween = null;
         }
         this.setFinalPositions();
      }
      
      protected function normalState() : void
      {
         this.music_counter = 120;
         this.counter1 = int(Math.random() * 3 + 1) * 60;
         this.bounceTween = null;
         this.shiftTween = null;
         this.normal_counter = 0;
         this.splashHudPanel.enableButtons();
         this.setFinalPositions();
      }
      
      protected function settingsState() : void
      {
         SoundSystem.PlaySound("select");
         if(Utils.IS_ANDROID)
         {
            this.settingsPanel.destroy();
            this.settingsPanel.dispose();
            this.settingsPanel = null;
            this.settingsPanel = new SettingsPanel();
         }
         this.settingsPanel.popUp();
      }
      
      protected function exitPanelState() : void
      {
         SoundSystem.PlaySound("select");
         if(Utils.IS_ANDROID)
         {
            this.exitPanel.destroy();
            this.exitPanel.dispose();
            this.exitPanel = null;
            this.exitPanel = new ExitPanel();
         }
         this.exitPanel.popUp();
      }
      
      protected function scoresState() : void
      {
      }
      
      protected function playState() : void
      {
         SoundSystem.StopMusic();
         this.counter1 = this.counter2 = 0;
         var target_y:Number = this.gameTitle.y;
         this.gameTitle.y -= 16;
         this.bounceTween = new Tween(this.gameTitle,0.5,Transitions.EASE_OUT_BOUNCE);
         this.bounceTween.moveTo(this.gameTitle.x,target_y);
         Starling.juggler.add(this.bounceTween);
         this.splashHudPanel.disableButtons();
         this.playPanel.blink();
         this.gameTitle.lightUp();
      }
      
      protected function quitState() : void
      {
         this.GET_OUT_FLAG = true;
      }
      
      protected function setFinalPositions() : void
      {
         this.playPanel.alpha = 1;
         if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
         {
            this.pumpkinSprite1.alpha = this.pumpkinSprite2.alpha = this.pumpkinSprite3.alpha = this.pumpkinSprite4.alpha = this.playPanel.alpha;
         }
         this.playPanel.visible = true;
         this.gameTitle.x = int(Utils.WIDTH * 0.5);
         this.gameTitle.y = int(this.y_margin + this.gameTitle.height * 0.5);
         this.alpha_mult = 1;
         this.gameTitle.visible = true;
         this.gameTitle.alpha = 1;
         this.gameTitle.y = int(this.y_margin + this.gameTitle.height * 0.5);
         this.menuBackground.endIntro();
         this.splashHudPanel.setbuttonsInside();
      }
      
      protected function initBackground() : void
      {
         this.menuBackground = new MenuBackground();
      }
      
      protected function initTitle() : void
      {
         this.gameTitle = new GameTitlePanel();
         this.container.addChild(this.gameTitle);
         this.gameTitle.pivotX = int(this.gameTitle.width * 0.5);
         this.gameTitle.pivotY = int(this.gameTitle.height * 0.5);
         this.gameTitle.x = int(Utils.WIDTH * 0.5);
         this.gameTitle.y = int(Utils.HEIGHT * 0.5);
      }
      
      protected function initPlayPanel() : void
      {
         this.playPanel = new TapToPlayPanel();
         this.container.addChild(this.playPanel);
         this.playPanel.pivotX = int(this.playPanel.width * 0.5);
         this.playPanel.pivotY = int(this.playPanel.HEIGHT * 0.5);
         this.playPanel.x = int(Utils.WIDTH * 0.5);
         this.playPanel.y = int(Utils.HEIGHT * 0.85);
      }
      
      protected function initFlair() : void
      {
         if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
         {
            this.pumpkinSprite1 = new MovieClip(TextureManager.hudTextureAtlas.getTextures("halloweenHudSpriteAnim_"),1);
            this.pumpkinSprite2 = new MovieClip(TextureManager.hudTextureAtlas.getTextures("halloweenHudSpriteAnim_"),1);
            this.pumpkinSprite3 = new MovieClip(TextureManager.hudTextureAtlas.getTextures("halloweenHudSpriteAnim_"),1);
            this.pumpkinSprite4 = new MovieClip(TextureManager.hudTextureAtlas.getTextures("halloweenHudSpriteAnim_"),1);
            Utils.juggler.add(this.pumpkinSprite1);
            Utils.juggler.add(this.pumpkinSprite2);
            Utils.juggler.add(this.pumpkinSprite3);
            Utils.juggler.add(this.pumpkinSprite4);
            this.pumpkinSprite1.pivotX = this.pumpkinSprite2.pivotX = this.pumpkinSprite3.pivotX = this.pumpkinSprite4.pivotX = int(this.pumpkinSprite1.width * 0.5);
            this.pumpkinSprite1.pivotY = this.pumpkinSprite2.pivotY = this.pumpkinSprite3.pivotY = this.pumpkinSprite4.pivotY = int(this.pumpkinSprite1.height * 0.5);
            this.container.addChild(this.pumpkinSprite1);
            this.container.addChild(this.pumpkinSprite2);
            this.container.addChild(this.pumpkinSprite3);
            this.container.addChild(this.pumpkinSprite4);
            this.pumpkinSprite1.x = int(this.playPanel.x - this.playPanel.width * 0.5 - 24);
            this.pumpkinSprite2.x = int(this.playPanel.x - this.playPanel.width * 0.5 - 56);
            this.pumpkinSprite3.x = int(this.playPanel.x + this.playPanel.width * 0.5 + 24);
            this.pumpkinSprite4.x = int(this.playPanel.x + this.playPanel.width * 0.5 + 56);
            this.pumpkinSprite2.currentFrame = 1;
            this.pumpkinSprite4.currentFrame = 1;
            this.pumpkinSprite1.y = this.pumpkinSprite2.y = this.pumpkinSprite3.y = this.pumpkinSprite4.y = this.playPanel.y + 6;
            this.pumpkinSprite1.alpha = this.pumpkinSprite2.alpha = this.pumpkinSprite3.alpha = this.pumpkinSprite4.alpha = 0;
         }
      }
      
      protected function initButton() : void
      {
         this.splashHudPanel = new SplashHudPanel();
         this.container.addChild(this.splashHudPanel);
         this.splashHudPanel.disableButtons();
         this.splashHudPanel.settingsButton.addEventListener(Event.TRIGGERED,this.buttonClickHandler);
         this.splashHudPanel.scoresButton.addEventListener(Event.TRIGGERED,this.buttonClickHandler);
         if(Utils.IS_ANDROID)
         {
            this.splashHudPanel.achievementsButton.addEventListener(Event.TRIGGERED,this.buttonClickHandler);
            this.splashHudPanel.googlePlayButton.addEventListener(Event.TRIGGERED,this.buttonClickHandler);
         }
      }
      
      protected function initWhiteFadeElement() : void
      {
         this.whiteFadeImage = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         this.container.addChild(this.whiteFadeImage);
         this.whiteFadeImage.x = this.whiteFadeImage.y = 0;
         this.whiteFadeImage.width = Utils.WIDTH;
         this.whiteFadeImage.height = Utils.HEIGHT;
         this.whiteFadeImage.visible = false;
      }
      
      protected function initSettingsPanel() : void
      {
         this.settingsPanel = new SettingsPanel();
      }
      
      protected function initExitPanel() : void
      {
         this.exitPanel = new ExitPanel();
      }
      
      public function onClick(event:TouchEvent) : void
      {
         var point:Point = null;
         if(this.normal_delay < 10)
         {
            return;
         }
         var touch:Touch = event.getTouch(Utils.rootStage);
         if(event.target is Button)
         {
            return;
         }
         if(touch != null)
         {
            if(touch.phase == "ended")
            {
               if(this.stateMachine.currentState == "IS_NORMAL_STATE")
               {
                  point = new Point(touch.globalX * Utils.GFX_INV_SCALE,touch.globalY * Utils.GFX_INV_SCALE);
                  if(this.touch_area_1.containsPoint(point))
                  {
                     return;
                  }
                  if(Utils.IS_ANDROID)
                  {
                     if(point.x <= Utils.WIDTH * 0.15 || point.x >= Utils.WIDTH * 0.85)
                     {
                        return;
                     }
                  }
               }
               if(this.stateMachine.currentState == "IS_INTRO_STATE")
               {
                  SoundSystem.PlaySound("confirmShort");
               }
               else if(this.stateMachine.currentState == "IS_NORMAL_STATE")
               {
                  SoundSystem.PlaySound("confirmLong");
               }
               this.stateMachine.performAction("TOUCH_ACTION");
               if(Utils.IS_ANDROID)
               {
                  NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
               }
            }
         }
      }
      
      protected function buttonClickHandler(event:Event) : void
      {
         if(this.stateMachine == null)
         {
            return;
         }
         if(this.stateMachine.currentState != "IS_NORMAL_STATE")
         {
            return;
         }
         var button:Button = event.target as Button;
         if(button.name == "scores")
         {
            SoundSystem.PlaySound("select");
            if(GameServices.isSupported)
            {
               GameServices.service.leaderboards.displayLeaderboardUI();
               this.stateMachine.performAction("SCORES_ACTION");
            }
         }
         else if(button.name == "event")
         {
            SoundSystem.PlaySound("select");
            Utils.IS_SEASONAL = true;
            SoundSystem.StopMusic();
            this.choice = 2;
            this.stateMachine.performAction("QUIT_ACTION");
         }
         else if(button.name == "achievements")
         {
            SoundSystem.PlaySound("select");
            if(GameServices.isSupported)
            {
               GameServices.service.achievements.displayAchievementsUI();
               this.stateMachine.performAction("SCORES_ACTION");
            }
         }
         else if(button.name == "google")
         {
            SoundSystem.PlaySound("select");
            if(!GameServices.service.isSignedIn())
            {
               GameServices.service.signIn();
            }
            else
            {
               GameServices.service.signOut();
               this.setGoogleSignedIn(false);
            }
         }
         else
         {
            this.stateMachine.performAction("SETTINGS_ACTION");
         }
      }
      
      private function tween1Complete() : void
      {
         this.counter1 = 0;
      }
      
      protected function onKeyDown(event:flash.events.KeyboardEvent) : void
      {
         if(event.keyCode == Keyboard.BACK)
         {
            event.preventDefault();
            event.stopImmediatePropagation();
            if(this.stateMachine.currentState == "IS_SETTINGS_STATE")
            {
               SoundSystem.PlaySound("select");
               this.settingsPanel.stateMachine.setState("IS_QUIT_STATE");
            }
            else if(this.stateMachine.currentState == "IS_NORMAL_STATE")
            {
               this.stateMachine.performAction("BACK_BUTTON_ACTION");
            }
            else if(this.stateMachine.currentState == "IS_EXIT_PANEL_STATE")
            {
               if(this.exitPanel.QUIT_FLAG == false)
               {
                  this.exitPanel.QUIT_FLAG = true;
                  this.exitPanel.EXIT_GAME = false;
                  this.exitPanel.popOut();
               }
            }
         }
      }
      
      internal function onViewClosed(event:LeaderboardEvent) : void
      {
         this.stateMachine.performAction("END_ACTION");
      }
      
      internal function signInSuccessHandler(event:GameServicesEvent) : void
      {
         Utils.Slot.gameVariables[GameSlot.VARIABLE_GOOGLE_SIGN_IN] = 1;
         SaveManager.SaveGameVariables();
         this.setGoogleSignedIn(true);
      }
      
      internal function signInFailedHandler(event:GameServicesEvent) : void
      {
         Utils.Slot.gameVariables[GameSlot.VARIABLE_GOOGLE_SIGN_IN] = 0;
         SaveManager.SaveGameVariables();
         this.setGoogleSignedIn(false);
         this.splashHudPanel.googlePlayButton.touchable = false;
         this.splashHudPanel.googlePlayButton.enabled = false;
      }
   }
}
