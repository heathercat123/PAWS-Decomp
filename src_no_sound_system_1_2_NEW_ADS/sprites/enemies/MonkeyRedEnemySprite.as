package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class MonkeyRedEnemySprite extends GameSprite
   {
       
      
      protected var floatAnim:GameMovieClip;
      
      protected var hurtAnim:GameMovieClip;
      
      protected var color:int;
      
      public function MonkeyRedEnemySprite(_color:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.color = _color;
         this.initFloatAnim();
         this.initHurtAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.floatAnim);
         sprite.addChild(this.hurtAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.floatAnim);
         Utils.juggler.remove(this.hurtAnim);
         this.floatAnim.dispose();
         this.hurtAnim.dispose();
         this.floatAnim = null;
         this.hurtAnim = null;
         super.destroy();
      }
      
      protected function initFloatAnim() : void
      {
         if(this.color == 0)
         {
            this.floatAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyRedEnemyFloatAnim_"));
         }
         else
         {
            this.floatAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyBlueEnemyFloatAnim_"));
         }
         this.floatAnim.touchable = false;
         this.floatAnim.x = this.floatAnim.y = 0;
         this.floatAnim.loop = true;
         Utils.juggler.add(this.floatAnim);
      }
      
      protected function initHurtAnim() : void
      {
         if(this.color == 0)
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyRedEnemyHurtAnim_"));
         }
         else
         {
            this.hurtAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("monkeyBlueEnemyHurtAnim_"));
         }
         this.hurtAnim.touchable = false;
         this.hurtAnim.x = this.hurtAnim.y = 0;
         this.hurtAnim.loop = false;
         Utils.juggler.add(this.hurtAnim);
      }
   }
}
