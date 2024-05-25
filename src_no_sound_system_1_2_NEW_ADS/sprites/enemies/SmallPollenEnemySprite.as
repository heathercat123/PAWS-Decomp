package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SmallPollenEnemySprite extends GameSprite
   {
       
      
      protected var sleepAnim:GameMovieClip;
      
      protected var hitAnim:GameMovieClip;
      
      protected var floatAnim:GameMovieClip;
      
      public function SmallPollenEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initSleepAnim();
         this.initHitAnim();
         this.initFloatAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.sleepAnim);
         sprite.addChild(this.hitAnim);
         sprite.addChild(this.floatAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.sleepAnim);
         Utils.juggler.remove(this.hitAnim);
         Utils.juggler.remove(this.floatAnim);
         this.sleepAnim.dispose();
         this.hitAnim.dispose();
         this.floatAnim.dispose();
         this.sleepAnim = null;
         this.hitAnim = null;
         this.floatAnim = null;
         super.destroy();
      }
      
      protected function initSleepAnim() : void
      {
         this.sleepAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallPollenEnemySleepAnim_"));
         this.sleepAnim.setFrameDuration(0,1);
         this.sleepAnim.setFrameDuration(1,0.5);
         this.sleepAnim.touchable = false;
         this.sleepAnim.x = this.sleepAnim.y = 0;
         this.sleepAnim.loop = false;
         Utils.juggler.add(this.sleepAnim);
      }
      
      protected function initHitAnim() : void
      {
         this.hitAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallPollenEnemyHurtAnim_"));
         this.hitAnim.setFrameDuration(0,0.075);
         this.hitAnim.setFrameDuration(1,0.075);
         this.hitAnim.setFrameDuration(2,0.075);
         this.hitAnim.setFrameDuration(3,0.075);
         this.hitAnim.touchable = false;
         this.hitAnim.x = this.hitAnim.y = 0;
         this.hitAnim.loop = false;
         Utils.juggler.add(this.hitAnim);
      }
      
      protected function initFloatAnim() : void
      {
         this.floatAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallPollenEnemyFloatAnim_"));
         this.floatAnim.setFrameDuration(0,0.4);
         this.floatAnim.setFrameDuration(1,0.4);
         this.floatAnim.touchable = false;
         this.floatAnim.x = this.floatAnim.y = 0;
         this.floatAnim.loop = true;
         Utils.juggler.add(this.floatAnim);
      }
   }
}
