package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class ImpactParticleSprite extends GameSprite
   {
       
      
      protected var doNotFreeze:Boolean;
      
      protected var standAnimation:GameMovieClip;
      
      public function ImpactParticleSprite(do_not_freeze:Boolean = false)
      {
         super();
         this.doNotFreeze = do_not_freeze;
         this.initAnims();
         addChild(this.standAnimation);
      }
      
      override public function destroy() : void
      {
         if(!this.doNotFreeze)
         {
            Utils.juggler.remove(this.standAnimation);
         }
         else
         {
            Utils.freeze_juggler.add(this.standAnimation);
         }
         this.standAnimation.dispose();
         this.standAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("impactParticleSpriteAnim_"),12);
         if(!this.doNotFreeze)
         {
            this.standAnimation.setFrameDuration(0,0.05);
            this.standAnimation.setFrameDuration(1,0.05);
            this.standAnimation.setFrameDuration(2,0.05);
            this.standAnimation.setFrameDuration(3,0.05);
         }
         else
         {
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.1);
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -16;
         this.standAnimation.loop = false;
         if(!this.doNotFreeze)
         {
            Utils.juggler.add(this.standAnimation);
         }
         else
         {
            Utils.freeze_juggler.add(this.standAnimation);
         }
      }
   }
}
