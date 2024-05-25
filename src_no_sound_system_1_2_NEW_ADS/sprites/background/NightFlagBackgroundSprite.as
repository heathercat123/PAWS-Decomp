package sprites.background
{
   import sprites.GameMovieClip;
   import sprites.GameSprite;
   
   public class NightFlagBackgroundSprite extends GameSprite
   {
       
      
      protected var type:int;
      
      protected var standAnimation1:GameMovieClip;
      
      protected var speed_value:Number;
      
      public function NightFlagBackgroundSprite(_type:int = 0)
      {
         super();
         this.type = _type;
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
         if(this.type == 0)
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("mountainNightBackgroundFlagSpriteAnim_"));
         }
         else
         {
            this.standAnimation1 = new GameMovieClip(TextureManager.GetBackgroundTexture().getTextures("mountainSnowNightBackgroundFlagSpriteAnim_"));
         }
         this.standAnimation1.setFrameDuration(0,0.25);
         this.standAnimation1.setFrameDuration(1,0.25);
         this.standAnimation1.setFrameDuration(2,0.25);
         this.standAnimation1.setFrameDuration(3,0.25);
         this.standAnimation1.textureSmoothing = Utils.getSmoothing();
         this.standAnimation1.touchable = false;
         this.standAnimation1.x = this.standAnimation1.y = 0;
         this.standAnimation1.loop = true;
         Utils.juggler.add(this.standAnimation1);
      }
   }
}
