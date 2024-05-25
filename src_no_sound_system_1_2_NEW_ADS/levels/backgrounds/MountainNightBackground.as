package levels.backgrounds
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.background.CityNightSnowBackgroundParticleSprite;
   import starling.core.Starling;
   import starling.display.Image;
   
   public class MountainNightBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var ORIGINAL_FOG_Y_POS:Number;
      
      protected var FOG_Y_POS:Number;
      
      protected var snow_counter:int;
      
      protected var sky_layer:Image;
      
      public function MountainNightBackground(_level:Level)
      {
         super(_level);
         Starling.current.stage.color = 0;
         this.snow_counter = 0;
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_8"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function update() : void
      {
         var pSprite:GameSprite = null;
         super.update();
         if(this.snow_counter++ > 0)
         {
            this.snow_counter = -(Math.random() * 5 + 10);
            pSprite = new CityNightSnowBackgroundParticleSprite();
            pSprite.gfxHandleClip().gotoAndStop(int(Math.random() * 4) + 1);
            particlesManager.pushParticle(pSprite,level.camera.xPos - level.camera.WIDTH * 0.5 + Math.random() * level.camera.WIDTH * 2,level.camera.yPos,0,0,1,Math.random() * Math.PI * 2,-0.5 + 0.5 * int(Math.random() * 2));
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         layer_static.setChildIndex(this.sky_layer,0);
         backgroundContainer.setChildIndex(layer_static,0);
      }
      
      override public function particles(area:ParticleArea) : void
      {
      }
      
      override public function shake() : void
      {
      }
   }
}
