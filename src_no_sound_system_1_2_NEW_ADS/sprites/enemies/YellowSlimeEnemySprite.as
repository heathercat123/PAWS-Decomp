package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class YellowSlimeEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var readyAnim:GameMovieClip;
      
      protected var shakeAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var landAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var emergeAnim:GameMovieClip;
      
      public function YellowSlimeEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initReadyAnim();
         this.initShakeAnim();
         this.initJumpAnim();
         this.initLandAnim();
         this.initHurtAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initEmergeAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = sprite.y = 8;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.readyAnim);
         sprite.addChild(this.shakeAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.landAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.emergeAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.readyAnim);
         Utils.juggler.remove(this.shakeAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.landAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.emergeAnim);
         this.standAnim.dispose();
         this.readyAnim.dispose();
         this.shakeAnim.dispose();
         this.jumpAnim.dispose();
         this.landAnim.dispose();
         this.hurtAnim.dispose();
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.emergeAnim.dispose();
         this.standAnim = null;
         this.readyAnim = null;
         this.shakeAnim = null;
         this.jumpAnim = null;
         this.landAnim = null;
         this.hurtAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.emergeAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowSlimeEnemyStandAnim_"));
         this.standAnim.setFrameDuration(0,0.2);
         this.standAnim.setFrameDuration(1,0.2);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initReadyAnim() : void
      {
         this.readyAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowSlimeEnemyReadyAnim_"));
         this.readyAnim.setFrameDuration(0,0.1);
         this.readyAnim.setFrameDuration(1,0.1);
         this.readyAnim.setFrameDuration(2,0.05);
         this.readyAnim.setFrameDuration(3,0.1);
         this.readyAnim.touchable = false;
         this.readyAnim.x = this.readyAnim.y = 0;
         this.readyAnim.loop = false;
         Utils.juggler.add(this.readyAnim);
      }
      
      protected function initShakeAnim() : void
      {
         this.shakeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowSlimeEnemyShakeAnim_"));
         this.shakeAnim.setFrameDuration(0,0.05);
         this.shakeAnim.setFrameDuration(1,0.05);
         this.shakeAnim.touchable = false;
         this.shakeAnim.x = this.shakeAnim.y = 0;
         this.shakeAnim.loop = true;
         Utils.juggler.add(this.shakeAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowSlimeEnemyJumpAnim_"));
         this.jumpAnim.setFrameDuration(0,0.1);
         this.jumpAnim.setFrameDuration(1,0.1);
         this.jumpAnim.setFrameDuration(2,0.1);
         this.jumpAnim.setFrameDuration(3,0.1);
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = false;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initLandAnim() : void
      {
         this.landAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowSlimeEnemyLandAnim_"));
         this.landAnim.setFrameDuration(0,0.05);
         this.landAnim.setFrameDuration(1,0.1);
         this.landAnim.touchable = false;
         this.landAnim.x = this.landAnim.y = 0;
         this.landAnim.loop = false;
         Utils.juggler.add(this.landAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowSlimeEnemyHurtAnim_"));
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = false;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowSlimeEnemyWalkAnim_"));
         this.walkAnim.setFrameDuration(0,0.1);
         this.walkAnim.setFrameDuration(1,0.1);
         this.walkAnim.setFrameDuration(2,0.1);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.jumpAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowSlimeEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initEmergeAnim() : void
      {
         this.emergeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowSlimeEnemyEmergeAnim_"));
         this.emergeAnim.setFrameDuration(0,0.1);
         this.emergeAnim.setFrameDuration(1,0.1);
         this.emergeAnim.setFrameDuration(2,0.1);
         this.emergeAnim.setFrameDuration(3,0.1);
         this.emergeAnim.touchable = false;
         this.emergeAnim.x = this.emergeAnim.y = 0;
         this.emergeAnim.loop = false;
         Utils.juggler.add(this.emergeAnim);
      }
   }
}
