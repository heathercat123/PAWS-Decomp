package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GiantRockEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var sleepAnim:GameMovieClip;
      
      protected var wakeUpAnim:GameMovieClip;
      
      public function GiantRockEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initHitAnim();
         this.initHurtAnim();
         this.initSleepAnim();
         this.initWakeUpAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 28;
         sprite.x = 16;
         sprite.y = 12;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.sleepAnim);
         sprite.addChild(this.wakeUpAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.sleepAnim);
         Utils.juggler.remove(this.wakeUpAnim);
         this.standAnim.dispose();
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.hitAnim.dispose();
         this.hurtAnim.dispose();
         this.sleepAnim.dispose();
         this.wakeUpAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.hitAnim = null;
         this.hurtAnim = null;
         this.sleepAnim = null;
         this.wakeUpAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantRockEnemyWalkAnim_a"));
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantRockEnemyWalkAnim_"));
         this.walkAnim.setFrameDuration(0,0.1);
         this.walkAnim.setFrameDuration(1,0.1);
         this.walkAnim.setFrameDuration(2,0.1);
         this.walkAnim.setFrameDuration(3,0.1);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantRockEnemyWakeUpAnim_c"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHitAnim() : void
      {
         this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantRockEnemyHitAnim_"));
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = false;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantRockEnemyHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initSleepAnim() : void
      {
         this.sleepAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantRockEnemySleepAnim_"));
         this.sleepAnim.setFrameDuration(0,1);
         this.sleepAnim.setFrameDuration(1,1);
         this.sleepAnim.touchable = false;
         this.sleepAnim.x = this.sleepAnim.y = 0;
         this.sleepAnim.loop = true;
         Utils.juggler.add(this.sleepAnim);
      }
      
      protected function initWakeUpAnim() : void
      {
         this.wakeUpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantRockEnemyWakeUpAnim_"));
         this.wakeUpAnim.setFrameDuration(0,0.1);
         this.wakeUpAnim.setFrameDuration(1,0.1);
         this.wakeUpAnim.setFrameDuration(2,0.25);
         this.wakeUpAnim.touchable = false;
         this.wakeUpAnim.x = this.wakeUpAnim.y = 0;
         this.wakeUpAnim.loop = false;
         Utils.juggler.add(this.wakeUpAnim);
      }
   }
}
