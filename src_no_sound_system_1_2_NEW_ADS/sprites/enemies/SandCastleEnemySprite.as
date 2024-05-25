package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SandCastleEnemySprite extends GameSprite
   {
       
      
      protected var isArmed:Boolean;
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var hiddenAnim:GameMovieClip;
      
      protected var unhideAnim:GameMovieClip;
      
      public function SandCastleEnemySprite(_isArmed:Boolean = false)
      {
         var sprite:GameSprite = null;
         super();
         this.isArmed = _isArmed;
         this.initStandAnim();
         this.initTurnAnim();
         this.initWalkAnim();
         this.initHurtAnim();
         this.initHiddenAnim();
         this.initUnhideAnim();
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
         sprite.addChild(this.unhideAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.hiddenAnim);
         Utils.juggler.remove(this.unhideAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.hiddenAnim.dispose();
         this.unhideAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.walkAnim = null;
         this.hurtAnim = null;
         this.hiddenAnim = null;
         this.unhideAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.isArmed)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleEnemyStandArmedAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleEnemyStandAnim_"));
         }
         this.standAnim.setFrameDuration(0,0.5);
         this.standAnim.setFrameDuration(1,0.1);
         this.standAnim.setFrameDuration(2,0.1);
         this.standAnim.setFrameDuration(3,0.1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.isArmed)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleEnemyTurnArmedAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleEnemyTurnAnim_"));
         }
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.isArmed)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleEnemyWalkArmedAnim_"));
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleEnemyWalkAnim_"));
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
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleEnemyHurtAnim_"));
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
         this.hiddenAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleHiddenAnim_"));
         this.hiddenAnim.touchable = false;
         this.hiddenAnim.x = this.hiddenAnim.y = 0;
         this.hiddenAnim.loop = true;
         Utils.juggler.add(this.hiddenAnim);
      }
      
      protected function initUnhideAnim() : void
      {
         if(this.isArmed)
         {
            this.unhideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleEnemyUnhideArmedAnim_"));
         }
         else
         {
            this.unhideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandCastleEnemyUnhideAnim_"));
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
