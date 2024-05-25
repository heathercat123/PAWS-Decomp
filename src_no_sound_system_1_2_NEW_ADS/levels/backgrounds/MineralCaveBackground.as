package levels.backgrounds
{
   import levels.Level;
   import starling.core.Starling;
   import starling.display.Image;
   
   public class MineralCaveBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var sky_layer:Image;
      
      public function MineralCaveBackground(_level:Level)
      {
         super(_level);
         Starling.current.stage.color = 0;
         this.pCounter = 0;
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_12"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
      }
      
      override public function update() : void
      {
         super.update();
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
