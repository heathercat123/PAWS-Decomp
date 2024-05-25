package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BirdCollisionSprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var flyAnim:GameMovieClip;
      
      protected var chirpAnim:GameMovieClip;
      
      protected var isBirdA:Boolean;
      
      public function BirdCollisionSprite()
      {
         var sprite:GameSprite = null;
         super();
         this.isBirdA = true;
         this.initStandAnim();
         this.initWalkAnim();
         this.initJumpAnim();
         this.initFlyAnim();
         this.initChirpAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = 12;
         sprite.x = 0;
         sprite.y = -8;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.flyAnim);
         sprite.addChild(this.chirpAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.flyAnim);
         Utils.juggler.remove(this.chirpAnim);
         this.standAnim.dispose();
         this.walkAnim.dispose();
         this.jumpAnim.dispose();
         this.flyAnim.dispose();
         this.chirpAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.jumpAnim = null;
         this.flyAnim = null;
         this.chirpAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.isBirdA)
         {
            if(Utils.IS_SEASONAL)
            {
               this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionWinterSpriteAStandAnim_"),12);
            }
            else
            {
               this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionSpriteAStandAnim_"),12);
            }
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionSpriteBStandAnim_"),12);
         }
         this.standAnim.setFrameDuration(0,Math.random() * 3 + 1);
         this.standAnim.setFrameDuration(1,0.15);
         this.standAnim.setFrameDuration(2,0.15);
         this.standAnim.setFrameDuration(3,0.15);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.isBirdA)
         {
            if(Utils.IS_SEASONAL)
            {
               this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionWinterSpriteAWalkAnim_"),16);
            }
            else
            {
               this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionSpriteAWalkAnim_"),16);
            }
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionSpriteBWalkAnim_"),16);
         }
         this.walkAnim.setFrameDuration(0,0.1);
         this.walkAnim.setFrameDuration(1,0.1);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initJumpAnim() : void
      {
         if(this.isBirdA)
         {
            if(Utils.IS_SEASONAL)
            {
               this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionWinterSpriteAJumpAnim_"),16);
            }
            else
            {
               this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionSpriteAJumpAnim_"),16);
            }
         }
         else
         {
            this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionSpriteBJumpAnim_"),16);
         }
         this.jumpAnim.setFrameDuration(0,0.15);
         this.jumpAnim.setFrameDuration(1,0.15);
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initFlyAnim() : void
      {
         if(this.isBirdA)
         {
            if(Utils.IS_SEASONAL)
            {
               this.flyAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionWinterSpriteAFlyAnim_"),16);
            }
            else
            {
               this.flyAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionSpriteAFlyAnim_"),16);
            }
         }
         else
         {
            this.flyAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionSpriteBFlyAnim_"),16);
         }
         this.flyAnim.setFrameDuration(0,0.1);
         this.flyAnim.setFrameDuration(1,0.1);
         this.flyAnim.touchable = false;
         this.flyAnim.x = this.flyAnim.y = 0;
         this.flyAnim.loop = true;
         Utils.juggler.add(this.flyAnim);
      }
      
      protected function initChirpAnim() : void
      {
         this.chirpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("birdCollisionSpriteAChirpAnim_"),16);
         this.chirpAnim.setFrameDuration(0,0.3);
         this.chirpAnim.setFrameDuration(1,0.15);
         this.chirpAnim.setFrameDuration(2,0.15);
         this.chirpAnim.setFrameDuration(3,0.15);
         this.chirpAnim.touchable = false;
         this.chirpAnim.x = this.chirpAnim.y = 0;
         this.chirpAnim.loop = false;
         Utils.juggler.add(this.chirpAnim);
      }
   }
}
