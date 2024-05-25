package sprites.background
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class DawnDesertStarBackgroundSprite extends GameSprite
   {
       
      
      protected var standAnimation1:GameMovieClip;
      
      protected var standAnimation2:GameMovieClip;
      
      protected var standAnimation3:GameMovieClip;
      
      protected var standAnimation4:GameMovieClip;
      
      protected var speed_value:Number;
      
      public function DawnDesertStarBackgroundSprite()
      {
         super();
         this.speed_value = 0.4;
         this.initAnims1();
         this.initAnims2();
         this.initAnims3();
         this.initAnims4();
         addChild(this.standAnimation1);
         addChild(this.standAnimation2);
         addChild(this.standAnimation3);
         addChild(this.standAnimation4);
      }
      
      override public function destroy() : void
      {
         Utils.juggler.remove(this.standAnimation1);
         Utils.juggler.remove(this.standAnimation2);
         Utils.juggler.remove(this.standAnimation3);
         Utils.juggler.remove(this.standAnimation4);
         this.standAnimation1.dispose();
         this.standAnimation2.dispose();
         this.standAnimation3.dispose();
         this.standAnimation4.dispose();
         this.standAnimation1 = null;
         this.standAnimation2 = null;
         this.standAnimation3 = null;
         this.standAnimation4 = null;
         super.destroy();
      }
      
      protected function initAnims1() : void
      {
         this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("desertStarBackgroundBlueBigStarAnim_"));
         this.standAnimation1.setFrameDuration(0,this.speed_value);
         this.standAnimation1.setFrameDuration(1,this.speed_value);
         this.standAnimation1.setFrameDuration(2,this.speed_value);
         this.standAnimation1.setFrameDuration(3,this.speed_value);
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = false;
         Utils.juggler.add(this.standAnimation1);
      }
      
      protected function initAnims2() : void
      {
         this.standAnimation2 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("desertStarBackgroundBlueSmallStarAnim_"));
         this.standAnimation2.setFrameDuration(0,this.speed_value);
         this.standAnimation2.setFrameDuration(1,this.speed_value);
         this.standAnimation2.textureSmoothing = Utils.getSmoothing();
         this.standAnimation2.touchable = false;
         this.standAnimation2.x = this.standAnimation2.y = 0;
         this.standAnimation2.loop = false;
         Utils.juggler.add(this.standAnimation2);
      }
      
      protected function initAnims3() : void
      {
         this.standAnimation3 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("desertStarBackgroundPurpleBigStarAnim_"));
         this.standAnimation3.setFrameDuration(0,this.speed_value);
         this.standAnimation3.setFrameDuration(1,this.speed_value);
         this.standAnimation3.setFrameDuration(2,this.speed_value);
         this.standAnimation3.setFrameDuration(3,this.speed_value);
         this.standAnimation3.textureSmoothing = Utils.getSmoothing();
         this.standAnimation3.touchable = false;
         this.standAnimation3.x = this.standAnimation3.y = 0;
         this.standAnimation3.loop = false;
         Utils.juggler.add(this.standAnimation3);
      }
      
      protected function initAnims4() : void
      {
         this.standAnimation4 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("desertStarBackgroundPurpleSmallStarAnim_"));
         this.standAnimation4.setFrameDuration(0,this.speed_value);
         this.standAnimation4.setFrameDuration(1,this.speed_value);
         this.standAnimation4.textureSmoothing = Utils.getSmoothing();
         this.standAnimation4.touchable = false;
         this.standAnimation4.x = this.standAnimation4.y = 0;
         this.standAnimation4.loop = false;
         Utils.juggler.add(this.standAnimation4);
      }
   }
}
