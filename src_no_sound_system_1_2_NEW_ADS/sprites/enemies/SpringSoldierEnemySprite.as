package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SpringSoldierEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var jumpAnim:GameMovieClip;
      
      protected var groundAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function SpringSoldierEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initTurnAnim();
         this.initJumpAnim();
         this.initGroundAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.jumpAnim);
         sprite.addChild(this.groundAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.jumpAnim);
         Utils.juggler.remove(this.groundAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.jumpAnim.dispose();
         this.groundAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.jumpAnim = null;
         this.groundAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("springSoldierStandAnim_"));
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("springSoldierTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initJumpAnim() : void
      {
         this.jumpAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("springSoldierJumpAnim_"));
         this.jumpAnim.touchable = false;
         this.jumpAnim.x = this.jumpAnim.y = 0;
         this.jumpAnim.loop = true;
         Utils.juggler.add(this.jumpAnim);
      }
      
      protected function initGroundAnim() : void
      {
         this.groundAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("springSoldierGroundAnim_"));
         this.groundAnim.setFrameDuration(0,0.1);
         this.groundAnim.touchable = false;
         this.groundAnim.x = this.groundAnim.y = 0;
         this.groundAnim.loop = false;
         Utils.juggler.add(this.groundAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("springSoldierHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
   }
}
