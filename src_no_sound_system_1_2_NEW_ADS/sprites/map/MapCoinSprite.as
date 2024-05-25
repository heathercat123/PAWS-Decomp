package sprites.map
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class MapCoinSprite extends GameSprite
   {
       
      
      protected var standAnimation1:GameMovieClip;
      
      public function MapCoinSprite()
      {
         super();
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
         this.standAnimation1 = new GameMovieClip(TextureManager.hudTextureAtlas.getTextures("mapCoinSpriteAnim_"),12);
         this.standAnimation1.setFrameDuration(0,int(Math.random() * 3) + 1);
         this.standAnimation1.setFrameDuration(1,0.1);
         this.standAnimation1.setFrameDuration(2,0.1);
         this.standAnimation1.setFrameDuration(3,0.1);
         this.standAnimation1.setFrameDuration(4,0.1);
         this.standAnimation1.setFrameDuration(5,0.1);
         this.standAnimation1.setFrameDuration(6,0.1);
         this.standAnimation1.setFrameDuration(7,0.1);
         this.standAnimation1.setFrameDuration(8,0.1);
         this.standAnimation1.setFrameDuration(9,0.1);
         this.standAnimation1.setFrameDuration(10,0.1);
         this.standAnimation1.setFrameDuration(11,0.1);
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = -8;
         this.standAnimation1.y = -10;
         this.standAnimation1.loop = false;
         Utils.juggler.add(this.standAnimation1);
      }
   }
}
