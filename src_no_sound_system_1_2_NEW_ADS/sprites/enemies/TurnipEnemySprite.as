package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class TurnipEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var hiddenAnim:GameMovieClip;
      
      protected var unhideAnim:GameMovieClip;
      
      public function TurnipEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
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
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("turnipEnemyStandAnim_"));
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
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("turnipEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("turnipEnemyWalkAnim_"));
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
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("turnipEnemyHurtAnim_"));
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
         this.hiddenAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("turnipEnemyHiddenAnim_"));
         this.hiddenAnim.touchable = false;
         this.hiddenAnim.x = this.hiddenAnim.y = 0;
         this.hiddenAnim.loop = true;
         Utils.juggler.add(this.hiddenAnim);
      }
      
      protected function initUnhideAnim() : void
      {
         this.unhideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("turnipEnemyUnhideAnim_"));
         this.unhideAnim.setFrameDuration(0,0.075);
         this.unhideAnim.setFrameDuration(1,0.075);
         this.unhideAnim.touchable = false;
         this.unhideAnim.x = this.unhideAnim.y = 0;
         this.unhideAnim.loop = false;
         Utils.juggler.add(this.unhideAnim);
      }
   }
}
