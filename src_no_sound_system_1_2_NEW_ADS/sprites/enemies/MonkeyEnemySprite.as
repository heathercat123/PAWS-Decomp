package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class MonkeyEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var laughAnim:GameMovieClip;
      
      protected var surprisedAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var runAnim:GameMovieClip;
      
      protected var aimAnim:GameMovieClip;
      
      protected var tossAnim:GameMovieClip;
      
      protected var ropeAnim:GameMovieClip;
      
      protected var ropeTossAnim:GameMovieClip;
      
      protected var ropeTurnAnim:GameMovieClip;
      
      public function MonkeyEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initLaughAnim();
         this.initSurprisedAnim();
         this.initHitAnim();
         this.initRunAnim();
         this.initAimAnim();
         this.initTossAnim();
         this.initRopeAnim();
         this.initRopeTossAnim();
         this.initRopeTurnAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.laughAnim);
         sprite.addChild(this.surprisedAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.runAnim);
         sprite.addChild(this.aimAnim);
         sprite.addChild(this.tossAnim);
         sprite.addChild(this.ropeAnim);
         sprite.addChild(this.ropeTossAnim);
         sprite.addChild(this.ropeTurnAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.laughAnim);
         Utils.juggler.remove(this.surprisedAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.runAnim);
         Utils.juggler.remove(this.aimAnim);
         Utils.juggler.remove(this.tossAnim);
         Utils.juggler.remove(this.ropeAnim);
         Utils.juggler.remove(this.ropeTossAnim);
         Utils.juggler.remove(this.ropeTurnAnim);
         this.standAnim.dispose();
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.laughAnim.dispose();
         this.surprisedAnim.dispose();
         this.hitAnim.dispose();
         this.runAnim.dispose();
         this.aimAnim.dispose();
         this.tossAnim.dispose();
         this.ropeAnim.dispose();
         this.ropeTossAnim.dispose();
         this.ropeTurnAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.laughAnim = null;
         this.surprisedAnim = null;
         this.hitAnim = null;
         this.runAnim = null;
         this.aimAnim = null;
         this.tossAnim = null;
         this.ropeAnim = null;
         this.ropeTossAnim = null;
         this.ropeTurnAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyStandAnim_"));
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyWalkAnim_"));
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
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initLaughAnim() : void
      {
         this.laughAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyLaughAnim_"));
         this.laughAnim.setFrameDuration(0,0.1);
         this.laughAnim.touchable = false;
         this.laughAnim.x = this.laughAnim.y = 0;
         this.laughAnim.loop = true;
         Utils.juggler.add(this.laughAnim);
      }
      
      protected function initSurprisedAnim() : void
      {
         this.surprisedAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemySurprisedAnim_"));
         this.surprisedAnim.setFrameDuration(0,0.1);
         this.surprisedAnim.touchable = false;
         this.surprisedAnim.x = this.surprisedAnim.y = 0;
         this.surprisedAnim.loop = false;
         Utils.juggler.add(this.surprisedAnim);
      }
      
      protected function initHitAnim() : void
      {
         this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyHitAnim_"));
         this.hitAnim.setFrameDuration(0,0.075);
         this.hitAnim.setFrameDuration(1,0.075);
         this.hitAnim.setFrameDuration(2,0.075);
         this.hitAnim.setFrameDuration(3,0.075);
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = true;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initRunAnim() : void
      {
         this.runAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyWalkAnim_"));
         this.runAnim.setFrameDuration(0,0.05);
         this.runAnim.setFrameDuration(1,0.05);
         this.runAnim.setFrameDuration(2,0.05);
         this.runAnim.touchable = false;
         this.runAnim.x = this.runAnim.y = 0;
         this.runAnim.loop = true;
         Utils.juggler.add(this.runAnim);
      }
      
      protected function initAimAnim() : void
      {
         this.aimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyAimAnim_"));
         this.aimAnim.setFrameDuration(0,0.25);
         this.aimAnim.touchable = false;
         this.aimAnim.x = this.aimAnim.y = 0;
         this.aimAnim.loop = false;
         Utils.juggler.add(this.aimAnim);
      }
      
      protected function initTossAnim() : void
      {
         this.tossAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyTossAnim_"));
         this.tossAnim.setFrameDuration(0,0.1);
         this.tossAnim.setFrameDuration(1,0.2);
         this.tossAnim.touchable = false;
         this.tossAnim.x = this.tossAnim.y = 0;
         this.tossAnim.loop = false;
         Utils.juggler.add(this.tossAnim);
      }
      
      protected function initRopeAnim() : void
      {
         this.ropeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyRopeAnim_"));
         this.ropeAnim.setFrameDuration(0,0.1);
         this.ropeAnim.setFrameDuration(1,0.1);
         this.ropeAnim.touchable = false;
         this.ropeAnim.x = this.ropeAnim.y = 0;
         this.ropeAnim.loop = true;
         Utils.juggler.add(this.ropeAnim);
      }
      
      protected function initRopeTossAnim() : void
      {
         this.ropeTossAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyRopeTossAnim_"));
         this.ropeTossAnim.setFrameDuration(0,0.1);
         this.ropeTossAnim.setFrameDuration(1,0.2);
         this.ropeTossAnim.touchable = false;
         this.ropeTossAnim.x = this.ropeTossAnim.y = 0;
         this.ropeTossAnim.loop = false;
         Utils.juggler.add(this.ropeTossAnim);
      }
      
      protected function initRopeTurnAnim() : void
      {
         this.ropeTurnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyEnemyRopeTurnAnim_"));
         this.ropeTurnAnim.setFrameDuration(0,0.1);
         this.ropeTurnAnim.touchable = false;
         this.ropeTurnAnim.x = this.ropeTurnAnim.y = 0;
         this.ropeTurnAnim.loop = false;
         Utils.juggler.add(this.ropeTurnAnim);
      }
   }
}
