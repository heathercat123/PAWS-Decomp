package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class TravelerEnemySprite extends GameSprite
   {
       
      
      protected var index:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var fishAnim:GameMovieClip;
      
      protected var iceWalkAnim:GameMovieClip;
      
      protected var iceJumpAnim:GameMovieClip;
      
      protected var standSnowAnim:GameMovieClip;
      
      protected var turnSnowAnim:GameMovieClip;
      
      protected var walkSnowAnim:GameMovieClip;
      
      protected var aimSnowAnim:GameMovieClip;
      
      protected var tossSnowAnim:GameMovieClip;
      
      protected var makeSnowAnim:GameMovieClip;
      
      protected var pogoStandAnim:GameMovieClip;
      
      protected var pogoJumpAnim:GameMovieClip;
      
      protected var pogoTurnAnim:GameMovieClip;
      
      public function TravelerEnemySprite(_index:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.index = _index;
         this.initStandAnim();
         this.initTurnAnim();
         this.initWalkAnim();
         this.initHurtAnim();
         this.initJumpAnim();
         this.initFishAnim();
         this.initIceWalkAnim();
         this.initIceJumpAnim();
         this.initStandSnowAnim();
         this.initTurnSnowAnim();
         this.initWalkSnowAnim();
         this.initAimSnowAnim();
         this.initTossSnowAnim();
         this.initMakeSnowAnim();
         this.initPogoAnims();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.fishAnim);
         sprite.addChild(this.iceWalkAnim);
         sprite.addChild(this.iceJumpAnim);
         sprite.addChild(this.standSnowAnim);
         sprite.addChild(this.turnSnowAnim);
         sprite.addChild(this.walkSnowAnim);
         sprite.addChild(this.aimSnowAnim);
         sprite.addChild(this.tossSnowAnim);
         sprite.addChild(this.makeSnowAnim);
         sprite.addChild(this.pogoStandAnim);
         sprite.addChild(this.pogoJumpAnim);
         sprite.addChild(this.pogoTurnAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.fishAnim);
         Utils.juggler.remove(this.iceWalkAnim);
         Utils.juggler.remove(this.iceJumpAnim);
         Utils.juggler.remove(this.standSnowAnim);
         Utils.juggler.remove(this.turnSnowAnim);
         Utils.juggler.remove(this.walkSnowAnim);
         Utils.juggler.remove(this.aimSnowAnim);
         Utils.juggler.remove(this.tossSnowAnim);
         Utils.juggler.remove(this.makeSnowAnim);
         Utils.juggler.remove(this.pogoStandAnim);
         Utils.juggler.remove(this.pogoJumpAnim);
         Utils.juggler.remove(this.pogoTurnAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.jumpAnim.dispose();
         this.fishAnim.dispose();
         this.iceWalkAnim.dispose();
         this.iceJumpAnim.dispose();
         this.standSnowAnim.dispose();
         this.turnSnowAnim.dispose();
         this.walkSnowAnim.dispose();
         this.aimSnowAnim.dispose();
         this.tossSnowAnim.dispose();
         this.makeSnowAnim.dispose();
         this.pogoStandAnim.dispose();
         this.pogoJumpAnim.dispose();
         this.pogoTurnAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.walkAnim = null;
         this.hurtAnim = null;
         this.jumpAnim = null;
         this.fishAnim = null;
         this.iceWalkAnim = null;
         this.iceJumpAnim = null;
         this.standSnowAnim = null;
         this.turnSnowAnim = null;
         this.walkSnowAnim = null;
         this.aimSnowAnim = null;
         this.tossSnowAnim = null;
         this.makeSnowAnim = null;
         this.pogoStandAnim = null;
         this.pogoJumpAnim = null;
         this.pogoTurnAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.index == 5)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyFireStandAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyStandAnim_"));
         }
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.index == 5)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyFireTurnAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyTurnAnim_"));
         }
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.index == 5)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyFireWalkAnim_"));
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyWalkAnim_"));
         }
         this.walkAnim.setFrameDuration(0,0.075);
         this.walkAnim.setFrameDuration(1,0.075);
         this.walkAnim.setFrameDuration(2,0.075);
         this.walkAnim.setFrameDuration(3,0.075);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyJumpAnim_"));
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initFishAnim() : void
      {
         this.fishAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyFishAnim_"));
         this.fishAnim.touchable = false;
         this.fishAnim.x = this.fishAnim.y = 0;
         this.fishAnim.loop = true;
         Utils.juggler.add(this.fishAnim);
      }
      
      protected function initIceWalkAnim() : void
      {
         this.iceWalkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyIceWalkAnim_"));
         this.iceWalkAnim.setFrameDuration(0,0.1);
         this.iceWalkAnim.setFrameDuration(1,0.1);
         this.iceWalkAnim.setFrameDuration(2,0.1);
         this.iceWalkAnim.setFrameDuration(3,0.1);
         this.iceWalkAnim.touchable = false;
         this.iceWalkAnim.x = this.iceWalkAnim.y = 0;
         this.iceWalkAnim.loop = true;
         Utils.juggler.add(this.iceWalkAnim);
      }
      
      protected function initIceJumpAnim() : void
      {
         this.iceJumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyIceJumpAnim_"));
         this.iceJumpAnim.touchable = false;
         this.iceJumpAnim.x = this.iceJumpAnim.y = 0;
         this.iceJumpAnim.loop = true;
         Utils.juggler.add(this.iceJumpAnim);
      }
      
      protected function initStandSnowAnim() : void
      {
         this.standSnowAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowTravelerEnemyStandAnim_"));
         this.standSnowAnim.touchable = false;
         this.standSnowAnim.x = this.standSnowAnim.y = 0;
         this.standSnowAnim.loop = false;
         Utils.juggler.add(this.standSnowAnim);
      }
      
      protected function initTurnSnowAnim() : void
      {
         this.turnSnowAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowTravelerEnemyTurnAnim_"));
         this.turnSnowAnim.setFrameDuration(0,0.1);
         this.turnSnowAnim.touchable = false;
         this.turnSnowAnim.x = this.turnSnowAnim.y = 0;
         this.turnSnowAnim.loop = false;
         Utils.juggler.add(this.turnSnowAnim);
      }
      
      protected function initWalkSnowAnim() : void
      {
         this.walkSnowAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowTravelerEnemyWalkAnim_"));
         this.walkSnowAnim.setFrameDuration(0,0.075);
         this.walkSnowAnim.setFrameDuration(1,0.075);
         this.walkSnowAnim.setFrameDuration(2,0.075);
         this.walkSnowAnim.setFrameDuration(3,0.075);
         this.walkSnowAnim.touchable = false;
         this.walkSnowAnim.x = this.walkSnowAnim.y = 0;
         this.walkSnowAnim.loop = true;
         Utils.juggler.add(this.walkSnowAnim);
      }
      
      protected function initAimSnowAnim() : void
      {
         this.aimSnowAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowTravelerEnemyAimAnim_"));
         this.aimSnowAnim.setFrameDuration(0,0.25);
         this.aimSnowAnim.touchable = false;
         this.aimSnowAnim.x = this.aimSnowAnim.y = 0;
         this.aimSnowAnim.loop = false;
         Utils.juggler.add(this.aimSnowAnim);
      }
      
      protected function initTossSnowAnim() : void
      {
         this.tossSnowAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowTravelerEnemyTossAnim_"));
         this.tossSnowAnim.setFrameDuration(0,0.1);
         this.tossSnowAnim.touchable = false;
         this.tossSnowAnim.x = this.tossSnowAnim.y = 0;
         this.tossSnowAnim.loop = false;
         Utils.juggler.add(this.tossSnowAnim);
      }
      
      protected function initMakeSnowAnim() : void
      {
         this.makeSnowAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowTravelerEnemyMakeSnowballAnim_"));
         this.makeSnowAnim.setFrameDuration(0,0.1);
         this.makeSnowAnim.setFrameDuration(1,0.1);
         this.makeSnowAnim.setFrameDuration(2,0.1);
         this.makeSnowAnim.setFrameDuration(3,0.1);
         this.makeSnowAnim.setFrameDuration(4,0.1);
         this.makeSnowAnim.setFrameDuration(5,0.1);
         this.makeSnowAnim.setFrameDuration(6,0.1);
         this.makeSnowAnim.setFrameDuration(7,0.1);
         this.makeSnowAnim.setFrameDuration(8,0.1);
         this.makeSnowAnim.touchable = false;
         this.makeSnowAnim.x = this.makeSnowAnim.y = 0;
         this.makeSnowAnim.loop = false;
         Utils.juggler.add(this.makeSnowAnim);
      }
      
      protected function initPogoAnims() : void
      {
         this.pogoStandAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyPogoStandAnim_"));
         this.pogoStandAnim.touchable = false;
         this.pogoStandAnim.x = 0;
         this.pogoStandAnim.y = -4;
         this.pogoStandAnim.loop = false;
         Utils.juggler.add(this.pogoStandAnim);
         this.pogoJumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyPogoJumpAnim_"));
         this.pogoJumpAnim.touchable = false;
         this.pogoJumpAnim.x = 0;
         this.pogoJumpAnim.y = -4;
         this.pogoJumpAnim.loop = false;
         Utils.juggler.add(this.pogoJumpAnim);
         this.pogoTurnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("travelerEnemyPogoTurnAnim_"));
         this.pogoTurnAnim.setFrameDuration(0,0.1);
         this.pogoTurnAnim.touchable = false;
         this.pogoTurnAnim.x = 0;
         this.pogoTurnAnim.y = -4;
         this.pogoTurnAnim.loop = false;
         Utils.juggler.add(this.pogoTurnAnim);
      }
   }
}
