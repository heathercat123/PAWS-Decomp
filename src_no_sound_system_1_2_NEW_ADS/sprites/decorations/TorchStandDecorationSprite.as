package sprites.decorations
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class TorchStandDecorationSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var offAnimation:GameMovieClip;
      
      public function TorchStandDecorationSprite()
      {
         super();
         this.initAnims();
         this.initOffAnim();
         addChild(this.standAnimation);
         addChild(this.offAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.offAnimation);
         this.standAnimation.dispose();
         this.offAnimation.dispose();
         this.standAnimation = null;
         this.offAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("torchStandDecorationSpriteAnim_"),12);
         this.standAnimation.setFrameDuration(0,1);
         this.standAnimation.setFrameDuration(1,1);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initOffAnim() : void
      {
         this.offAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("torchStandOffDecorationSpriteAnim_"),12);
         this.offAnimation.touchable = false;
         this.offAnimation.x = this.offAnimation.y = 0;
         this.offAnimation.loop = true;
         Utils.juggler.add(this.offAnimation);
      }
   }
}
