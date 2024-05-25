package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CaveBeetleEnemySprite extends GameSprite
   {
       
      
      protected var walkAnim:GameMovieClip;
      
      protected var rotateAnim:GameMovieClip;
      
      protected var rotateFrontAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var hideAnim:GameMovieClip;
      
      protected var unhideAnim:GameMovieClip;
      
      public function CaveBeetleEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initWalkAnim();
         this.initRotateAnim();
         this.initRotateFrontAnim();
         this.initHitAnim();
         this.initHideAnim();
         this.initUnhideAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = sprite.y = 8;
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.rotateAnim);
         sprite.addChild(this.rotateFrontAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.hideAnim);
         sprite.addChild(this.unhideAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.rotateAnim);
         Utils.juggler.remove(this.rotateFrontAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.hideAnim);
         Utils.juggler.remove(this.unhideAnim);
         this.walkAnim.dispose();
         this.rotateAnim.dispose();
         this.rotateFrontAnim.dispose();
         this.hitAnim.dispose();
         this.hideAnim.dispose();
         this.unhideAnim.dispose();
         this.walkAnim = null;
         this.rotateAnim = null;
         this.rotateFrontAnim = null;
         this.hitAnim = null;
         this.hideAnim = null;
         this.unhideAnim = null;
         super.destroy();
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveBeetleEnemyWalkAnim_"),16);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initRotateAnim() : void
      {
         this.rotateAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveBeetleEnemyRotateAnim_"),16);
         this.rotateAnim.touchable = false;
         this.rotateAnim.x = this.rotateAnim.y = 0;
         this.rotateAnim.loop = false;
         Utils.juggler.add(this.rotateAnim);
      }
      
      protected function initRotateFrontAnim() : void
      {
         this.rotateFrontAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveBeetleEnemyRotateFrontAnim_"),16);
         this.rotateFrontAnim.touchable = false;
         this.rotateFrontAnim.x = this.rotateFrontAnim.y = 0;
         this.rotateFrontAnim.loop = false;
         Utils.juggler.add(this.rotateFrontAnim);
      }
      
      protected function initHitAnim() : void
      {
         this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveBeetleEnemyHitAnim_"),16);
         this.hitAnim.setFrameDuration(0,0.075);
         this.hitAnim.setFrameDuration(1,0.075);
         this.hitAnim.setFrameDuration(2,0.075);
         this.hitAnim.setFrameDuration(3,0.075);
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = true;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initHideAnim() : void
      {
         this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveBeetleEnemyHideAnim_"),16);
         this.hideAnim.setFrameDuration(0,0.1);
         this.hideAnim.setFrameDuration(1,0.1);
         this.hideAnim.setFrameDuration(2,0.1);
         this.hideAnim.setFrameDuration(3,1);
         this.hideAnim.touchable = false;
         this.hideAnim.x = this.hideAnim.y = 0;
         this.hideAnim.loop = false;
         Utils.juggler.add(this.hideAnim);
      }
      
      protected function initUnhideAnim() : void
      {
         this.unhideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("caveBeetleEnemyUnhideAnim_"),16);
         this.unhideAnim.setFrameDuration(0,0.2);
         this.unhideAnim.setFrameDuration(1,0.2);
         this.unhideAnim.setFrameDuration(2,0.2);
         this.unhideAnim.setFrameDuration(3,0.2);
         this.unhideAnim.setFrameDuration(4,0.2);
         this.unhideAnim.touchable = false;
         this.unhideAnim.x = this.unhideAnim.y = 0;
         this.unhideAnim.loop = false;
         Utils.juggler.add(this.unhideAnim);
      }
   }
}
