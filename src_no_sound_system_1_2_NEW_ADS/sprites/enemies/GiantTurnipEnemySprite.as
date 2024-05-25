package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GiantTurnipEnemySprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var spinAnim:GameMovieClip;
      
      public function GiantTurnipEnemySprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.initStandAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initHitAnim();
         this.initHurtAnim();
         if(this.TYPE == 1)
         {
            this.initSpinAnim();
         }
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 28;
         sprite.x = 15;
         sprite.y = 12;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.hurtAnim);
         if(this.TYPE == 1)
         {
            sprite.addChild(this.spinAnim);
         }
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.hurtAnim);
         if(this.TYPE == 1)
         {
            Utils.juggler.remove(this.spinAnim);
         }
         this.standAnim.dispose();
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.hitAnim.dispose();
         this.hurtAnim.dispose();
         if(this.TYPE == 1)
         {
            this.spinAnim.dispose();
         }
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.hitAnim = null;
         this.hurtAnim = null;
         if(this.TYPE == 1)
         {
            this.spinAnim = null;
         }
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantLogEnemyStandAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantTurnipEnemyStandAnim_"));
         }
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantLogEnemyWalkAnim_"));
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantTurnipEnemyWalkAnim_"));
         }
         this.walkAnim.setFrameDuration(0,0.1);
         this.walkAnim.setFrameDuration(1,0.1);
         this.walkAnim.setFrameDuration(2,0.1);
         this.walkAnim.setFrameDuration(3,0.1);
         if(this.TYPE == 1)
         {
            this.walkAnim.setFrameDuration(0,0.075);
            this.walkAnim.setFrameDuration(1,0.075);
            this.walkAnim.setFrameDuration(2,0.075);
            this.walkAnim.setFrameDuration(3,0.075);
         }
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantLogEnemyTurnAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantTurnipEnemyTurnAnim_"));
         }
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
            this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantLogEnemyHitAnim_"));
         }
         else
         {
            this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantTurnipEnemyHitAnim_"));
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
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantLogEnemyHurtAnim_"));
         }
         else
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantTurnipEnemyHurtAnim_"));
         }
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initSpinAnim() : void
      {
         if(this.TYPE == 0)
         {
            return;
         }
         this.spinAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantLogEnemySpinAnim_"));
         this.spinAnim.touchable = false;
         this.spinAnim.x = this.spinAnim.y = 0;
         this.spinAnim.loop = true;
         Utils.juggler.add(this.spinAnim);
      }
   }
}
