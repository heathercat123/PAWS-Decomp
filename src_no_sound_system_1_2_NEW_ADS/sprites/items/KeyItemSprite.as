package sprites.items
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class KeyItemSprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      protected var largeAnimation:GameMovieClip;
      
      protected var tallAnimation:GameMovieClip;
      
      protected var getAnimation:GameMovieClip;
      
      protected var appearAnimation:GameMovieClip;
      
      public function KeyItemSprite(_type:int)
      {
         super();
         this.TYPE = _type;
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
         if(this.TYPE == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keySpecialItemSpriteStandAnim_b"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keyItemSpriteStandAnim_"),12);
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
         }
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -8;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initLargeAnim() : void
      {
         if(this.TYPE == 2)
         {
            this.largeAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keySpecialItemSpriteStandAnim_b"),12);
         }
         else
         {
            this.largeAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keyItemSpriteLargeAnim_a"),12);
         }
         this.largeAnimation.touchable = false;
         this.largeAnimation.x = this.largeAnimation.y = -8;
         this.largeAnimation.loop = false;
         Utils.juggler.add(this.largeAnimation);
      }
      
      protected function initTallAnim() : void
      {
         if(this.TYPE == 2)
         {
            this.tallAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keySpecialItemSpriteStandAnim_b"),12);
         }
         else
         {
            this.tallAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keyItemSpriteTallAnim_a"),12);
         }
         this.tallAnimation.touchable = false;
         this.tallAnimation.x = this.tallAnimation.y = -8;
         this.tallAnimation.loop = false;
         Utils.juggler.add(this.tallAnimation);
      }
      
      protected function initGetAnim() : void
      {
         if(this.TYPE == 2)
         {
            this.getAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keySpecialItemSpriteStandAnim_b"),20);
         }
         else
         {
            this.getAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keyItemSpriteGetAnim_"),20);
         }
         this.getAnimation.touchable = false;
         this.getAnimation.x = this.getAnimation.y = -8;
         this.getAnimation.loop = true;
         Utils.juggler.add(this.getAnimation);
      }
      
      protected function initAppearAnim() : void
      {
         if(this.TYPE == 2)
         {
            this.appearAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keySpecialItemSpriteStandAnim_b"),12);
         }
         else
         {
            this.appearAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("keyItemSpriteAppearAnim_"),12);
            this.appearAnimation.setFrameDuration(0,0.075);
            this.appearAnimation.setFrameDuration(1,0.075);
            this.appearAnimation.setFrameDuration(2,0.075);
            this.appearAnimation.setFrameDuration(3,0.075);
         }
         this.appearAnimation.touchable = false;
         this.appearAnimation.x = this.appearAnimation.y = -8;
         this.appearAnimation.loop = false;
         Utils.juggler.add(this.appearAnimation);
      }
   }
}
