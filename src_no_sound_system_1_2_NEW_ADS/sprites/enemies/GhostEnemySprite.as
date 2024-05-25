package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GhostEnemySprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var scaredAnim:GameMovieClip;
      
      protected var turnVaseAnim:GameMovieClip;
      
      protected var walkVaseAnim:GameMovieClip;
      
      public function GhostEnemySprite(_TYPE:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _TYPE;
         this.initStandAnim();
         this.initTurnAnim();
         this.initWalkAnim();
         this.initHurtAnim();
         this.initScaredAnim();
         this.initTurnVaseAnim();
         this.initWalkVaseAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         if(this.TYPE != 1)
         {
            sprite.x = 8;
            sprite.y = 4;
         }
         sprite.addChild(this.standAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.scaredAnim);
         sprite.addChild(this.turnVaseAnim);
         sprite.addChild(this.walkVaseAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.scaredAnim);
         Utils.juggler.remove(this.turnVaseAnim);
         Utils.juggler.remove(this.walkVaseAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.scaredAnim.dispose();
         this.turnVaseAnim.dispose();
         this.walkVaseAnim.dispose();
         this.standAnim = null;
         this.turnAnim = null;
         this.walkAnim = null;
         this.hurtAnim = null;
         this.scaredAnim = null;
         this.turnVaseAnim = null;
         this.walkVaseAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("ghostStandAnim_"));
            this.standAnim.setFrameDuration(0,0.5);
            this.standAnim.setFrameDuration(1,0.5);
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("warlockEnemyWalkAnim_"));
            this.standAnim.setFrameDuration(0,0.1);
            this.standAnim.setFrameDuration(1,0.1);
            this.standAnim.setFrameDuration(2,0.1);
            this.standAnim.setFrameDuration(3,0.1);
         }
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("ghostTurnAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("warlockEnemyTurnAnim_"));
         }
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("ghostWalkAnim_"));
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("warlockEnemyWalkAnim_"));
         }
         this.walkAnim.setFrameDuration(0,0.1);
         this.walkAnim.setFrameDuration(1,0.1);
         this.walkAnim.setFrameDuration(2,0.1);
         this.walkAnim.setFrameDuration(3,0.1);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initHurtAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("ghostHurtAnim_"));
         }
         else
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("warlockEnemyHitAnim_"));
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
      
      protected function initScaredAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.scaredAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("ghostScaredAnim_a"));
            this.scaredAnim.setFrameDuration(0,0.1);
            this.scaredAnim.loop = true;
         }
         else
         {
            this.scaredAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("warlockEnemyAppearAnim_"));
            this.scaredAnim.setFrameDuration(0,0.1);
            this.scaredAnim.setFrameDuration(1,0.1);
            this.scaredAnim.setFrameDuration(2,0.1);
            this.scaredAnim.loop = false;
         }
         this.scaredAnim.touchable = false;
         this.scaredAnim.x = this.scaredAnim.y = 0;
         Utils.juggler.add(this.scaredAnim);
      }
      
      protected function initTurnVaseAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.turnVaseAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("ghostTurnVaseAnim_"));
            this.turnVaseAnim.setFrameDuration(0,0.1);
            this.turnVaseAnim.loop = false;
         }
         else
         {
            this.turnVaseAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("warlockEnemyAttackAnim_"));
            this.turnVaseAnim.setFrameDuration(0,0.075);
            this.turnVaseAnim.setFrameDuration(1,0.075);
            this.turnVaseAnim.loop = true;
         }
         this.turnVaseAnim.touchable = false;
         this.turnVaseAnim.x = this.turnVaseAnim.y = 0;
         Utils.juggler.add(this.turnVaseAnim);
      }
      
      protected function initWalkVaseAnim() : void
      {
         this.walkVaseAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("ghostWalkVaseAnim_"));
         this.walkVaseAnim.setFrameDuration(0,0.1);
         this.walkVaseAnim.setFrameDuration(1,0.1);
         this.walkVaseAnim.setFrameDuration(2,0.1);
         this.walkVaseAnim.setFrameDuration(3,0.1);
         this.walkVaseAnim.touchable = false;
         this.walkVaseAnim.x = this.walkVaseAnim.y = 0;
         this.walkVaseAnim.loop = true;
         Utils.juggler.add(this.walkVaseAnim);
      }
   }
}
