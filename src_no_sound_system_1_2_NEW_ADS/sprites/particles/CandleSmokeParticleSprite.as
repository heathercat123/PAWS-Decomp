package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CandleSmokeParticleSprite extends GameSprite
   {
      
      protected var standAnimation:GameMovieClip;
      
      public function CandleSmokeParticleSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("candleSmokeParticleSpriteAnim_"),12);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -3;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}

