package interfaces.panels
{
   import flash.desktop.NativeApplication;
   import game_utils.SaveManager;
   import game_utils.StateMachine;
   import interfaces.buttons.GameButton;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class SettingsPanel extends Sprite
   {
       
      
      public var QUIT_FLAG:Boolean;
      
      public var GET_OUT_FLAG:Boolean;
      
      public var settingsPanelEntering:Boolean;
      
      public var settingsPanelExiting:Boolean;
      
      public var settingsPanelStaying:Boolean;
      
      public var backgroundQuad:Image;
      
      public var title:TextPanel;
      
      public var buttonSXContainer:Sprite;
      
      public var continueButton:GameButton;
      
      public var restoreButton:GameButton;
      
      public var resetButton:GameButton;
      
      public var creditsPanel:SettingsCreditsPanel;
      
      public var resetPanel:SettingsSubPanel;
      
      public var optionsPanel:SettingsSubPanel;
      
      public var counter:int;
      
      protected var body_percentage:Number;
      
      protected var column_percentage:Number;
      
      protected var inner_margin_percentage:Number;
      
      protected var body_width:int;
      
      protected var body_height:int;
      
      protected var column_width:int;
      
      protected var button_height:int;
      
      protected var inner_margin:int;
      
      protected var outer_x_margin:int;
      
      protected var outer_y_margin:int;
      
      public var stateMachine:StateMachine;
      
      protected var ITEM_INDEX:int;
      
      protected var ITEM_PRICE:Number;
      
      protected var REPLY_INDEX:int;
      
      public var ITEM_RECEIVED:Boolean;
      
      public function SettingsPanel()
      {
         super();
         this.QUIT_FLAG = false;
         this.GET_OUT_FLAG = false;
         this.ITEM_RECEIVED = false;
         this.settingsPanelEntering = false;
         this.settingsPanelExiting = false;
         this.settingsPanelStaying = false;
         this.counter = 0;
         this.visible = false;
         this.scaleX = this.scaleY = Utils.GFX_SCALE;
         this.evaluatePercentages();
         this.initBackground();
         this.initButtons();
         this.initText();
         this.initPanels();
         this.continueButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.restoreButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.resetButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_CREDITS_STATE","RESET_ACTION","IS_RESET_STATE");
         this.stateMachine.setRule("IS_RESET_STATE","END_ACTION","IS_OPTIONS_STATE");
         this.stateMachine.setRule("IS_CREDITS_STATE","OPTIONS_ACTION","IS_OPTIONS_STATE");
         this.stateMachine.setRule("IS_OPTIONS_STATE","END_ACTION","IS_CREDITS_STATE");
         this.stateMachine.setRule("IS_OPTIONS_STATE","RESET_ACTION","IS_RESET_STATE");
         this.stateMachine.setRule("IS_OPTIONS_STATE","CREDITS_ACTION","IS_CREDITS_STATE");
         this.stateMachine.setRule("IS_CREDITS_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_OPTIONS_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setRule("IS_RESET_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setFunctionToState("IS_CREDITS_STATE",this.creditsState);
         this.stateMachine.setFunctionToState("IS_RESET_STATE",this.resetState);
         this.stateMachine.setFunctionToState("IS_OPTIONS_STATE",this.optionsState);
         this.stateMachine.setFunctionToState("IS_QUIT_STATE",this.quitState);
         this.stateMachine.setState("IS_OPTIONS_STATE");
      }
      
      public static function iCloudSaveCoins() : void
      {
      }
      
      public static function iCloudRestoreCoins() : void
      {
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.stateMachine.destroy();
         this.continueButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.restoreButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.resetButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         removeChild(this.optionsPanel);
         this.optionsPanel.destroy();
         this.optionsPanel.dispose();
         this.optionsPanel = null;
         removeChild(this.resetPanel);
         this.resetPanel.destroy();
         this.resetPanel.dispose();
         this.resetPanel = null;
         removeChild(this.creditsPanel);
         this.creditsPanel.destroy();
         this.creditsPanel.dispose();
         this.creditsPanel = null;
         removeChild(this.title);
         this.title.destroy();
         this.title.dispose();
         this.title = null;
         this.buttonSXContainer.removeChild(this.continueButton);
         this.continueButton.destroy();
         this.continueButton.dispose();
         this.continueButton = null;
         this.buttonSXContainer.removeChild(this.restoreButton);
         this.restoreButton.destroy();
         this.restoreButton.dispose();
         this.restoreButton = null;
         this.buttonSXContainer.removeChild(this.resetButton);
         this.resetButton.destroy();
         this.resetButton.dispose();
         this.resetButton = null;
         removeChild(this.buttonSXContainer);
         this.buttonSXContainer.dispose();
         this.buttonSXContainer = null;
         removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
      }
      
      public function update() : void
      {
         if(this.stateMachine.currentState == "IS_CREDITS_STATE")
         {
            if(this.creditsPanel != null)
            {
               this.creditsPanel.update();
            }
         }
         else if(this.stateMachine.currentState == "IS_RESET_STATE")
         {
            if(this.resetPanel != null)
            {
               this.resetPanel.update();
               if(this.resetPanel.IS_DONE)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_OPTIONS_STATE")
         {
            if(this.optionsPanel != null)
            {
               this.optionsPanel.update();
               if(this.optionsPanel.IS_DONE)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      public function showReset() : void
      {
         this.stateMachine.performAction("RESET_ACTION");
      }
      
      public function showCredits() : void
      {
         this.stateMachine.performAction("CREDITS_ACTION");
      }
      
      protected function clickHandler(event:Event) : void
      {
         var button:Button = null;
         if(this.settingsPanelStaying)
         {
            button = Button(event.target);
            SoundSystem.PlaySound("select");
            if(button.name == "continueButton")
            {
               this.stateMachine.performAction("QUIT_ACTION");
            }
            else if(button.name == "restoreButton")
            {
               SoundSystem.PlaySound("selectGo");
               if(Utils.IS_ANDROID)
               {
                  NativeApplication.nativeApplication.exit();
               }
            }
            else if(button.name == "optionsButton")
            {
               this.stateMachine.performAction("OPTIONS_ACTION");
            }
            else if(button.name == "resetButton")
            {
               this.stateMachine.performAction("RESET_ACTION");
            }
         }
      }
      
      public function popUp() : void
      {
         var i:int = 0;
         var tween:Tween = null;
         var targetY:int = 0;
         this.stateMachine.setState("IS_OPTIONS_STATE");
         this.QUIT_FLAG = false;
         this.GET_OUT_FLAG = false;
         this.settingsPanelEntering = true;
         this.settingsPanelExiting = false;
         this.settingsPanelStaying = false;
         this.counter = 0;
         Utils.rootMovie.addChild(this);
         this.visible = true;
         this.backgroundQuad.alpha = 0;
         this.setButtonsTouchable(false);
         tween = new Tween(this.backgroundQuad,0.25,Transitions.EASE_OUT);
         tween.fadeTo(0.8);
         Starling.juggler.add(tween);
         if(this.optionsPanel != null)
         {
            this.optionsPanel.visible = true;
            tween = new Tween(this.optionsPanel,0.25,Transitions.EASE_OUT);
            tween.fadeTo(1);
            Starling.juggler.add(tween);
            this.optionsPanel.reset();
            this.creditsPanel.visible = false;
            this.resetPanel.visible = false;
         }
         tween = new Tween(this.title,0.25,Transitions.EASE_OUT);
         tween.moveTo(this.title.x,this.outer_y_margin);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.buttonSXContainer,0.25,Transitions.EASE_OUT);
         tween.moveTo(this.outer_x_margin,0);
         tween.roundToInt = true;
         tween.delay = 0;
         tween.onComplete = this.popUpComplete;
         Starling.juggler.add(tween);
      }
      
      protected function popOut() : void
      {
         var tween:Tween = null;
         this.settingsPanelEntering = false;
         this.settingsPanelExiting = true;
         this.settingsPanelStaying = false;
         this.counter = 0;
         tween = new Tween(this.backgroundQuad,0.15);
         tween.fadeTo(0);
         Starling.juggler.add(tween);
         if(this.creditsPanel.visible)
         {
            tween = new Tween(this.creditsPanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         else if(this.optionsPanel.visible)
         {
            tween = new Tween(this.optionsPanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         else if(this.resetPanel.visible)
         {
            tween = new Tween(this.resetPanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         tween = new Tween(this.title,0.15);
         tween.moveTo(this.title.x,-this.title.height);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.buttonSXContainer,0.15);
         tween.moveTo(-(this.column_width + this.outer_x_margin),0);
         tween.delay = 0;
         tween.roundToInt = true;
         tween.onComplete = this.popOutComplete;
         Starling.juggler.add(tween);
      }
      
      protected function popUpComplete() : void
      {
         this.settingsPanelEntering = false;
         this.settingsPanelStaying = true;
         this.setButtonsTouchable(true);
      }
      
      protected function popOutComplete() : void
      {
         this.settingsPanelExiting = false;
         this.GET_OUT_FLAG = true;
      }
      
      public function hide() : void
      {
         Utils.rootMovie.removeChild(this);
         this.visible = false;
      }
      
      protected function evaluatePercentages() : void
      {
         var WIDTH:int = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE);
         var HEIGHT:int = int(Utils.SCREEN_HEIGHT * Utils.GFX_INV_SCALE);
         WIDTH -= Utils.X_SCREEN_MARGIN;
         HEIGHT -= Utils.Y_SCREEN_MARGIN;
         this.body_percentage = 0.75;
         this.column_percentage = 0.15;
         this.inner_margin_percentage = 0.15;
         if(int(WIDTH * this.column_percentage) < 40)
         {
            this.body_percentage = 0.56;
            this.column_percentage = 0.18;
            this.inner_margin_percentage = 0.12;
         }
         this.body_width = int(WIDTH * this.body_percentage);
         this.column_width = int(WIDTH * this.column_percentage);
         this.inner_margin = int(this.column_width * this.inner_margin_percentage);
         this.outer_x_margin = this.outer_y_margin = int((WIDTH - (this.body_width + this.column_width * 1 + this.inner_margin * 1)) * 0.5);
         this.outer_x_margin += int(Utils.X_SCREEN_MARGIN * 0.5);
         this.body_height = int(HEIGHT - this.outer_y_margin * 2);
         this.button_height = int((this.body_height - this.inner_margin * 2) / 3);
      }
      
      protected function initBackground() : void
      {
         this.backgroundQuad = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         this.backgroundQuad.width = Utils.WIDTH;
         this.backgroundQuad.height = Utils.HEIGHT;
         this.backgroundQuad.x = 0;
         this.backgroundQuad.y = 0;
         addChild(this.backgroundQuad);
      }
      
      protected function initText() : void
      {
         this.title = new TextPanel(StringsManager.GetString("panel_settings"),this.body_width,26);
         this.title.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.title.y = -26;
         addChild(this.title);
      }
      
      protected function initButtons() : void
      {
         this.buttonSXContainer = new Sprite();
         this.buttonSXContainer.x = -(this.column_width + this.outer_x_margin);
         this.buttonSXContainer.y = 0;
         addChild(this.buttonSXContainer);
         if(Utils.IS_ANDROID)
         {
            this.restoreButton = new GameButton("onoff_button_icon",this.column_width,this.button_height);
         }
         else
         {
            this.restoreButton = new GameButton("restore_button_icon",this.column_width,this.button_height);
         }
         this.restoreButton.name = "restoreButton";
         this.restoreButton.x = 0;
         this.restoreButton.y = this.outer_y_margin;
         this.resetButton = new GameButton("options_button_icon",this.column_width,this.button_height);
         this.resetButton.name = "optionsButton";
         this.resetButton.x = 0;
         this.resetButton.y = this.outer_y_margin + this.inner_margin + this.button_height;
         this.continueButton = new GameButton("back_button_icon",this.column_width,this.button_height);
         this.continueButton.name = "continueButton";
         this.continueButton.x = 0;
         this.continueButton.y = this.outer_y_margin + this.inner_margin * 2 + this.button_height * 2;
         this.buttonSXContainer.addChild(this.restoreButton);
         this.buttonSXContainer.addChild(this.resetButton);
         this.buttonSXContainer.addChild(this.continueButton);
         this.resetButton.visible = false;
         this.resetButton.enabled = false;
      }
      
      protected function initPanels() : void
      {
         this.creditsPanel = new SettingsCreditsPanel(this,this.body_width,this.body_height - (this.inner_margin + 26));
         this.creditsPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.creditsPanel.y = this.outer_y_margin + 26 + this.inner_margin;
         this.creditsPanel.visible = false;
         this.creditsPanel.setArea(this.creditsPanel.x,this.creditsPanel.y,this.creditsPanel.WIDTH,this.creditsPanel.HEIGHT);
         addChild(this.creditsPanel);
         this.resetPanel = new SettingsSubPanel(this,this.body_width,this.body_height - (this.inner_margin + 26),0);
         this.resetPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.resetPanel.y = this.outer_y_margin + 26 + this.inner_margin;
         this.resetPanel.visible = false;
         addChild(this.resetPanel);
         this.optionsPanel = new SettingsSubPanel(this,this.body_width,this.body_height - (this.inner_margin + 26),1);
         this.optionsPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.optionsPanel.y = this.outer_y_margin + 26 + this.inner_margin;
         this.optionsPanel.visible = false;
         this.optionsPanel.setArea(this.optionsPanel.x,this.optionsPanel.y,this.optionsPanel.WIDTH,this.optionsPanel.HEIGHT);
         addChild(this.optionsPanel);
      }
      
      protected function setButtonsTouchable(value:Boolean) : void
      {
         this.continueButton.touchable = value;
      }
      
      protected function creditsState() : void
      {
         this.title.updateText(StringsManager.GetString("panel_settings"));
         this.creditsPanel.visible = true;
         this.resetPanel.visible = this.optionsPanel.visible = false;
         this.creditsPanel.reset();
      }
      
      protected function resetState() : void
      {
         this.title.updateText(StringsManager.GetString("panel_reset"));
         this.creditsPanel.visible = this.optionsPanel.visible = false;
         this.resetPanel.visible = true;
         this.resetPanel.alpha = 1;
         this.resetPanel.reset();
      }
      
      protected function optionsState() : void
      {
         this.title.updateText(StringsManager.GetString("panel_options"));
         this.creditsPanel.visible = this.resetPanel.visible = false;
         this.optionsPanel.visible = true;
         this.optionsPanel.alpha = 1;
         this.optionsPanel.reset();
      }
      
      protected function quitState() : void
      {
         this.QUIT_FLAG = true;
         this.popOut();
         this.setButtonsTouchable(false);
         SaveManager.SaveGameVariables();
      }
   }
}
