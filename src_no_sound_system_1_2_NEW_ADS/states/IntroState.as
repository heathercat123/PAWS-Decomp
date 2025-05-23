package states
{
   import entities.particles.ParticlesManager;
   import flash.desktop.NativeApplication;
   import flash.desktop.SystemIdleMode;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import flash.net.*;
   import flash.ui.Keyboard;
   import game_utils.StateMachine;
   import interfaces.panels.LightSource;
   import interfaces.panels.intro.*;
   import levels.*;
   import levels.backgrounds.*;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class IntroState implements IState
   {
      
      public var GET_OUT_FLAG:Boolean;
      
      public var ALREADY_OUT:Boolean;
      
      public var choice:int;
      
      protected var PROGRESSION_1:int;
      
      protected var PROGRESSION_2:int;
      
      protected var counter1:int;
      
      protected var counter2:int;
      
      protected var counter3:int;
      
      protected var intro_counter_1:int;
      
      protected var stateMachine:StateMachine;
      
      protected var darkPanel:Image;
      
      protected var whitePanel:Image;
      
      protected var tapestryPanel:TapestryCutscenePanel;
      
      protected var scene1Panel:IntroScene1Panel;
      
      protected var scene2Panel:IntroScene2Panel;
      
      protected var scene3Panel:IntroScene3Panel;
      
      protected var particlesManager:ParticlesManager;
      
      public var container:Sprite;
      
      public var camera:Rectangle;
      
      protected var particles_counter1:int;
      
      protected var particles_counter2:int;
      
      protected var sin_counter_1:Number;
      
      protected var sin_counter_2:Number;
      
      protected var sin_speed_1:Number;
      
      protected var sin_speed_2:Number;
      
      protected var tapestry_light_frequency:int;
      
      protected var introCatPanel1:IntroCatPanel;
      
      protected var introCatPanel2:IntroCatPanel;
      
      protected var introCatPanel3:IntroCatPanel;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var time_cat_sequence:int;
      
      protected var stop_visible_invisible:Boolean;
      
      protected var lightSource:LightSource;
      
      protected var _time_alive:int = 0;
      
      protected var tapestryAdded:Boolean = false;
      
      public function IntroState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         game.enterIntroState();
         this.scene1Panel = null;
         this.scene2Panel = null;
         this.scene3Panel = null;
         this.GET_OUT_FLAG = false;
         this.ALREADY_OUT = false;
         this.stop_visible_invisible = false;
         this.choice = -1;
         this.time_cat_sequence = 45;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         this.sin_counter_1 = Math.random() * Math.PI * 2;
         this.sin_counter_2 = Math.random() * Math.PI * 2;
         this.sin_speed_1 = Math.random() * 0.025 + 0.025;
         this.sin_speed_2 = Math.random() * 0.025 + 0.025;
         this.tapestry_light_frequency = 5;
         this.PROGRESSION_1 = this.counter1 = this.counter2 = this.counter3 = this.PROGRESSION_2 = 0;
         this.particles_counter1 = this.particles_counter2 = 0;
         this.intro_counter_1 = 0;
         this.camera = new Rectangle(0,0,Utils.WIDTH,Utils.HEIGHT);
         this.container = new Sprite();
         this.container.scaleX = this.container.scaleY = Utils.GFX_SCALE;
         this.container.x = this.container.y = 0;
         Utils.rootMovie.addChild(this.container);
         this.darkPanel = new Image(TextureManager.introTextureAtlas.getTexture("intro_black_color_1"));
         this.darkPanel.width = Utils.WIDTH;
         this.darkPanel.height = Utils.HEIGHT;
         this.container.addChild(this.darkPanel);
         this.darkPanel.visible = false;
         this.particlesManager = new ParticlesManager(null,this.container);
         this.whitePanel = new Image(TextureManager.introTextureAtlas.getTexture("intro_white_color_1"));
         this.whitePanel.width = Utils.WIDTH;
         this.whitePanel.height = Utils.HEIGHT;
         this.container.addChild(this.whitePanel);
         this.whitePanel.visible = false;
         this.lightSource = new LightSource(100,100,64);
         this.container.addChild(this.lightSource);
         this.initScenes();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_SCENE_1_STATE","END_ACTION","IS_SCENE_2_STATE");
         this.stateMachine.setRule("IS_SCENE_2_STATE","END_ACTION","IS_SCENE_3_STATE");
         this.stateMachine.setRule("IS_SCENE_3_STATE","END_ACTION","IS_SCENE_4_STATE");
         this.stateMachine.setRule("IS_SCENE_4_STATE","END_ACTION","IS_SCENE_5_STATE");
         this.stateMachine.setRule("IS_SCENE_5_STATE","END_ACTION","IS_SCENE_6_STATE");
         this.stateMachine.setRule("IS_SCENE_6_STATE","END_ACTION","IS_SCENE_7_STATE");
         this.stateMachine.setRule("IS_SCENE_7_STATE","END_ACTION","IS_END_STATE");
         this.stateMachine.setFunctionToState("IS_SCENE_1_STATE",this.scene1State);
         this.stateMachine.setFunctionToState("IS_SCENE_2_STATE",this.scene2State);
         this.stateMachine.setFunctionToState("IS_SCENE_3_STATE",this.scene3State);
         this.stateMachine.setFunctionToState("IS_SCENE_4_STATE",this.scene4State);
         this.stateMachine.setFunctionToState("IS_SCENE_5_STATE",this.scene5State);
         this.stateMachine.setFunctionToState("IS_SCENE_6_STATE",this.scene6State);
         this.stateMachine.setFunctionToState("IS_SCENE_7_STATE",this.scene7State);
         this.stateMachine.setFunctionToState("IS_SCENE_8_STATE",this.scene8State);
         this.stateMachine.setFunctionToState("IS_END_STATE",this.endState);
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onClick);
         this.stateMachine.setState("IS_SCENE_1_STATE");
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
            NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         }
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         }
      }
      
      public function exitState(game:Game) : void
      {
         var i:int = 0;
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         if(Utils.IS_ANDROID)
         {
            NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         }
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onClick);
         this.stateMachine.destroy();
         this.stateMachine = null;
         if(this.tapestryAdded)
         {
            this.container.removeChild(this.tapestryPanel);
         }
         this.tapestryPanel.destroy();
         this.tapestryPanel.dispose();
         this.tapestryPanel = null;
         if(this.scene1Panel != null)
         {
            this.container.removeChild(this.scene1Panel);
            this.scene1Panel.destroy();
            this.scene1Panel.dispose();
            this.scene1Panel = null;
         }
         if(this.scene2Panel != null)
         {
            this.container.removeChild(this.scene2Panel);
            this.scene2Panel.destroy();
            this.scene2Panel.dispose();
            this.scene2Panel = null;
         }
         if(this.scene3Panel != null)
         {
            this.container.removeChild(this.scene3Panel);
            this.scene3Panel.destroy();
            this.scene3Panel.dispose();
            this.scene3Panel = null;
         }
         if(this.introCatPanel3 != null)
         {
            this.container.removeChild(this.introCatPanel3);
            this.introCatPanel3.destroy();
            this.introCatPanel3.dispose();
            this.introCatPanel3 = null;
         }
         if(this.introCatPanel2 != null)
         {
            this.container.removeChild(this.introCatPanel2);
            this.introCatPanel2.destroy();
            this.introCatPanel2.dispose();
            this.introCatPanel2 = null;
         }
         if(this.introCatPanel1 != null)
         {
            this.container.removeChild(this.introCatPanel1);
            this.introCatPanel1.destroy();
            this.introCatPanel1.dispose();
            this.introCatPanel1 = null;
         }
         this.container.removeChild(this.lightSource);
         this.lightSource.destroy();
         this.lightSource.dispose();
         this.lightSource = null;
         this.container.removeChild(this.whitePanel);
         this.container.removeChild(this.darkPanel);
         this.whitePanel.dispose();
         this.darkPanel.dispose();
         this.whitePanel = null;
         this.darkPanel = null;
         this.camera = null;
         this.particlesManager.destroy();
         this.particlesManager = null;
         Utils.rootMovie.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         game.exitIntroState();
      }
      
      protected function onKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == Keyboard.BACK)
         {
            event.preventDefault();
            event.stopImmediatePropagation();
            if(!this.ALREADY_OUT)
            {
               this.ALREADY_OUT = true;
               this.GET_OUT_FLAG = true;
               this.choice = 1;
               SoundSystem.PlaySound("confirmShort");
            }
         }
      }
      
      public function onClick(event:TouchEvent) : void
      {
         if(this.intro_counter_1 < 60 || this.ALREADY_OUT)
         {
            return;
         }
         var touch:Touch = event.getTouch(Utils.rootStage);
         if(touch != null)
         {
            if(touch.phase == "ended")
            {
               if(!this.ALREADY_OUT)
               {
                  this.ALREADY_OUT = true;
                  this.GET_OUT_FLAG = true;
                  this.choice = 1;
                  SoundSystem.PlaySound("confirmShort");
               }
            }
         }
      }
      
      public function updateState(game:Game) : void
      {
         var i:int = 0;
         ++this.counter1;
         ++this.intro_counter_1;
         if(this.stateMachine.currentState == "IS_SCENE_1_STATE")
         {
            this.tapestryPanel.update();
            if(this.PROGRESSION_1 == 0)
            {
               if(this.counter1 >= 15)
               {
                  this.counter1 = 0;
                  ++this.PROGRESSION_1;
               }
               this.container.setChildIndex(this.darkPanel,this.container.numChildren - 1);
            }
            else if(this.PROGRESSION_1 == 1)
            {
               ++this._time_alive;
               if(this.counter2++ >= 5)
               {
                  this.counter2 = 0;
                  this.darkPanel.alpha -= 0.2;
                  if(this.darkPanel.alpha <= 0)
                  {
                     this.darkPanel.alpha = 0;
                     this.darkPanel.visible = false;
                  }
               }
               if(this._time_alive >= 96)
               {
                  this.counter1 = 0;
                  ++this.PROGRESSION_1;
               }
               this.container.setChildIndex(this.darkPanel,this.container.numChildren - 1);
            }
            else if(this.PROGRESSION_1 == 2)
            {
               if(this.counter1 >= 60)
               {
                  this.PROGRESSION_1 = 3;
                  this.counter1 = 0;
               }
            }
            else if(this.PROGRESSION_1 == 3)
            {
               if(this.counter1 > 5)
               {
                  this.stateMachine.performAction("END_ACTION");
                  this.PROGRESSION_1 = 0;
                  this.PROGRESSION_2 = 0;
                  this.counter1 = this.counter2 = this.counter3 = 0;
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_SCENE_2_STATE")
         {
            if(this.PROGRESSION_1 == 0)
            {
               if(this.counter1 >= 90)
               {
                  this.tapestryPanel.visible = false;
                  this.container.setChildIndex(this.introCatPanel1,this.container.numChildren - 1);
                  this.introCatPanel1.visible = true;
                  this.introCatPanel1.startPanel();
                  this.PROGRESSION_1 = 1;
                  this.counter1 = this.counter2 = this.counter3 = 0;
               }
            }
            else if(this.PROGRESSION_1 == 1)
            {
               this.introCatPanel1.update();
               if(this.counter1 >= 90)
               {
                  this.introCatPanel1.visible = false;
                  this.scene1Panel.visible = false;
                  this.tapestryPanel.visible = true;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            if(this.scene1Panel.alpha < 1)
            {
               this.scene1Panel.alpha += 0.2;
               this.tapestryPanel.update();
            }
            this.scene1Panel.update();
         }
         else if(this.stateMachine.currentState == "IS_SCENE_3_STATE" || this.stateMachine.currentState == "IS_SCENE_5_STATE")
         {
            this.tapestryPanel.update();
            if(this.PROGRESSION_1 == 0)
            {
               if(this.counter1 >= 120)
               {
                  this.PROGRESSION_1 = 1;
                  this.counter1 = 0;
               }
            }
            else if(this.PROGRESSION_1 == 1)
            {
               if(this.counter1 > 5)
               {
                  this.stateMachine.performAction("END_ACTION");
                  this.PROGRESSION_1 = 0;
                  this.PROGRESSION_2 = 0;
                  this.counter1 = this.counter2 = this.counter3 = 0;
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_SCENE_4_STATE")
         {
            if(this.PROGRESSION_1 == 0)
            {
               if(this.counter1 >= 90)
               {
                  this.tapestryPanel.visible = false;
                  this.container.setChildIndex(this.introCatPanel2,this.container.numChildren - 1);
                  this.introCatPanel2.visible = true;
                  this.introCatPanel2.startPanel();
                  this.PROGRESSION_1 = 1;
                  this.counter1 = this.counter2 = this.counter3 = 0;
               }
               else if(this.counter1 == 10 || this.counter1 == 20 || this.counter1 == 30 || this.counter1 == 40 || this.counter1 == 50 || this.counter1 == 60)
               {
                  for(i = 0; i < 7 * 10; i++)
                  {
                     this.tapestryPanel.update(true);
                  }
               }
            }
            else if(this.PROGRESSION_1 == 1)
            {
               this.introCatPanel2.update();
               if(this.counter1 >= 90)
               {
                  this.introCatPanel2.visible = false;
                  this.scene2Panel.visible = false;
                  this.tapestryPanel.visible = true;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            if(this.scene2Panel.alpha < 1)
            {
               this.scene2Panel.alpha += 0.2;
               this.tapestryPanel.update();
            }
            this.scene2Panel.update();
         }
         else if(this.stateMachine.currentState == "IS_SCENE_6_STATE")
         {
            if(this.PROGRESSION_1 == 0)
            {
               if(this.counter1 >= 90)
               {
                  this.tapestryPanel.visible = false;
                  this.container.setChildIndex(this.introCatPanel3,this.container.numChildren - 1);
                  this.introCatPanel3.visible = true;
                  this.introCatPanel3.startPanel();
                  this.PROGRESSION_1 = 1;
                  this.counter1 = this.counter2 = this.counter3 = 0;
               }
            }
            else if(this.PROGRESSION_1 == 1)
            {
               this.introCatPanel3.update();
               if(this.counter1 >= 90)
               {
                  this.introCatPanel3.visible = false;
                  this.scene3Panel.visible = false;
                  this.tapestryPanel.visible = true;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            if(this.scene3Panel.alpha < 1)
            {
               this.scene3Panel.alpha += 0.2;
               this.tapestryPanel.update();
            }
            this.scene3Panel.update();
         }
         else if(this.stateMachine.currentState == "IS_SCENE_7_STATE")
         {
            this.tapestryPanel.update();
            if(this.PROGRESSION_1 == 0)
            {
               if(this.counter1 >= 240)
               {
                  this.PROGRESSION_1 = 1;
                  this.counter1 = this.counter2 = this.counter3 = 0;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_END_STATE")
         {
         }
         this.lightSource.update();
         this.lightSource.x = 951 - this.camera.x;
         this.lightSource.y = this.tapestryPanel.y - 39;
         this.container.setChildIndex(this.lightSource,this.container.numChildren - 1);
         if(this.particles_counter1++ > 5)
         {
         }
         this.updateFlames();
         this.particlesManager.update();
         this.updateScreenPositions();
         game.updateIntroState();
      }
      
      protected function updateTapestryStone() : void
      {
         ++this.counter2;
         if(!this.stop_visible_invisible)
         {
            if(this.counter2 >= this.tapestry_light_frequency)
            {
               this.counter2 = 0;
            }
         }
      }
      
      protected function updateFlames() : void
      {
         this.sin_counter_1 += this.sin_speed_1;
         if(this.sin_counter_1 > Math.PI * 2)
         {
            this.sin_counter_1 -= Math.PI * 2;
            this.sin_speed_1 = Math.random() * 0.04 + 0.025;
         }
         this.sin_counter_2 += this.sin_speed_2;
         if(this.sin_counter_2 > Math.PI * 2)
         {
            this.sin_counter_2 -= Math.PI * 2;
            this.sin_speed_2 = Math.random() * 0.04 + 0.025;
         }
      }
      
      protected function updateScreenPositions() : void
      {
         var i:int = 0;
         for(i = 0; i < this.particlesManager.particles.length; i++)
         {
            if(this.particlesManager.particles[i].sprite != null)
            {
               this.particlesManager.particles[i].sprite.x = int(Math.floor(this.particlesManager.particles[i].xPos - this.camera.x));
               this.particlesManager.particles[i].sprite.y = int(Math.floor(this.particlesManager.particles[i].yPos - 0));
               this.particlesManager.particles[i].sprite.updateScreenPosition();
            }
         }
      }
      
      protected function initScenes() : void
      {
         this.tapestryPanel = new TapestryCutscenePanel();
         this.tapestryPanel.x = 0;
         this.tapestryPanel.pivotY = 104;
         this.tapestryPanel.y = int(Utils.HEIGHT * 0.5);
         this.tapestryPanel.touchable = false;
         this.introCatPanel3 = null;
         this.introCatPanel2 = null;
         this.introCatPanel1 = null;
      }
      
      protected function scene1State() : void
      {
         var i:int = 0;
         SoundSystem.PlayMusic("intro");
         this.container.addChild(this.tapestryPanel);
         this.tapestryAdded = true;
         this.container.setChildIndex(this.darkPanel,this.container.numChildren - 1);
         this.darkPanel.visible = true;
         for(i = 0; i < 1 * 60; i++)
         {
            this.tapestryPanel.update();
         }
         this.PROGRESSION_1 = 0;
         this.counter1 = this.counter2 = this.counter3 = 0;
      }
      
      protected function scene2State() : void
      {
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.scene1Panel = new IntroScene1Panel();
         this.container.addChild(this.scene1Panel);
         this.scene1Panel.x = int(Utils.WIDTH * 0.5);
         this.scene1Panel.y = int(Utils.HEIGHT * 0.5);
         this.scene1Panel.alpha = 0;
         this.whitePanel.visible = false;
         this.container.setChildIndex(this.whitePanel,this.container.numChildren - 1);
         this.introCatPanel1 = new IntroCatPanel(0);
         this.container.addChild(this.introCatPanel1);
         this.introCatPanel1.visible = false;
      }
      
      protected function scene3State() : void
      {
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.PROGRESSION_1 = this.PROGRESSION_2 = 0;
      }
      
      protected function scene4State() : void
      {
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.scene2Panel = new IntroScene2Panel();
         this.container.addChild(this.scene2Panel);
         this.scene2Panel.x = int(Utils.WIDTH * 0.5);
         this.scene2Panel.y = int(Utils.HEIGHT * 0.5);
         this.scene2Panel.alpha = 0;
         this.introCatPanel2 = new IntroCatPanel(1);
         this.container.addChild(this.introCatPanel2);
         this.introCatPanel2.visible = false;
      }
      
      protected function scene5State() : void
      {
         var i:int = 0;
         this.tapestryPanel.hideParticles();
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.PROGRESSION_1 = this.PROGRESSION_2 = 0;
      }
      
      protected function scene6State() : void
      {
         this.scene3Panel = new IntroScene3Panel();
         this.container.addChild(this.scene3Panel);
         this.scene3Panel.x = int(Utils.WIDTH * 0.5);
         this.scene3Panel.y = int(Utils.HEIGHT * 0.5);
         this.scene3Panel.alpha = 0;
         this.introCatPanel3 = new IntroCatPanel(2);
         this.container.addChild(this.introCatPanel3);
         this.introCatPanel3.visible = false;
      }
      
      protected function scene7State() : void
      {
         this.counter1 = this.counter2 = this.counter3 = 0;
         this.PROGRESSION_1 = this.PROGRESSION_2 = 0;
         var ratio:Number = Utils.WIDTH / Utils.HEIGHT;
         ratio -= 1.4;
         this.tapestryPanel.y += ratio * Utils.HEIGHT * 0.15;
         this.tapestryPanel.hideParticles();
      }
      
      protected function scene8State() : void
      {
      }
      
      protected function endState() : void
      {
         this.ALREADY_OUT = true;
         this.GET_OUT_FLAG = true;
         this.choice = 0;
      }
   }
}

