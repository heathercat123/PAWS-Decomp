package interfaces.panels
{
   import game_utils.StateMachine;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class ExitPanel extends Sprite
   {
       
      
      public var QUIT_FLAG:Boolean;
      
      public var GET_OUT_FLAG:Boolean;
      
      public var settingsPanelEntering:Boolean;
      
      public var settingsPanelExiting:Boolean;
      
      public var settingsPanelStaying:Boolean;
      
      public var backgroundQuad:Image;
      
      public var title:TextPanel;
      
      public var exitTextPanel:ExitTextPanel;
      
      public var counter:int;
      
      protected var body_percentage:Number;
      
      protected var column_percentage:Number;
      
      protected var inner_margin_percentage:Number;
      
      protected var body_width:int;
      
      protected var body_height:int;
      
      protected var column_width:int;
      
      protected var inner_margin:int;
      
      protected var outer_x_margin:int;
      
      protected var outer_y_margin:int;
      
      public var stateMachine:StateMachine;
      
      protected var ITEM_INDEX:int;
      
      protected var ITEM_PRICE:Number;
      
      protected var REPLY_INDEX:int;
      
      public var EXIT_GAME:Boolean;
      
      public function ExitPanel()
      {
         super();
         this.QUIT_FLAG = false;
         this.GET_OUT_FLAG = false;
         this.EXIT_GAME = false;
         this.settingsPanelEntering = false;
         this.settingsPanelExiting = false;
         this.settingsPanelStaying = false;
         this.counter = 0;
         this.visible = false;
         this.scaleX = this.scaleY = Utils.GFX_SCALE;
         this.evaluatePercentages();
         this.initBackground();
         this.initText();
         this.initPanels();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_NORMAL_STATE","CONTINUE_ACTION","IS_CONTINUE_STATE");
         this.stateMachine.setRule("IS_NORMAL_STATE","QUIT_ACTION","IS_QUIT_STATE");
         this.stateMachine.setFunctionToState("IS_NORMAL_STATE",this.normalState);
         this.stateMachine.setFunctionToState("IS_CONTINUE_STATE",this.continueState);
         this.stateMachine.setFunctionToState("IS_QUIT_STATE",this.quitState);
         this.stateMachine.setState("IS_NORMAL_STATE");
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.stateMachine.destroy();
         this.stateMachine = null;
         removeChild(this.title);
         this.title.destroy();
         this.title.dispose();
         this.title = null;
         removeChild(this.exitTextPanel);
         this.exitTextPanel.destroy();
         this.exitTextPanel.dispose();
         this.exitTextPanel = null;
         removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
      }
      
      public function update() : void
      {
         this.exitTextPanel.update();
         if(this.stateMachine.currentState == "IS_NORMAL_STATE")
         {
            if(this.exitTextPanel.CONTINUE_FLAG)
            {
               this.stateMachine.performAction("CONTINUE_ACTION");
            }
            else if(this.exitTextPanel.QUIT_FLAG)
            {
               this.stateMachine.performAction("QUIT_ACTION");
            }
         }
      }
      
      public function popUp() : void
      {
         var i:int = 0;
         var tween:Tween = null;
         var targetY:int = 0;
         this.stateMachine.setState("IS_NORMAL_STATE");
         this.QUIT_FLAG = false;
         this.GET_OUT_FLAG = false;
         this.EXIT_GAME = false;
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
         this.exitTextPanel.visible = true;
         this.exitTextPanel.resetValues();
         this.exitTextPanel.alpha = 0;
         tween = new Tween(this.exitTextPanel,0.25,Transitions.EASE_OUT);
         tween.fadeTo(1);
         Starling.juggler.add(tween);
         tween = new Tween(this.title,0.25,Transitions.EASE_OUT);
         tween.moveTo(this.title.x,this.outer_y_margin);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween.onComplete = this.popUpComplete;
      }
      
      public function popOut() : void
      {
         var tween:Tween = null;
         this.settingsPanelEntering = false;
         this.settingsPanelExiting = true;
         this.settingsPanelStaying = false;
         this.counter = 0;
         tween = new Tween(this.backgroundQuad,0.15);
         tween.fadeTo(0);
         Starling.juggler.add(tween);
         tween = new Tween(this.exitTextPanel,0.15);
         tween.fadeTo(0);
         Starling.juggler.add(tween);
         tween = new Tween(this.title,0.15);
         tween.moveTo(this.title.x,-this.title.height);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween.onComplete = this.popOutComplete;
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
         this.body_percentage = 0.8;
         this.column_percentage = 0.15;
         this.inner_margin_percentage = 0.15;
         if(int(WIDTH * this.column_percentage) < 40)
         {
            this.body_percentage = 0.9;
            this.column_percentage = 0;
            this.inner_margin_percentage = 0.2;
         }
         this.body_width = int(WIDTH * this.body_percentage);
         this.column_width = int(WIDTH * 0.15);
         this.inner_margin = int(this.column_width * this.inner_margin_percentage);
         this.outer_x_margin = int((WIDTH - this.body_width) * 0.5);
         this.body_height = int(Utils.HEIGHT * 0.8);
         this.outer_y_margin = int((HEIGHT - this.body_height) * 0.5);
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
         this.title = new TextPanel(StringsManager.GetString("exit"),this.body_width,26);
         this.title.x = this.outer_x_margin;
         this.title.y = -26;
         addChild(this.title);
      }
      
      protected function initPanels() : void
      {
         this.exitTextPanel = new ExitTextPanel(this.body_width,this.body_height - (this.inner_margin + 26));
         this.exitTextPanel.x = this.outer_x_margin;
         this.exitTextPanel.y = this.outer_y_margin + 26 + this.inner_margin;
         addChild(this.exitTextPanel);
      }
      
      protected function setButtonsTouchable(value:Boolean) : void
      {
      }
      
      protected function normalState() : void
      {
         this.QUIT_FLAG = false;
         this.EXIT_GAME = false;
      }
      
      protected function continueState() : void
      {
         this.QUIT_FLAG = true;
         this.EXIT_GAME = false;
         this.popOut();
         this.setButtonsTouchable(false);
      }
      
      protected function quitState() : void
      {
         this.QUIT_FLAG = true;
         this.EXIT_GAME = true;
         this.popOut();
         this.setButtonsTouchable(false);
      }
   }
}
