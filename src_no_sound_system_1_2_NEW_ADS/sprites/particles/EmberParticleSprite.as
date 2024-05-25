package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class EmberParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      public function EmberParticleSprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initAnims();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.addChild(this.standAnimation);
         sprite.addChild(this.standAnimation2);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         Utils.juggler.remove(this.standAnimation2);
         this.standAnimation2.dispose();
         this.standAnimation2 = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("EmberParticleBigSpriteAnim_"),12);
         this.standAnimation.setFrameDuration(0,0.1);
         this.standAnimation.setFrameDuration(1,0.1);
         this.standAnimation.setFrameDuration(2,0.1);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = -3;
         this.standAnimation.y = -3;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("EmberParticleSmallSpriteAnim_"),12);
         this.standAnimation2.setFrameDuration(0,0.1);
         this.standAnimation2.setFrameDuration(1,0.1);
         this.standAnimation2.setFrameDuration(2,0.1);
         this.standAnimation2.textureSmoothing = Utils.getSmoothing();
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = -3;
         this.standAnimation2.y = -3;
         this.standAnimation2.loop = true;
         Utils.juggler.add(this.standAnimation2);
      }
   }
}
