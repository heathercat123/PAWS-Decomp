package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CanyonMoleSprite extends GameSprite
   {
       
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var scaredAnim:GameMovieClip;
      
      protected var hideAnim:GameMovieClip;
      
      protected var hiddenAnim:GameMovieClip;
      
      protected var unhideAnim:GameMovieClip;
      
      protected var peakAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function CanyonMoleSprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initTurnAnim();
         this.initScaredAnim();
         this.initHideAnim();
         this.initHiddenAnim();
         this.initUnhideAnim();
         this.initPeakAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.scaredAnim);
         sprite.addChild(this.hideAnim);
         sprite.addChild(this.hiddenAnim);
         sprite.addChild(this.unhideAnim);
         sprite.addChild(this.peakAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.scaredAnim);
         Utils.juggler.remove(this.hideAnim);
         Utils.juggler.remove(this.hiddenAnim);
         Utils.juggler.remove(this.unhideAnim);
         Utils.juggler.remove(this.peakAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.scaredAnim.dispose();
         this.hideAnim.dispose();
         this.hiddenAnim.dispose();
         this.unhideAnim.dispose();
         this.peakAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.scaredAnim = null;
         this.hideAnim = null;
         this.hiddenAnim = null;
         this.unhideAnim = null;
         this.peakAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonMoleStandAnim_"));
         this.standAnim.setFrameDuration(0,1);
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
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonMoleTurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initScaredAnim() : void
      {
         this.scaredAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonMoleScaredAnim_"));
         this.scaredAnim.setFrameDuration(0,0.2);
         this.scaredAnim.touchable = false;
         this.scaredAnim.x = this.scaredAnim.y = 0;
         this.scaredAnim.loop = false;
         Utils.juggler.add(this.scaredAnim);
      }
      
      protected function initHideAnim() : void
      {
         this.hideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonMoleHideAnim_"));
         this.hideAnim.setFrameDuration(0,0.1);
         this.hideAnim.setFrameDuration(1,0.1);
         this.hideAnim.setFrameDuration(2,0.1);
         this.hideAnim.touchable = false;
         this.hideAnim.x = this.hideAnim.y = 0;
         this.hideAnim.loop = false;
         Utils.juggler.add(this.hideAnim);
      }
      
      protected function initHiddenAnim() : void
      {
         this.hiddenAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonMoleHideAnim_d"));
         this.hiddenAnim.touchable = false;
         this.hiddenAnim.x = this.hiddenAnim.y = 0;
         this.hiddenAnim.loop = false;
         Utils.juggler.add(this.hiddenAnim);
      }
      
      protected function initUnhideAnim() : void
      {
         this.unhideAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonMoleUnhideAnim_"));
         this.unhideAnim.setFrameDuration(0,0.1);
         this.unhideAnim.touchable = false;
         this.unhideAnim.x = this.unhideAnim.y = 0;
         this.unhideAnim.loop = false;
         Utils.juggler.add(this.unhideAnim);
      }
      
      protected function initPeakAnim() : void
      {
         this.peakAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonMolePeakAnim_"));
         this.peakAnim.touchable = false;
         this.peakAnim.x = this.peakAnim.y = 0;
         this.peakAnim.loop = false;
         Utils.juggler.add(this.peakAnim);
      }
      
      protected function initHurtAnim() : void
      {
         this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("canyonMoleHitAnim_"));
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
