package sprites.decorations
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DiamondRockDecorationSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var standAnimation1:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      public function DiamondRockDecorationSprite()
      {
         super();
         this.initAnims();
         this.initAnims1();
         this.initAnims2();
         addChild(this.standAnimation);
         addChild(this.standAnimation1);
         addChild(this.standAnimation2);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         Utils.juggler.remove(this.standAnimation1);
         Utils.juggler.remove(this.standAnimation2);
         this.standAnimation.dispose();
         this.standAnimation1.dispose();
         this.standAnimation2.dispose();
         this.standAnimation = null;
         this.standAnimation1 = null;
         this.standAnimation2 = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceDecorationSpriteAnim_Rock1Anim_"),12);
         this.standAnimation.setFrameDuration(0,Math.random() * 2 + 1);
         this.standAnimation.setFrameDuration(1,0.25);
         this.standAnimation.setFrameDuration(2,0.25);
         this.standAnimation.setFrameDuration(3,0.25);
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = false;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initAnims1() : void
      {
         this.standAnimation1 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceDecorationSpriteAnim_Rock2Anim_"),12);
         this.standAnimation1.setFrameDuration(0,Math.random() * 2 + 1);
         this.standAnimation1.setFrameDuration(1,0.25);
         this.standAnimation1.setFrameDuration(2,0.25);
         this.standAnimation1.setFrameDuration(3,0.25);
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = false;
         Utils.juggler.add(this.standAnimation1);
      }
      
      protected function initAnims2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceDecorationSpriteAnim_Rock3Anim_"),12);
         this.standAnimation2.setFrameDuration(0,Math.random() * 2 + 1);
         this.standAnimation2.setFrameDuration(1,0.25);
         this.standAnimation2.setFrameDuration(2,0.25);
         this.standAnimation2.setFrameDuration(3,0.25);
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = 0;
         this.standAnimation2.loop = false;
         Utils.juggler.add(this.standAnimation2);
      }
   }
}
