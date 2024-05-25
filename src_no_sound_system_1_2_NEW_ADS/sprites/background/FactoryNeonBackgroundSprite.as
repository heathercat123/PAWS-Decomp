package sprites.background
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class FactoryNeonBackgroundSprite extends GameSprite
   {
       
      
      protected var standAnimation1:GameMovieClip;
      
      protected var TYPE:int;
      
      public function FactoryNeonBackgroundSprite(_type:int)
      {
         super();
         this.TYPE = _type;
         this.initAnims1();
         addChild(this.standAnimation1);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation1);
         this.standAnimation1.dispose();
         this.standAnimation1 = null;
         super.destroy();
      }
      
      protected function initAnims1() : void
      {
         if(this.TYPE == 1)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("neon2BackgroundAnim_"));
         }
         else if(this.TYPE == 2)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("neon3BackgroundAnim_"));
         }
         else
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("neon1BackgroundAnim_"));
         }
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = true;
         Utils.juggler.add(this.standAnimation1);
      }
   }
}
