package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class WaterfallCollisionSprite extends GameSprite
   {
      
      protected var standAnimation1:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      protected var standAnimation3:GameMovieClip;
      
      protected var standAnimation4:GameMovieClip;
      
      public function WaterfallCollisionSprite()
      {
         super();
         this.initAnims1();
         this.initAnims2();
         this.initAnims3();
         this.initAnims4();
         addChild(this.standAnimation1);
         addChild(this.standAnimation2);
         addChild(this.standAnimation3);
         addChild(this.standAnimation4);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation1);
         Utils.juggler.remove(this.standAnimation2);
         Utils.juggler.remove(this.standAnimation3);
         Utils.juggler.remove(this.standAnimation4);
         this.standAnimation1.dispose();
         this.standAnimation2.dispose();
         this.standAnimation3.dispose();
         this.standAnimation4.dispose();
         this.standAnimation1 = null;
         this.standAnimation2 = null;
         this.standAnimation3 = null;
         this.standAnimation4 = null;
         super.destroy();
      }
      
      protected function initAnims1() : void
      {
         this.standAnimation1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterfallCollisiontopSideSpriteAnim_"),12);
         this.standAnimation1.setFrameDuration(0,0.075);
         this.standAnimation1.setFrameDuration(1,0.075);
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = true;
         Utils.juggler.add(this.standAnimation1);
      }
      
      protected function initAnims2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterfallCollisiontopCenterSpriteAnim_"),12);
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation1.y = 0;
         this.standAnimation2.loop = true;
         Utils.juggler.add(this.standAnimation2);
      }
      
      protected function initAnims3() : void
      {
         this.standAnimation3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterfallCollisionmiddleSideSpriteAnim_"),12);
         this.standAnimation3.touchable = false;
         this.standAnimation3.x = this.standAnimation3.y = 0;
         this.standAnimation3.loop = true;
         Utils.juggler.add(this.standAnimation3);
      }
      
      protected function initAnims4() : void
      {
         this.standAnimation4 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waterfallCollisionmiddleCenterSpriteAnim_"),12);
         this.standAnimation4.touchable = false;
         this.standAnimation4.x = this.standAnimation4.y = 0;
         this.standAnimation4.loop = true;
         Utils.juggler.add(this.standAnimation4);
      }
   }
}

