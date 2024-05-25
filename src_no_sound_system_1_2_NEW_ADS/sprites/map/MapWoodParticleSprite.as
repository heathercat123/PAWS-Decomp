package sprites.map
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class MapWoodParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function MapWoodParticleSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("woodParticleMapSpriteAnim_"),12);
         this.standAnimation.setFrameDuration(0,0.075);
         this.standAnimation.setFrameDuration(1,0.075);
         this.standAnimation.setFrameDuration(2,0.075);
         this.standAnimation.setFrameDuration(3,0.075);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -8;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
