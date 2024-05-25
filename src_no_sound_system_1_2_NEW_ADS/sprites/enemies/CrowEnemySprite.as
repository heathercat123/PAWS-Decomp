package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CrowEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var flyAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var shootAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function CrowEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initFlyAnim();
         this.initTurnAnim();
         this.initShootAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.flyAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.shootAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.flyAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.shootAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.flyAnim.dispose();
         this.turnAnim.dispose();
         this.shootAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.flyAnim = null;
         this.turnAnim = null;
         this.shootAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crowEnemyFlyAnim_a"));
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initFlyAnim() : void
      {
         this.flyAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crowEnemyFlyAnim_"));
         this.flyAnim.setFrameDuration(0,0.075);
         this.flyAnim.setFrameDuration(1,0.075);
         this.flyAnim.setFrameDuration(2,0.075);
         this.flyAnim.touchable = false;
         this.flyAnim.x = this.flyAnim.y = 0;
         this.flyAnim.loop = true;
         Utils.juggler.add(this.flyAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crowEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initShootAnim() : void
      {
         this.shootAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crowEnemyShootAnim_"));
         this.shootAnim.setFrameDuration(0,0.5);
         this.shootAnim.touchable = false;
         this.shootAnim.x = this.shootAnim.y = 0;
         this.shootAnim.loop = false;
         Utils.juggler.add(this.shootAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crowEnemyHurtAnim_"));
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
