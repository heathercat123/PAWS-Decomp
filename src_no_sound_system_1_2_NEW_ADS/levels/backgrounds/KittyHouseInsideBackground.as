package levels.backgrounds
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.particles.PollenBackgroundParticleSprite;
   import starling.core.Starling;
   import starling.display.Image;
   
   public class KittyHouseInsideBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var pollen_counter_1:int;
      
      public var pollen_spawn_time:int;
      
      protected var sky_layer:Image;
      
      public var TYPE:int;
      
      public function KittyHouseInsideBackground(_level:Level, _type:int = 0)
      {
         var i:int = 0;
         var image:Image = null;
         super(_level);
         this.TYPE = _type;
         Starling.current.stage.color = 0;
         this.pCounter = this.pollen_counter_1 = 0;
         this.pollen_spawn_time = 60;
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_2"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
         if(this.TYPE == 1)
         {
            this.pollen_spawn_time = -1;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:PollenBackgroundParticleSprite = null;
         super.update();
         if(this.pollen_spawn_time > -1)
         {
            if(this.pollen_counter_1-- < this.pollen_spawn_time)
            {
               this.pollen_counter_1 = Math.random() * 30 + 60;
               pSprite = new PollenBackgroundParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  pSprite.scaleX = -1;
               }
               else
               {
                  pSprite.scaleX = 1;
               }
               if(Math.random() * 100 > 50)
               {
                  particlesManager.pushParticle(pSprite,level.camera.xPos + Math.random() * level.camera.HALF_WIDTH + level.camera.HALF_WIDTH,level.camera.yPos + level.camera.HEIGHT + (Math.random() * 2 + 1) * 16,0,0,1,0,0.25 * int(Math.random() * 3),Math.random() * Math.PI * 2);
               }
               else
               {
                  particlesManager.pushParticle(pSprite,level.camera.xPos + level.camera.WIDTH + 16,level.camera.yPos + level.camera.HALF_HEIGHT + Math.random() * level.camera.HALF_HEIGHT,0,0,1,0,0.25 * int(Math.random() * 3),Math.random() * Math.PI * 2);
               }
            }
         }
         layer_static.setChildIndex(this.sky_layer,0);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
      
      override public function particles(area:ParticleArea) : void
      {
      }
      
      override public function shake() : void
      {
      }
   }
}
