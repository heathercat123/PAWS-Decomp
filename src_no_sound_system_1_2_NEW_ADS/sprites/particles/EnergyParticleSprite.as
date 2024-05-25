package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class EnergyParticleSprite extends GameSprite
   {
       
      
      protected var standAnim1:GameMovieClip;
      
      protected var standAnim2:GameMovieClip;
      
      public function EnergyParticleSprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         addChild(this.standAnim1);
         addChild(this.standAnim2);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim1);
         Utils.juggler.remove(this.standAnim2);
         this.standAnim1.dispose();
         this.standAnim2.dispose();
         this.standAnim1 = null;
         this.standAnim2 = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("energyParticleBigSpriteAnim_"));
         this.standAnim1.setFrameDuration(0,0.075);
         this.standAnim1.setFrameDuration(1,0.075);
         this.standAnim1.touchable = false;
         this.standAnim1.x = this.standAnim1.y = -4;
         this.standAnim1.loop = true;
         Utils.juggler.add(this.standAnim1);
         this.standAnim2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("energyParticleSmallSpriteAnim_"));
         this.standAnim2.setFrameDuration(0,0.075);
         this.standAnim2.setFrameDuration(1,0.075);
         this.standAnim2.touchable = false;
         this.standAnim2.x = this.standAnim2.y = -4;
         this.standAnim2.loop = true;
         Utils.juggler.add(this.standAnim2);
      }
   }
}
