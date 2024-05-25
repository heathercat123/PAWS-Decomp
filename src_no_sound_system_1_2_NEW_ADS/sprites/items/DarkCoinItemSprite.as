package sprites.items
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DarkCoinItemSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var largeAnimation:GameMovieClip;
      
      protected var tallAnimation:GameMovieClip;
      
      protected var getAnimation:GameMovieClip;
      
      protected var appearAnimation:GameMovieClip;
      
      public function DarkCoinItemSprite()
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
         Utils.juggler.remove(this.appearAnimation);
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.largeAnimation);
         Utils.juggler.remove(this.tallAnimation);
         Utils.juggler.remove(this.getAnimation);
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("coinSpriteStandAnim_"),12);
         this.standAnimation.setFrameDuration(0,0.15);
         this.standAnimation.setFrameDuration(1,0.15);
         this.standAnimation.setFrameDuration(2,0.15);
         this.standAnimation.setFrameDuration(3,0.15);
         this.standAnimation.touchable = false;
         this.standAnimation.x = 0;
         this.standAnimation.y = 2;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initLargeAnim() : void
      {
         this.largeAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keyItemSpriteLargeAnim_a"),12);
         this.largeAnimation.touchable = false;
         this.largeAnimation.x = 0;
         this.largeAnimation.y = 2;
         this.largeAnimation.loop = false;
         Utils.juggler.add(this.largeAnimation);
      }
      
      protected function initTallAnim() : void
      {
         this.tallAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keyItemSpriteTallAnim_a"),12);
         this.tallAnimation.touchable = false;
         this.tallAnimation.x = 0;
         this.tallAnimation.y = 2;
         this.tallAnimation.loop = false;
         Utils.juggler.add(this.tallAnimation);
      }
      
      protected function initGetAnim() : void
      {
         this.getAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkCoinItemSpriteStandAnim_"),20);
         this.getAnimation.touchable = false;
         this.getAnimation.x = 0;
         this.getAnimation.y = 2;
         this.getAnimation.loop = true;
         Utils.juggler.add(this.getAnimation);
      }
      
      protected function initAppearAnim() : void
      {
         this.appearAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keyItemSpriteAppearAnim_"),12);
         this.appearAnimation.setFrameDuration(0,0.075);
         this.appearAnimation.setFrameDuration(1,0.075);
         this.appearAnimation.setFrameDuration(2,0.075);
         this.appearAnimation.setFrameDuration(3,0.075);
         this.appearAnimation.touchable = false;
         this.appearAnimation.x = 0;
         this.appearAnimation.y = 2;
         this.appearAnimation.loop = false;
         Utils.juggler.add(this.appearAnimation);
      }
   }
}
