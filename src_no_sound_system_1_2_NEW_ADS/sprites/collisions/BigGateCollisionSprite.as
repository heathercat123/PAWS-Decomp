package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BigGateCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function BigGateCollisionSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bigGateCollisionSprite"),24);
         this.standAnimation.touchable = false;
         this.standAnimation.x = -16;
         this.standAnimation.y = -24;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
