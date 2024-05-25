package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class WindDustIntroParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function WindDustIntroParticleSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("windDustIntroParticleSpriteAnim_"),12);
         this.standAnimation.setFrameDuration(0,0.5);
         this.standAnimation.setFrameDuration(1,0.5);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.pivotX = 1;
         this.standAnimation.pivotY = 1;
         this.standAnimation.loop = true;
         this.standAnimation.gotoAndPlay(int(Math.random() * this.standAnimation.numFrames) + 1);
         Utils.juggler.add(this.standAnimation);
      }
   }
}
