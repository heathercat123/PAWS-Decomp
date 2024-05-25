package levels.backgrounds
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import starling.core.Starling;
   import starling.display.Image;
   
   public class WatercaveBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var sky_layer:Image;
      
      public function WatercaveBackground(_level:Level)
      {
         super(_level);
         Starling.current.stage.color = 0;
         this.pCounter = 0;
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_6"));
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
         var i:int = 0;
         var amount:int = Math.random() * 2 + 3;
         for(i = 0; i < 4; i++)
         {
            if(i < 2)
            {
               level.topParticlesManager.createClusterBubbles(level.camera.xPos + Math.random() * level.camera.HALF_WIDTH,level.camera.yPos + level.camera.HEIGHT + i * Utils.TILE_HEIGHT + 4);
            }
            else
            {
               level.topParticlesManager.createClusterBubbles(level.camera.xPos + level.camera.HALF_WIDTH + Math.random() * level.camera.HALF_WIDTH,level.camera.yPos + level.camera.HEIGHT + i * Utils.TILE_HEIGHT + 4);
            }
         }
      }
   }
}
