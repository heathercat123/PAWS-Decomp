package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class RockEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var preJumpAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var transformStartAnim:GameMovieClip;
      
      protected var transformEndAnim:GameMovieClip;
      
      public function RockEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initHurtAnim();
         this.initPreJumpAnim();
         this.initJumpAnim();
         this.initTransformStartAnim();
         this.initTransformEndAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 20;
         sprite.x = 12;
         sprite.y = 10;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.preJumpAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.transformStartAnim);
         sprite.addChild(this.transformEndAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.preJumpAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.transformStartAnim);
         Utils.juggler.remove(this.transformEndAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.preJumpAnim.dispose();
         this.jumpAnim.dispose();
         this.transformStartAnim.dispose();
         this.transformEndAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.hurtAnim = null;
         this.preJumpAnim = null;
         this.jumpAnim = null;
         this.transformStartAnim = null;
         this.transformEndAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockEnemyStandAnim_"));
         this.standAnim.setFrameDuration(0,int(Math.random() * 3 + 1));
         this.standAnim.setFrameDuration(1,0.1);
         this.standAnim.setFrameDuration(2,0.1);
         this.standAnim.setFrameDuration(3,0.1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockEnemyWalkAnim_"));
         this.walkAnim.setFrameDuration(0,0.075);
         this.walkAnim.setFrameDuration(1,0.075);
         this.walkAnim.setFrameDuration(2,0.075);
         this.walkAnim.setFrameDuration(3,0.075);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockEnemyHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initPreJumpAnim() : void
      {
         this.preJumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockEnemyPreJumpAnim_"));
         this.preJumpAnim.touchable = false;
         this.preJumpAnim.x = this.preJumpAnim.y = 0;
         this.preJumpAnim.loop = false;
         Utils.juggler.add(this.preJumpAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockEnemyJumpAnim_"));
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initTransformStartAnim() : void
      {
         this.transformStartAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockEnemyTransformStartAnim_"));
         this.transformStartAnim.setFrameDuration(0,0.2);
         this.transformStartAnim.setFrameDuration(1,0.1);
         this.transformStartAnim.touchable = false;
         this.transformStartAnim.x = this.transformStartAnim.y = 0;
         this.transformStartAnim.loop = false;
         Utils.juggler.add(this.transformStartAnim);
      }
      
      protected function initTransformEndAnim() : void
      {
         this.transformEndAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockEnemyTransformEndAnim_"));
         this.transformEndAnim.setFrameDuration(0,0.1);
         this.transformEndAnim.setFrameDuration(1,0.1);
         this.transformEndAnim.touchable = false;
         this.transformEndAnim.x = this.transformEndAnim.y = 0;
         this.transformEndAnim.loop = false;
         Utils.juggler.add(this.transformEndAnim);
      }
   }
}
