package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GlassParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation1:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      protected var standAnimation3:GameMovieClip;
      
      public function GlassParticleSprite()
      {
         super();
         this.initAnims1();
         this.initAnims2();
         this.initAnims3();
         addChild(this.standAnimation1);
         addChild(this.standAnimation2);
         addChild(this.standAnimation3);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation1);
         this.standAnimation1.dispose();
         this.standAnimation1 = null;
         Utils.juggler.remove(this.standAnimation2);
         this.standAnimation2.dispose();
         this.standAnimation2 = null;
         Utils.juggler.remove(this.standAnimation3);
         this.standAnimation3.dispose();
         this.standAnimation3 = null;
         super.destroy();
      }
      
      protected function initAnims1() : void
      {
         this.standAnimation1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glass1ParticleSpriteAnim_"));
         this.standAnimation1.setFrameDuration(0,Math.random() * 0.5);
         this.standAnimation1.setFrameDuration(1,0.075);
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = -8;
         this.standAnimation1.loop = false;
         Utils.juggler.add(this.standAnimation1);
      }
      
      protected function initAnims2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glass2ParticleSpriteAnim_"));
         this.standAnimation2.setFrameDuration(0,Math.random() * 0.5);
         this.standAnimation2.setFrameDuration(1,0.075);
         this.standAnimation2.textureSmoothing = Utils.getSmoothing();
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = -8;
         this.standAnimation2.loop = false;
         Utils.juggler.add(this.standAnimation2);
      }
      
      protected function initAnims3() : void
      {
         this.standAnimation3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glass3ParticleSpriteAnim_"));
         this.standAnimation3.setFrameDuration(0,Math.random() * 0.5);
         this.standAnimation3.setFrameDuration(1,0.075);
         this.standAnimation3.textureSmoothing = Utils.getSmoothing();
         this.standAnimation3.touchable = false;
         this.standAnimation3.x = this.standAnimation3.y = -8;
         this.standAnimation3.loop = false;
         Utils.juggler.add(this.standAnimation3);
      }
   }
}
