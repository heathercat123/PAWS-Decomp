package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class RedGooEnemySprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var hideAnim:GameMovieClip;
      
      protected var unhideAnim:GameMovieClip;
      
      public function RedGooEnemySprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.initStandAnim();
         this.initTurnAnim();
         this.initWalkAnim();
         this.initHurtAnim();
         this.initHideAnim();
         this.initUnhideAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         if(this.TYPE == 0)
         {
            sprite.y = 4;
         }
         else
         {
            sprite.y = 7;
         }
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.hideAnim);
         sprite.addChild(this.unhideAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.hideAnim);
         Utils.juggler.remove(this.unhideAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.hideAnim.dispose();
         this.unhideAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.walkAnim = null;
         this.hurtAnim = null;
         this.hideAnim = null;
         this.unhideAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redGooEnemyStandAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowGooEnemyStandAnim_"));
         }
         this.standAnim.setFrameDuration(0,0.1);
         this.standAnim.setFrameDuration(1,0.1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redGooEnemyTurnAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowGooEnemyTurnAnim_"));
         }
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redGooEnemyWalkAnim_"));
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowGooEnemyWalkAnim_"));
         }
         this.walkAnim.setFrameDuration(0,0.075);
         this.walkAnim.setFrameDuration(1,0.075);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initHurtAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redGooEnemyHurtAnim_"));
         }
         else
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowGooEnemyHurtAnim_"));
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
      
      protected function initHideAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redGooEnemyHideAnim_"));
         }
         else
         {
            this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowGooEnemyHideAnim_"));
         }
         this.hideAnim.setFrameDuration(0,0.075);
         this.hideAnim.setFrameDuration(1,0.075);
         this.hideAnim.setFrameDuration(2,0.075);
         this.hideAnim.setFrameDuration(3,0.075);
         this.hideAnim.touchable = false;
         this.hideAnim.x = this.hideAnim.y = 0;
         this.hideAnim.loop = false;
         Utils.juggler.add(this.hideAnim);
      }
      
      protected function initUnhideAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.unhideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("redGooEnemyUnhideAnim_"));
         }
         else
         {
            this.unhideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowGooEnemyUnhideAnim_"));
         }
         this.unhideAnim.setFrameDuration(0,0.075);
         this.unhideAnim.setFrameDuration(1,0.075);
         this.unhideAnim.touchable = false;
         this.unhideAnim.x = this.unhideAnim.y = 0;
         this.unhideAnim.loop = false;
         Utils.juggler.add(this.unhideAnim);
      }
   }
}
