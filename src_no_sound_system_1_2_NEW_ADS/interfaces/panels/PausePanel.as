package interfaces.panels
{
   import game_utils.SaveManager;
   import interfaces.buttons.GameButton;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class PausePanel extends Sprite
   {
       
      
      public var GET_OUT_FLAG:Boolean;
      
      public var CONTINUE_FLAG:Boolean;
      
      public var QUIT_FLAG:Boolean;
      
      public var REPEAT_FLAG:Boolean;
      
      public var pausePanelEntering:Boolean;
      
      public var pausePanelExiting:Boolean;
      
      public var pausePanelStaying:Boolean;
      
      public var backgroundQuad:Image;
      
      public var title:TextPanel;
      
      public var buttonSXContainer:Sprite;
      
      public var buttonDXContainer:Sprite;
      
      public var continueButton:GameButton;
      
      public var levelSelectButton:GameButton;
      
      public var musicOnButton:GameButton;
      
      public var soundOnButton:GameButton;
      
      public var musicOffButton:GameButton;
      
      public var soundOffButton:GameButton;
      
      public var bluePanel:ItemsAndTimerPanel;
      
      public var inventoryPanel:InventoryPanel;
      
      public var popsiclesSprites:Array;
      
      public var popsiclesScratchSprites:Array;
      
      public var counter:int;
      
      protected var body_percentage:Number;
      
      protected var column_percentage:Number;
      
      protected var inner_margin_percentage:Number;
      
      protected var body_height_percentage:Number;
      
      protected var body_width:int;
      
      protected var body_height:int;
      
      protected var column_width:int;
      
      protected var button_height:int;
      
      protected var inner_margin:int;
      
      protected var outer_x_margin:int;
      
      protected var outer_y_margin:int;
      
      public var TYPE:int;
      
      public function PausePanel(type:int = 0)
      {
         super();
         this.GET_OUT_FLAG = false;
         this.CONTINUE_FLAG = false;
         this.QUIT_FLAG = false;
         this.REPEAT_FLAG = false;
         this.pausePanelEntering = false;
         this.pausePanelExiting = false;
         this.pausePanelStaying = false;
         this.counter = 0;
         this.TYPE = type;
         this.visible = false;
         this.scaleX = this.scaleY = Utils.GFX_SCALE;
         this.evaluatePercentages();
         this.initBackground();
         this.initButtons();
         this.initBluePanel();
         this.initText();
         this.continueButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.levelSelectButton.addEventListener(Event.TRIGGERED,this.clickHandler);
         this.musicOnButton.addEventListener(Event.TRIGGERED,this.soundHandler);
         this.soundOnButton.addEventListener(Event.TRIGGERED,this.soundHandler);
         this.musicOffButton.addEventListener(Event.TRIGGERED,this.soundHandler);
         this.soundOffButton.addEventListener(Event.TRIGGERED,this.soundHandler);
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         if(this.visible)
         {
            Utils.rootMovie.removeChild(this);
         }
         this.soundOffButton.removeEventListener(Event.TRIGGERED,this.soundHandler);
         this.musicOffButton.removeEventListener(Event.TRIGGERED,this.soundHandler);
         this.soundOnButton.removeEventListener(Event.TRIGGERED,this.soundHandler);
         this.musicOnButton.removeEventListener(Event.TRIGGERED,this.soundHandler);
         this.levelSelectButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.continueButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         removeChild(this.title);
         this.title.destroy();
         this.title.dispose();
         this.title = null;
         if(this.bluePanel != null)
         {
            removeChild(this.bluePanel);
            this.bluePanel.destroy();
            this.bluePanel.dispose();
            this.bluePanel = null;
         }
         if(this.inventoryPanel != null)
         {
            removeChild(this.inventoryPanel);
            this.inventoryPanel.destroy();
            this.inventoryPanel.dispose();
            this.inventoryPanel = null;
         }
         this.buttonSXContainer.removeChild(this.levelSelectButton);
         this.buttonSXContainer.removeChild(this.soundOffButton);
         this.buttonSXContainer.removeChild(this.musicOffButton);
         this.buttonSXContainer.removeChild(this.soundOnButton);
         this.buttonSXContainer.removeChild(this.musicOnButton);
         this.levelSelectButton.destroy();
         this.levelSelectButton.dispose();
         this.soundOffButton.destroy();
         this.soundOffButton.dispose();
         this.musicOffButton.destroy();
         this.musicOffButton.dispose();
         this.soundOnButton.destroy();
         this.soundOnButton.dispose();
         this.musicOnButton.destroy();
         this.musicOnButton.dispose();
         this.buttonDXContainer.removeChild(this.continueButton);
         this.continueButton.destroy();
         this.continueButton.dispose();
         this.continueButton = null;
         removeChild(this.buttonSXContainer);
         removeChild(this.buttonDXContainer);
         this.buttonSXContainer.dispose();
         this.buttonDXContainer.dispose();
         this.buttonSXContainer = this.buttonDXContainer = null;
         this.musicOnButton = this.soundOnButton = this.musicOffButton = this.soundOffButton = this.levelSelectButton = null;
         removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
      }
      
      public function update() : void
      {
         if(this.bluePanel != null)
         {
            this.bluePanel.update();
         }
         if(this.inventoryPanel != null)
         {
            this.inventoryPanel.update();
         }
      }
      
      protected function clickHandler(event:Event) : void
      {
         if(this.pausePanelStaying)
         {
            if(DisplayObject(event.target).name == "continueButton")
            {
               this.continuePanel();
            }
            else if(DisplayObject(event.target).name == "quitButton")
            {
               this.quitPanel();
            }
         }
      }
      
      public function continuePanel() : void
      {
         if(this.CONTINUE_FLAG)
         {
            return;
         }
         SoundSystem.PlaySound("selectGo");
         this.CONTINUE_FLAG = true;
         this.popOut();
         this.setButtonsTouchable(false);
      }
      
      public function quitPanel() : void
      {
         if(this.GET_OUT_FLAG)
         {
            return;
         }
         SoundSystem.PlaySound("selectBack");
         this.GET_OUT_FLAG = true;
         this.QUIT_FLAG = true;
         this.setButtonsTouchable(false);
      }
      
      protected function soundHandler(event:Event) : void
      {
         if(this.pausePanelStaying)
         {
            if(DisplayObject(event.target).name == "musicOnButton")
            {
               Utils.MusicOn = false;
               this.musicOnButton.visible = false;
               this.musicOffButton.visible = true;
               SoundSystem.StopMusic(true,true);
               SoundSystem.PlaySound("selectGo");
            }
            else if(DisplayObject(event.target).name == "musicOffButton")
            {
               Utils.MusicOn = true;
               SoundSystem.PlayLastMusic(true);
               this.musicOnButton.visible = true;
               this.musicOffButton.visible = false;
               SoundSystem.PlaySound("selectGo");
            }
            else if(DisplayObject(event.target).name == "soundOnButton")
            {
               Utils.SoundOn = false;
               this.soundOnButton.visible = false;
               this.soundOffButton.visible = true;
               SoundSystem.PlaySound("selectGo");
            }
            else if(DisplayObject(event.target).name == "soundOffButton")
            {
               Utils.SoundOn = true;
               this.soundOnButton.visible = true;
               this.soundOffButton.visible = false;
               SoundSystem.PlaySound("selectGo");
            }
            SaveManager.LocalData.data.MusicOn = Utils.MusicOn;
            SaveManager.LocalData.data.SoundOn = Utils.SoundOn;
            SaveManager.Save();
         }
      }
      
      public function popUp() : void
      {
         var i:int = 0;
         var tween:Tween = null;
         var targetY:int = 0;
         this.GET_OUT_FLAG = false;
         this.CONTINUE_FLAG = false;
         this.pausePanelEntering = true;
         this.pausePanelExiting = false;
         this.pausePanelStaying = false;
         this.counter = 0;
         Utils.rootMovie.addChild(this);
         this.visible = true;
         this.backgroundQuad.alpha = 0;
         this.continueButton.touchable = false;
         this.levelSelectButton.touchable = false;
         this.musicOffButton.touchable = false;
         this.musicOnButton.touchable = false;
         this.soundOffButton.touchable = false;
         this.soundOnButton.touchable = false;
         tween = new Tween(this.backgroundQuad,0.25,Transitions.EASE_OUT);
         tween.fadeTo(0.8);
         Starling.juggler.add(tween);
         if(this.bluePanel != null)
         {
            tween = new Tween(this.bluePanel,0.25,Transitions.EASE_OUT);
            tween.fadeTo(1);
            Starling.juggler.add(tween);
            this.bluePanel.updateItems();
            this.bluePanel.updateTime(Utils.PauseTimeToDisplay);
         }
         else if(this.inventoryPanel != null)
         {
            tween = new Tween(this.inventoryPanel,0.25,Transitions.EASE_OUT);
            tween.fadeTo(1);
            Starling.juggler.add(tween);
            this.inventoryPanel.refreshContent();
         }
         tween = new Tween(this.title,0.25,Transitions.EASE_OUT);
         tween.moveTo(this.title.x,this.outer_y_margin);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.buttonDXContainer,0.25,Transitions.EASE_OUT);
         tween.moveTo(int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE - (this.column_width + this.outer_x_margin)),0);
         tween.delay = 0;
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
         this.pausePanelEntering = false;
         this.pausePanelExiting = true;
         this.pausePanelStaying = false;
         this.counter = 0;
         tween = new Tween(this.backgroundQuad,0.15);
         tween.fadeTo(0);
         Starling.juggler.add(tween);
         if(this.bluePanel != null)
         {
            tween = new Tween(this.bluePanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         else if(this.inventoryPanel != null)
         {
            tween = new Tween(this.inventoryPanel,0.15);
            tween.fadeTo(0);
            Starling.juggler.add(tween);
         }
         tween = new Tween(this.title,0.15);
         tween.moveTo(this.title.x,-this.title.height);
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.buttonDXContainer,0.15);
         tween.moveTo(int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE),0);
         tween.delay = 0;
         tween.roundToInt = true;
         tween.onComplete = this.popOutComplete;
         Starling.juggler.add(tween);
         tween = new Tween(this.buttonSXContainer,0.15);
         tween.moveTo(-(this.column_width + this.outer_x_margin),0);
         tween.delay = 0;
         tween.roundToInt = true;
         Starling.juggler.add(tween);
      }
      
      protected function popUpComplete() : void
      {
         this.pausePanelEntering = false;
         this.pausePanelStaying = true;
         this.continueButton.touchable = true;
         this.levelSelectButton.touchable = true;
         this.musicOffButton.touchable = true;
         this.musicOnButton.touchable = true;
         this.soundOffButton.touchable = true;
         this.soundOnButton.touchable = true;
      }
      
      protected function popOutComplete() : void
      {
         this.pausePanelExiting = false;
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
         this.body_percentage = 0.58;
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
         this.outer_x_margin = this.outer_y_margin = int((WIDTH - (this.body_width + this.column_width * 2 + this.inner_margin * 2)) * 0.5);
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
         this.title = new TextPanel(StringsManager.GetString("panel_pause"),this.body_width,26);
         this.title.x = this.outer_x_margin + this.column_width + this.inner_margin;
         this.title.y = -26;
         addChild(this.title);
      }
      
      protected function initButtons() : void
      {
         this.buttonDXContainer = new Sprite();
         this.buttonDXContainer.x = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE);
         this.buttonDXContainer.y = 0;
         this.buttonSXContainer = new Sprite();
         this.buttonSXContainer.x = -(this.column_width + this.outer_x_margin);
         this.buttonSXContainer.y = 0;
         addChild(this.buttonDXContainer);
         addChild(this.buttonSXContainer);
         this.continueButton = new GameButton("play_button_icon",this.column_width,this.body_height);
         this.continueButton.name = "continueButton";
         this.continueButton.x = 0;
         this.continueButton.y = this.outer_y_margin;
         this.buttonDXContainer.addChild(this.continueButton);
         this.musicOnButton = new GameButton("music_on_icon",this.column_width,this.button_height);
         this.musicOnButton.name = "musicOnButton";
         this.musicOnButton.x = 0;
         this.musicOnButton.y = this.outer_y_margin;
         this.musicOffButton = new GameButton("music_off_icon",this.column_width,this.button_height);
         this.musicOffButton.name = "musicOffButton";
         this.musicOffButton.x = 0;
         this.musicOffButton.y = this.outer_y_margin;
         this.soundOnButton = new GameButton("sound_on_icon",this.column_width,this.button_height);
         this.soundOnButton.name = "soundOnButton";
         this.soundOnButton.x = 0;
         this.soundOnButton.y = this.outer_y_margin + this.inner_margin + this.button_height;
         this.soundOffButton = new GameButton("sound_off_icon",this.column_width,this.button_height);
         this.soundOffButton.name = "soundOffButton";
         this.soundOffButton.x = 0;
         this.soundOffButton.y = this.outer_y_margin + this.inner_margin + this.button_height;
         this.levelSelectButton = new GameButton("level_select_icon",this.column_width,this.button_height);
         this.levelSelectButton.name = "quitButton";
         this.levelSelectButton.x = 0;
         this.levelSelectButton.y = this.outer_y_margin + this.inner_margin * 2 + this.button_height * 2;
         this.buttonSXContainer.addChild(this.musicOnButton);
         this.buttonSXContainer.addChild(this.soundOnButton);
         this.buttonSXContainer.addChild(this.musicOffButton);
         this.buttonSXContainer.addChild(this.soundOffButton);
         this.buttonSXContainer.addChild(this.levelSelectButton);
         if(Utils.SoundOn)
         {
            this.soundOffButton.visible = false;
            this.soundOnButton.visible = true;
         }
         else
         {
            this.soundOffButton.visible = true;
            this.soundOnButton.visible = false;
         }
         if(Utils.MusicOn)
         {
            this.musicOffButton.visible = false;
            this.musicOnButton.visible = true;
         }
         else
         {
            this.musicOffButton.visible = true;
            this.musicOnButton.visible = false;
         }
      }
      
      protected function initBluePanel() : void
      {
         this.bluePanel = null;
         this.inventoryPanel = null;
         if(this.TYPE == 0)
         {
            this.bluePanel = new ItemsAndTimerPanel(this.body_width,this.body_height - (this.inner_margin + 26));
            this.bluePanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
            this.bluePanel.y = this.outer_y_margin + 26 + this.inner_margin;
            addChild(this.bluePanel);
         }
         else
         {
            this.inventoryPanel = new InventoryPanel(this.body_width,this.body_height - (this.inner_margin + 26));
            this.inventoryPanel.x = this.outer_x_margin + this.column_width + this.inner_margin;
            this.inventoryPanel.y = this.outer_y_margin + 26 + this.inner_margin;
            addChild(this.inventoryPanel);
         }
      }
      
      protected function setButtonsTouchable(value:Boolean) : void
      {
         this.continueButton.touchable = value;
         this.levelSelectButton.touchable = value;
         this.musicOffButton.touchable = value;
         this.musicOnButton.touchable = value;
         this.soundOffButton.touchable = value;
         this.soundOnButton.touchable = value;
      }
   }
}
