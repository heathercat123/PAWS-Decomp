package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class AnglerFishEnemySprite extends GameSprite
   {
       
      
      protected var swimAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      public function AnglerFishEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initSwimAnim();
         this.initTurnAnim();
         this.initHurtAnim();
         this.initJumpAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.swimAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.jumpAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.swimAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.jumpAnim);
         this.swimAnim.dispose();
         this.turnAnim.dispose();
         this.hurtAnim.dispose();
         this.jumpAnim.dispose();
         this.swimAnim = null;
         this.turnAnim = null;
         this.hurtAnim = null;
         this.jumpAnim = null;
         super.destroy();
      }
      
      protected function initSwimAnim() : void
      {
         this.swimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("anglerFishEnemySwimAnim_"));
         this.swimAnim.setFrameDuration(0,0.1);
         this.swimAnim.setFrameDuration(1,0.2);
         this.swimAnim.setFrameDuration(2,0.2);
         this.swimAnim.setFrameDuration(3,0.1);
         this.swimAnim.setFrameDuration(4,0.2);
         this.swimAnim.setFrameDuration(5,0.2);
         this.swimAnim.touchable = false;
         this.swimAnim.x = this.swimAnim.y = 0;
         this.swimAnim.loop = true;
         Utils.juggler.add(this.swimAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("anglerFishEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("anglerFishEnemyHitAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("anglerFishEnemyJumpAnim_"));
         this.jumpAnim.setFrameDuration(0,0.1);
         this.jumpAnim.setFrameDuration(1,0.1);
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
   }
}
