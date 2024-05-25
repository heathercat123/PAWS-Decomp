package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GiantDragonEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var aimAnim:GameMovieClip;
      
      protected var tossAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function GiantDragonEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initAimAnim();
         this.initTossAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 32;
         sprite.x = sprite.y = 16;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.aimAnim);
         sprite.addChild(this.tossAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.aimAnim);
         Utils.juggler.remove(this.tossAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.aimAnim.dispose();
         this.tossAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.aimAnim = null;
         this.tossAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantDragonEnemyStandAnim_"));
         this.standAnim.setFrameDuration(0,0.2);
         this.standAnim.setFrameDuration(1,0.2);
         this.standAnim.setFrameDuration(2,0.2);
         this.standAnim.setFrameDuration(3,0.2);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initAimAnim() : void
      {
         this.aimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantDragonEnemyAimAnim_"));
         this.aimAnim.setFrameDuration(0,0.1);
         this.aimAnim.setFrameDuration(1,0.1);
         this.aimAnim.touchable = false;
         this.aimAnim.x = this.aimAnim.y = 0;
         this.aimAnim.loop = true;
         Utils.juggler.add(this.aimAnim);
      }
      
      protected function initTossAnim() : void
      {
         this.tossAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantDragonEnemyTossAnim_"));
         this.tossAnim.setFrameDuration(0,0.1);
         this.tossAnim.setFrameDuration(1,0.1);
         this.tossAnim.setFrameDuration(2,0.1);
         this.tossAnim.touchable = false;
         this.tossAnim.x = this.tossAnim.y = 0;
         this.tossAnim.loop = false;
         Utils.juggler.add(this.tossAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantDragonEnemyHurtAnim_"));
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = false;
         Utils.juggler.add(this.hurtAnim);
      }
   }
}
