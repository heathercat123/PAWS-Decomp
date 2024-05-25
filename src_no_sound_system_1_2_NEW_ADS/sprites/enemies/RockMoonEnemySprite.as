package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class RockMoonEnemySprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var hiddenAnim:GameMovieClip;
      
      protected var hideAnim:GameMovieClip;
      
      public function RockMoonEnemySprite(_type:int)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.initStandAnim();
         this.initTurnAnim();
         this.initWalkAnim();
         this.initHurtAnim();
         this.initHiddenAnim();
         this.initHideAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.hiddenAnim);
         sprite.addChild(this.hideAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.hiddenAnim);
         Utils.juggler.remove(this.hideAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.hiddenAnim.dispose();
         this.hideAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.walkAnim = null;
         this.hurtAnim = null;
         this.hiddenAnim = null;
         this.hideAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockDarkMoonEnemyStandAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceCubeEnemyStandAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockMoonEnemyStandAnim_"));
         }
         if(this.TYPE == 2)
         {
            this.standAnim.setFrameDuration(0,0.5 + Math.random() * 0.5);
            this.standAnim.setFrameDuration(1,0.1);
            this.standAnim.setFrameDuration(2,0.1);
            this.standAnim.setFrameDuration(3,0.1);
         }
         else
         {
            this.standAnim.setFrameDuration(0,0.1);
            this.standAnim.setFrameDuration(1,0.1);
         }
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockDarkMoonEnemyTurnAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceCubeEnemyTurnAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockMoonEnemyTurnAnim_"));
         }
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockDarkMoonEnemyWalkAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceCubeEnemyWalkAnim_"));
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockMoonEnemyWalkAnim_"));
         }
         this.walkAnim.setFrameDuration(0,0.075);
         this.walkAnim.setFrameDuration(1,0.075);
         this.walkAnim.setFrameDuration(2,0.075);
         this.walkAnim.setFrameDuration(3,0.075);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initHurtAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockDarkMoonEnemyHurtAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceCubeEnemyHurtAnim_"));
         }
         else
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockMoonEnemyHurtAnim_"));
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
      
      protected function initHiddenAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hiddenAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockDarkMoonHiddenAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.hiddenAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceCubeEnemyHiddenAnim_"));
         }
         else
         {
            this.hiddenAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockMoonHiddenAnim_"));
         }
         this.hiddenAnim.touchable = false;
         this.hiddenAnim.x = this.hiddenAnim.y = 0;
         this.hiddenAnim.loop = true;
         Utils.juggler.add(this.hiddenAnim);
      }
      
      protected function initHideAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockDarkMoonEnemyHideAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceCubeEnemyUnhideAnim_"));
         }
         else
         {
            this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("rockMoonEnemyHideAnim_"));
         }
         if(this.TYPE == 2)
         {
            this.hideAnim.setFrameDuration(0,0.075);
         }
         else
         {
            this.hideAnim.setFrameDuration(0,0.075);
            this.hideAnim.setFrameDuration(1,0.075);
         }
         this.hideAnim.touchable = false;
         this.hideAnim.x = this.hideAnim.y = 0;
         this.hideAnim.loop = false;
         Utils.juggler.add(this.hideAnim);
      }
   }
}
