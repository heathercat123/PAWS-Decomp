package sprites
{
   public class StunStarsSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var bigStandAnimation:GameMovieClip;
      
      public function StunStarsSprite()
      {
         super();
         this.initAnims();
         this.initBigAnims();
         addChild(this.standAnimation);
         addChild(this.bigStandAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.bigStandAnimation);
         this.standAnimation.dispose();
         this.bigStandAnimation.dispose();
         this.standAnimation = null;
         this.bigStandAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("stunSpriteAnim_"),12);
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -16;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initBigAnims() : void
      {
         this.bigStandAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("stunBigSpriteAnim_"),12);
         this.bigStandAnimation.textureSmoothing = Utils.getSmoothing();
         this.bigStandAnimation.touchable = false;
         this.bigStandAnimation.x = this.bigStandAnimation.y = -32;
         this.bigStandAnimation.loop = false;
         Utils.juggler.add(this.bigStandAnimation);
      }
   }
}
