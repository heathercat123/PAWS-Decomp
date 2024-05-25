package sprites.decorations
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BurnedFlowerBaseDecorationSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function BurnedFlowerBaseDecorationSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("burnedFlowerBaseDecorationSpriteAnim_"),12);
         this.standAnimation.touchable = false;
         this.standAnimation.x = 0;
         this.standAnimation.y = 1;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
