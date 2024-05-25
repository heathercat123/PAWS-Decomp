package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GiantPollenEnemySprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var sleepAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function GiantPollenEnemySprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.initSleepAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initHitAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 28;
         sprite.x = 15;
         sprite.y = 12;
         sprite.addChild(this.sleepAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.sleepAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.sleepAnim.dispose();
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.hitAnim.dispose();
         this.hurtAnim.dispose();
         this.sleepAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.hitAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initSleepAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.sleepAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantSeaUrchinStandAnim_"));
         }
         else
         {
            this.sleepAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantPollenEnemySleepAnim_"));
         }
         if(this.TYPE == 1)
         {
            this.sleepAnim.setFrameDuration(0,1);
            this.sleepAnim.setFrameDuration(1,1);
         }
         else
         {
            this.sleepAnim.setFrameDuration(0,0.5);
            this.sleepAnim.setFrameDuration(1,0.5);
         }
         this.sleepAnim.touchable = false;
         this.sleepAnim.x = this.sleepAnim.y = 0;
         this.sleepAnim.loop = true;
         Utils.juggler.add(this.sleepAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantPollenEnemyStandAnim_"));
         this.walkAnim.setFrameDuration(0,0.2);
         this.walkAnim.setFrameDuration(1,0.2);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantTurnipEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHitAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantSeaUrchinHitAnim_"));
         }
         else
         {
            this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantPollenEnemyHitAnim_"));
         }
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = false;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initHurtAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantSeaUrchinHurtAnim_"));
         }
         else
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantPollenEnemyHurtAnim_"));
         }
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = 0;
         this.hurtAnim.y = 3;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
   }
}
