package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FireSoldierEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var attackStartAnim:GameMovieClip;
      
      protected var attackAnim:GameMovieClip;
      
      public function FireSoldierEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initTurnAnim();
         this.initWalkAnim();
         this.initHurtAnim();
         this.initAttackStartAnim();
         this.initAttackAnim();
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
         sprite.addChild(this.attackStartAnim);
         sprite.addChild(this.attackAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.attackStartAnim);
         Utils.juggler.remove(this.attackAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.attackStartAnim.dispose();
         this.attackAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.walkAnim = null;
         this.hurtAnim = null;
         this.attackStartAnim = null;
         this.attackAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireSoldierStandAnim_"));
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireSoldierTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireSoldierWalkAnim_"));
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
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireSoldierHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initAttackStartAnim() : void
      {
         this.attackStartAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireSoldierAttackStartAnim_"));
         this.attackStartAnim.setFrameDuration(0,0.1);
         this.attackStartAnim.setFrameDuration(1,0.1);
         this.attackStartAnim.setFrameDuration(2,0.1);
         this.attackStartAnim.setFrameDuration(3,0.25);
         this.attackStartAnim.touchable = false;
         this.attackStartAnim.x = this.attackStartAnim.y = 0;
         this.attackStartAnim.loop = false;
         Utils.juggler.add(this.attackStartAnim);
      }
      
      protected function initAttackAnim() : void
      {
         this.attackAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireSoldierAttackAnim_"));
         this.attackAnim.setFrameDuration(0,0.075);
         this.attackAnim.setFrameDuration(1,0.075);
         this.attackAnim.touchable = false;
         this.attackAnim.x = this.attackAnim.y = 0;
         this.attackAnim.loop = true;
         Utils.juggler.add(this.attackAnim);
      }
   }
}
