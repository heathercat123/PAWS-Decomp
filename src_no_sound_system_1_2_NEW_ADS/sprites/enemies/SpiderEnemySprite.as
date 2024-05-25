package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SpiderEnemySprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var moveAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function SpiderEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initMoveAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = sprite.y = 0;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.moveAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.moveAnim);
         Utils.juggler.remove(this.standAnim);
         this.hurtAnim.dispose();
         this.moveAnim.dispose();
         this.standAnim.dispose();
         this.hurtAnim = null;
         this.moveAnim = null;
         this.standAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spiderEnemyStandAnim_"));
         this.standAnim.setFrameDuration(0,int(Math.random() * 2 + 1));
         this.standAnim.setFrameDuration(1,0.1);
         this.standAnim.setFrameDuration(2,0.1);
         this.standAnim.setFrameDuration(3,0.1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initMoveAnim() : void
      {
         this.moveAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spiderEnemyMoveAnim_"));
         this.moveAnim.setFrameDuration(0,0.2);
         this.moveAnim.setFrameDuration(1,0.2);
         this.moveAnim.touchable = false;
         this.moveAnim.x = this.moveAnim.y = 0;
         this.moveAnim.loop = true;
         Utils.juggler.add(this.moveAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spiderEnemyHurtAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = false;
         Utils.juggler.add(this.hurtAnim);
      }
   }
}
