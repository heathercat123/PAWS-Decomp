package levels.backgrounds
{
   import flash.geom.Point;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import states.LevelState;
   
   public class FrozenLakeBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var cloudsContainer:Sprite;
      
      protected var clouds:Array;
      
      protected var cloudsData:Array;
      
      protected var cloudStep:int;
      
      protected var cloud_base_image:Image;
      
      protected var pollen_counter_1:int;
      
      public var pollen_spawn_time:int;
      
      protected var sky_layer:Image;
      
      public function FrozenLakeBackground(_level:Level)
      {
         var i:int = 0;
         var image:Image = null;
         super(_level);
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_3_5_3 || Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_3_8_2)
         {
            Starling.current.stage.color = 0;
         }
         else
         {
            Starling.current.stage.color = 0;
         }
         this.pCounter = 0;
         this.pollen_counter_1 = 0;
         this.pollen_spawn_time = 0;
         this.cloudStep = 256;
         var amount:int = int(Utils.WIDTH / this.cloudStep) + 2;
         this.clouds = new Array();
         this.cloudsData = new Array();
         this.cloudsContainer = new Sprite();
         backgroundContainer.addChild(this.cloudsContainer);
         backgroundContainer.setChildIndex(this.cloudsContainer,0);
         for(i = 0; i < amount; i++)
         {
            image = new Image(TextureManager.GetBackgroundTexture().getTexture("mountain_cloud_1"));
            image.x = i * this.cloudStep;
            image.y = int(Utils.HEIGHT * 0.5);
            image.pivotY = image.height;
            this.cloudsData.push(new Point(i * this.cloudStep,int(Utils.HEIGHT * 0.5)));
            this.cloudsContainer.addChild(image);
            this.clouds.push(image);
         }
         this.cloud_base_image = new Image(TextureManager.GetBackgroundTexture().getTexture("mountain_cloud_2"));
         this.cloud_base_image.width = Utils.WIDTH + 2;
         this.cloud_base_image.height = int(Utils.HEIGHT * 0.5 + 2);
         this.cloudsContainer.addChild(this.cloud_base_image);
         this.cloud_base_image.x = 0;
         this.cloud_base_image.y = int(Utils.HEIGHT * 0.5);
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_4"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.cloudsContainer.removeChild(this.cloud_base_image);
         this.cloud_base_image.dispose();
         this.cloud_base_image = null;
         for(i = 0; i < this.clouds.length; i++)
         {
            this.cloudsContainer.removeChild(this.clouds[i]);
            this.clouds[i].dispose();
            this.clouds[i] = null;
            this.cloudsData[i] = null;
         }
         this.clouds = null;
         this.cloudsData = null;
         backgroundContainer.removeChild(this.cloudsContainer);
         this.cloudsContainer.dispose();
         this.cloudsContainer = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         super.update();
         for(i = 0; i < this.cloudsData.length; i++)
         {
            this.cloudsData[i].x -= 0.25;
            if(this.cloudsData[i].x <= -this.cloudStep)
            {
               this.cloudsData[i].x += this.cloudsData.length * this.cloudStep;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
         this.cloudsContainer.x = 0;
         this.cloudsContainer.y = 0;
         for(i = 0; i < this.clouds.length; i++)
         {
            if(this.clouds[i] != null)
            {
               this.clouds[i].x = int(Math.floor(this.cloudsData[i].x));
               this.clouds[i].y = int(Math.floor(this.cloudsData[i].y));
            }
         }
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
