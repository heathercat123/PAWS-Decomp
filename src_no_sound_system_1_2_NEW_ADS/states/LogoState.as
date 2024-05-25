package states
{
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class LogoState implements IState
   {
       
      
      public var container:Sprite;
      
      public var whiteBackground:Quad;
      
      public var logoImage:Image;
      
      public var logoShadow:Image;
      
      protected var counter:*;
      
      protected var counter2:int;
      
      protected var scale:Number;
      
      protected var soundCounter:int;
      
      protected var touch_counter:int;
      
      protected var ALREADY_OUT:Boolean;
      
      public var GET_OUT_FLAG:Boolean;
      
      public function LogoState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         this.container = new Sprite();
         this.container.x = this.container.y = 0;
         Utils.rootMovie.addChild(this.container);
         var amount_w:Number = Utils.SCREEN_WIDTH / 237;
         var amount_h:Number = Utils.SCREEN_HEIGHT / 282;
         if(amount_h < amount_w)
         {
            this.scale = int(amount_h);
            if(amount_h < 1)
            {
               this.scale = 0.5;
            }
         }
         else
         {
            this.scale = int(amount_w);
            if(amount_w < 1)
            {
               this.scale = 0.5;
            }
         }
         if(this.scale <= 0)
         {
            this.scale = 1;
         }
         this.whiteBackground = new Quad(Utils.SCREEN_WIDTH,Utils.SCREEN_HEIGHT,2110331);
         this.whiteBackground.x = this.whiteBackground.y = 0;
         this.container.addChild(this.whiteBackground);
         this.logoShadow = new Image(TextureManager.introTextureAtlas.getTexture("neutronizedLogoShadow"));
         this.logoShadow.pivotX = this.logoShadow.width * 0.5;
         this.logoShadow.pivotY = this.logoShadow.height * 0.5;
         this.logoShadow.scaleX = this.logoShadow.scaleY = this.scale;
         this.logoShadow.x = Utils.SCREEN_WIDTH * 0.5;
         this.logoShadow.y = Utils.SCREEN_HEIGHT * 0.5 + 8 * this.scale;
         this.logoShadow.alpha = 0;
         this.container.addChild(this.logoShadow);
         this.logoImage = new Image(TextureManager.introTextureAtlas.getTexture("neutronizedLogo"));
         this.logoImage.pivotX = this.logoImage.width * 0.5;
         this.logoImage.pivotY = this.logoImage.height * 0.5;
         this.logoImage.scaleX = this.logoImage.scaleY = this.scale;
         this.logoImage.x = Utils.SCREEN_WIDTH * 0.5;
         this.logoImage.y = Utils.SCREEN_HEIGHT * 0.5 + 8 * this.scale;
         this.logoImage.alpha = 0;
         this.container.addChild(this.logoImage);
         this.counter = -5;
         this.counter2 = 0;
         this.soundCounter = 0;
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onClick);
         game.enterLogoState();
      }
      
      public function onClick(event:TouchEvent) : void
      {
         if(this.touch_counter < 30 || this.ALREADY_OUT)
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
                  SoundSystem.StopSound();
                  SoundSystem.PlaySound("select");
               }
            }
         }
      }
      
      public function updateState(game:Game) : void
      {
         ++this.soundCounter;
         ++this.touch_counter;
         if(this.soundCounter == 1)
         {
            SoundSystem.PlaySound("logo");
         }
         ++this.counter;
         if(this.logoShadow.alpha == 1)
         {
            if(this.counter >= 6)
            {
               this.counter = 0;
               this.logoImage.alpha += 0.3;
               if(this.logoImage.alpha >= 1)
               {
                  this.logoImage.alpha = 1;
               }
            }
            ++this.counter2;
            if(this.counter2 >= 4)
            {
               this.counter2 = 0;
               this.logoImage.y -= 1 * this.scale;
            }
            if(this.logoImage.y <= Utils.SCREEN_HEIGHT * 0.5)
            {
               this.logoImage.y = Utils.SCREEN_HEIGHT * 0.5;
            }
         }
         else if(this.counter >= 8)
         {
            this.counter = 0;
            this.logoShadow.alpha += 0.3;
            if(this.logoShadow.alpha >= 1)
            {
               this.logoShadow.alpha = 1;
               this.counter = 3;
            }
         }
         game.updateLogoState();
      }
      
      public function exitState(game:Game) : void
      {
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onClick);
         this.container.removeChild(this.logoShadow);
         this.logoShadow.dispose();
         this.logoShadow = null;
         this.container.removeChild(this.logoImage);
         this.logoImage.dispose();
         this.logoImage = null;
         this.container.removeChild(this.whiteBackground);
         this.whiteBackground.dispose();
         this.whiteBackground = null;
         Utils.rootMovie.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         game.exitLogoState();
      }
   }
}
