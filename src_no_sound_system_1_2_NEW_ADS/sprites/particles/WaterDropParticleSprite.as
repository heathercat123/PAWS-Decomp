package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class WaterDropParticleSprite extends GameSprite
   {
       
      
      protected var type:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function WaterDropParticleSprite(_type:int = 0)
      {
         super();
         this.type = _type;
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
         if(this.type == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterDawnDropParticleSpriteAnim_"));
         }
         else if(this.type == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("honeyDropParticleSpriteAnim_"));
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterDropParticleSpriteAnim_"));
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -4;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
