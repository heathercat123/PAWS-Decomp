package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GiantWoodBeetleEnemySprite extends GameSprite
   {
       
      
      protected var walkAnim:GameMovieClip;
      
      protected var rotateAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var hideAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function GiantWoodBeetleEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initWalkAnim();
         this.initRotateAnim();
         this.initHitAnim();
         this.initHideAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 28;
         sprite.x = sprite.y = 16;
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.rotateAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.hideAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.rotateAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.hideAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.walkAnim.dispose();
         this.rotateAnim.dispose();
         this.hitAnim.dispose();
         this.hideAnim.dispose();
         this.hurtAnim.dispose();
         this.walkAnim = null;
         this.rotateAnim = null;
         this.hitAnim = null;
         this.hideAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantWoodBeetleEnemyWalkAnim_"),16);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initRotateAnim() : void
      {
         this.rotateAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantWoodBeetleEnemyRotateAnim_"),16);
         this.rotateAnim.touchable = false;
         this.rotateAnim.x = this.rotateAnim.y = 0;
         this.rotateAnim.loop = false;
         Utils.juggler.add(this.rotateAnim);
      }
      
      protected function initHitAnim() : void
      {
         this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantWoodBeetleEnemyHitAnim_"),16);
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = false;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initHideAnim() : void
      {
         this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantWoodBeetleEnemyHideAnim_"),16);
         this.hideAnim.setFrameDuration(0,0.1);
         this.hideAnim.setFrameDuration(1,0.1);
         this.hideAnim.setFrameDuration(2,0.1);
         this.hideAnim.setFrameDuration(3,1);
         this.hideAnim.touchable = false;
         this.hideAnim.x = this.hideAnim.y = 0;
         this.hideAnim.loop = false;
         Utils.juggler.add(this.hideAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantWoodBeetleEnemyHurtAnim_"),16);
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
