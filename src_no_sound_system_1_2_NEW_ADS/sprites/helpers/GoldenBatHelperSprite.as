package sprites.helpers
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GoldenBatHelperSprite extends GameSprite
   {
       
      
      protected var LEVEL:int;
      
      protected var flyAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var eggAnim:GameMovieClip;
      
      public function GoldenBatHelperSprite(_level:int = 1)
      {
         var sprite:GameSprite = null;
         super();
         this.LEVEL = _level;
         if(this.LEVEL <= 0)
         {
            this.LEVEL = 1;
         }
         this.initFlyAnim();
         this.initTurnAnim();
         this.initEggAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = sprite.y = 0;
         sprite.addChild(this.flyAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.eggAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.eggAnim);
         this.eggAnim.dispose();
         this.eggAnim = null;
         Utils.juggler.remove(this.flyAnim);
         Utils.juggler.remove(this.turnAnim);
         this.flyAnim.dispose();
         this.turnAnim.dispose();
         this.flyAnim = null;
         this.turnAnim = null;
         super.destroy();
      }
      
      protected function initFlyAnim() : void
      {
         this.flyAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("goldenBatHelper" + this.LEVEL + "StandAnim_"));
         this.flyAnim.setFrameDuration(0,0.1);
         this.flyAnim.setFrameDuration(1,0.1);
         this.flyAnim.setFrameDuration(2,0.1);
         this.flyAnim.touchable = false;
         this.flyAnim.x = this.flyAnim.y = 0;
         this.flyAnim.loop = true;
         Utils.juggler.add(this.flyAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("goldenBatHelper" + this.LEVEL + "TurnAnim_"));
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initEggAnim() : void
      {
         this.eggAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("eggHelperStandAnim_"));
         this.eggAnim.setFrameDuration(0,0.2);
         this.eggAnim.setFrameDuration(1,0.1);
         this.eggAnim.setFrameDuration(2,0.2);
         this.eggAnim.setFrameDuration(3,0.1);
         this.eggAnim.touchable = false;
         this.eggAnim.x = this.eggAnim.y = 0;
         this.eggAnim.loop = true;
         Utils.juggler.add(this.eggAnim);
      }
   }
}
