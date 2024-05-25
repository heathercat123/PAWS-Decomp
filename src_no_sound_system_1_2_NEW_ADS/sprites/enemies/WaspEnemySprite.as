package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class WaspEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var attackAnim:GameMovieClip;
      
      public function WaspEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initTurnAnim();
         this.initHurtAnim();
         this.initAttackAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = sprite.y = 0;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.attackAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.attackAnim);
         this.hurtAnim.dispose();
         this.turnAnim.dispose();
         this.standAnim.dispose();
         this.attackAnim.dispose();
         this.hurtAnim = null;
         this.turnAnim = null;
         this.standAnim = null;
         this.attackAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waspEnemyStandAnim_"));
         this.standAnim.setFrameDuration(0,0.05);
         this.standAnim.setFrameDuration(1,0.05);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waspEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waspEnemyHitAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initAttackAnim() : void
      {
         this.attackAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("waspEnemyAttackAnim_"));
         this.attackAnim.setFrameDuration(0,0.05);
         this.attackAnim.setFrameDuration(1,0.05);
         this.attackAnim.touchable = false;
         this.attackAnim.x = this.attackAnim.y = 0;
         this.attackAnim.loop = true;
         Utils.juggler.add(this.attackAnim);
      }
   }
}
