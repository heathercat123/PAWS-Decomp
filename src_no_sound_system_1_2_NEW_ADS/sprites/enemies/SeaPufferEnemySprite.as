package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SeaPufferEnemySprite extends GameSprite
   {
       
      
      protected var swimAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var inflateAnim:GameMovieClip;
      
      protected var deflateAnim:GameMovieClip;
      
      public function SeaPufferEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initSwimAnim();
         this.initTurnAnim();
         this.initHurtAnim();
         this.initInflateAnim();
         this.initDeflateAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.swimAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.inflateAnim);
         sprite.addChild(this.deflateAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.swimAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.inflateAnim);
         Utils.juggler.remove(this.deflateAnim);
         this.swimAnim.dispose();
         this.turnAnim.dispose();
         this.hurtAnim.dispose();
         this.inflateAnim.dispose();
         this.deflateAnim.dispose();
         this.swimAnim = null;
         this.turnAnim = null;
         this.hurtAnim = null;
         this.inflateAnim = null;
         this.deflateAnim = null;
         super.destroy();
      }
      
      protected function initSwimAnim() : void
      {
         this.swimAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaPufferEnemySwimAnim_"));
         this.swimAnim.setFrameDuration(0,0.1);
         this.swimAnim.setFrameDuration(1,0.2);
         this.swimAnim.setFrameDuration(2,0.2);
         this.swimAnim.setFrameDuration(3,0.1);
         this.swimAnim.setFrameDuration(4,0.2);
         this.swimAnim.setFrameDuration(5,0.2);
         this.swimAnim.touchable = false;
         this.swimAnim.x = this.swimAnim.y = 0;
         this.swimAnim.loop = true;
         Utils.juggler.add(this.swimAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaPufferEnemyTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaPufferEnemyHitAnim_"));
         this.hurtAnim.setFrameDuration(0,0.075);
         this.hurtAnim.setFrameDuration(1,0.075);
         this.hurtAnim.setFrameDuration(2,0.075);
         this.hurtAnim.setFrameDuration(3,0.075);
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = true;
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initInflateAnim() : void
      {
         this.inflateAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaPufferEnemyInflateAnim_"));
         this.inflateAnim.setFrameDuration(0,0.075);
         this.inflateAnim.setFrameDuration(1,0.075);
         this.inflateAnim.setFrameDuration(2,0.075);
         this.inflateAnim.touchable = false;
         this.inflateAnim.x = this.inflateAnim.y = -8;
         this.inflateAnim.loop = false;
         Utils.juggler.add(this.inflateAnim);
      }
      
      protected function initDeflateAnim() : void
      {
         this.deflateAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaPufferEnemyDeflateAnim_"));
         this.deflateAnim.setFrameDuration(0,0.075);
         this.deflateAnim.setFrameDuration(1,0.075);
         this.deflateAnim.setFrameDuration(2,0.075);
         this.deflateAnim.touchable = false;
         this.deflateAnim.x = this.deflateAnim.y = -8;
         this.deflateAnim.loop = false;
         Utils.juggler.add(this.deflateAnim);
      }
   }
}
