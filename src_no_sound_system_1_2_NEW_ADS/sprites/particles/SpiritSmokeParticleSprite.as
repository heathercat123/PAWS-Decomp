package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SpiritSmokeParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation1:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      public function SpiritSmokeParticleSprite()
      {
         super();
         this.initAnims1();
         this.initAnims2();
         addChild(this.standAnimation1);
         addChild(this.standAnimation2);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation1);
         Utils.juggler.remove(this.standAnimation2);
         this.standAnimation1.dispose();
         this.standAnimation2.dispose();
         this.standAnimation1 = null;
         this.standAnimation2 = null;
         super.destroy();
      }
      
      protected function initAnims1() : void
      {
         var i:int = 0;
         this.standAnimation1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spiritParticlefrontSpriteAnim_"));
         this.standAnimation1.setFrameDuration(0,0.2);
         this.standAnimation1.setFrameDuration(1,0.2);
         this.standAnimation1.setFrameDuration(2,0.2);
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = -6;
         this.standAnimation1.loop = false;
         Utils.juggler.add(this.standAnimation1);
      }
      
      protected function initAnims2() : void
      {
         var i:int = 0;
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spiritParticlebackSpriteAnim_"));
         this.standAnimation2.setFrameDuration(0,0.2);
         this.standAnimation2.setFrameDuration(1,0.2);
         this.standAnimation2.setFrameDuration(2,0.2);
         this.standAnimation2.textureSmoothing = Utils.getSmoothing();
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = -6;
         this.standAnimation2.loop = false;
         Utils.juggler.add(this.standAnimation2);
      }
   }
}
