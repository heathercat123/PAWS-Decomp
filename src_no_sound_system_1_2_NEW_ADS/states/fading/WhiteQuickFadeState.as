package states.fading
{
   import starling.display.Image;
   import starling.display.Sprite;
   import states.IState;
   
   public class WhiteQuickFadeState implements IState
   {
       
      
      private var container:Sprite;
      
      private var fader:Image;
      
      private var delayCounter:int;
      
      private var counter:int;
      
      private var alphaCounter:int;
      
      public function WhiteQuickFadeState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         this.delayCounter = 0;
         if(game.fadingOut)
         {
            game.FADE_IN_FLAG = false;
            this.container = new Sprite();
            this.container.scaleX = this.container.scaleY = Utils.GFX_SCALE;
            this.container.x = this.container.y = 0;
            Utils.rootMovie.addChild(this.container);
            this.fader = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
            this.fader.width = Utils.WIDTH;
            this.fader.height = Utils.HEIGHT;
            this.container.addChild(this.fader);
            this.fader.alpha = 1;
         }
         else
         {
            Utils.rootMovie.setChildIndex(this.container,Utils.rootMovie.numChildren - 1);
            this.fader.alpha = 1;
         }
      }
      
      public function updateState(game:Game) : void
      {
         var i:* = undefined;
         var j:int = 0;
         Utils.rootMovie.setChildIndex(this.container,Utils.rootMovie.numChildren - 1);
         if(game.fadingOut)
         {
            game.FADE_OUT_FLAG = true;
         }
         else if(this.delayCounter++ >= 2)
         {
            game.removeFader();
         }
      }
      
      public function exitState(game:Game) : void
      {
         var i:int = 0;
         this.container.removeChild(this.fader);
         this.fader.dispose();
         this.fader = null;
         Utils.rootMovie.removeChild(this.container);
         this.container = null;
      }
   }
}
