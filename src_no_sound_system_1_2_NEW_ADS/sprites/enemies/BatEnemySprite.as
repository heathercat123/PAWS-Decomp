package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BatEnemySprite extends GameSprite
   {
       
      
      protected var sleepAnim:GameMovieClip;
      
      protected var wakeUpAnim:GameMovieClip;
      
      protected var flyAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var scaredAnim:GameMovieClip;
      
      public function BatEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initSleepAnim();
         this.initWakeUpAnim();
         this.initFlyAnim();
         this.initTurnAnim();
         this.initHurtAnim();
         this.initScaredAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = sprite.y = 0;
         sprite.addChild(this.sleepAnim);
         sprite.addChild(this.wakeUpAnim);
         sprite.addChild(this.flyAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.scaredAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.sleepAnim);
         Utils.juggler.remove(this.wakeUpAnim);
         Utils.juggler.remove(this.flyAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.scaredAnim);
         this.sleepAnim.dispose();
         this.wakeUpAnim.dispose();
         this.flyAnim.dispose();
         this.turnAnim.dispose();
         this.hurtAnim.dispose();
         this.scaredAnim.dispose();
         this.sleepAnim = null;
         this.wakeUpAnim = null;
         this.flyAnim = null;
         this.turnAnim = null;
         this.hurtAnim = null;
         this.scaredAnim = null;
         super.destroy();
      }
      
      protected function initSleepAnim() : void
      {
         this.sleepAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("batEnemySleepAnim_"));
         this.sleepAnim.setFrameDuration(0,1);
         this.sleepAnim.setFrameDuration(1,1);
         this.sleepAnim.touchable = false;
         this.sleepAnim.x = this.sleepAnim.y = 0;
         this.sleepAnim.loop = true;
         Utils.juggler.add(this.sleepAnim);
      }
      
      protected function initWakeUpAnim() : void
      {
         this.wakeUpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("batEnemyWakeUpAnim_"));
         this.wakeUpAnim.setFrameDuration(0,0.2);
         this.wakeUpAnim.setFrameDuration(1,0.2);
         this.wakeUpAnim.setFrameDuration(2,0.2);
         this.wakeUpAnim.setFrameDuration(3,0.2);
         this.wakeUpAnim.touchable = false;
         this.wakeUpAnim.x = this.wakeUpAnim.y = 0;
         this.wakeUpAnim.loop = false;
         Utils.juggler.add(this.wakeUpAnim);
      }
      
      protected function initFlyAnim() : void
      {
         this.flyAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("batEnemyFlyAnim_"));
         this.flyAnim.setFrameDuration(0,0.1);
         this.flyAnim.setFrameDuration(1,0.1);
         this.flyAnim.setFrameDuration(2,0.1);
         this.flyAnim.touchable = false;
         this.flyAnim.x = this.flyAnim.y = 0;
         this.flyAnim.loop = true;
         Utils.juggler.add(this.flyAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("batEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("batEnemyHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initScaredAnim() : void
      {
         this.scaredAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("batEnemyScaredAnim_"));
         this.scaredAnim.setFrameDuration(0,0.1);
         this.scaredAnim.touchable = false;
         this.scaredAnim.x = this.scaredAnim.y = 0;
         this.scaredAnim.loop = false;
         Utils.juggler.add(this.scaredAnim);
      }
   }
}
