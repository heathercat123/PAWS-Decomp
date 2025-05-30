package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class LeverKnobCollisionSprite extends GameSprite
   {
      
      protected var standAnimation:GameMovieClip;
      
      public function LeverKnobCollisionSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("leverKnobAnim_"),12);
         this.standAnimation.setFrameDuration(0,0.4);
         this.standAnimation.setFrameDuration(1,0.1);
         this.standAnimation.setFrameDuration(2,0.1);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
   }
}

