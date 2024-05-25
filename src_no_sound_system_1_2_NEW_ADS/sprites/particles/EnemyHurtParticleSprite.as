package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class EnemyHurtParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function EnemyHurtParticleSprite()
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
         var i:int = 0;
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("enemyHurtParticleSpriteAnim_"));
         this.standAnimation.setFrameDuration(0,0.05);
         this.standAnimation.setFrameDuration(1,0.05);
         this.standAnimation.setFrameDuration(2,0.05);
         this.standAnimation.setFrameDuration(3,0.05);
         this.standAnimation.setFrameDuration(4,0.05);
         this.standAnimation.setFrameDuration(5,0.05);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -16;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
