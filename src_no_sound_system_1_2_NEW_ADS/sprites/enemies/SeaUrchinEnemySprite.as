package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SeaUrchinEnemySprite extends GameSprite
   {
       
      
      public var TYPE:int;
      
      protected var standAnim:GameMovieClip;
      
      protected var attackAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      public function SeaUrchinEnemySprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.attackAnim = null;
         this.initStandAnim();
         this.initHurtAnim();
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            this.initAttackAnim();
         }
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = 16;
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            sprite.pivotY = 16;
         }
         else
         {
            sprite.pivotY = 21;
         }
         sprite.x = sprite.y = 0;
         sprite.addChild(this.standAnim);
         if(this.attackAnim != null)
         {
            sprite.addChild(this.attackAnim);
         }
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.standAnim.dispose();
         this.hurtAnim.dispose();
         this.standAnim = null;
         this.hurtAnim = null;
         if(this.attackAnim != null)
         {
            Utils.juggler.remove(this.attackAnim);
            this.attackAnim.dispose();
            this.attackAnim = null;
         }
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaAnemoneEnemyStandAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaAnemoneSlopeEnemyStandAnim_"));
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaUrchinEnemyStandAnim_"));
         }
         this.standAnim.setFrameDuration(0,1);
         this.standAnim.setFrameDuration(1,1);
         this.standAnim.touchable = false;
         this.standAnim.x = this.standAnim.y = 0;
         this.standAnim.loop = true;
         Utils.juggler.add(this.standAnim);
      }
      
      protected function initAttackAnim() : void
      {
         if(this.TYPE == 2)
         {
            this.attackAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaAnemoneSlopeEnemyAttackAnim_"));
         }
         else
         {
            this.attackAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaAnemoneEnemyAttackAnim_"));
         }
         this.attackAnim.setFrameDuration(0,0.1);
         this.attackAnim.setFrameDuration(1,0.1);
         this.attackAnim.setFrameDuration(2,0.1);
         this.attackAnim.touchable = false;
         this.attackAnim.x = this.attackAnim.y = 0;
         this.attackAnim.loop = false;
         Utils.juggler.add(this.attackAnim);
      }
      
      protected function initHurtAnim() : void
      {
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaAnemoneEnemyHurtAnim_"));
         }
         else
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("seaUrchinEnemyHurtAnim_"));
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
