package sprites.decorations
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class IceLightDecorationSprite extends GameSprite
   {
       
      
      protected var standAnimation:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      public function IceLightDecorationSprite()
      {
         super();
         this.initAnims();
         this.initAnims2();
         addChild(this.standAnimation);
         addChild(this.standAnimation2);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation);
         this.standAnimation.dispose();
         this.standAnimation = null;
         Utils.juggler.remove(this.standAnimation2);
         this.standAnimation2.dispose();
         this.standAnimation2 = null;
         super.destroy();
      }
      
      protected function initAnims() : void
      {
         this.standAnimation = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceLightDecorationSpriteAnim_"),12);
         for(var i:* = 0; i < this.standAnimation.numFrames; i++)
         {
            this.standAnimation.setFrameDuration(i,0.2);
         }
         this.standAnimation.touchable = false;
         this.standAnimation.x = this.standAnimation.y = 0;
         this.standAnimation.loop = true;
         Utils.juggler.add(this.standAnimation);
      }
      
      protected function initAnims2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.sTextureAtlas.getTextures("iceLightShortDecorationSpriteAnim_"),12);
         for(var i:* = 0; i < this.standAnimation2.numFrames; i++)
         {
            this.standAnimation2.setFrameDuration(i,0.2);
         }
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = 0;
         this.standAnimation2.loop = true;
         Utils.juggler.add(this.standAnimation2);
      }
   }
}
