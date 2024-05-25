package sprites.items
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BellItemSprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      protected var largeAnimation:GameMovieClip;
      
      protected var tallAnimation:GameMovieClip;
      
      protected var ringAnimation:GameMovieClip;
      
      protected var appearAnimation:GameMovieClip;
      
      public function BellItemSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
         if(this.TYPE == 0)
         {
            this.initAnims();
            this.initLargeAnim();
            this.initTallAnim();
            this.initRingAnim();
            this.initAppearAnim();
            addChild(this.standAnimation);
            addChild(this.largeAnimation);
            addChild(this.tallAnimation);
            addChild(this.ringAnimation);
            addChild(this.appearAnimation);
         }
         else if(this.TYPE == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("questionMarkItemSpriteAnim_"),12);
            this.standAnimation.touchable = false;
            this.standAnimation.x = this.standAnimation.y = 0;
            this.standAnimation.loop = false;
            Utils.freeze_juggler.add(this.standAnimation);
            addChild(this.standAnimation);
         }
      }
      
      override public function destroy() : void
      {
         if(this.TYPE == 0)
         {
            Utils.juggler.remove(this.appearAnimation);
            Utils.juggler.remove(this.standAnimation);
            Utils.juggler.remove(this.largeAnimation);
            Utils.juggler.remove(this.tallAnimation);
            Utils.juggler.remove(this.ringAnimation);
            this.appearAnimation.dispose();
            this.appearAnimation = null;
            this.standAnimation.dispose();
            this.standAnimation = null;
            this.largeAnimation.dispose();
            this.largeAnimation = null;
            this.tallAnimation.dispose();
            this.tallAnimation = null;
            this.ringAnimation.dispose();
            this.ringAnimation = null;
         }
         else if(this.TYPE == 1)
         {
            Utils.freeze_juggler.remove(this.standAnimation);
            this.standAnimation.dispose();
            this.standAnimation = null;
         }
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bellItemSpriteStandAnim_"),12);
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
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initLargeAnim() : void
      {
         this.largeAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bellItemSpriteLargeAnim_a"),12);
         this.largeAnimation.touchable = false;
         this.largeAnimation.x = this.largeAnimation.y = -8;
         this.largeAnimation.loop = false;
         Utils.juggler.add(this.largeAnimation);
      }
      
      protected function initTallAnim() : void
      {
         this.tallAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bellItemSpriteTallAnim_a"),12);
         this.tallAnimation.touchable = false;
         this.tallAnimation.x = this.tallAnimation.y = -8;
         this.tallAnimation.loop = false;
         Utils.juggler.add(this.tallAnimation);
      }
      
      protected function initRingAnim() : void
      {
         this.ringAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bellItemSpriteRingAnim_"),12);
         this.ringAnimation.setFrameDuration(0,0.075);
         this.ringAnimation.setFrameDuration(1,0.075);
         this.ringAnimation.setFrameDuration(2,0.075);
         this.ringAnimation.setFrameDuration(3,0.075);
         this.ringAnimation.touchable = false;
         this.ringAnimation.x = this.ringAnimation.y = -8;
         this.ringAnimation.loop = true;
         Utils.juggler.add(this.ringAnimation);
      }
      
      protected function initAppearAnim() : void
      {
         this.appearAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bellItemSpriteAppearAnim_"),12);
         this.appearAnimation.setFrameDuration(0,0.075);
         this.appearAnimation.setFrameDuration(1,0.075);
         this.appearAnimation.setFrameDuration(2,0.075);
         this.appearAnimation.setFrameDuration(3,0.075);
         this.appearAnimation.touchable = false;
         this.appearAnimation.x = this.appearAnimation.y = -8;
         this.appearAnimation.loop = false;
         Utils.juggler.add(this.appearAnimation);
      }
   }
}
