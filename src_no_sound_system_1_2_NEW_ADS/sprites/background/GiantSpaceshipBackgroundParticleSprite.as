package sprites.background
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GiantSpaceshipBackgroundParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function GiantSpaceshipBackgroundParticleSprite()
      {
         super();
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
         this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("background_flying_ship_10"),12);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.pivotX = 150;
         this.standAnimation.pivotY = 82;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
