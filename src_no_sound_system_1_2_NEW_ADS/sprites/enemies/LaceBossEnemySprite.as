package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class LaceBossEnemySprite extends GameSprite
   {
       
      
      public var standAnim:GameMovieClip;
      
      public var turnAnim:GameMovieClip;
      
      public var backAnim:GameMovieClip;
      
      public function LaceBossEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initStandAnim();
         this.initTurnAnim();
         this.initBackAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = 24;
         sprite.x = 8;
         sprite.y = -28;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.backAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.backAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.backAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.backAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("laceNpcStandAnim_"),16);
         this.standAnim.setFrameDuration(0,1);
         this.standAnim.setFrameDuration(1,1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("laceNpcTurnAnim_"),16);
         this.turnAnim.setFrameDuration(0,0.2);
         this.turnAnim.touchable = true;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = true;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initBackAnim() : void
      {
         this.backAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("laceNpcBackAnim_"),16);
         this.backAnim.setFrameDuration(0,0.2);
         this.backAnim.touchable = true;
         this.backAnim.x = this.backAnim.y = 0;
         this.backAnim.loop = true;
         Utils.juggler.add(this.backAnim);
      }
   }
}
