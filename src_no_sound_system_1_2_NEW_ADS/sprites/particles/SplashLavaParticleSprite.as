package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SplashLavaParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function SplashLavaParticleSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("splashLavaParticleSpriteAnim_"));
         this.standAnimation.setFrameDuration(0,0.025);
         this.standAnimation.setFrameDuration(1,0.025);
         this.standAnimation.setFrameDuration(2,0.025);
         this.standAnimation.setFrameDuration(3,0.05);
         this.standAnimation.setFrameDuration(4,0.05);
         this.standAnimation.setFrameDuration(5,0.05);
         this.standAnimation.setFrameDuration(6,0.05);
         this.standAnimation.setFrameDuration(7,0.05);
         this.standAnimation.setFrameDuration(8,0.05);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = -9;
         this.standAnimation.y = -19;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
