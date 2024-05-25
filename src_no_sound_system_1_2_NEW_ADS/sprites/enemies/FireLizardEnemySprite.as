package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FireLizardEnemySprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var aimAnim:GameMovieClip;
      
      protected var tossAnim:GameMovieClip;
      
      public function FireLizardEnemySprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.initStandAnim();
         this.initWalkAnim();
         this.initTurnAnim();
         this.initHitAnim();
         this.initAimAnim();
         this.initTossAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.aimAnim);
         sprite.addChild(this.tossAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.aimAnim);
         Utils.juggler.remove(this.tossAnim);
         this.standAnim.dispose();
         this.walkAnim.dispose();
         this.turnAnim.dispose();
         this.hitAnim.dispose();
         this.aimAnim.dispose();
         this.tossAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.hitAnim = null;
         this.aimAnim = null;
         this.tossAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireDragonEnemyStandAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandHippoEnemyStandAnim_"));
         }
         this.standAnim.setFrameDuration(0,0.2);
         this.standAnim.setFrameDuration(1,0.2);
         this.standAnim.touchable = false;
         if(this.TYPE == 1)
         {
            this.standAnim.x = 0;
            this.standAnim.y = 4;
         }
         else
         {
            this.standAnim.x = this.standAnim.y = 0;
         }
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireDragonEnemyWalkAnim_"));
            this.walkAnim.setFrameDuration(0,0.1);
            this.walkAnim.setFrameDuration(1,0.1);
            this.walkAnim.setFrameDuration(2,0.1);
            this.walkAnim.setFrameDuration(3,0.1);
            this.walkAnim.loop = false;
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandHippoEnemyWalkAnim_"));
            this.walkAnim.setFrameDuration(0,0.075);
            this.walkAnim.setFrameDuration(1,0.075);
            this.walkAnim.loop = true;
         }
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireDragonEnemyTurnAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandHippoEnemyTurnAnim_"));
         }
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHitAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireDragonEnemyHitAnim_"));
         }
         else
         {
            this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandHippoEnemyHitAnim_"));
         }
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = false;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initAimAnim() : void
      {
         this.aimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireDragonEnemyAimAnim_"));
         this.aimAnim.setFrameDuration(0,0.25);
         this.aimAnim.touchable = false;
         this.aimAnim.x = this.aimAnim.y = 0;
         this.aimAnim.loop = false;
         Utils.juggler.add(this.aimAnim);
      }
      
      protected function initTossAnim() : void
      {
         this.tossAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireDragonEnemyTossAnim_"));
         this.tossAnim.setFrameDuration(0,0.1);
         this.tossAnim.touchable = false;
         this.tossAnim.x = this.tossAnim.y = 0;
         this.tossAnim.loop = false;
         Utils.juggler.add(this.tossAnim);
      }
   }
}
