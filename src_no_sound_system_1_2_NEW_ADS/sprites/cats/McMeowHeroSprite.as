package sprites.cats
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class McMeowHeroSprite extends GameSprite
   {
       
      
      protected var isInjured:Boolean;
      
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
      
      protected var ropeHangAnim:GameMovieClip;
      
      protected var ropeTurnAnim:GameMovieClip;
      
      protected var backAnim:GameMovieClip;
      
      protected var eatAnim:GameMovieClip;
      
      protected var hissAnim:GameMovieClip;
      
      protected var injuredAnim:GameMovieClip;
      
      public function McMeowHeroSprite(_isInjured:Boolean = false)
      {
         var sprite:GameSprite = null;
         super();
         this.isInjured = _isInjured;
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
         this.initRopeHangAnim();
         this.initRopeTurnAnim();
         this.initBackAnim();
         this.initEatAnim();
         this.initHissAnim();
         this.initInjuredAnim();
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
         sprite.addChild(this.ropeHangAnim);
         sprite.addChild(this.ropeTurnAnim);
         sprite.addChild(this.backAnim);
         sprite.addChild(this.eatAnim);
         sprite.addChild(this.hissAnim);
         sprite.addChild(this.injuredAnim);
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
         Utils.juggler.remove(this.ropeHangAnim);
         Utils.juggler.remove(this.ropeTurnAnim);
         Utils.juggler.remove(this.backAnim);
         Utils.juggler.remove(this.eatAnim);
         Utils.juggler.remove(this.hissAnim);
         Utils.juggler.remove(this.injuredAnim);
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
         this.ropeHangAnim.dispose();
         this.ropeTurnAnim.dispose();
         this.backAnim.dispose();
         this.eatAnim.dispose();
         this.hissAnim.dispose();
         this.injuredAnim.dispose();
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
         this.ropeHangAnim = null;
         this.ropeTurnAnim = null;
         this.backAnim = null;
         this.eatAnim = null;
         this.hissAnim = null;
         this.injuredAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.isInjured)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowStandHurtAnim_"));
            this.standAnim.setFrameDuration(0,0.1);
            this.standAnim.setFrameDuration(1,0.1);
            this.standAnim.setFrameDuration(2,0.1);
            this.standAnim.setFrameDuration(3,0.1);
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowStandAnim_"));
            this.standAnim.setFrameDuration(0,1);
            this.standAnim.setFrameDuration(1,0.1);
            this.standAnim.setFrameDuration(2,0.1);
            this.standAnim.setFrameDuration(3,0.1);
         }
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         if(this.isInjured)
         {
            this.standAnim.loop = true;
         }
         else
         {
            this.standAnim.loop = false;
         }
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowWalkAnim_"),16);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowTurnAnim_"),12);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initJumpAnim() : void
      {
         if(this.isInjured)
         {
            this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowJumpHurtAnim_"));
         }
         else
         {
            this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowJumpAnim_"));
         }
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initFallAnim() : void
      {
         this.fallAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowFallAnim_"));
         this.fallAnim.touchable = false;
         this.fallAnim.x = this.fallAnim.y = 0;
         this.fallAnim.loop = true;
         Utils.juggler.add(this.fallAnim);
      }
      
      protected function initClimbAnim() : void
      {
         this.climbAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowClimbAnim_"),20);
         this.climbAnim.touchable = false;
         this.climbAnim.x = this.climbAnim.y = 0;
         this.climbAnim.loop = true;
         Utils.juggler.add(this.climbAnim);
      }
      
      protected function initSlideAnim() : void
      {
         this.slideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowSlideAnim_"));
         this.slideAnim.touchable = false;
         this.slideAnim.x = this.slideAnim.y = 0;
         this.slideAnim.loop = true;
         Utils.juggler.add(this.slideAnim);
      }
      
      protected function initRunAnim() : void
      {
         this.runAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowRunAnim_"));
         this.runAnim.setFrameDuration(0,0.05);
         this.runAnim.setFrameDuration(1,0.05);
         this.runAnim.setFrameDuration(2,0.05);
         this.runAnim.setFrameDuration(3,0.05);
         this.runAnim.touchable = false;
         this.runAnim.x = this.runAnim.y = 0;
         this.runAnim.loop = true;
         Utils.juggler.add(this.runAnim);
      }
      
      protected function initBrakeAnim() : void
      {
         this.brakeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowBrakeAnim_"));
         this.brakeAnim.touchable = false;
         this.brakeAnim.x = this.brakeAnim.y = 0;
         this.brakeAnim.loop = true;
         Utils.juggler.add(this.brakeAnim);
      }
      
      protected function initHopAnim() : void
      {
         this.hopAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowHopAnim_"));
         this.hopAnim.touchable = false;
         this.hopAnim.x = this.hopAnim.y = 0;
         this.hopAnim.loop = true;
         Utils.juggler.add(this.hopAnim);
      }
      
      protected function initFallRunAnim() : void
      {
         this.fallRunAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowFallRunAnim_"));
         this.fallRunAnim.touchable = false;
         this.fallRunAnim.x = this.fallRunAnim.y = 0;
         this.fallRunAnim.loop = true;
         Utils.juggler.add(this.fallRunAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowHurtAnim_"));
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initLevelStartAnim() : void
      {
         this.levelStartAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowLevelStartAnim_"));
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
         this.levelCompleteAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowLevelCompleteAnim_"));
         this.levelCompleteAnim.setFrameDuration(0,0.1);
         this.levelCompleteAnim.setFrameDuration(1,0.1);
         this.levelCompleteAnim.setFrameDuration(2,0.1);
         this.levelCompleteAnim.setFrameDuration(3,0.1);
         this.levelCompleteAnim.setFrameDuration(4,0.1);
         this.levelCompleteAnim.setFrameDuration(5,0.1);
         this.levelCompleteAnim.setFrameDuration(6,0.1);
         this.levelCompleteAnim.setFrameDuration(7,0.1);
         this.levelCompleteAnim.setFrameDuration(8,0.1);
         this.levelCompleteAnim.touchable = false;
         this.levelCompleteAnim.x = this.levelCompleteAnim.y = 0;
         this.levelCompleteAnim.loop = false;
         Utils.juggler.add(this.levelCompleteAnim);
      }
      
      protected function initSwimAnim() : void
      {
         this.swimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowSwimAnim_"));
         this.swimAnim.setFrameDuration(0,0.2);
         this.swimAnim.setFrameDuration(1,0.1);
         this.swimAnim.touchable = false;
         this.swimAnim.x = this.swimAnim.y = 0;
         this.swimAnim.loop = false;
         Utils.juggler.add(this.swimAnim);
      }
      
      protected function initRopeHangAnim() : void
      {
         this.ropeHangAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowRopeHangingAnim_"));
         this.ropeHangAnim.touchable = false;
         this.ropeHangAnim.x = this.ropeHangAnim.y = 0;
         this.ropeHangAnim.loop = false;
         Utils.juggler.add(this.ropeHangAnim);
      }
      
      protected function initRopeTurnAnim() : void
      {
         this.ropeTurnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowRopeTurnAnim_"),12);
         this.ropeTurnAnim.touchable = false;
         this.ropeTurnAnim.x = this.ropeTurnAnim.y = 0;
         this.ropeTurnAnim.loop = false;
         Utils.juggler.add(this.ropeTurnAnim);
      }
      
      protected function initBackAnim() : void
      {
         this.backAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowBackAnim_a"));
         this.backAnim.setFrameDuration(0,1);
         this.backAnim.touchable = false;
         this.backAnim.x = this.backAnim.y = 0;
         this.backAnim.loop = false;
         Utils.juggler.add(this.backAnim);
      }
      
      protected function initEatAnim() : void
      {
         this.eatAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowEatAnim_"));
         this.eatAnim.setFrameDuration(0,0.2);
         this.eatAnim.setFrameDuration(1,0.2);
         this.eatAnim.setFrameDuration(2,0.2);
         this.eatAnim.setFrameDuration(3,0.2);
         this.eatAnim.setFrameDuration(4,0.2);
         this.eatAnim.setFrameDuration(5,0.2);
         this.eatAnim.setFrameDuration(6,0.1);
         this.eatAnim.setFrameDuration(7,0.1);
         this.eatAnim.setFrameDuration(8,0.1);
         this.eatAnim.touchable = false;
         this.eatAnim.x = this.eatAnim.y = 0;
         this.eatAnim.loop = true;
         Utils.juggler.add(this.eatAnim);
      }
      
      protected function initHissAnim() : void
      {
         this.hissAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowHissAnim_"));
         this.hissAnim.setFrameDuration(0,0.075);
         this.hissAnim.setFrameDuration(1,0.075);
         this.hissAnim.touchable = false;
         this.hissAnim.x = this.hissAnim.y = 0;
         this.hissAnim.loop = true;
         Utils.juggler.add(this.hissAnim);
      }
      
      protected function initInjuredAnim() : void
      {
         this.injuredAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mcMeowInjuredAnim_"));
         this.injuredAnim.touchable = false;
         this.injuredAnim.x = this.injuredAnim.y = 0;
         this.injuredAnim.loop = true;
         Utils.juggler.add(this.injuredAnim);
      }
   }
}
