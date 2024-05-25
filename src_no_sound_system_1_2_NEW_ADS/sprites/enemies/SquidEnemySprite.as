package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SquidEnemySprite extends GameSprite
   {
       
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var groundAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function SquidEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initJumpAnim();
         this.initGroundAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.groundAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.groundAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.jumpAnim.dispose();
         this.groundAnim.dispose();
         this.hurtAnim.dispose();
         this.walkAnim = null;
         this.turnAnim = null;
         this.jumpAnim = null;
         this.groundAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("squidEnemyWalkAnim_"));
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
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("squidEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("squidEnemyJumpAnim_"));
         this.jumpAnim.setFrameDuration(0,0.1);
         this.jumpAnim.setFrameDuration(1,0.15);
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initGroundAnim() : void
      {
         this.groundAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("squidEnemyGroundAnim_"));
         this.groundAnim.setFrameDuration(0,0.1);
         this.groundAnim.touchable = false;
         this.groundAnim.x = this.groundAnim.y = 0;
         this.groundAnim.loop = false;
         Utils.juggler.add(this.groundAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("squidEnemyHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
   }
}
