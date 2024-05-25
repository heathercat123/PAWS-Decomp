package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SnowmanEnemySprite extends GameSprite
   {
       
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var snowballAnim:GameMovieClip;
      
      protected var emergeAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var fallAnim:GameMovieClip;
      
      protected var groundImpactAnim:GameMovieClip;
      
      public function SnowmanEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initHurtAnim();
         this.initSnowballAnim();
         this.initEmergeAnim();
         this.initJumpAnim();
         this.initFallAnim();
         this.initGroundImpactAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.snowballAnim);
         sprite.addChild(this.emergeAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.fallAnim);
         sprite.addChild(this.groundImpactAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.snowballAnim);
         Utils.juggler.remove(this.emergeAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.fallAnim);
         Utils.juggler.remove(this.groundImpactAnim);
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.hurtAnim.dispose();
         this.snowballAnim.dispose();
         this.emergeAnim.dispose();
         this.jumpAnim.dispose();
         this.fallAnim.dispose();
         this.groundImpactAnim.dispose();
         this.walkAnim = null;
         this.turnAnim = null;
         this.hurtAnim = null;
         this.snowballAnim = null;
         this.emergeAnim = null;
         this.jumpAnim = null;
         this.fallAnim = null;
         this.groundImpactAnim = null;
         super.destroy();
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanEnemyWalkAnim_"));
         this.walkAnim.setFrameDuration(0,0.2);
         this.walkAnim.setFrameDuration(1,0.2);
         this.walkAnim.setFrameDuration(2,0.05);
         this.walkAnim.setFrameDuration(3,0.2);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanEnemyHurtAnim_"));
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = false;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initSnowballAnim() : void
      {
         this.snowballAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanEnemySnowballAnim_"));
         this.snowballAnim.touchable = false;
         this.snowballAnim.x = this.snowballAnim.y = 0;
         this.snowballAnim.loop = false;
         Utils.juggler.add(this.snowballAnim);
      }
      
      protected function initEmergeAnim() : void
      {
         this.emergeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanEnemyEmergeAnim_"));
         this.emergeAnim.setFrameDuration(0,0.1);
         this.emergeAnim.setFrameDuration(1,0.1);
         this.emergeAnim.setFrameDuration(2,0.1);
         this.emergeAnim.setFrameDuration(3,0.5);
         this.emergeAnim.touchable = false;
         this.emergeAnim.x = this.emergeAnim.y = 0;
         this.emergeAnim.loop = false;
         Utils.juggler.add(this.emergeAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanEnemyJumpAnim_"));
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = false;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initFallAnim() : void
      {
         this.fallAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanEnemyFallAnim_"));
         this.fallAnim.setFrameDuration(0,0.075);
         this.fallAnim.setFrameDuration(1,0.075);
         this.fallAnim.setFrameDuration(2,0.075);
         this.fallAnim.setFrameDuration(3,0.075);
         this.fallAnim.setFrameDuration(4,0.075);
         this.fallAnim.setFrameDuration(5,0.075);
         this.fallAnim.setFrameDuration(6,0.1);
         this.fallAnim.setFrameDuration(7,0.25);
         this.fallAnim.touchable = false;
         this.fallAnim.x = this.fallAnim.y = 0;
         this.fallAnim.loop = false;
         Utils.juggler.add(this.fallAnim);
      }
      
      protected function initGroundImpactAnim() : void
      {
         this.groundImpactAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("snowmanEnemyGroundImpactAnim_"));
         this.groundImpactAnim.setFrameDuration(0,0.075);
         this.groundImpactAnim.setFrameDuration(1,0.35);
         this.groundImpactAnim.setFrameDuration(2,0.075);
         this.groundImpactAnim.touchable = false;
         this.groundImpactAnim.x = this.groundImpactAnim.y = 0;
         this.groundImpactAnim.loop = false;
         Utils.juggler.add(this.groundImpactAnim);
      }
   }
}
