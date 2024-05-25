package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class ItemHeroParticleSprite extends GameSprite
   {
       
      
      protected var standAnim1:GameMovieClip;
      
      public function ItemHeroParticleSprite()
      {
         super();
         this.initStandAnim();
         addChild(this.standAnim1);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim1);
         this.standAnim1.dispose();
         this.standAnim1 = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("itemHeroParticleSpriteAnim_"));
         this.standAnim1.touchable = false;
         this.standAnim1.x = this.standAnim1.y = -8;
         this.standAnim1.loop = false;
         Utils.juggler.add(this.standAnim1);
      }
   }
}
