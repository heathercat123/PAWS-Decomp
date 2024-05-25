package sprites.decorations
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class ChimneyDecorationSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      public function ChimneyDecorationSprite()
      {
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("chimneyDecorationSpriteAnim_"),12);
         this.standAnimation.setFrameDuration(0,1);
         this.standAnimation.setFrameDuration(1,1);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initAnims2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boatChimneyDecorationSpriteAnim_"),12);
         this.standAnimation2.setFrameDuration(0,1);
         this.standAnimation2.setFrameDuration(1,1);
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = 0;
         this.standAnimation2.loop = true;
         Utils.juggler.add(this.standAnimation2);
      }
   }
}
