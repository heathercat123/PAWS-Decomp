package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class LizardBossEnemySprite extends GameSprite
   {
       
      
      public var standAnim:GameMovieClip;
      
      public var impactAnim:GameMovieClip;
      
      public var tongueAnim:GameMovieClip;
      
      public var eatAnim:GameMovieClip;
      
      public var turnAnim:GameMovieClip;
      
      public var jumpAnim:GameMovieClip;
      
      public var hitAnim:GameMovieClip;
      
      public var stunnedAnim:GameMovieClip;
      
      public function LizardBossEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initImpactAnim();
         this.initTongueAnim();
         this.initEatAnim();
         this.initTurnAnim();
         this.initJumpAnim();
         this.initHitAnim();
         this.initStunnedAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = 48;
         sprite.pivotY = 32;
         sprite.x = 16;
         sprite.y = 8;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.impactAnim);
         sprite.addChild(this.tongueAnim);
         sprite.addChild(this.eatAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.stunnedAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.impactAnim);
         Utils.juggler.remove(this.tongueAnim);
         Utils.juggler.remove(this.eatAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.stunnedAnim);
         this.standAnim.dispose();
         this.impactAnim.dispose();
         this.tongueAnim.dispose();
         this.eatAnim.dispose();
         this.turnAnim.dispose();
         this.jumpAnim.dispose();
         this.hitAnim.dispose();
         this.stunnedAnim.dispose();
         this.standAnim = null;
         this.impactAnim = null;
         this.tongueAnim = null;
         this.eatAnim = null;
         this.turnAnim = null;
         this.jumpAnim = null;
         this.hitAnim = null;
         this.stunnedAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lizardBossEnemyStandAnim_"),16);
         this.standAnim.setFrameDuration(0,1);
         this.standAnim.setFrameDuration(1,1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initImpactAnim() : void
      {
         this.impactAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lizardBossEnemyGroundImpactAnim_"),16);
         this.impactAnim.touchable = false;
         this.impactAnim.x = this.impactAnim.y = 0;
         this.impactAnim.loop = true;
         Utils.juggler.add(this.impactAnim);
      }
      
      protected function initTongueAnim() : void
      {
         this.tongueAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lizardBossEnemyTongueAnim_"),16);
         this.tongueAnim.setFrameDuration(0,0.1);
         this.tongueAnim.setFrameDuration(1,0.1);
         this.tongueAnim.touchable = false;
         this.tongueAnim.x = this.tongueAnim.y = 0;
         this.tongueAnim.loop = false;
         Utils.juggler.add(this.tongueAnim);
      }
      
      protected function initEatAnim() : void
      {
         this.eatAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lizardBossEnemyEatAnim_"),16);
         this.eatAnim.setFrameDuration(0,0.1);
         this.eatAnim.setFrameDuration(1,0.1);
         this.eatAnim.touchable = false;
         this.eatAnim.x = this.eatAnim.y = 0;
         this.eatAnim.loop = false;
         Utils.juggler.add(this.eatAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lizardBossEnemyTurnAnim_a"),16);
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lizardBossEnemyJumpAnim_a"),16);
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initHitAnim() : void
      {
         this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lizardBossEnemyHitAnim_a"),16);
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = false;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initStunnedAnim() : void
      {
         this.stunnedAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("lizardBossEnemyStunnedAnim_a"),16);
         this.stunnedAnim.touchable = false;
         this.stunnedAnim.x = 0;
         this.stunnedAnim.y = 18;
         this.stunnedAnim.loop = true;
         Utils.juggler.add(this.stunnedAnim);
      }
   }
}
