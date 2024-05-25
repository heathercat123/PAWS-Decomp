package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DustEnemySprite extends GameSprite
   {
       
      
      protected var floatAnim:GameMovieClip;
      
      public function DustEnemySprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initFloatAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 16;
         sprite.x = 8;
         sprite.y = 4;
         sprite.addChild(this.floatAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.floatAnim);
         this.floatAnim.dispose();
         this.floatAnim = null;
         super.destroy();
      }
      
      protected function initFloatAnim() : void
      {
         this.floatAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("dustEnemyFloatAnim_"));
         this.floatAnim.setFrameDuration(0,Math.random() * 0.5);
         this.floatAnim.setFrameDuration(1,0.5);
         this.floatAnim.touchable = false;
         this.floatAnim.x = this.floatAnim.y = 0;
         this.floatAnim.loop = false;
         Utils.juggler.add(this.floatAnim);
      }
   }
}
