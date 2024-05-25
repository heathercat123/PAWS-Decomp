package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class WindEggEnemySprite extends GameSprite
   {
       
      
      protected var TYPE:int = 0;
      
      protected var standAnim:GameMovieClip;
      
      protected var walkAnim:GameMovieClip;
      
      protected var turnAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var inhaleAnim:GameMovieClip;
      
      protected var blowAnim:GameMovieClip;
      
      protected var hurtNormalAnim:GameMovieClip;
      
      protected var hurtSpikesAnim:GameMovieClip;
      
      public function WindEggEnemySprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.blowAnim = null;
         this.hurtNormalAnim = null;
         this.hurtSpikesAnim = null;
         if(this.TYPE == 3)
         {
            this.initStandAnim();
            this.initWalkAnim();
            this.initTurnAnim();
            this.initHurtAnim();
            this.initInhaleAnim();
         }
         else
         {
            this.initStandAnim();
            this.initWalkAnim();
            this.initTurnAnim();
            this.initHurtAnim();
            this.initInhaleAnim();
            this.initBlowAnim();
            this.initHurtNormalAnim();
            if(this.TYPE == 1)
            {
               this.initHurtSpikesAnim();
            }
         }
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 20;
         if(this.TYPE == 2)
         {
            sprite.x = 11;
         }
         else
         {
            sprite.x = 12;
         }
         sprite.y = 10;
         sprite.addChild(this.standAnim);
         sprite.addChild(this.walkAnim);
         sprite.addChild(this.turnAnim);
         sprite.addChild(this.hurtAnim);
         sprite.addChild(this.inhaleAnim);
         if(this.blowAnim != null)
         {
            sprite.addChild(this.blowAnim);
         }
         if(this.hurtNormalAnim != null)
         {
            sprite.addChild(this.hurtNormalAnim);
         }
         if(this.hurtSpikesAnim != null)
         {
            sprite.addChild(this.hurtSpikesAnim);
         }
      }
      
      override public function destroy() : void
      {
         if(this.hurtNormalAnim != null)
         {
            Utils.juggler.remove(this.hurtNormalAnim);
            this.hurtNormalAnim.dispose();
            this.hurtNormalAnim = null;
         }
         if(this.hurtSpikesAnim != null)
         {
            Utils.juggler.remove(this.hurtSpikesAnim);
            this.hurtSpikesAnim.dispose();
            this.hurtSpikesAnim = null;
         }
         if(this.blowAnim != null)
         {
            Utils.juggler.remove(this.blowAnim);
            this.blowAnim.dispose();
            this.blowAnim = null;
         }
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.turnAnim);
         Utils.juggler.remove(this.walkAnim);
         Utils.juggler.remove(this.hurtAnim);
         Utils.juggler.remove(this.inhaleAnim);
         this.standAnim.dispose();
         this.turnAnim.dispose();
         this.walkAnim.dispose();
         this.hurtAnim.dispose();
         this.inhaleAnim.dispose();
         this.standAnim = null;
         this.walkAnim = null;
         this.turnAnim = null;
         this.hurtAnim = null;
         this.inhaleAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("windEggEnemyStandAnim_"));
            this.standAnim.setFrameDuration(0,0.2);
            this.standAnim.setFrameDuration(1,0.2);
         }
         else if(this.TYPE == 2)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandHippoEnemyStandAnim_"));
            this.standAnim.setFrameDuration(0,0.2);
            this.standAnim.setFrameDuration(1,0.2);
         }
         else if(this.TYPE == 3)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("octopusEnemyStandAnim_"));
            this.standAnim.setFrameDuration(0,0.075);
            this.standAnim.setFrameDuration(1,0.075);
            this.standAnim.setFrameDuration(2,0.2);
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cactusEnemyWalkAnim_"));
            this.standAnim.setFrameDuration(0,0.2);
            this.standAnim.setFrameDuration(1,0.1);
            this.standAnim.setFrameDuration(2,0.2);
            this.standAnim.setFrameDuration(3,0.1);
         }
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         if(this.TYPE == 3)
         {
            this.standAnim.loop = false;
         }
         else
         {
            this.standAnim.loop = true;
         }
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initWalkAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("windEggEnemyWalkAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandHippoEnemyWalkAnim_"));
         }
         else if(this.TYPE == 3)
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("octopusEnemyWalkAnim_"));
         }
         else
         {
            this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cactusEnemyWalkSpikeAnim_"));
         }
         if(this.TYPE == 0 || this.TYPE == 1)
         {
            this.walkAnim.setFrameDuration(0,0.2);
            this.walkAnim.setFrameDuration(1,0.1);
            this.walkAnim.setFrameDuration(2,0.2);
            this.walkAnim.setFrameDuration(3,0.1);
         }
         else if(this.TYPE == 3)
         {
            this.walkAnim.setFrameDuration(0,0.2);
            this.walkAnim.setFrameDuration(1,0.2);
            this.walkAnim.setFrameDuration(2,0.05);
            this.walkAnim.setFrameDuration(3,0.2);
         }
         else if(this.TYPE == 2)
         {
            this.walkAnim.setFrameDuration(0,0.1);
            this.walkAnim.setFrameDuration(1,0.1);
         }
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
      
      protected function initTurnAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("windEggEnemyTurnAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandHippoEnemyTurnAnim_"));
         }
         else if(this.TYPE == 3)
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("octopusEnemyTurnAnim_"));
         }
         else
         {
            this.turnAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cactusEnemyTurnAnim_a"));
         }
         this.turnAnim.setFrameDuration(0,0.1);
         this.turnAnim.touchable = false;
         this.turnAnim.x = this.turnAnim.y = 0;
         this.turnAnim.loop = false;
         Utils.juggler.add(this.turnAnim);
      }
      
      protected function initHurtAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("windEggEnemyHurtAnim_"));
            this.hurtAnim.setFrameDuration(0,0.075);
            this.hurtAnim.setFrameDuration(1,0.075);
            this.hurtAnim.setFrameDuration(2,0.075);
            this.hurtAnim.setFrameDuration(3,0.075);
         }
         else if(this.TYPE == 2)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("sandHippoEnemyHitAnim_"));
            this.hurtAnim.setFrameDuration(0,0.075);
            this.hurtAnim.setFrameDuration(1,0.075);
            this.hurtAnim.setFrameDuration(2,0.075);
            this.hurtAnim.setFrameDuration(3,0.075);
         }
         else if(this.TYPE == 3)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("octopusEnemyHurtAnim_"));
            this.hurtAnim.setFrameDuration(0,0.075);
            this.hurtAnim.setFrameDuration(1,0.075);
            this.hurtAnim.setFrameDuration(2,0.075);
            this.hurtAnim.setFrameDuration(3,0.075);
         }
         else
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cactusEnemyTurnSpikeAnim_a"));
            this.hurtAnim.setFrameDuration(0,0.1);
         }
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         if(this.TYPE == 1)
         {
            this.hurtAnim.loop = false;
         }
         else
         {
            this.hurtAnim.loop = true;
         }
         Utils.juggler.add(this.hurtAnim);
      }
      
      protected function initInhaleAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.inhaleAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("windEggEnemyInhaleAnim_a"));
            this.inhaleAnim.setFrameDuration(0,0.2);
         }
         else if(this.TYPE == 3)
         {
            this.inhaleAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("octopusEnemyAttackAnim_a"));
            this.inhaleAnim.setFrameDuration(0,0.2);
         }
         else
         {
            this.inhaleAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cactusEnemySpikesInAnim_"));
            this.inhaleAnim.setFrameDuration(0,0.1);
            this.inhaleAnim.setFrameDuration(1,0.1);
            this.inhaleAnim.setFrameDuration(2,0.3);
         }
         this.inhaleAnim.touchable = false;
         this.inhaleAnim.x = this.inhaleAnim.y = 0;
         this.inhaleAnim.loop = false;
         Utils.juggler.add(this.inhaleAnim);
      }
      
      protected function initBlowAnim() : void
      {
         if(this.TYPE == 0)
         {
            this.blowAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("windEggEnemyBlowAnim_"));
            this.blowAnim.setFrameDuration(0,0.05);
            this.blowAnim.setFrameDuration(1,0.05);
         }
         else
         {
            this.blowAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cactusEnemySpikesOutAnim_"));
            this.blowAnim.setFrameDuration(0,0.1);
            this.blowAnim.setFrameDuration(1,0.1);
            this.blowAnim.setFrameDuration(2,0.3);
         }
         this.blowAnim.touchable = false;
         this.blowAnim.x = this.blowAnim.y = 0;
         if(this.TYPE == 0)
         {
            this.blowAnim.loop = true;
         }
         else
         {
            this.blowAnim.loop = false;
         }
         Utils.juggler.add(this.blowAnim);
      }
      
      protected function initHurtNormalAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.hurtNormalAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cactusEnemyHurtAnim_"));
            this.hurtNormalAnim.setFrameDuration(0,0.075);
            this.hurtNormalAnim.setFrameDuration(1,0.075);
            this.hurtNormalAnim.setFrameDuration(2,0.075);
            this.hurtNormalAnim.setFrameDuration(3,0.075);
         }
         else
         {
            this.hurtNormalAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("windEggEnemyJumpAnim_"));
         }
         this.hurtNormalAnim.touchable = false;
         this.hurtNormalAnim.x = this.hurtNormalAnim.y = 0;
         this.hurtNormalAnim.loop = true;
         Utils.juggler.add(this.hurtNormalAnim);
      }
      
      protected function initHurtSpikesAnim() : void
      {
         this.hurtSpikesAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("cactusEnemyHurtSpikeAnim_"));
         this.hurtSpikesAnim.setFrameDuration(0,0.075);
         this.hurtSpikesAnim.setFrameDuration(1,0.075);
         this.hurtSpikesAnim.setFrameDuration(2,0.075);
         this.hurtSpikesAnim.setFrameDuration(3,0.075);
         this.hurtSpikesAnim.touchable = false;
         this.hurtSpikesAnim.x = this.hurtSpikesAnim.y = 0;
         this.hurtSpikesAnim.loop = true;
         Utils.juggler.add(this.hurtSpikesAnim);
      }
   }
}
