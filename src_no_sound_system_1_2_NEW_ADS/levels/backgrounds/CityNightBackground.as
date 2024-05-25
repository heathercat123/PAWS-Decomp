package levels.backgrounds
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import starling.core.Starling;
   import starling.display.Image;
   
   public class CityNightBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var pollen_counter_1:int;
      
      public var pollen_spawn_time:int;
      
      protected var sky_layer:Image;
      
      protected var smoke_counter_1:int;
      
      protected var smoke_counter_2:int;
      
      public function CityNightBackground(_level:Level)
      {
         super(_level);
         Starling.current.stage.color = 0;
         this.pCounter = this.pollen_counter_1 = 0;
         this.pollen_spawn_time = 0;
         this.smoke_counter_1 = this.smoke_counter_2 = 0;
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_5"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         super.update();
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
