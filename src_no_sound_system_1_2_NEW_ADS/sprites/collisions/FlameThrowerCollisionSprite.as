package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FlameThrowerCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var flameAnimation:GameMovieClip;
      
      public function FlameThrowerCollisionSprite()
      {
         super();
         this.initAnims();
         this.initFlame();
         addChild(this.standAnimation);
         addChild(this.flameAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         Utils.juggler.remove(this.flameAnimation);
         this.flameAnimation.dispose();
         this.flameAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("flameThrowerCollisionSpriteStandAnim_"),12);
         this.standAnimation.touchable = false;
         this.standAnimation.x = -9;
         this.standAnimation.y = -9;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initFlame() : void
      {
         this.flameAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("flameThrowerCollisionSpriteShootAnim_"),12);
         this.flameAnimation.setFrameDuration(0,0.1);
         this.flameAnimation.touchable = false;
         this.flameAnimation.x = -9;
         this.flameAnimation.y = -9;
         this.flameAnimation.loop = false;
         Utils.juggler.add(this.flameAnimation);
      }
   }
}
