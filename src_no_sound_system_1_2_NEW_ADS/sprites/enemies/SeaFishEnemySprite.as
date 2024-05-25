package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SeaFishEnemySprite extends GameSprite
   {
       
      
      protected var swimAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var stuckAnim:GameMovieClip;
      
      protected var frozenAnim:GameMovieClip;
      
      public function SeaFishEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initSwimAnim();
         this.initTurnAnim();
         this.initHurtAnim();
         this.initStuckAnim();
         this.initFrozenAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.swimAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.stuckAnim);
         sprite.addChild(this.frozenAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.swimAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.stuckAnim);
         Utils.juggler.remove(this.frozenAnim);
         this.swimAnim.dispose();
         this.turnAnim.dispose();
         this.hurtAnim.dispose();
         this.stuckAnim.dispose();
         this.frozenAnim.dispose();
         this.swimAnim = null;
         this.turnAnim = null;
         this.hurtAnim = null;
         this.stuckAnim = null;
         this.frozenAnim = null;
         super.destroy();
      }
      
      protected function initSwimAnim() : void
      {
         this.swimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaFishEnemySwimAnim_"));
         this.swimAnim.setFrameDuration(0,0.1);
         this.swimAnim.setFrameDuration(1,0.2);
         this.swimAnim.setFrameDuration(2,0.2);
         this.swimAnim.setFrameDuration(3,0.1);
         this.swimAnim.setFrameDuration(4,0.2);
         this.swimAnim.setFrameDuration(5,0.2);
         this.swimAnim.touchable = false;
         this.swimAnim.x = this.swimAnim.y = 0;
         this.swimAnim.loop = true;
         Utils.juggler.add(this.swimAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaFishEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaFishEnemyHitAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initStuckAnim() : void
      {
         this.stuckAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaFishEnemyStuckAnim_"));
         this.stuckAnim.setFrameDuration(0,0.1);
         this.stuckAnim.setFrameDuration(1,0.1);
         this.stuckAnim.touchable = false;
         this.stuckAnim.x = this.stuckAnim.y = 0;
         this.stuckAnim.loop = true;
         Utils.juggler.add(this.stuckAnim);
      }
      
      protected function initFrozenAnim() : void
      {
         this.frozenAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaFishEnemyFrozenAnim_"));
         this.frozenAnim.setFrameDuration(0,0.1);
         this.frozenAnim.touchable = false;
         this.frozenAnim.x = this.frozenAnim.y = 0;
         this.frozenAnim.loop = true;
         Utils.juggler.add(this.frozenAnim);
      }
   }
}
