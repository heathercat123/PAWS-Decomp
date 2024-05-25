package sprites.background
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class WaterfallBackgroundSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var TYPE:int;
      
      public function WaterfallBackgroundSprite(_type:int)
      {
         super();
         this.TYPE = _type;
         this.initAnims();
         addChild(this.standAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("waterfallBackgroundSpriteAnim_"));
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.1);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("temple_waterfall_1"));
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
