package interfaces.panels
{
   import game_utils.GameSlot;
   import interfaces.buttons.CatButton;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class CatPanel extends Sprite
   {
       
      
      public var GET_OUT_FLAG:Boolean;
      
      public var CAT_INDEX:int;
      
      public var catPanelEntering:Boolean;
      
      public var catPanelExiting:Boolean;
      
      public var catPanelStaying:Boolean;
      
      public var backgroundQuad:Image;
      
      public var buttonTOPContainer:Sprite;
      
      public var buttonBOTContainer:Sprite;
      
      public var catsButton:Array;
      
      public var counter:int;
      
      protected var button_width_percentage:Number;
      
      protected var button_height_percentage:Number;
      
      protected var button_width:int;
      
      protected var button_height:int;
      
      protected var x_margin:int;
      
      protected var y_margin:int;
      
      public function CatPanel()
      {
         super();
         this.GET_OUT_FLAG = false;
         this.CAT_INDEX = 0;
         this.catPanelEntering = false;
         this.catPanelExiting = false;
         this.catPanelStaying = false;
         this.counter = 0;
         this.visible = false;
         this.scaleX = this.scaleY = Utils.GFX_SCALE;
         this.evaluatePercentages();
         this.initBackground();
         this.initButtons();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.catsButton.length; i++)
         {
            this.catsButton[i].removeEventListener(Event.TRIGGERED,this.clickHandler);
            this.catsButton[i].destroy();
            this.catsButton[i].dispose();
            this.catsButton[i] = null;
         }
         this.catsButton = null;
         removeChild(this.buttonTOPContainer);
         this.buttonTOPContainer.dispose();
         this.buttonTOPContainer = null;
         removeChild(this.buttonBOTContainer);
         this.buttonBOTContainer.dispose();
         this.buttonBOTContainer = null;
         if(this.visible)
         {
            Utils.rootMovie.removeChild(this);
         }
         removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.catsButton.length; i++)
         {
            this.catsButton[i].update();
         }
      }
      
      protected function clickHandler(event:Event) : void
      {
         if(this.catPanelStaying)
         {
            SoundSystem.PlaySound("select");
            this.CAT_INDEX = Number(CatButton(event.target).name);
            this.popOut();
         }
      }
      
      public function backButtonAndroid() : void
      {
         if(this.catPanelStaying)
         {
            SoundSystem.PlaySound("select");
            this.CAT_INDEX = Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT];
            this.popOut();
         }
      }
      
      public function popUp() : void
      {
         var i:int = 0;
         var tween:Tween = null;
         var targetY:int = 0;
         this.GET_OUT_FLAG = false;
         this.catPanelEntering = true;
         this.catPanelExiting = false;
         this.catPanelStaying = false;
         this.counter = 0;
         Utils.rootMovie.addChild(this);
         this.visible = true;
         this.backgroundQuad.alpha = 0;
         for(i = 0; i < this.catsButton.length; i++)
         {
            this.catsButton[i].touchable = false;
            this.catsButton[i].resetData();
         }
         tween = new Tween(this.backgroundQuad,0.25,Transitions.EASE_OUT);
         tween.fadeTo(0.8);
         Starling.juggler.add(tween);
         tween = new Tween(this.buttonTOPContainer,0.25,Transitions.EASE_OUT);
         tween.moveTo(0,this.y_margin);
         tween.delay = 0;
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween = new Tween(this.buttonBOTContainer,0.25,Transitions.EASE_OUT);
         tween.moveTo(0,this.button_height + this.y_margin * 2);
         tween.roundToInt = true;
         tween.delay = 0;
         tween.onComplete = this.popUpComplete;
         Starling.juggler.add(tween);
      }
      
      protected function popOut() : void
      {
         var i:int = 0;
         var tween:Tween = null;
         this.catPanelEntering = false;
         this.catPanelExiting = true;
         this.catPanelStaying = false;
         this.counter = 0;
         for(i = 0; i < this.catsButton.length; i++)
         {
            this.catsButton[i].touchable = false;
         }
         tween = new Tween(this.backgroundQuad,0.15);
         tween.fadeTo(0);
         Starling.juggler.add(tween);
         tween = new Tween(this.buttonTOPContainer,0.15);
         tween.moveTo(0,int(-this.button_height));
         tween.delay = 0;
         tween.roundToInt = true;
         tween.onComplete = this.popOutComplete;
         Starling.juggler.add(tween);
         tween = new Tween(this.buttonBOTContainer,0.15);
         tween.moveTo(0,Utils.HEIGHT);
         tween.delay = 0;
         tween.roundToInt = true;
         Starling.juggler.add(tween);
      }
      
      protected function popUpComplete() : void
      {
         var i:int = 0;
         this.catPanelEntering = false;
         this.catPanelStaying = true;
         for(i = 0; i < this.catsButton.length; i++)
         {
            this.catsButton[i].touchable = true;
         }
      }
      
      protected function popOutComplete() : void
      {
         this.catPanelExiting = false;
         this.GET_OUT_FLAG = true;
      }
      
      public function hide() : void
      {
         Utils.rootMovie.removeChild(this);
         this.visible = false;
      }
      
      protected function evaluatePercentages() : void
      {
         var WIDTH:int = Utils.WIDTH - Utils.X_SCREEN_MARGIN;
         var HEIGHT:int = Utils.HEIGHT;
         this.button_width_percentage = 0.1922;
         this.button_height_percentage = 0.4362;
         this.button_width = int(WIDTH * this.button_width_percentage);
         this.button_height = int(HEIGHT * this.button_height_percentage);
         var x_space_left:Number = WIDTH - this.button_width * 4;
         var y_space_left:Number = HEIGHT - this.button_height * 2;
         this.x_margin = int(x_space_left / 5);
         this.y_margin = int(y_space_left / 3);
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
      
      protected function initButtons() : void
      {
         var i:int = 0;
         var index:int = 0;
         var gButton:CatButton = null;
         this.buttonTOPContainer = new Sprite();
         this.buttonTOPContainer.x = 0;
         this.buttonTOPContainer.y = -this.button_height;
         this.buttonBOTContainer = new Sprite();
         this.buttonBOTContainer.x = 0;
         this.buttonBOTContainer.y = Utils.HEIGHT;
         addChild(this.buttonTOPContainer);
         addChild(this.buttonBOTContainer);
         this.catsButton = new Array();
         for(i = 0; i < 8; i++)
         {
            if(i == 1)
            {
               index = 4;
            }
            else if(i == 4)
            {
               index = 1;
            }
            else
            {
               index = i;
            }
            gButton = new CatButton(index,this.button_width,this.button_height);
            if(i < 4)
            {
               this.buttonTOPContainer.addChild(gButton);
               gButton.x = int((this.button_width + this.x_margin) * i + this.x_margin + Utils.X_SCREEN_MARGIN * 0.5);
               gButton.y = 0;
            }
            else
            {
               this.buttonBOTContainer.addChild(gButton);
               gButton.x = int((this.button_width + this.x_margin) * (i - 4) + this.x_margin + Utils.X_SCREEN_MARGIN * 0.5);
               gButton.y = 0;
            }
            gButton.name = "" + index;
            gButton.addEventListener(Event.TRIGGERED,this.clickHandler);
            this.catsButton.push(gButton);
         }
      }
   }
}
