package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FirePlantEnemySprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var shootStartAnim:GameMovieClip;
      
      protected var shakeAnim:GameMovieClip;
      
      protected var shootAnim:GameMovieClip;
      
      protected var hideAnim:GameMovieClip;
      
      protected var hiddenAnim:GameMovieClip;
      
      protected var unhideAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function FirePlantEnemySprite(_TYPE:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _TYPE;
         this.initStandAnim();
         this.initShootStartAnim();
         this.initShakeAnim();
         this.initShootAnim();
         this.initHideAnim();
         this.initHiddenAnim();
         this.initUnhideAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.shootStartAnim);
         sprite.addChild(this.shakeAnim);
         sprite.addChild(this.shootAnim);
         sprite.addChild(this.hideAnim);
         sprite.addChild(this.hiddenAnim);
         sprite.addChild(this.unhideAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.shootStartAnim);
         Utils.juggler.remove(this.shakeAnim);
         Utils.juggler.remove(this.shootAnim);
         Utils.juggler.remove(this.hideAnim);
         Utils.juggler.remove(this.hiddenAnim);
         Utils.juggler.remove(this.unhideAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.shootStartAnim.dispose();
         this.shakeAnim.dispose();
         this.shootAnim.dispose();
         this.hideAnim.dispose();
         this.hiddenAnim.dispose();
         this.unhideAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.shootStartAnim = null;
         this.shakeAnim = null;
         this.shootAnim = null;
         this.hideAnim = null;
         this.hiddenAnim = null;
         this.unhideAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedPlantEnemyStandAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantEnemyStandAnim_"));
         }
         this.standAnim.setFrameDuration(0,int(Math.random() * 2 + 2));
         this.standAnim.setFrameDuration(1,0.1);
         this.standAnim.setFrameDuration(2,0.1);
         this.standAnim.setFrameDuration(3,0.1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = false;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initShootStartAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.shootStartAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedPlantEnemyShootStartAnim_"));
         }
         else
         {
            this.shootStartAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantEnemyShootStartAnim_"));
         }
         this.shootStartAnim.setFrameDuration(0,0.05);
         this.shootStartAnim.setFrameDuration(1,0.05);
         this.shootStartAnim.setFrameDuration(2,0.05);
         this.shootStartAnim.setFrameDuration(3,0.05);
         this.shootStartAnim.touchable = false;
         this.shootStartAnim.x = this.shootStartAnim.y = 0;
         this.shootStartAnim.loop = false;
         Utils.juggler.add(this.shootStartAnim);
      }
      
      protected function initShakeAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.shakeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedPlantEnemyShakeAnim_"));
         }
         else
         {
            this.shakeAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantEnemyShakeAnim_"));
         }
         this.shakeAnim.setFrameDuration(0,0.05);
         this.shakeAnim.setFrameDuration(1,0.05);
         this.shakeAnim.touchable = false;
         this.shakeAnim.x = this.shakeAnim.y = 0;
         this.shakeAnim.loop = true;
         Utils.juggler.add(this.shakeAnim);
      }
      
      protected function initShootAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.shootAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedPlantEnemyShootAnim_"));
         }
         else
         {
            this.shootAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantEnemyShootAnim_"));
         }
         this.shootAnim.setFrameDuration(0,0.1);
         this.shootAnim.setFrameDuration(1,0.1);
         this.shootAnim.setFrameDuration(2,0.1);
         this.shootAnim.setFrameDuration(3,0.1);
         this.shootAnim.touchable = false;
         this.shootAnim.x = this.shootAnim.y = 0;
         this.shootAnim.loop = false;
         Utils.juggler.add(this.shootAnim);
      }
      
      protected function initHideAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedPlantEnemyHideAnim_"));
         }
         else
         {
            this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantEnemyHideAnim_"));
         }
         this.hideAnim.setFrameDuration(0,0.1);
         this.hideAnim.setFrameDuration(1,0.1);
         this.hideAnim.setFrameDuration(2,0.1);
         this.hideAnim.setFrameDuration(3,0.1);
         this.hideAnim.setFrameDuration(4,0.1);
         this.hideAnim.touchable = false;
         this.hideAnim.x = this.hideAnim.y = 0;
         this.hideAnim.loop = false;
         Utils.juggler.add(this.hideAnim);
      }
      
      protected function initHiddenAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hiddenAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedPlantEnemyHiddenAnim_"));
         }
         else
         {
            this.hiddenAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantEnemyHiddenAnim_"));
         }
         this.hiddenAnim.setFrameDuration(0,1);
         this.hiddenAnim.touchable = false;
         this.hiddenAnim.x = this.hiddenAnim.y = 0;
         this.hiddenAnim.loop = true;
         Utils.juggler.add(this.hiddenAnim);
      }
      
      protected function initUnhideAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.unhideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedPlantEnemyUnhideAnim_"));
         }
         else
         {
            this.unhideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantEnemyUnhideAnim_"));
         }
         this.unhideAnim.setFrameDuration(0,0.1);
         this.unhideAnim.setFrameDuration(1,0.1);
         this.unhideAnim.setFrameDuration(2,0.1);
         this.unhideAnim.setFrameDuration(3,0.1);
         this.unhideAnim.touchable = false;
         this.unhideAnim.x = this.unhideAnim.y = 0;
         this.unhideAnim.loop = false;
         Utils.juggler.add(this.unhideAnim);
      }
      
      protected function initHurtAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seedPlantEnemyHurtAnim_"));
         }
         else
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("firePlantEnemyHurtAnim_"));
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
   }
}
