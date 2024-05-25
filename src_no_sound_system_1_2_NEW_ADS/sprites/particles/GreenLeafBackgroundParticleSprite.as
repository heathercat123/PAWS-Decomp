package sprites.particles
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class GreenLeafBackgroundParticleSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      public function GreenLeafBackgroundParticleSprite()
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
         if(Math.random() * 100 > 50)
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("greenLeafBackgroundSpriteLightAnim_"),12);
         }
         else
         {
            this.standAnimation = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("greenLeafBackgroundSpriteDarkAnim_"),12);
         }
         if(Math.random() * 100 > 50)
         {
            this.standAnimation.setFrameDuration(0,0.1);
            this.standAnimation.setFrameDuration(1,0.1);
            this.standAnimation.setFrameDuration(2,0.1);
            this.standAnimation.setFrameDuration(3,0.1);
            this.standAnimation.setFrameDuration(4,0.2);
            this.standAnimation.setFrameDuration(5,0.1);
         }
         else
         {
            this.standAnimation.setFrameDuration(0,0.06);
            this.standAnimation.setFrameDuration(1,0.06);
            this.standAnimation.setFrameDuration(2,0.06);
            this.standAnimation.setFrameDuration(3,0.06);
            this.standAnimation.setFrameDuration(4,0.12);
            this.standAnimation.setFrameDuration(5,0.06);
         }
         this.standAnimation.textureSmoothing = Utils.getSmoothing();
         this.standAnimation.touchable = false;
         this.standAnimation.pivotX = 4;
         this.standAnimation.pivotY = 4;
         this.standAnimation.loop = true;
         this.standAnimation.gotoAndPlay(int(Math.random() * this.standAnimation.numFrames) + 1);
         Utils.juggler.add(this.standAnimation);
      }
   }
}
