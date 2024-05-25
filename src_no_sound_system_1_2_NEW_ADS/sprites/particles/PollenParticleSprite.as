package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class PollenParticleSprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function PollenParticleSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
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
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowPollenParticleSpriteAnim_"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pollenParticleSpriteAnim_"),12);
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -3;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
