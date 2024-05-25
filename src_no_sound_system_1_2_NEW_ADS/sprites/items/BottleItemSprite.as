package sprites.items
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BottleItemSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var largeAnimation:GameMovieClip;
      
      protected var tallAnimation:GameMovieClip;
      
      protected var getAnimation:GameMovieClip;
      
      protected var appearAnimation:GameMovieClip;
      
      public function BottleItemSprite()
      {
         super();
         this.initAnims();
         this.initLargeAnim();
         this.initTallAnim();
         this.initGetAnim();
         this.initAppearAnim();
         addChild(this.standAnimation);
         addChild(this.largeAnimation);
         addChild(this.tallAnimation);
         addChild(this.getAnimation);
         addChild(this.appearAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.freeze_juggler.remove(this.appearAnimation);
         Utils.freeze_juggler.remove(this.standAnimation);
         Utils.freeze_juggler.remove(this.largeAnimation);
         Utils.freeze_juggler.remove(this.tallAnimation);
         Utils.freeze_juggler.remove(this.getAnimation);
         this.appearAnimation.dispose();
         this.appearAnimation = null;
         this.standAnimation.dispose();
         this.standAnimation = null;
         this.largeAnimation.dispose();
         this.largeAnimation = null;
         this.tallAnimation.dispose();
         this.tallAnimation = null;
         this.getAnimation.dispose();
         this.getAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bottleItemSpriteStandAnim_"),12);
         this.standAnimation.setFrameDuration(0,5);
         this.standAnimation.setFrameDuration(1,0.1);
         this.standAnimation.setFrameDuration(2,0.1);
         this.standAnimation.setFrameDuration(3,0.1);
         this.standAnimation.setFrameDuration(4,0.1);
         this.standAnimation.setFrameDuration(5,0.1);
         this.standAnimation.setFrameDuration(6,0.1);
         this.standAnimation.setFrameDuration(7,0.1);
         this.standAnimation.setFrameDuration(8,0.1);
         this.standAnimation.setFrameDuration(9,0.1);
         this.standAnimation.setFrameDuration(10,0.1);
         this.standAnimation.setFrameDuration(11,0.1);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -8;
         this.standAnimation.loop = false;
         Utils.freeze_juggler.add(this.standAnimation);
      }
      
      protected function initLargeAnim() : void
      {
         this.largeAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bottleItemSpriteLargeAnim_a"),12);
         this.largeAnimation.touchable = false;
         this.largeAnimation.x = this.largeAnimation.y = -8;
         this.largeAnimation.loop = false;
         Utils.freeze_juggler.add(this.largeAnimation);
      }
      
      protected function initTallAnim() : void
      {
         this.tallAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bottleItemSpriteTallAnim_a"),12);
         this.tallAnimation.touchable = false;
         this.tallAnimation.x = this.tallAnimation.y = -8;
         this.tallAnimation.loop = false;
         Utils.freeze_juggler.add(this.tallAnimation);
      }
      
      protected function initGetAnim() : void
      {
         this.getAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bottleItemSpriteGetAnim_"),20);
         this.getAnimation.touchable = false;
         this.getAnimation.x = this.getAnimation.y = -8;
         this.getAnimation.loop = false;
         Utils.freeze_juggler.add(this.getAnimation);
      }
      
      protected function initAppearAnim() : void
      {
         this.appearAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keyItemSpriteAppearAnim_"),12);
         this.appearAnimation.setFrameDuration(0,0.075);
         this.appearAnimation.setFrameDuration(1,0.075);
         this.appearAnimation.setFrameDuration(2,0.075);
         this.appearAnimation.setFrameDuration(3,0.075);
         this.appearAnimation.touchable = false;
         this.appearAnimation.x = this.appearAnimation.y = -8;
         this.appearAnimation.loop = false;
         Utils.freeze_juggler.add(this.appearAnimation);
      }
   }
}
