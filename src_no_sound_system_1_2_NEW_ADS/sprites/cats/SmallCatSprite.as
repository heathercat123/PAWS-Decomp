package sprites.cats
{
   import game_utils.FrameData;
   import levels.cameras.*;
   import sprites.*;
   
   public class SmallCatSprite extends CatSprite
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
      
      protected var standHoleAnim:GameMovieClip;
      
      protected var walkHoleAnim:GameMovieClip;
      
      protected var turnHoleAnim:GameMovieClip;
      
      protected var backAnim:GameMovieClip;
      
      protected var ropeHangAnim:GameMovieClip;
      
      protected var ropeTurnAnim:GameMovieClip;
      
      protected var specialAnim1:GameMovieClip;
      
      protected var specialAnim2:GameMovieClip;
      
      protected var specialAnim3:GameMovieClip;
      
      protected var specialAnim4:GameMovieClip;
      
      public function SmallCatSprite(_forced_cat_id:int = -1)
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
         this.initStandHoleAnim();
         this.initWalkHoleAnim();
         this.initTurnHoleAnim();
         this.initBackAnim();
         this.initRopeHangAnim();
         this.initRopeTurnAnim();
         this.initSpecial1Anim();
         this.initSpecial2Anim();
         this.initSpecial3Anim();
         this.initSpecial4Anim();
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
         sprite.addChild(this.standHoleAnim);
         sprite.addChild(this.walkHoleAnim);
         sprite.addChild(this.turnHoleAnim);
         sprite.addChild(this.backAnim);
         sprite.addChild(this.ropeHangAnim);
         sprite.addChild(this.ropeTurnAnim);
         sprite.addChild(this.specialAnim1);
         sprite.addChild(this.specialAnim2);
         sprite.addChild(this.specialAnim3);
         sprite.addChild(this.specialAnim4);
         this.initHatArray();
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
         Utils.juggler.remove(this.standHoleAnim);
         Utils.juggler.remove(this.walkHoleAnim);
         Utils.juggler.remove(this.turnHoleAnim);
         Utils.juggler.remove(this.backAnim);
         Utils.juggler.remove(this.ropeHangAnim);
         Utils.juggler.remove(this.ropeTurnAnim);
         Utils.juggler.remove(this.specialAnim1);
         Utils.juggler.remove(this.specialAnim2);
         Utils.juggler.remove(this.specialAnim3);
         Utils.juggler.remove(this.specialAnim4);
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
         this.standHoleAnim.dispose();
         this.walkHoleAnim.dispose();
         this.turnHoleAnim.dispose();
         this.backAnim.dispose();
         this.ropeHangAnim.dispose();
         this.ropeTurnAnim.dispose();
         this.specialAnim1.dispose();
         this.specialAnim2.dispose();
         this.specialAnim3.dispose();
         this.specialAnim4.dispose();
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
         this.standHoleAnim = null;
         this.walkHoleAnim = null;
         this.turnHoleAnim = null;
         this.backAnim = null;
         this.ropeHangAnim = null;
         this.ropeTurnAnim = null;
         this.specialAnim1 = null;
         this.specialAnim2 = null;
         this.specialAnim3 = null;
         this.specialAnim4 = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatStandAnim_"));
         this.standAnim.setFrameDuration(0,int(Math.random() * 5 + 2));
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
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatWalkAnim_"),16);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatTurnAnim_"),12);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatJumpAnim_"));
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initFallAnim() : void
      {
         this.fallAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatFallAnim_"));
         this.fallAnim.touchable = false;
         this.fallAnim.x = this.fallAnim.y = 0;
         this.fallAnim.loop = true;
         Utils.juggler.add(this.fallAnim);
      }
      
      protected function initClimbAnim() : void
      {
         this.climbAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatClimbAnim_"),20);
         this.climbAnim.touchable = false;
         this.climbAnim.x = this.climbAnim.y = 0;
         this.climbAnim.loop = true;
         Utils.juggler.add(this.climbAnim);
      }
      
      protected function initSlideAnim() : void
      {
         this.slideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatSlideAnim_"));
         this.slideAnim.touchable = false;
         this.slideAnim.x = this.slideAnim.y = 0;
         this.slideAnim.loop = true;
         Utils.juggler.add(this.slideAnim);
      }
      
      protected function initRunAnim() : void
      {
         this.runAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatRunAnim_"));
         this.runAnim.touchable = false;
         this.runAnim.x = this.runAnim.y = 0;
         this.runAnim.loop = true;
         Utils.juggler.add(this.runAnim);
      }
      
      protected function initBrakeAnim() : void
      {
         this.brakeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatBrakeAnim_"));
         this.brakeAnim.touchable = false;
         this.brakeAnim.x = this.brakeAnim.y = 0;
         this.brakeAnim.loop = true;
         Utils.juggler.add(this.brakeAnim);
      }
      
      protected function initHopAnim() : void
      {
         this.hopAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatHopAnim_"));
         this.hopAnim.touchable = false;
         this.hopAnim.x = this.hopAnim.y = 0;
         this.hopAnim.loop = true;
         Utils.juggler.add(this.hopAnim);
      }
      
      protected function initFallRunAnim() : void
      {
         this.fallRunAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatFallRunAnim_"));
         this.fallRunAnim.setFrameDuration(0,0.1);
         this.fallRunAnim.setFrameDuration(1,0);
         this.fallRunAnim.setFrameDuration(2,0);
         this.fallRunAnim.touchable = false;
         this.fallRunAnim.x = this.fallRunAnim.y = 0;
         this.fallRunAnim.loop = true;
         Utils.juggler.add(this.fallRunAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatHurtAnim_"));
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initLevelStartAnim() : void
      {
         this.levelStartAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatLevelStartAnim_"));
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
         this.levelCompleteAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatLevelCompleteAnim_"));
         this.levelCompleteAnim.setFrameDuration(0,0.25);
         this.levelCompleteAnim.setFrameDuration(1,0.1);
         this.levelCompleteAnim.setFrameDuration(2,0.1);
         this.levelCompleteAnim.setFrameDuration(3,0.1);
         this.levelCompleteAnim.setFrameDuration(4,0.4);
         this.levelCompleteAnim.setFrameDuration(5,0.1);
         this.levelCompleteAnim.setFrameDuration(6,0.1);
         this.levelCompleteAnim.touchable = false;
         this.levelCompleteAnim.x = this.levelCompleteAnim.y = 0;
         this.levelCompleteAnim.loop = false;
         Utils.juggler.add(this.levelCompleteAnim);
      }
      
      protected function initSwimAnim() : void
      {
         this.swimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatSwimAnim_"));
         this.swimAnim.setFrameDuration(0,0.2);
         this.swimAnim.setFrameDuration(1,0.1);
         this.swimAnim.touchable = false;
         this.swimAnim.x = this.swimAnim.y = 0;
         this.swimAnim.loop = false;
         Utils.juggler.add(this.swimAnim);
      }
      
      protected function initStandHoleAnim() : void
      {
         this.standHoleAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatStandHoleAnim_"));
         this.standHoleAnim.setFrameDuration(0,1);
         this.standHoleAnim.setFrameDuration(1,0.1);
         this.standHoleAnim.setFrameDuration(2,0.1);
         this.standHoleAnim.setFrameDuration(3,0.1);
         this.standHoleAnim.touchable = false;
         this.standHoleAnim.x = this.standHoleAnim.y = 0;
         this.standHoleAnim.loop = false;
         Utils.juggler.add(this.standHoleAnim);
      }
      
      protected function initWalkHoleAnim() : void
      {
         this.walkHoleAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatWalkHoleAnim_"));
         this.walkHoleAnim.setFrameDuration(0,0.2);
         this.walkHoleAnim.setFrameDuration(1,0.2);
         this.walkHoleAnim.setFrameDuration(2,0.2);
         this.walkHoleAnim.setFrameDuration(3,0.2);
         this.walkHoleAnim.touchable = false;
         this.walkHoleAnim.x = this.walkHoleAnim.y = 0;
         this.walkHoleAnim.loop = true;
         Utils.juggler.add(this.walkHoleAnim);
      }
      
      protected function initTurnHoleAnim() : void
      {
         this.turnHoleAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatTurnHoleAnim_"),12);
         this.turnHoleAnim.touchable = false;
         this.turnHoleAnim.x = this.turnHoleAnim.y = 0;
         this.turnHoleAnim.loop = false;
         Utils.juggler.add(this.turnHoleAnim);
      }
      
      protected function initBackAnim() : void
      {
         this.backAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatBackAnim_"));
         this.backAnim.setFrameDuration(0,1);
         this.backAnim.setFrameDuration(1,0.1);
         this.backAnim.setFrameDuration(2,0.1);
         this.backAnim.setFrameDuration(3,0.1);
         this.backAnim.touchable = false;
         this.backAnim.x = this.backAnim.y = 0;
         this.backAnim.loop = false;
         Utils.juggler.add(this.backAnim);
      }
      
      protected function initRopeHangAnim() : void
      {
         this.ropeHangAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatRopeHangingAnim_"));
         this.ropeHangAnim.touchable = false;
         this.ropeHangAnim.x = this.ropeHangAnim.y = 0;
         this.ropeHangAnim.loop = false;
         Utils.juggler.add(this.ropeHangAnim);
      }
      
      protected function initRopeTurnAnim() : void
      {
         this.ropeTurnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatRopeTurnAnim_"),12);
         this.ropeTurnAnim.touchable = false;
         this.ropeTurnAnim.x = this.ropeTurnAnim.y = 0;
         this.ropeTurnAnim.loop = false;
         Utils.juggler.add(this.ropeTurnAnim);
      }
      
      protected function initSpecial1Anim() : void
      {
         this.specialAnim1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatSpecial1Anim_"),12);
         this.specialAnim1.touchable = false;
         this.specialAnim1.x = this.specialAnim1.y = 0;
         this.specialAnim1.loop = false;
         Utils.juggler.add(this.specialAnim1);
      }
      
      protected function initSpecial2Anim() : void
      {
         this.specialAnim2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatSpecial2Anim_"),12);
         this.specialAnim2.setFrameDuration(0,0.5);
         this.specialAnim2.setFrameDuration(1,0.2);
         this.specialAnim2.setFrameDuration(2,0.2);
         this.specialAnim2.setFrameDuration(3,10);
         this.specialAnim2.touchable = false;
         this.specialAnim2.x = this.specialAnim2.y = 0;
         this.specialAnim2.loop = false;
         Utils.juggler.add(this.specialAnim2);
      }
      
      protected function initSpecial3Anim() : void
      {
         this.specialAnim3 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatSpecial3Anim_"),12);
         this.specialAnim3.setFrameDuration(0,0.4);
         this.specialAnim3.setFrameDuration(1,0.4);
         this.specialAnim3.setFrameDuration(2,0.4);
         this.specialAnim3.setFrameDuration(3,0.4);
         this.specialAnim3.touchable = false;
         this.specialAnim3.x = this.specialAnim3.y = 0;
         this.specialAnim3.loop = true;
         Utils.juggler.add(this.specialAnim3);
      }
      
      protected function initSpecial4Anim() : void
      {
         this.specialAnim4 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallCatLookUpAnim_"),12);
         this.specialAnim4.touchable = false;
         this.specialAnim4.x = this.specialAnim4.y = 0;
         this.specialAnim4.loop = true;
         Utils.juggler.add(this.specialAnim4);
      }
      
      override public function playSpecialAnim(type:int = 0) : void
      {
         if(type == CatSprite.SHOCKED)
         {
            gfxHandle().gotoAndStop(22);
            gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         else if(type == CatSprite.PEEK)
         {
            gfxHandle().gotoAndStop(23);
            gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         else if(type == CatSprite.PANT)
         {
            gfxHandle().gotoAndStop(24);
            gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         else if(type == CatSprite.LOOK_UP)
         {
            gfxHandle().gotoAndStop(25);
            gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
      }
      
      override protected function initHatArray() : void
      {
         var i:int = 0;
         var j:int = 0;
         hat_frames = new Array();
         for(i = 0; i < 32; i++)
         {
            hat_frames.push(new Array());
         }
         hat_frames[0].push(new FrameData(5,-2,1,6));
         hat_frames[0].push(new FrameData(5,-2,1,6));
         hat_frames[0].push(new FrameData(5,-2,1,6));
         hat_frames[0].push(new FrameData(5,-2,1,6));
         hat_frames[1].push(new FrameData(5,0,1,6));
         hat_frames[1].push(new FrameData(5,-4,1,6));
         hat_frames[1].push(new FrameData(5,-5,1,6));
         hat_frames[1].push(new FrameData(5,-4,1,6));
         hat_frames[1].push(new FrameData(5,1,1,6));
         hat_frames[1].push(new FrameData(5,2,1,6));
         hat_frames[2].push(new FrameData(8,-2,2,0));
         hat_frames[3].push(new FrameData(5,-4,1,6));
         hat_frames[4].push(new FrameData(5,-4,1,6));
         hat_frames[5].push(new FrameData(20,5,1,-24,Math.PI * 0.5));
         hat_frames[5].push(new FrameData(24,5,1,-32,Math.PI * 0.5));
         hat_frames[5].push(new FrameData(25,5,1,-34,Math.PI * 0.5));
         hat_frames[5].push(new FrameData(23,5,1,-31,Math.PI * 0.5));
         hat_frames[5].push(new FrameData(19,5,1,-22,Math.PI * 0.5));
         hat_frames[5].push(new FrameData(18,5,1,-20,Math.PI * 0.5));
         hat_frames[6].push(new FrameData(20,7,1,-24,Math.PI * 0.5));
         hat_frames[7].push(new FrameData(5,0,1,6,0));
         hat_frames[7].push(new FrameData(5,-5,1,6,0));
         hat_frames[7].push(new FrameData(5,-4,1,6,0));
         hat_frames[7].push(new FrameData(5,2,1,6,0));
         hat_frames[8].push(new FrameData(8,0,1,0,0,-1));
         hat_frames[9].push(new FrameData(5,-4,1,6));
         hat_frames[10].push(new FrameData(5,-4,1,6));
         hat_frames[11].push(new FrameData(5,-1,1,6));
         hat_frames[12].push(new FrameData(5,-2,1,6));
         hat_frames[12].push(new FrameData(5,-2,1,6));
         hat_frames[12].push(new FrameData(5,-2,1,6));
         hat_frames[12].push(new FrameData(5,-2,1,6));
         hat_frames[13].push(new FrameData(5,2,1,6));
         hat_frames[13].push(new FrameData(4,1,1,8));
         hat_frames[13].push(new FrameData(2,1,1,12));
         hat_frames[13].push(new FrameData(4,1,1,8));
         hat_frames[13].push(new FrameData(2,1,1,12));
         hat_frames[13].push(new FrameData(4,1,1,8));
         hat_frames[13].push(new FrameData(5,-2,1,6));
         hat_frames[14].push(new FrameData(5,-2,1,6));
         hat_frames[14].push(new FrameData(5,-4,1,6));
         hat_frames[15].push(new FrameData(5,3,1,6));
         hat_frames[15].push(new FrameData(5,3,1,6));
         hat_frames[15].push(new FrameData(5,3,1,6));
         hat_frames[15].push(new FrameData(5,3,1,6));
         hat_frames[16].push(new FrameData(5,3,1,6));
         hat_frames[16].push(new FrameData(5,2,1,6));
         hat_frames[16].push(new FrameData(5,3,1,6));
         hat_frames[16].push(new FrameData(5,2,1,6));
         hat_frames[17].push(new FrameData(8,3,2,0));
         hat_frames[18].push(new FrameData(4,-2,3,8));
         hat_frames[18].push(new FrameData(4,-2,3,8));
         hat_frames[18].push(new FrameData(4,-2,3,8));
         hat_frames[18].push(new FrameData(4,-2,3,8));
         hat_frames[19].push(new FrameData(6,-4,3,4));
         hat_frames[19].push(new FrameData(6,-4,3,4));
         hat_frames[20].push(new FrameData(8,-4,4,0));
         hat_frames[21].push(new FrameData(5,-2,1,6));
         hat_frames[22].push(new FrameData(5,-1,1,6));
         hat_frames[23].push(new FrameData(4,-1,1,8));
         hat_frames[23].push(new FrameData(5,-2,1,6));
         hat_frames[23].push(new FrameData(5,-3,1,6));
         hat_frames[23].push(new FrameData(4,-2,1,8));
         hat_frames[24].push(new FrameData(5,-2,1,6));
      }
   }
}
