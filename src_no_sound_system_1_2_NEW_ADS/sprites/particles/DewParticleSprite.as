package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DewParticleSprite extends GameSprite
   {
       
      
      public var ID:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function DewParticleSprite(_id:int = 0)
      {
         super();
         this.ID = _id;
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
         if(this.ID == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("honeyParticleSpriteAnim_"));
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("dewParticleSpriteAnim_"));
         }
         this.standAnimation.setFrameDuration(0,0.2);
         this.standAnimation.setFrameDuration(1,0.2);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -8;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
