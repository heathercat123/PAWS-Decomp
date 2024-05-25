package sprites.items
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BubbleItemSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function BubbleItemSprite()
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bubbleItemSpriteStandAnim_"),12);
         this.standAnimation.setFrameDuration(0,0.5);
         this.standAnimation.setFrameDuration(1,0.5);
         this.standAnimation.setFrameDuration(2,0.5);
         this.standAnimation.setFrameDuration(3,0.5);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -20;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
