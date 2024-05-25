package sprites.map
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class MapButtonAppearingParticleSprite extends GameSprite
   {
       
      
      protected var type:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function MapButtonAppearingParticleSprite(_type:int = 0)
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
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapFishingButtonAppearingParticleSpriteAnim_"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapButtonAppearingParticleSpriteAnim_"),12);
         }
         this.standAnimation.setFrameDuration(0,0.07);
         this.standAnimation.setFrameDuration(1,0.07);
         this.standAnimation.setFrameDuration(2,0.07);
         this.standAnimation.setFrameDuration(3,0.07);
         this.standAnimation.setFrameDuration(4,0.07);
         this.standAnimation.setFrameDuration(5,0.07);
         this.standAnimation.setFrameDuration(6,0.07);
         this.standAnimation.setFrameDuration(7,0.07);
         this.standAnimation.setFrameDuration(8,0.07);
         this.standAnimation.setFrameDuration(9,0.07);
         this.standAnimation.setFrameDuration(10,0.07);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = -16;
         this.standAnimation.y = -32;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
