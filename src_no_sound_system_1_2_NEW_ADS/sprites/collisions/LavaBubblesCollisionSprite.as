package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class LavaBubblesCollisionSprite extends GameSprite
   {
      
      protected var standAnimation:GameMovieClip;
      
      public function LavaBubblesCollisionSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lavaBubblesSpriteAnim_"));
         this.standAnimation.setFrameDuration(0,0.2);
         this.standAnimation.setFrameDuration(1,0.2);
         this.standAnimation.setFrameDuration(2,0.2);
         this.standAnimation.setFrameDuration(3,0.2);
         this.standAnimation.setFrameDuration(4,0.2);
         this.standAnimation.setFrameDuration(5,0.2);
         this.standAnimation.setFrameDuration(6,0.2);
         this.standAnimation.setFrameDuration(7,0.2);
         this.standAnimation.touchable = false;
         this.standAnimation.x = 0;
         this.standAnimation.y = -8;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}

