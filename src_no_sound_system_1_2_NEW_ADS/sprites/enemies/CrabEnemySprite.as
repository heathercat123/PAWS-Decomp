package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CrabEnemySprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var walkAnim:GameMovieClip;
      
      protected var rotateAnim:GameMovieClip;
      
      protected var rotateFrontAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var disappearAnim:GameMovieClip;
      
      protected var appearAnim:GameMovieClip;
      
      protected var anim_1:GameMovieClip;
      
      public function CrabEnemySprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.anim_1 = null;
         if(this.TYPE == 1)
         {
            this.initWalkAnim();
            this.initRotateAnim();
            this.initRotateFrontAnim();
            this.initHitAnim();
            this.initDisappearAnim();
            this.initAppearAnim();
            this.initAnim1();
         }
         else
         {
            this.initWalkAnim();
            this.initRotateAnim();
            this.initRotateFrontAnim();
            this.initHitAnim();
            this.initDisappearAnim();
            this.initAppearAnim();
         }
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         if(this.TYPE == 1)
         {
            sprite.pivotX = sprite.pivotY = 28;
            sprite.x = 8;
            sprite.y = 8;
         }
         else
         {
            sprite.pivotX = sprite.pivotY = 16;
            sprite.x = sprite.y = 8;
         }
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.rotateAnim);
         sprite.addChild(this.rotateFrontAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.disappearAnim);
         sprite.addChild(this.appearAnim);
         if(this.TYPE == 1)
         {
            sprite.addChild(this.anim_1);
         }
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.rotateAnim);
         Utils.juggler.remove(this.rotateFrontAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.disappearAnim);
         Utils.juggler.remove(this.appearAnim);
         if(this.anim_1 != null)
         {
            Utils.juggler.remove(this.anim_1);
            this.anim_1.dispose();
            this.anim_1 = null;
         }
         this.walkAnim.dispose();
         this.rotateAnim.dispose();
         this.rotateFrontAnim.dispose();
         this.hitAnim.dispose();
         this.disappearAnim.dispose();
         this.appearAnim.dispose();
         this.walkAnim = null;
         this.rotateAnim = null;
         this.rotateFrontAnim = null;
         this.hitAnim = null;
         this.disappearAnim = null;
         this.appearAnim = null;
         super.destroy();
      }
      
      protected function initWalkAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantCrabEnemyWalkAnim_"),16);
            this.walkAnim.setFrameDuration(0,0.1);
            this.walkAnim.setFrameDuration(1,0.1);
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crabEnemyWalkAnim_"),16);
            this.walkAnim.setFrameDuration(0,0.1);
            this.walkAnim.setFrameDuration(1,0.1);
            this.walkAnim.setFrameDuration(2,0.1);
            this.walkAnim.setFrameDuration(3,0.1);
         }
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initRotateAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.rotateAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantCrabEnemySpikesOutAnim_"),16);
            this.rotateAnim.setFrameDuration(0,0.1);
            this.rotateAnim.setFrameDuration(1,0.1);
            this.rotateAnim.setFrameDuration(2,0.1);
         }
         else
         {
            this.rotateAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crabEnemyRotateAnim_"),16);
            this.rotateAnim.setFrameDuration(0,0.1);
         }
         this.rotateAnim.touchable = false;
         this.rotateAnim.x = this.rotateAnim.y = 0;
         this.rotateAnim.loop = false;
         Utils.juggler.add(this.rotateAnim);
      }
      
      protected function initRotateFrontAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.rotateFrontAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantCrabEnemySpikesInAnim_"),16);
            this.rotateFrontAnim.setFrameDuration(0,0.1);
            this.rotateFrontAnim.setFrameDuration(1,0.1);
            this.rotateFrontAnim.setFrameDuration(2,0.1);
         }
         else
         {
            this.rotateFrontAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crabEnemyRotateFrontAnim_"),16);
            this.rotateFrontAnim.setFrameDuration(0,0.1);
         }
         this.rotateFrontAnim.touchable = false;
         this.rotateFrontAnim.x = this.rotateFrontAnim.y = 0;
         this.rotateFrontAnim.loop = false;
         Utils.juggler.add(this.rotateFrontAnim);
      }
      
      protected function initHitAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantCrabEnemyWalkSpikesAnim_"),16);
            this.hitAnim.setFrameDuration(0,0.1);
            this.hitAnim.setFrameDuration(1,0.1);
         }
         else
         {
            this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crabEnemyHurtAnim_"),16);
            this.hitAnim.setFrameDuration(0,0.075);
            this.hitAnim.setFrameDuration(1,0.075);
            this.hitAnim.setFrameDuration(2,0.075);
            this.hitAnim.setFrameDuration(3,0.075);
         }
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = true;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initDisappearAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.disappearAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantCrabEnemyHitAnim_"));
            this.disappearAnim.setFrameDuration(0,0.1);
         }
         else
         {
            this.disappearAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crabEnemyDisappearAnim_"));
            this.disappearAnim.setFrameDuration(0,0.1);
            this.disappearAnim.setFrameDuration(1,0.1);
            this.disappearAnim.setFrameDuration(2,0.1);
            this.disappearAnim.setFrameDuration(3,0.1);
         }
         this.disappearAnim.touchable = false;
         this.disappearAnim.x = this.disappearAnim.y = 0;
         this.disappearAnim.loop = false;
         Utils.juggler.add(this.disappearAnim);
      }
      
      protected function initAppearAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.appearAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantCrabEnemyHitSpikesAnim_"));
            this.appearAnim.setFrameDuration(0,0.1);
         }
         else
         {
            this.appearAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("crabEnemyAppearAnim_"));
            this.appearAnim.setFrameDuration(0,0.1);
            this.appearAnim.setFrameDuration(1,0.1);
            this.appearAnim.setFrameDuration(2,0.1);
            this.appearAnim.setFrameDuration(3,0.1);
         }
         this.appearAnim.touchable = false;
         this.appearAnim.x = this.appearAnim.y = 0;
         this.appearAnim.loop = false;
         Utils.juggler.add(this.appearAnim);
      }
      
      protected function initAnim1() : void
      {
         this.anim_1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantCrabEnemyHurtAnim_"),16);
         this.anim_1.setFrameDuration(0,0.075);
         this.anim_1.setFrameDuration(1,0.075);
         this.anim_1.setFrameDuration(2,0.075);
         this.anim_1.setFrameDuration(3,0.075);
         this.anim_1.touchable = false;
         this.anim_1.x = this.anim_1.y = 0;
         this.anim_1.loop = true;
         Utils.juggler.add(this.anim_1);
      }
   }
}
