package sprites.background
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class SeaDawnReflectionBackgroundSprite extends GameSprite
   {
       
      
      protected var standAnimation1:GameMovieClip;
      
      protected var TYPE:int;
      
      protected var speed_value:Number;
      
      public function SeaDawnReflectionBackgroundSprite(_type:int = 0)
      {
         super();
         this.TYPE = _type;
         this.speed_value = 0.075;
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
         if(this.TYPE == 0)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("seaDawnReflectionBackgroundSpriteAnim_"));
         }
         else
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("seaNightReflectionBackgroundSpriteAnim_"));
         }
         this.standAnimation1.setFrameDuration(0,0.2);
         this.standAnimation1.setFrameDuration(1,0.2);
         this.standAnimation1.setFrameDuration(2,0.2);
         this.standAnimation1.setFrameDuration(3,0.2);
         this.standAnimation1.setFrameDuration(4,0.2);
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = false;
         Utils.juggler.add(this.standAnimation1);
      }
   }
}
