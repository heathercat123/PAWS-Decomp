package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class RaiderEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var aimAnim:GameMovieClip;
      
      protected var tossAnim:GameMovieClip;
      
      protected var preJumpAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      public function RaiderEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initHitAnim();
         this.initAimAnim();
         this.initTossAnim();
         this.initPreJumpAnim();
         this.initJumpAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.aimAnim);
         sprite.addChild(this.tossAnim);
         sprite.addChild(this.preJumpAnim);
         sprite.addChild(this.jumpAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.aimAnim);
         Utils.juggler.remove(this.tossAnim);
         Utils.juggler.remove(this.preJumpAnim);
         Utils.juggler.remove(this.jumpAnim);
         this.standAnim.dispose();
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.hitAnim.dispose();
         this.aimAnim.dispose();
         this.tossAnim.dispose();
         this.preJumpAnim.dispose();
         this.jumpAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.hitAnim = null;
         this.aimAnim = null;
         this.tossAnim = null;
         this.preJumpAnim = null;
         this.jumpAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("raiderEnemyStandAnim_"));
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("raiderEnemyWalkAnim_"));
         this.walkAnim.setFrameDuration(0,0.1);
         this.walkAnim.setFrameDuration(1,0.1);
         this.walkAnim.setFrameDuration(2,0.1);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = false;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("raiderEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHitAnim() : void
      {
         this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("raiderEnemyHitAnim_"));
         this.hitAnim.setFrameDuration(0,0.075);
         this.hitAnim.setFrameDuration(1,0.075);
         this.hitAnim.setFrameDuration(2,0.075);
         this.hitAnim.setFrameDuration(3,0.075);
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = true;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initAimAnim() : void
      {
         this.aimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("raiderEnemyAimAnim_"));
         this.aimAnim.setFrameDuration(0,0.25);
         this.aimAnim.touchable = false;
         this.aimAnim.x = this.aimAnim.y = 0;
         this.aimAnim.loop = false;
         Utils.juggler.add(this.aimAnim);
      }
      
      protected function initTossAnim() : void
      {
         this.tossAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("raiderEnemyTossAnim_"));
         this.tossAnim.setFrameDuration(0,0.1);
         this.tossAnim.setFrameDuration(1,0.2);
         this.tossAnim.touchable = false;
         this.tossAnim.x = this.tossAnim.y = 0;
         this.tossAnim.loop = false;
         Utils.juggler.add(this.tossAnim);
      }
      
      protected function initPreJumpAnim() : void
      {
         this.preJumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("raiderEnemyPreJumpAnim_"));
         this.preJumpAnim.setFrameDuration(0,0.5);
         this.preJumpAnim.touchable = false;
         this.preJumpAnim.x = this.preJumpAnim.y = 0;
         this.preJumpAnim.loop = false;
         Utils.juggler.add(this.preJumpAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("raiderEnemyJumpAnim_"));
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = false;
         Utils.juggler.add(this.jumpAnim);
      }
   }
}
