package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FishBossEnemySprite extends GameSprite
   {
       
      
      public var standAnim:GameMovieClip;
      
      public var TYPE:int;
      
      public function FishBossEnemySprite(_type:int = 0)
      {
         var sprite:GameSprite = null;
         super();
         this.TYPE = _type;
         this.initStandAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = 0;
         sprite.pivotY = 0;
         sprite.x = 0;
         sprite.y = 0;
         sprite.addChild(this.standAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnim);
         this.standAnim.dispose();
         this.standAnim = null;
         super.destroy();
      }
      
      protected function initStandAnim() : void
      {
         if(this.TYPE == 1)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bossFishMouthSpriteAnim_"),16);
            this.standAnim.setFrameDuration(0,0.2);
            this.standAnim.setFrameDuration(1,0.2);
            this.standAnim.loop = true;
            this.standAnim.x = 0;
            this.standAnim.y = -12;
         }
         else if(this.TYPE == 2)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bossFishFinSpriteAnim_a"),16);
         }
         else if(this.TYPE == 3)
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bossFishTailSpriteAnim_"),16);
            this.standAnim.setFrameDuration(0,0.05);
            this.standAnim.setFrameDuration(1,0.1);
            this.standAnim.setFrameDuration(2,0.15);
            this.standAnim.setFrameDuration(3,0.1);
            this.standAnim.setFrameDuration(4,0.05);
            this.standAnim.setFrameDuration(5,0.1);
            this.standAnim.setFrameDuration(6,0.15);
            this.standAnim.setFrameDuration(7,0.1);
            this.standAnim.loop = true;
            this.standAnim.x = 0;
            this.standAnim.y = -12;
         }
         else
         {
            this.standAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bossFishBodySpriteAnim_a"),16);
            this.standAnim.x = this.standAnim.y = 0;
         }
         this.standAnim.touchable = false;
         Utils.juggler.add(this.standAnim);
      }
   }
}
