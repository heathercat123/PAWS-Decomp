package sprites.enemies
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GiantWoodBeetleEnemyEyesSprite extends GameSprite
   {
       
      
      protected var walkAnim:GameMovieClip;
      
      public function GiantWoodBeetleEnemyEyesSprite()
      {
         var sprite:GameSprite = null;
         super();
         this.initWalkAnim();
         sprite = new GameSprite();
         addChild(sprite);
         sprite.touchable = false;
         sprite.pivotX = sprite.pivotY = 0;
         sprite.x = sprite.y = 0;
         sprite.addChild(this.walkAnim);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.walkAnim);
         this.walkAnim.dispose();
         this.walkAnim = null;
         super.destroy();
      }
      
      protected function initWalkAnim() : void
      {
         this.walkAnim = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("giantWoodBeetleEnemyEyesSpriteAnim_"),16);
         this.walkAnim.touchable = false;
         this.walkAnim.x = this.walkAnim.y = 0;
         this.walkAnim.loop = true;
         Utils.juggler.add(this.walkAnim);
      }
   }
}
