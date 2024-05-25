package sprites.background
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CityNightSnowBackgroundParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function CityNightSnowBackgroundParticleSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("cityNightSnowBackgroundParticleSpriteAnim_"),12);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.pivotX = 2;
         this.standAnimation.pivotY = 2;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
