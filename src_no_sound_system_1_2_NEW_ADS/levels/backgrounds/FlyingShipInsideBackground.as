package levels.backgrounds
{
   import flash.geom.Point;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import sprites.background.GiantSpaceshipBackgroundParticleSprite;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import states.LevelState;
   
   public class FlyingShipInsideBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var cloudsContainer:Sprite;
      
      protected var clouds:Array;
      
      protected var cloudsData:Array;
      
      protected var SPAWN_GIANT_SHIP:Boolean;
      
      protected var giant_ship_counter:int;
      
      protected var giantSpaceship:GiantSpaceshipBackgroundParticleSprite;
      
      protected var sky_layer:Image;
      
      public function FlyingShipInsideBackground(_level:Level)
      {
         var i:int = 0;
         var image:Image = null;
         super(_level);
         Starling.current.stage.color = 0;
         this.pCounter = 0;
         this.SPAWN_GIANT_SHIP = false;
         Utils.GLOBAL_VAR_1 = 0;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_2_4 || Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_2_6)
         {
            this.SPAWN_GIANT_SHIP = true;
            if(Utils.Slot.gameProgression[2] == 0)
            {
               this.giant_ship_counter = 0;
            }
            else
            {
               this.giant_ship_counter = (Math.random() * 5 + 5) * 60;
            }
         }
         var amount:int = 8;
         this.clouds = new Array();
         this.cloudsData = new Array();
         this.cloudsContainer = new Sprite();
         this.giantSpaceship = new GiantSpaceshipBackgroundParticleSprite();
         backgroundContainer.addChild(this.giantSpaceship);
         backgroundContainer.setChildIndex(this.giantSpaceship,0);
         this.giantSpaceship.visible = false;
         this.giantSpaceship.x = Utils.WIDTH + 300;
         this.giantSpaceship.y = int(Utils.HEIGHT * 0.5);
         backgroundContainer.addChild(this.cloudsContainer);
         backgroundContainer.setChildIndex(this.cloudsContainer,0);
         for(i = 0; i < amount; i++)
         {
            if(i % 2 == 0)
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("sea_cloud_1"));
            }
            else
            {
               image = new Image(TextureManager.GetBackgroundTexture().getTexture("sea_cloud_2"));
            }
            image.x = int(Math.random() * Utils.WIDTH);
            image.y = int(Math.random() * int(Utils.HEIGHT / Utils.TILE_HEIGHT)) * Utils.TILE_HEIGHT;
            this.cloudsData.push(new Point(image.x,image.y));
            this.cloudsContainer.addChild(image);
            this.clouds.push(image);
         }
         this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_3"));
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         backgroundContainer.removeChild(this.giantSpaceship);
         this.giantSpaceship.destroy();
         this.giantSpaceship.dispose();
         this.giantSpaceship = null;
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
         var diff_x:Number = NaN;
         var magnitudo:Number = NaN;
         super.update();
         for(i = 0; i < this.cloudsData.length; i++)
         {
            if(i % 2 == 0)
            {
               this.cloudsData[i].x -= 8;
               this.clouds[i].visible = !this.clouds[i].visible;
            }
            else
            {
               this.cloudsData[i].x -= 4;
            }
            if(this.cloudsData[i].x <= -this.clouds[i].width)
            {
               this.cloudsData[i].x = int(Utils.WIDTH + int(Math.random() * 4) * 16);
               this.cloudsData[i].y = int(Math.random() * int(Utils.HEIGHT / Utils.TILE_HEIGHT)) * Utils.TILE_HEIGHT;
            }
         }
         if(this.SPAWN_GIANT_SHIP)
         {
            if(!this.giantSpaceship.visible)
            {
               if(this.giant_ship_counter-- < 0)
               {
                  this.giantSpaceship.x = Utils.WIDTH + 300;
                  this.giantSpaceship.y = int(Utils.HEIGHT * 0.5);
                  this.giant_ship_counter = (Math.random() * 5 + 5) * 60;
                  this.giantSpaceship.visible = true;
                  SoundSystem.PlaySound("giant_spaceship");
               }
            }
         }
         if(this.giantSpaceship.visible)
         {
            this.giantSpaceship.x -= 5;
            if(this.giantSpaceship.x < -300)
            {
               this.giantSpaceship.visible = false;
            }
            diff_x = Utils.WIDTH * 0.5 - this.giantSpaceship.x;
            diff_x /= Utils.WIDTH * 0.5;
            if(diff_x < -2)
            {
               diff_x = -2;
            }
            else if(diff_x > 2)
            {
               diff_x = 2;
            }
            magnitudo = 2 - Math.abs(diff_x);
            Utils.GLOBAL_VAR_1 = magnitudo;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         super.updateScreenPosition(camera);
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
