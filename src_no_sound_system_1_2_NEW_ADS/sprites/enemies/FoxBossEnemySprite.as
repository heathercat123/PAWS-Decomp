package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FoxBossEnemySprite extends GameSprite
   {
       
      
      public var standAnim:GameMovieClip;
      
      public var fallAnim:GameMovieClip;
      
      public var laughAnim:GameMovieClip;
      
      public function FoxBossEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initFallAnim();
         this.initLaughAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = 24;
         sprite.x = 8;
         sprite.y = -24;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.fallAnim);
         sprite.addChild(this.laughAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.fallAnim);
         Utils.juggler.remove(this.laughAnim);
         this.standAnim.dispose();
         this.fallAnim.dispose();
         this.laughAnim.dispose();
         this.standAnim = null;
         this.fallAnim = null;
         this.laughAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("foxBossEnemyStandAnim_"),16);
         this.standAnim.setFrameDuration(0,1);
         this.standAnim.setFrameDuration(1,1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initFallAnim() : void
      {
         this.fallAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("foxBossEnemyFallAnim_"),16);
         this.fallAnim.setFrameDuration(0,0.2);
         this.fallAnim.setFrameDuration(1,0.2);
         this.fallAnim.touchable = true;
         this.fallAnim.x = this.fallAnim.y = 0;
         this.fallAnim.loop = true;
         Utils.juggler.add(this.fallAnim);
      }
      
      protected function initLaughAnim() : void
      {
         this.laughAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("foxBossEnemyLaughAnim_"),16);
         this.laughAnim.setFrameDuration(0,0.2);
         this.laughAnim.setFrameDuration(1,0.2);
         this.laughAnim.touchable = true;
         this.laughAnim.x = this.laughAnim.y = 0;
         this.laughAnim.loop = true;
         Utils.juggler.add(this.laughAnim);
      }
   }
}
