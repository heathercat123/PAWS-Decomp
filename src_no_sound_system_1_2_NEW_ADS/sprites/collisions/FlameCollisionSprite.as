package sprites.collisions
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FlameCollisionSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var igniteAnimation:GameMovieClip;
      
      public function FlameCollisionSprite()
      {
         super();
         this.initAnims();
         this.igniteAnims();
         addChild(this.standAnimation);
         addChild(this.igniteAnimation);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.igniteAnimation);
         this.standAnimation.dispose();
         this.igniteAnimation.dispose();
         this.standAnimation = null;
         this.igniteAnimation = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("flameCollisionSpriteAnim_"),12);
         this.standAnimation.setFrameDuration(0,0.075);
         this.standAnimation.setFrameDuration(1,0.075);
         this.standAnimation.setFrameDuration(2,0.075);
         this.standAnimation.touchable = false;
         this.standAnimation.x = 0;
         this.standAnimation.y = -9;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function igniteAnims() : void
      {
         this.igniteAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("flameCollisionSpriteIgniteAnim_"),12);
         this.igniteAnimation.setFrameDuration(0,0.075);
         this.igniteAnimation.setFrameDuration(1,0.075);
         this.igniteAnimation.touchable = false;
         this.igniteAnimation.x = 0;
         this.igniteAnimation.y = -9;
         this.igniteAnimation.loop = false;
         Utils.juggler.add(this.igniteAnimation);
      }
   }
}
