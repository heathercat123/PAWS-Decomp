package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BigEyeEnemySprite extends GameSprite
   {
       
      
      protected var openAnim:GameMovieClip;
      
      protected var normalAnim:GameMovieClip;
      
      protected var blinkAnim:GameMovieClip;
      
      protected var deadAnim:GameMovieClip;
      
      public function BigEyeEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initOpenAnim();
         this.initNormalAnim();
         this.initBlinkAnim();
         this.initDeadAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 0;
         sprite.x = sprite.y = 0;
         sprite.addChild(this.openAnim);
         sprite.addChild(this.normalAnim);
         sprite.addChild(this.blinkAnim);
         sprite.addChild(this.deadAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.deadAnim);
         Utils.juggler.remove(this.blinkAnim);
         Utils.juggler.remove(this.normalAnim);
         Utils.juggler.remove(this.openAnim);
         this.deadAnim.dispose();
         this.blinkAnim.dispose();
         this.normalAnim.dispose();
         this.openAnim.dispose();
         this.deadAnim = null;
         this.blinkAnim = null;
         this.normalAnim = null;
         this.openAnim = null;
         super.destroy();
      }
      
      protected function initOpenAnim() : void
      {
         this.openAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantEyeBigEyeSpriteAnim_"));
         this.openAnim.setFrameDuration(0,0.2);
         this.openAnim.setFrameDuration(1,0.1);
         this.openAnim.setFrameDuration(2,0.1);
         this.openAnim.setFrameDuration(3,0.1);
         this.openAnim.touchable = false;
         this.openAnim.x = this.openAnim.y = 0;
         this.openAnim.loop = false;
         Utils.juggler.add(this.openAnim);
      }
      
      protected function initNormalAnim() : void
      {
         this.normalAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantEyeBigEyeSpriteAnim_d"));
         this.normalAnim.touchable = false;
         this.normalAnim.x = this.normalAnim.y = 0;
         this.normalAnim.loop = false;
         Utils.juggler.add(this.normalAnim);
      }
      
      protected function initBlinkAnim() : void
      {
         this.blinkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantEyeBigEyeBlinkSpriteAnim_"));
         this.blinkAnim.setFrameDuration(0,0.1);
         this.blinkAnim.setFrameDuration(1,0.1);
         this.blinkAnim.setFrameDuration(2,0.1);
         this.blinkAnim.touchable = false;
         this.blinkAnim.x = this.blinkAnim.y = 0;
         this.blinkAnim.loop = false;
         Utils.juggler.add(this.blinkAnim);
      }
      
      protected function initDeadAnim() : void
      {
         this.deadAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantEyeBigEyeDeadSpriteAnim_"));
         this.deadAnim.touchable = false;
         this.deadAnim.x = this.deadAnim.y = 0;
         this.deadAnim.loop = false;
         Utils.juggler.add(this.deadAnim);
      }
   }
}
