package minigames
{
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class Minigame
   {
       
      
      public var GET_OUT_FLAG:Boolean;
      
      public var pauseButton:Button;
      
      protected var canPause:Boolean;
      
      protected var additional_x_margin:int;
      
      protected var additional_y_margin:int;
      
      public function Minigame()
      {
         super();
         this.canPause = true;
         this.GET_OUT_FLAG = false;
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
      }
      
      public function init() : void
      {
         this.initPauseButton();
      }
      
      protected function initPauseButton() : void
      {
         if(Utils.IS_IPHONE_X)
         {
            this.additional_x_margin = 16;
            this.additional_y_margin = -2;
         }
         else
         {
            this.additional_x_margin = -4;
            this.additional_y_margin = -3;
         }
         this.pauseButton = new Button(TextureManager.hudTextureAtlas.getTexture("pauseButton1"),"",TextureManager.hudTextureAtlas.getTexture("pauseButton2"));
         Image(Sprite(this.pauseButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.pauseButton.x = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE - (this.pauseButton.width + this.additional_x_margin));
         this.pauseButton.y = this.additional_y_margin;
         Utils.gameMovie.addChild(this.pauseButton);
         this.pauseButton.addEventListener(Event.TRIGGERED,this.pauseClickHandler);
      }
      
      protected function pauseButtonOnTop() : void
      {
         Utils.gameMovie.setChildIndex(this.pauseButton,Utils.gameMovie.numChildren - 1);
      }
      
      protected function pauseClickHandler(event:Event) : void
      {
         if(this.canPause)
         {
            SoundSystem.PlaySound("select");
            Utils.PauseOn = true;
         }
      }
      
      public function update() : void
      {
      }
      
      public function destroy() : void
      {
         this.pauseButton.removeEventListener(Event.TRIGGERED,this.pauseClickHandler);
         Utils.gameMovie.removeChild(this.pauseButton);
         this.pauseButton.dispose();
         this.pauseButton = null;
         Utils.gameMovie.removeChild(Utils.topWorld);
         Utils.gameMovie.removeChild(Utils.world);
         Utils.gameMovie.removeChild(Utils.backWorld);
         Utils.topWorld.dispose();
         Utils.world.dispose();
         Utils.backWorld.dispose();
         Utils.topWorld = null;
         Utils.world = null;
         Utils.backWorld = null;
         Utils.rootMovie.removeChild(Utils.gameMovie);
         Utils.gameMovie.dispose();
         Utils.gameMovie = null;
      }
   }
}
