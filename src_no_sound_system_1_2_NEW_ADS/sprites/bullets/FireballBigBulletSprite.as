package sprites.bullets
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FireballBigBulletSprite extends GameSprite
   {
      
      protected var standAnimation:GameMovieClip;
      
      public function FireballBigBulletSprite()
      {
         super();
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
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("fireBallBigBulletSpriteAnim_"));
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -12;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}

