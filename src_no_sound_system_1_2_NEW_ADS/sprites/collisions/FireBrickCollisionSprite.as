package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FireBrickCollisionSprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function FireBrickCollisionSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
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
         if(this.TYPE == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("pinkBlockCollision"),12);
         }
         else if(this.TYPE == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("spikedBallCollisionSpriteAnim_a"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireBrickCollisionSpriteAnim_"),12);
         }
         this.standAnimation.touchable = false;
         if(this.TYPE == 2)
         {
            this.standAnimation.x = this.standAnimation.y = -12;
         }
         else
         {
            this.standAnimation.x = this.standAnimation.y = -8;
         }
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
