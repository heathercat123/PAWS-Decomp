package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BigLeverCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      public function BigLeverCollisionSprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initAnims();
         this.initAnims2();
         addChild(this.standAnimation);
         addChild(this.standAnimation2);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.standAnimation2);
         this.standAnimation.dispose();
         this.standAnimation2.dispose();
         this.standAnimation = null;
         this.standAnimation2 = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("leverBigCollisionLeftAnim_"),12);
         this.standAnimation.setFrameDuration(0,0.01);
         this.standAnimation.setFrameDuration(1,0.1);
         this.standAnimation.setFrameDuration(2,0.2);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initAnims2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("leverBigCollisionRightAnim_"),12);
         this.standAnimation2.setFrameDuration(0,0.01);
         this.standAnimation2.setFrameDuration(1,0.1);
         this.standAnimation2.setFrameDuration(2,0.2);
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = 0;
         this.standAnimation2.loop = false;
         Utils.juggler.add(this.standAnimation2);
      }
   }
}
