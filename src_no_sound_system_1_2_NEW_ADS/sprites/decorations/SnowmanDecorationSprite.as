package sprites.decorations
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SnowmanDecorationSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      public function SnowmanDecorationSprite()
      {
         super();
         this.initAnims();
         this.initAnim2();
         addChild(this.standAnimation);
         addChild(this.standAnimation2);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         Utils.juggler.remove(this.standAnimation2);
         this.standAnimation2.dispose();
         this.standAnimation2 = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanDecorationSpriteStandAnim_"),12);
         this.standAnimation.setFrameDuration(0,1);
         this.standAnimation.setFrameDuration(1,1);
         this.standAnimation.touchable = false;
         this.standAnimation.x = 0;
         this.standAnimation.y = 1;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initAnim2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanDecorationSpriteDestroyAnim_"),12);
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = 0;
         this.standAnimation2.y = 1;
         this.standAnimation2.loop = true;
         Utils.juggler.add(this.standAnimation2);
      }
   }
}
