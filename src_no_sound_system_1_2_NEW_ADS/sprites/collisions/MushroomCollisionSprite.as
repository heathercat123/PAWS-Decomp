package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class MushroomCollisionSprite extends GameSprite
   {
       
      
      protected var TYPE:int;
      
      protected var standAnimation:GameMovieClip;
      
      protected var bounceAnimation:GameMovieClip;
      
      public function MushroomCollisionSprite(_type:int)
      {
         super();
         this.TYPE = _type;
         this.initAnims();
         this.initBounceAnims();
         addChild(this.standAnimation);
         addChild(this.bounceAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.bounceAnimation);
         this.standAnimation.dispose();
         this.bounceAnimation.dispose();
         this.standAnimation = null;
         this.bounceAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         if(this.TYPE == 0)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mushroomCollisionSpriteStandAnim_"),12);
         }
         else if(this.TYPE == 1)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mushroomCollisionSpriteStandSnowAnim_"),12);
         }
         else if(this.TYPE == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("springCollisionSpriteStandAnim_"),12);
         }
         if(this.TYPE == 0 || this.TYPE == 1)
         {
            this.standAnimation.setFrameDuration(0,1);
            this.standAnimation.setFrameDuration(1,1);
         }
         this.standAnimation.touchable = false;
         this.standAnimation.x = 0;
         this.standAnimation.y = 0;
         if(this.TYPE == 2)
         {
            this.standAnimation.y = -16;
         }
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initBounceAnims() : void
      {
         if(this.TYPE == 2)
         {
            this.bounceAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("springCollisionSpriteBounceAnim_"),12);
            this.bounceAnimation.setFrameDuration(0,0.1);
            this.bounceAnimation.setFrameDuration(1,0.1);
            this.bounceAnimation.setFrameDuration(2,0.1);
         }
         else
         {
            this.bounceAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("mushroomCollisionSpriteBounceAnim_"),12);
            this.bounceAnimation.setFrameDuration(0,0.1);
            this.bounceAnimation.setFrameDuration(1,0.1);
            this.bounceAnimation.setFrameDuration(2,0.1);
            this.bounceAnimation.setFrameDuration(3,0.1);
            this.bounceAnimation.setFrameDuration(4,0.1);
            this.bounceAnimation.setFrameDuration(5,0.1);
            this.bounceAnimation.setFrameDuration(6,0.1);
         }
         this.bounceAnimation.touchable = false;
         this.bounceAnimation.x = 0;
         this.bounceAnimation.y = 0;
         if(this.TYPE == 2)
         {
            this.bounceAnimation.y = -16;
         }
         this.bounceAnimation.loop = false;
         Utils.juggler.add(this.bounceAnimation);
      }
   }
}
