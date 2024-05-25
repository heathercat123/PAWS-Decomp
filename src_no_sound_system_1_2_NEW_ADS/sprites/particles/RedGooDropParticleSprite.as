package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class RedGooDropParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var TYPE:int;
      
      public function RedGooDropParticleSprite(_TYPE:int = 0)
      {
         super();
         this.TYPE = _TYPE;
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
         if(this.TYPE == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowGooDropParticleSpriteAnim_"));
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redGooDropParticleSpriteAnim_"));
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -4;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
