package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class TreadmillCollisionSprite extends GameSprite
   {
      
      protected var standAnimation:GameMovieClip;
      
      public function TreadmillCollisionSprite()
      {
         var sprite:GameSprite = null;
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("treadmillCollisionSpriteAnim_"),12);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}

