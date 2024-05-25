package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SkullEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var sleepAnim:GameMovieClip;
      
      protected var wakeUpAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function SkullEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initTurnAnim();
         this.initWalkAnim();
         this.initSleepAnim();
         this.initWakeUpAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.sleepAnim);
         sprite.addChild(this.wakeUpAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.sleepAnim);
         Utils.juggler.remove(this.wakeUpAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.sleepAnim.dispose();
         this.wakeUpAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.walkAnim = null;
         this.sleepAnim = null;
         this.wakeUpAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveSkullStandAnim_"));
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveSkullTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.05);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveSkullWalkAnim_"));
         this.walkAnim.setFrameDuration(0,0.075);
         this.walkAnim.setFrameDuration(1,0.075);
         this.walkAnim.setFrameDuration(2,0.075);
         this.walkAnim.setFrameDuration(3,0.075);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initSleepAnim() : void
      {
         this.sleepAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveSkullSleepAnim_"));
         this.sleepAnim.setFrameDuration(0,1);
         this.sleepAnim.touchable = false;
         this.sleepAnim.x = this.sleepAnim.y = 0;
         this.sleepAnim.loop = true;
         Utils.juggler.add(this.sleepAnim);
      }
      
      protected function initWakeUpAnim() : void
      {
         this.wakeUpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveSkullWakeUpAnim_"));
         this.wakeUpAnim.setFrameDuration(0,0.1);
         this.wakeUpAnim.setFrameDuration(1,0.1);
         this.wakeUpAnim.setFrameDuration(2,0.1);
         this.wakeUpAnim.touchable = false;
         this.wakeUpAnim.x = this.wakeUpAnim.y = 0;
         this.wakeUpAnim.loop = false;
         Utils.juggler.add(this.wakeUpAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveSkullHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
   }
}
