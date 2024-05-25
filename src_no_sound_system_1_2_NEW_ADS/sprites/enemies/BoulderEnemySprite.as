package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BoulderEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var transformStartAnim:GameMovieClip;
      
      protected var rollAnim:GameMovieClip;
      
      protected var transformEndAnim:GameMovieClip;
      
      public function BoulderEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initHurtAnim();
         this.initTransformStartAnim();
         this.initRollAnim();
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
         sprite.addChild(this.transformStartAnim);
         sprite.addChild(this.rollAnim);
         sprite.addChild(this.transformEndAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.transformStartAnim);
         Utils.juggler.remove(this.rollAnim);
         Utils.juggler.remove(this.transformEndAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.transformStartAnim.dispose();
         this.rollAnim.dispose();
         this.transformEndAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.hurtAnim = null;
         this.transformStartAnim = null;
         this.rollAnim = null;
         this.transformEndAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boulderEnemyStandAnim_"));
         this.standAnim.setFrameDuration(0,1);
         this.standAnim.setFrameDuration(1,0.2);
         this.standAnim.setFrameDuration(2,0.2);
         this.standAnim.setFrameDuration(3,0.1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boulderEnemyWalkAnim_"));
         this.walkAnim.setFrameDuration(0,0.08);
         this.walkAnim.setFrameDuration(1,0.08);
         this.walkAnim.setFrameDuration(2,0.08);
         this.walkAnim.setFrameDuration(3,0.08);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boulderEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boulderEnemyHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initTransformStartAnim() : void
      {
         this.transformStartAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boulderTransformStartAnim_"));
         this.transformStartAnim.touchable = false;
         this.transformStartAnim.x = this.transformStartAnim.y = 0;
         this.transformStartAnim.loop = false;
         Utils.juggler.add(this.transformStartAnim);
      }
      
      protected function initRollAnim() : void
      {
         this.rollAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boulderEnemyRollAnim_"));
         this.rollAnim.setFrameDuration(0,0.1);
         this.rollAnim.setFrameDuration(1,0.1);
         this.rollAnim.setFrameDuration(2,0.1);
         this.rollAnim.setFrameDuration(3,0.1);
         this.rollAnim.setFrameDuration(4,0.1);
         this.rollAnim.setFrameDuration(5,0.1);
         this.rollAnim.setFrameDuration(6,0.1);
         this.rollAnim.setFrameDuration(7,0.1);
         this.rollAnim.touchable = false;
         this.rollAnim.x = this.rollAnim.y = 0;
         this.rollAnim.loop = true;
         Utils.juggler.add(this.rollAnim);
      }
      
      protected function initTransformEndAnim() : void
      {
         this.transformEndAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("boulderTransformEndAnim_"));
         this.transformEndAnim.setFrameDuration(0,0.2);
         this.transformEndAnim.setFrameDuration(1,0.1);
         this.transformEndAnim.touchable = false;
         this.transformEndAnim.x = this.transformEndAnim.y = 0;
         this.transformEndAnim.loop = false;
         Utils.juggler.add(this.transformEndAnim);
      }
   }
}
