package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class MountainGoatEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var fallAnim:GameMovieClip;
      
      protected var brakeAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var with_rider:Boolean;
      
      public function MountainGoatEnemySprite(_withRider:Boolean = false)
      {
         var sprite:GameSprite = null;
         super();
         this.with_rider = _withRider;
         this.initStandAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initJumpAnim();
         this.initFallAnim();
         this.initBrakeAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = -4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.fallAnim);
         sprite.addChild(this.brakeAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.fallAnim);
         Utils.juggler.remove(this.brakeAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.jumpAnim.dispose();
         this.fallAnim.dispose();
         this.brakeAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.jumpAnim = null;
         this.fallAnim = null;
         this.brakeAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hogEnemyStandAnim_"));
         this.standAnim.setFrameDuration(0,0.2);
         this.standAnim.setFrameDuration(1,0.2);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.with_rider)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mountainGoatEnemyWalkRiderAnim_"));
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hogEnemyWalkAnim_"));
         }
         this.walkAnim.setFrameDuration(0,0.1);
         this.walkAnim.setFrameDuration(1,0.1);
         this.walkAnim.setFrameDuration(2,0.1);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.with_rider)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mountainGoatEnemyTurnRiderAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hogEnemyTurnAnim_"));
         }
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initJumpAnim() : void
      {
         if(this.with_rider)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mountainGoatEnemyJumpRiderAnim_"));
         }
         else
         {
            this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hogEnemyJumpAnim_"));
         }
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = false;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initFallAnim() : void
      {
         if(this.with_rider)
         {
            this.fallAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mountainGoatEnemyFallRiderAnim_"));
         }
         else
         {
            this.fallAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hogEnemyFallAnim_"));
         }
         this.fallAnim.touchable = false;
         this.fallAnim.x = this.fallAnim.y = 0;
         this.fallAnim.loop = false;
         Utils.juggler.add(this.fallAnim);
      }
      
      protected function initBrakeAnim() : void
      {
         if(this.with_rider)
         {
            this.brakeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mountainGoatEnemyBrakeRiderAnim_"));
         }
         else
         {
            this.brakeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hogEnemyBrakeAnim_"));
         }
         this.brakeAnim.touchable = false;
         this.brakeAnim.x = this.brakeAnim.y = 0;
         this.brakeAnim.loop = false;
         Utils.juggler.add(this.brakeAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("hogEnemyHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = false;
         Utils.juggler.add(this.hurtAnim);
      }
   }
}
