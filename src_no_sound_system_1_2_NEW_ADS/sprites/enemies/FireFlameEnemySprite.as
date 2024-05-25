package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FireFlameEnemySprite extends GameSprite
   {
       
      
      protected var walkAnim:GameMovieClip;
      
      protected var rotateAnim:GameMovieClip;
      
      protected var rotateFrontAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      public function FireFlameEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initWalkAnim();
         this.initRotateAnim();
         this.initRotateFrontAnim();
         this.initHitAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = sprite.y = 8;
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.rotateAnim);
         sprite.addChild(this.rotateFrontAnim);
         sprite.addChild(this.hitAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.rotateAnim);
         Utils.juggler.remove(this.rotateFrontAnim);
         Utils.juggler.remove(this.hitAnim);
         this.walkAnim.dispose();
         this.rotateAnim.dispose();
         this.rotateFrontAnim.dispose();
         this.hitAnim.dispose();
         this.walkAnim = null;
         this.rotateAnim = null;
         this.rotateFrontAnim = null;
         this.hitAnim = null;
         super.destroy();
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireFlameEnemyWalkAnim_"),16);
         this.walkAnim.setFrameDuration(0,0.1);
         this.walkAnim.setFrameDuration(1,0.1);
         this.walkAnim.setFrameDuration(2,0.05);
         this.walkAnim.setFrameDuration(3,0.1);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initRotateAnim() : void
      {
         this.rotateAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireFlameEnemyRotateAnim_"),16);
         this.rotateAnim.touchable = false;
         this.rotateAnim.x = this.rotateAnim.y = 0;
         this.rotateAnim.loop = false;
         Utils.juggler.add(this.rotateAnim);
      }
      
      protected function initRotateFrontAnim() : void
      {
         this.rotateFrontAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireFlameEnemyRotateFrontAnim_"),16);
         this.rotateFrontAnim.touchable = false;
         this.rotateFrontAnim.x = this.rotateFrontAnim.y = 0;
         this.rotateFrontAnim.loop = false;
         Utils.juggler.add(this.rotateFrontAnim);
      }
      
      protected function initHitAnim() : void
      {
         this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireFlameEnemyHurtAnim_"),16);
         this.hitAnim.setFrameDuration(0,0.075);
         this.hitAnim.setFrameDuration(1,0.075);
         this.hitAnim.setFrameDuration(2,0.075);
         this.hitAnim.setFrameDuration(3,0.075);
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = true;
         Utils.juggler.add(this.hitAnim);
      }
   }
}
