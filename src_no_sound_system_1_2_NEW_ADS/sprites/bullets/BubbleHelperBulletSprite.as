package sprites.bullets
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class BubbleHelperBulletSprite extends GameSprite
   {
       
      
      protected var LEVEL:int;
      
      protected var standAnimation:GameMovieClip;
      
      public function BubbleHelperBulletSprite(_LEVEL:int)
      {
         super();
         this.LEVEL = _LEVEL;
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
         if(this.LEVEL == 1 || this.LEVEL == 2)
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bubbleHelperBulletSpriteAnim_b"));
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("bubbleHelperBulletSpriteAnim_c"));
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = -4;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
   }
}
