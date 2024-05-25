package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DoorCollisionSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var closeAnimation:GameMovieClip;
      
      protected var openingAnimation:GameMovieClip;
      
      protected var openAnimation:GameMovieClip;
      
      protected var closingAnimation:GameMovieClip;
      
      public function DoorCollisionSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
         this.initCloseAnimation();
         this.initOpeningAnimation();
         this.initOpenAnimation();
         this.initClosingAnimation();
         addChild(this.closeAnimation);
         addChild(this.openingAnimation);
         addChild(this.openAnimation);
         addChild(this.closingAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.closeAnimation);
         Utils.juggler.remove(this.openingAnimation);
         Utils.juggler.remove(this.openAnimation);
         Utils.juggler.remove(this.closingAnimation);
         this.closeAnimation.dispose();
         this.openingAnimation.dispose();
         this.openAnimation.dispose();
         this.closingAnimation.dispose();
         this.closeAnimation = null;
         this.openingAnimation = null;
         this.openAnimation = null;
         this.closingAnimation = null;
         super.destroy();
      }
      
      protected function initCloseAnimation() : void
      {
         if(this.TYPE == 1)
         {
            this.closeAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("doorBigExitCollisionSpriteClosedAnim_a"),24);
            this.closeAnimation.x = -8;
            this.closeAnimation.y = 8;
         }
         else
         {
            this.closeAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("doorExitCollisionSpriteClosedAnim_a"),24);
            this.closeAnimation.x = this.closeAnimation.y = 0;
         }
         this.closeAnimation.touchable = false;
         this.closeAnimation.loop = false;
         Utils.juggler.add(this.closeAnimation);
      }
      
      protected function initOpeningAnimation() : void
      {
         if(this.TYPE == 1)
         {
            this.openingAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("doorBigExitCollisionSpriteOpeningAnim_"),24);
            this.openingAnimation.x = -8;
            this.openingAnimation.y = 8;
            this.openingAnimation.setFrameDuration(0,0.15);
            this.openingAnimation.setFrameDuration(1,0.15);
         }
         else
         {
            this.openingAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("doorExitCollisionSpriteOpeningAnim_"),24);
            this.openingAnimation.x = this.openingAnimation.y = 0;
            this.openingAnimation.setFrameDuration(0,0.075);
            this.openingAnimation.setFrameDuration(1,0.075);
         }
         this.openingAnimation.touchable = false;
         this.openingAnimation.loop = false;
         Utils.juggler.add(this.openingAnimation);
      }
      
      protected function initOpenAnimation() : void
      {
         if(this.TYPE == 1)
         {
            this.openAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("doorBigExitCollisionSpriteOpenAnim_a"),24);
            this.openAnimation.x = -8;
            this.openAnimation.y = 8;
         }
         else
         {
            this.openAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("doorExitCollisionSpriteOpenAnim_a"),24);
            this.openAnimation.x = this.openAnimation.y = 0;
         }
         this.openAnimation.touchable = false;
         this.openAnimation.loop = false;
         Utils.juggler.add(this.openAnimation);
      }
      
      protected function initClosingAnimation() : void
      {
         if(this.TYPE == 1)
         {
            this.closingAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("doorBigExitCollisionSpriteClosingAnim_"),24);
            this.closingAnimation.x = -8;
            this.closingAnimation.y = 8;
            this.closingAnimation.setFrameDuration(0,0.15);
            this.closingAnimation.setFrameDuration(1,0.075);
            this.closingAnimation.setFrameDuration(2,0.075);
         }
         else
         {
            this.closingAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("doorExitCollisionSpriteClosingAnim_"),24);
            this.closingAnimation.x = this.closingAnimation.y = 0;
            this.closingAnimation.setFrameDuration(0,0.075);
            this.closingAnimation.setFrameDuration(1,0.075);
            this.closingAnimation.setFrameDuration(2,0.075);
         }
         this.closingAnimation.touchable = false;
         this.closingAnimation.loop = false;
         Utils.juggler.add(this.closingAnimation);
      }
   }
}
