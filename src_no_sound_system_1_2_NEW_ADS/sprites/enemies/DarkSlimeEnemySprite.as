package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DarkSlimeEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var submergeAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var emergeAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function DarkSlimeEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initSubmergeAnim();
         this.initWalkAnim();
         this.initEmergeAnim();
         this.initTurnAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.submergeAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.emergeAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.submergeAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.emergeAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.submergeAnim.dispose();
         this.walkAnim.dispose();
         this.emergeAnim.dispose();
         this.turnAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.submergeAnim = null;
         this.walkAnim = null;
         this.emergeAnim = null;
         this.turnAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkSlimeEnemyStandAnim_"));
         this.standAnim.setFrameDuration(0,0.2);
         this.standAnim.setFrameDuration(1,0.2);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initSubmergeAnim() : void
      {
         this.submergeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkSlimeEnemySubmergeAnim_"));
         this.submergeAnim.setFrameDuration(0,0.1);
         this.submergeAnim.setFrameDuration(1,0.1);
         this.submergeAnim.setFrameDuration(2,0.1);
         this.submergeAnim.touchable = false;
         this.submergeAnim.x = this.submergeAnim.y = 0;
         this.submergeAnim.loop = false;
         Utils.juggler.add(this.submergeAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkSlimeEnemyWalkAnim_"));
         this.walkAnim.setFrameDuration(0,0.1);
         this.walkAnim.setFrameDuration(1,0.1);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initEmergeAnim() : void
      {
         this.emergeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkSlimeEnemyEmergeAnim_"));
         this.emergeAnim.setFrameDuration(0,0.1);
         this.emergeAnim.setFrameDuration(1,0.1);
         this.emergeAnim.setFrameDuration(2,0.1);
         this.emergeAnim.touchable = false;
         this.emergeAnim.x = this.emergeAnim.y = 0;
         this.emergeAnim.loop = false;
         Utils.juggler.add(this.emergeAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkSlimeEnemyTurnAnim_"));
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("darkSlimeEnemyHitAnim_"));
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = false;
         Utils.juggler.add(this.hurtAnim);
      }
   }
}
