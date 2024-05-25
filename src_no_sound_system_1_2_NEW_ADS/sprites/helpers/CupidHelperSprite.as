package sprites.helpers
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class CupidHelperSprite extends GameSprite
   {
       
      
      protected var LEVEL:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var attackAnim:GameMovieClip;
      
      protected var eggAnim:GameMovieClip;
      
      public function CupidHelperSprite(_level:int = 1)
      {
         var sprite:GameSprite = null;
         super();
         this.LEVEL = _level;
         if(this.LEVEL <= 0)
         {
            this.LEVEL = 1;
         }
         this.initStandAnim();
         this.initTurnAnim();
         this.initAttackAnim();
         this.initEggAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = sprite.y = 0;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.attackAnim);
         sprite.addChild(this.eggAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.eggAnim);
         this.eggAnim.dispose();
         this.eggAnim = null;
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.attackAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.attackAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.attackAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cupidHelper" + this.LEVEL + "StandAnim_"));
         this.standAnim.setFrameDuration(0,0.2);
         this.standAnim.setFrameDuration(1,0.2);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cupidHelper" + this.LEVEL + "TurnAnim_"));
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initAttackAnim() : void
      {
         this.attackAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cupidHelper" + this.LEVEL + "AttackAnim_a"));
         this.attackAnim.setFrameDuration(0,0.2);
         this.attackAnim.touchable = false;
         this.attackAnim.x = -12;
         this.attackAnim.y = 0;
         this.attackAnim.loop = false;
         Utils.juggler.add(this.attackAnim);
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
