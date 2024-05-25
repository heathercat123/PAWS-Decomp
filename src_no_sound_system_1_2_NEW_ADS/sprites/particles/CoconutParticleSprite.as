package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CoconutParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function CoconutParticleSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("coconutParticleSpriteAnim_"));
         for(i = 0; i < this.standAnimation.numFrames; i++)
         {
            this.standAnimation.setFrameDuration(i,0.075);
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -12;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
