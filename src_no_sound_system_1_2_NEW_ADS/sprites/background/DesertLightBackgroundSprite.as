package sprites.background
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DesertLightBackgroundSprite extends GameSprite
   {
      
      protected var standAnimation1:GameMovieClip;
      
      protected var speed_value:Number;
      
      public function DesertLightBackgroundSprite()
      {
         super();
         this.speed_value = 0.15;
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
         this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("desertLightBackgroundSpriteAnim_"));
         this.standAnimation1.setFrameDuration(0,this.speed_value);
         this.standAnimation1.setFrameDuration(1,this.speed_value);
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = true;
         Utils.juggler.add(this.standAnimation1);
      }
   }
}

