package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DarkSmallSpotCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      protected var standAnimation3:GameMovieClip;
      
      protected var standAnimation4:GameMovieClip;
      
      public function DarkSmallSpotCollisionSprite()
      {
         super();
         this.initAnims();
         this.initAnims2();
         this.initAnims3();
         this.initAnims4();
         addChild(this.standAnimation);
         addChild(this.standAnimation2);
         addChild(this.standAnimation3);
         addChild(this.standAnimation4);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         Utils.juggler.remove(this.standAnimation2);
         this.standAnimation2.dispose();
         this.standAnimation2 = null;
         Utils.juggler.remove(this.standAnimation3);
         this.standAnimation3.dispose();
         this.standAnimation3 = null;
         Utils.juggler.remove(this.standAnimation4);
         this.standAnimation4.dispose();
         this.standAnimation4 = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkSmallSpotlightCollisionSpriteAnim_a"),12);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -54;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initAnims2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkBigSpotlightCollisionSpriteAnim_a"),12);
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = -96;
         this.standAnimation2.loop = true;
         Utils.juggler.add(this.standAnimation2);
      }
      
      protected function initAnims3() : void
      {
         this.standAnimation3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkTinySpotlightCollisionSpriteAnim_a"),12);
         this.standAnimation3.touchable = false;
         this.standAnimation3.x = this.standAnimation3.y = -38;
         this.standAnimation3.loop = true;
         Utils.juggler.add(this.standAnimation3);
      }
      
      protected function initAnims4() : void
      {
         this.standAnimation4 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkMiniSpotlightCollisionSpriteAnim_a"),12);
         this.standAnimation4.touchable = false;
         this.standAnimation4.x = this.standAnimation4.y = -3;
         this.standAnimation4.loop = true;
         Utils.juggler.add(this.standAnimation4);
      }
   }
}
