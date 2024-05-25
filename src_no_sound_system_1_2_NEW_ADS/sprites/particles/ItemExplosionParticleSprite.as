package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class ItemExplosionParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function ItemExplosionParticleSprite()
      {
         super();
         this.initAnims();
         addChild(this.standAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.freeze_juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("itemExplosionParticleSpriteAnim_"),12);
         this.standAnimation.setFrameDuration(0,0.05);
         this.standAnimation.setFrameDuration(1,0.05);
         this.standAnimation.setFrameDuration(2,0.075);
         this.standAnimation.setFrameDuration(3,0.05);
         this.standAnimation.setFrameDuration(4,0.05);
         this.standAnimation.setFrameDuration(5,0.075);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -20;
         this.standAnimation.loop = false;
         Utils.freeze_juggler.add(this.standAnimation);
      }
   }
}
