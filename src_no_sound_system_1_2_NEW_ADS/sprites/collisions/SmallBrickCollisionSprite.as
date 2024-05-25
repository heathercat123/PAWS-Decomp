package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SmallBrickCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var is_spiked:int;
      
      protected var is_flipped:int;
      
      public var INDEX:int;
      
      public function SmallBrickCollisionSprite(_is_spiked:int = 0, _is_flipped:int = 0, _index:int = 0)
      {
         super();
         this.is_spiked = _is_spiked;
         this.is_flipped = _is_flipped;
         this.INDEX = _index;
         this.initAnims();
         addChild(this.standAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.is_spiked > 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallBrickSpikedCollisionSpriteAnim_"),12);
         }
         else if(this.INDEX == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallBrickCollisionSpriteAnim_b"),12);
         }
         else if(this.INDEX == 3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallBrickCollisionSpriteAnim_c"),12);
         }
         else if(this.INDEX == 4)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallBrickCollisionSpriteAnim_d"),12);
         }
         else if(this.INDEX == 5)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("brick_tile_1"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("smallBrickCollisionSpriteAnim_a"),12);
         }
         this.standAnimation.touchable = false;
         if(this.is_spiked > 0)
         {
            this.standAnimation.x = -4;
         }
         else
         {
            this.standAnimation.x = 0;
         }
         if(this.is_flipped > 0)
         {
            this.standAnimation.x -= 16;
         }
         this.standAnimation.y = 0;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
