package sprites.cats
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GlideCatSprite extends CatSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var fallAnim:GameMovieClip;
      
      protected var climbAnim:GameMovieClip;
      
      protected var slideAnim:GameMovieClip;
      
      protected var runAnim:GameMovieClip;
      
      protected var brakeAnim:GameMovieClip;
      
      protected var hopAnim:GameMovieClip;
      
      protected var fallRunAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var levelStartAnim:GameMovieClip;
      
      protected var levelCompleteAnim:GameMovieClip;
      
      protected var swimAnim:GameMovieClip;
      
      public function GlideCatSprite(_forced_cat_id:int = -1)
      {
         var sprite:GameSprite = null;
         super();
         FORCED_CAT_ID = _forced_cat_id;
         this.initStandAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initJumpAnim();
         this.initFallAnim();
         this.initClimbAnim();
         this.initSlideAnim();
         this.initRunAnim();
         this.initBrakeAnim();
         this.initHopAnim();
         this.initFallRunAnim();
         this.initHurtAnim();
         this.initLevelStartAnim();
         this.initLevelCompleteAnim();
         this.initSwimAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = 20;
         sprite.x = 8;
         sprite.y = -20;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.fallAnim);
         sprite.addChild(this.climbAnim);
         sprite.addChild(this.slideAnim);
         sprite.addChild(this.runAnim);
         sprite.addChild(this.brakeAnim);
         sprite.addChild(this.hopAnim);
         sprite.addChild(this.fallRunAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.levelStartAnim);
         sprite.addChild(this.levelCompleteAnim);
         sprite.addChild(this.swimAnim);
         initHatArray();
         hatItemSprite = null;
         refreshHat();
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.fallAnim);
         Utils.juggler.remove(this.climbAnim);
         Utils.juggler.remove(this.slideAnim);
         Utils.juggler.remove(this.runAnim);
         Utils.juggler.remove(this.brakeAnim);
         Utils.juggler.remove(this.hopAnim);
         Utils.juggler.remove(this.fallRunAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.levelStartAnim);
         Utils.juggler.remove(this.levelCompleteAnim);
         Utils.juggler.remove(this.swimAnim);
         this.standAnim.dispose();
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.jumpAnim.dispose();
         this.fallAnim.dispose();
         this.climbAnim.dispose();
         this.slideAnim.dispose();
         this.runAnim.dispose();
         this.brakeAnim.dispose();
         this.hopAnim.dispose();
         this.fallRunAnim.dispose();
         this.hurtAnim.dispose();
         this.levelStartAnim.dispose();
         this.levelCompleteAnim.dispose();
         this.swimAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.jumpAnim = null;
         this.fallAnim = null;
         this.climbAnim = null;
         this.slideAnim = null;
         this.runAnim = null;
         this.brakeAnim = null;
         this.hopAnim = null;
         this.fallRunAnim = null;
         this.hurtAnim = null;
         this.levelStartAnim = null;
         this.levelCompleteAnim = null;
         this.swimAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatStandAnim_"));
         this.standAnim.setFrameDuration(0,1);
         this.standAnim.setFrameDuration(1,0.1);
         this.standAnim.setFrameDuration(2,0.1);
         this.standAnim.setFrameDuration(3,0.1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatWalkAnim_"),16);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatTurnAnim_"),12);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatJumpAnim_"));
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initFallAnim() : void
      {
         this.fallAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatFallAnim_"));
         this.fallAnim.touchable = false;
         this.fallAnim.x = this.fallAnim.y = 0;
         this.fallAnim.loop = true;
         Utils.juggler.add(this.fallAnim);
      }
      
      protected function initClimbAnim() : void
      {
         this.climbAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatClimbAnim_"),20);
         this.climbAnim.touchable = false;
         this.climbAnim.x = 1;
         this.climbAnim.y = 0;
         this.climbAnim.loop = true;
         Utils.juggler.add(this.climbAnim);
      }
      
      protected function initSlideAnim() : void
      {
         this.slideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatSlideAnim_"));
         this.slideAnim.touchable = false;
         this.slideAnim.x = 1;
         this.slideAnim.y = 0;
         this.slideAnim.loop = true;
         Utils.juggler.add(this.slideAnim);
      }
      
      protected function initRunAnim() : void
      {
         this.runAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatRunAnim_"));
         this.runAnim.touchable = false;
         this.runAnim.x = this.runAnim.y = 0;
         this.runAnim.loop = true;
         Utils.juggler.add(this.runAnim);
      }
      
      protected function initBrakeAnim() : void
      {
         this.brakeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatBrakeAnim_"));
         this.brakeAnim.touchable = false;
         this.brakeAnim.x = this.brakeAnim.y = 0;
         this.brakeAnim.loop = true;
         Utils.juggler.add(this.brakeAnim);
      }
      
      protected function initHopAnim() : void
      {
         this.hopAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatHopAnim_"));
         this.hopAnim.touchable = false;
         this.hopAnim.x = this.hopAnim.y = 0;
         this.hopAnim.loop = true;
         Utils.juggler.add(this.hopAnim);
      }
      
      protected function initFallRunAnim() : void
      {
         this.fallRunAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatFallRunAnim_"));
         this.fallRunAnim.setFrameDuration(0,0.1);
         this.fallRunAnim.setFrameDuration(1,0.1);
         this.fallRunAnim.touchable = false;
         this.fallRunAnim.x = this.fallRunAnim.y = 0;
         this.fallRunAnim.loop = true;
         Utils.juggler.add(this.fallRunAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatHurtAnim_"));
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initLevelStartAnim() : void
      {
         this.levelStartAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatLevelStartAnim_"));
         this.levelStartAnim.setFrameDuration(0,0.1);
         this.levelStartAnim.setFrameDuration(1,0.2);
         this.levelStartAnim.setFrameDuration(2,0.3);
         this.levelStartAnim.setFrameDuration(3,0.1);
         this.levelStartAnim.touchable = false;
         this.levelStartAnim.x = this.levelStartAnim.y = 0;
         this.levelStartAnim.loop = false;
         Utils.juggler.add(this.levelStartAnim);
      }
      
      protected function initLevelCompleteAnim() : void
      {
         this.levelCompleteAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatLevelCompleteAnim_"));
         this.levelCompleteAnim.setFrameDuration(0,0.1);
         this.levelCompleteAnim.setFrameDuration(1,0.1);
         this.levelCompleteAnim.setFrameDuration(2,0.1);
         this.levelCompleteAnim.touchable = false;
         this.levelCompleteAnim.x = this.levelCompleteAnim.y = 0;
         this.levelCompleteAnim.loop = true;
         Utils.juggler.add(this.levelCompleteAnim);
      }
      
      protected function initSwimAnim() : void
      {
         this.swimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("glideCatSwimAnim_"));
         this.swimAnim.setFrameDuration(0,0.2);
         this.swimAnim.setFrameDuration(1,0.1);
         this.swimAnim.touchable = false;
         this.swimAnim.x = this.swimAnim.y = 0;
         this.swimAnim.loop = false;
         Utils.juggler.add(this.swimAnim);
      }
   }
}
