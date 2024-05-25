package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class YellowPlatformCollisionSprite extends GameSprite
   {
       
      
      protected var type:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function YellowPlatformCollisionSprite(_type:int = 0)
      {
         super();
         this.type = _type;
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
         if(this.type == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowVerticalPlatformCollisionSpriteAnim_a"),12);
         }
         else if(this.type == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("tickTockVerticalPlatformCollisionSpriteAnim_"),12);
         }
         else if(this.type == 3)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("tickHorizontalPlatformCollisionSpriteAnim_"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("yellowPlatformCollisionSpriteAnim_"),12);
         }
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
