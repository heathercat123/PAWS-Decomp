package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GeiserBubbleParticleSprite extends GameSprite
   {
      
      protected var standAnimation:GameMovieClip;
      
      public function GeiserBubbleParticleSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lavaBubbleParticleSpriteAnim_"));
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = -4;
         this.standAnimation.y = 0;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}

