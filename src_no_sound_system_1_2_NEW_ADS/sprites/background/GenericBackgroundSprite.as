package sprites.background
{
   import levels.backgrounds.elements.GenericBackgroundElement;
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GenericBackgroundSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function GenericBackgroundSprite(_type:int)
      {
         var sprite:GameSprite = null;
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
         if(this.TYPE == GenericBackgroundElement.CANYON_GLITTER_1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("canyonGlitter1BackgroundSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.loop = false;
         }
         else if(this.TYPE == GenericBackgroundElement.CASTLE_TORCH)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("castleTorchBackgroundSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.loop = true;
         }
         else if(this.TYPE == GenericBackgroundElement.LIGHTHOUSE)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("lighthouseBackgroundSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
            this.standAnimation.loop = true;
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("canyonGlitter2BackgroundSpriteAnim_"),12);
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.loop = false;
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
