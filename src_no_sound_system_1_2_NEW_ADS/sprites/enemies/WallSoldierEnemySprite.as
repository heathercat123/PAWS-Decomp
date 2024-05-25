package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class WallSoldierEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function WallSoldierEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initTurnAnim();
         this.initWalkAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.walkAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wallSoldierStandAnim_"));
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wallSoldierTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.2);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wallSoldierWalkAnim_"));
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
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("wallSoldierHurtAnim_"));
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
