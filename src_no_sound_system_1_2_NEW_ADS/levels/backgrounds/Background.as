package levels.backgrounds
{
   import entities.Entity;
   import entities.particles.ParticlesManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.backgrounds.elements.*;
   import levels.cameras.*;
   import starling.display.Sprite;
   
   public class Background
   {
       
      
      public var level:Level;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      public var layer_static:Sprite;
      
      public var layer_0:Sprite;
      
      public var layer_1:Sprite;
      
      public var layer_1_5:Sprite;
      
      public var layer_2:Sprite;
      
      public var layer_foreground:Sprite;
      
      protected var mult0:Number;
      
      protected var mult1:Number;
      
      protected var mult1_5:Number;
      
      protected var mult2:Number;
      
      protected var mult_foreground:Number;
      
      protected var mult0_y:Number;
      
      protected var mult1_y:Number;
      
      protected var mult1_5_y:Number;
      
      protected var mult2_y:Number;
      
      protected var mult_foreground_y:Number;
      
      protected var layer_0_x_offset:Number;
      
      protected var layer_0_y_offset:Number;
      
      protected var layer_1_x_offset:Number;
      
      protected var layer_1_y_offset:Number;
      
      protected var layer_2_x_offset:Number;
      
      protected var layer_2_y_offset:Number;
      
      public var foregroundContainer:Sprite;
      
      public var backgroundContainer:Sprite;
      
      public var elements:Array;
      
      public var particlesArea:Array;
      
      public var particlesManager:ParticlesManager;
      
      public var topParticlesManager:ParticlesManager;
      
      public function Background(_level:Level)
      {
         var i:int = 0;
         var j:int = 0;
         var bElement:BackgroundElement = null;
         var obj:DisplayObject = null;
         var sub_obj:DisplayObject = null;
         var mClip:MovieClip = null;
         var layer:Sprite = null;
         var _obj:XML = null;
         super();
         this.level = _level;
         this.layer_0_x_offset = this.layer_0_y_offset = 0;
         this.layer_1_x_offset = this.layer_1_y_offset = 0;
         this.layer_2_x_offset = this.layer_2_y_offset = 0;
         this.foregroundContainer = new Sprite();
         this.backgroundContainer = new Sprite();
         this.foregroundContainer.x = this.backgroundContainer.x = this.xPos = 0;
         this.foregroundContainer.y = this.backgroundContainer.y = this.yPos = 0;
         this.layer_static = new Sprite();
         this.layer_0 = new Sprite();
         this.layer_1 = new Sprite();
         this.layer_1_5 = new Sprite();
         this.layer_2 = new Sprite();
         this.layer_foreground = new Sprite();
         Utils.backgroundWorld.addChild(this.backgroundContainer);
         this.backgroundContainer.addChild(this.layer_static);
         this.backgroundContainer.addChild(this.layer_0);
         this.backgroundContainer.addChild(this.layer_1);
         this.backgroundContainer.addChild(this.layer_1_5);
         this.backgroundContainer.addChild(this.layer_2);
         Utils.foregroundWorld.addChild(this.layer_foreground);
         this.particlesManager = new ParticlesManager(this.level,this.layer_1_5);
         if(this is StarryNightBackground)
         {
            Utils.foregroundWorld.addChild(this.foregroundContainer);
         }
         else
         {
            Utils.topWorld.addChild(this.foregroundContainer);
         }
         this.topParticlesManager = new ParticlesManager(this.level,this.foregroundContainer);
         this.initDistanceMultipliers();
         this.elements = new Array();
         this.particlesArea = new Array();
         for each(_obj in this.level.map.layer_0.tiles[0].obj)
         {
            bElement = new BackgroundElement(this.level,_obj.@x,_obj.@y,_obj.@name,this.layer_0,_obj.@f_x == 0 ? false : true,_obj.@f_y == 0 ? false : true,_obj.@w,_obj.@h);
            this.elements.push(bElement);
         }
         for each(_obj in this.level.map.layer_1.tiles[0].obj)
         {
            bElement = new BackgroundElement(this.level,_obj.@x,_obj.@y,_obj.@name,this.layer_1,_obj.@f_x == 0 ? false : true,_obj.@f_y == 0 ? false : true,_obj.@w,_obj.@h);
            this.elements.push(bElement);
         }
         for each(_obj in this.level.map.layer_2.tiles[0].obj)
         {
            bElement = new BackgroundElement(this.level,_obj.@x,_obj.@y,_obj.@name,this.layer_2,_obj.@f_x == 0 ? false : true,_obj.@f_y == 0 ? false : true,_obj.@w,_obj.@h);
            this.elements.push(bElement);
         }
         for each(_obj in this.level.map.layer_sky.tiles[0].obj)
         {
            bElement = new BackgroundElement(this.level,_obj.@x,_obj.@y,_obj.@name,this.layer_static,_obj.@f_x == 0 ? false : true,_obj.@f_y == 0 ? false : true,_obj.@w,_obj.@h);
            this.elements.push(bElement);
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GFX] == 0)
         {
            for each(_obj in this.level.map.layer_foreground.tiles[0].obj)
            {
               bElement = new BackgroundElement(this.level,_obj.@x,_obj.@y,_obj.@name,this.layer_foreground,_obj.@f_x == 0 ? false : true,_obj.@f_y == 0 ? false : true,_obj.@w,_obj.@h);
               this.elements.push(bElement);
            }
         }
         for each(_obj in this.level.map.data[0].obj)
         {
            if(_obj.@_class == "ParticlesArea")
            {
               this.particlesArea.push(new ParticleArea(_obj.@x,_obj.@y,_obj.@w,_obj.@h));
            }
         }
         for each(_obj in this.level.map.layer_0.elements[0].obj)
         {
            this.createBackgroundElement(_obj,this.layer_0);
         }
         for each(_obj in this.level.map.layer_1.elements[0].obj)
         {
            this.createBackgroundElement(_obj,this.layer_1);
         }
         for each(_obj in this.level.map.layer_2.elements[0].obj)
         {
            this.createBackgroundElement(_obj,this.layer_2);
         }
         for each(_obj in this.level.map.layer_sky.elements[0].obj)
         {
            this.createBackgroundElement(_obj,this.layer_static);
         }
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GFX] == 0)
         {
            for each(_obj in this.level.map.layer_foreground.elements[0].obj)
            {
               this.createBackgroundElement(_obj,this.layer_foreground);
            }
         }
      }
      
      protected function createBackgroundElement(obj:XML, layer:Sprite) : void
      {
         var bElement:BackgroundElement = null;
         if(obj.@_class == "WaterfallBackground1")
         {
            bElement = new WaterfallBackgroundElement(this.level,obj.@x,obj.@y,"",layer,obj.@f_x == 1 ? true : false,obj.@f_y == 1 ? true : false,0);
         }
         else if(obj.@_class == "WaterfallBackground2")
         {
            bElement = new WaterfallBackgroundElement(this.level,obj.@x,obj.@y,"",layer,obj.@f_x == 1 ? true : false,obj.@f_y == 1 ? true : false,1);
         }
         else if(obj.@_class == "BackgroundLight1")
         {
            bElement = new BackgroundLightElement(this.level,obj.@x,obj.@y,"light_1",layer,obj.@f_x == 1 ? true : false);
         }
         else if(obj.@_class == "BackgroundLight2")
         {
            bElement = new BackgroundLightElement(this.level,obj.@x,obj.@y,"light_2",layer,obj.@f_x == 1 ? true : false);
         }
         else if(obj.@_class == "BackgroundCanyonGlitter1")
         {
            bElement = new GenericBackgroundElement(this.level,GenericBackgroundElement.CANYON_GLITTER_1,obj.@x,obj.@y,"",layer);
         }
         else if(obj.@_class == "BackgroundCanyonGlitter2")
         {
            bElement = new GenericBackgroundElement(this.level,GenericBackgroundElement.CANYON_GLITTER_2,obj.@x,obj.@y,"",layer);
         }
         else if(obj.@_class == "StarBackgroundScript1")
         {
            bElement = new NightCityStarElement(this.level,obj.@x,obj.@y,"",layer,0);
         }
         else if(obj.@_class == "StarBackgroundScript2")
         {
            bElement = new NightCityStarElement(this.level,obj.@x,obj.@y,"",layer,1);
         }
         else if(obj.@_class == "StarBackgroundScript3")
         {
            bElement = new NightCityStarElement(this.level,obj.@x,obj.@y,"",layer,2);
         }
         else if(obj.@_class == "StarBackgroundScript4")
         {
            bElement = new NightCityStarElement(this.level,obj.@x,obj.@y,"",layer,3);
         }
         else if(obj.@_class == "StarBackgroundScript5")
         {
            bElement = new NightCityStarElement(this.level,obj.@x,obj.@y,"",layer,4);
         }
         else if(obj.@_class == "StarBackgroundScript6")
         {
            bElement = new NightCityStarElement(this.level,obj.@x,obj.@y,"",layer,5);
         }
         else if(obj.@_class == "StarBackgroundScript7")
         {
            bElement = new NightCityStarElement(this.level,obj.@x,obj.@y,"",layer,6);
         }
         else if(obj.@_class == "StarBackgroundScript8")
         {
            bElement = new NightCityStarElement(this.level,obj.@x,obj.@y,"",layer,7);
         }
         else if(obj.@_class == "StarBackgroundScript9")
         {
            bElement = new NightCityStarElement(this.level,obj.@x,obj.@y,"",layer,8);
         }
         else if(obj.@_class == "CityNightBackground28")
         {
            bElement = new BackgroundBoatElement(this.level,obj.@x,obj.@y,"background_city_night_28",layer,obj.@f_x == 1 ? true : false);
         }
         else if(obj.@_class == "DesertBackground3")
         {
            bElement = new DesertSunBackgroundElement(this.level,obj.@x,obj.@y,"desert_bg_3",layer);
         }
         else if(obj.@_class == "DesertBackground21")
         {
            bElement = new DawnDesertStarElement(this.level,obj.@x,obj.@y,"",layer,0);
         }
         else if(obj.@_class == "DesertBackground22")
         {
            bElement = new DawnDesertStarElement(this.level,obj.@x,obj.@y,"",layer,1);
         }
         else if(obj.@_class == "DesertBackground23")
         {
            bElement = new DawnDesertStarElement(this.level,obj.@x,obj.@y,"",layer,2);
         }
         else if(obj.@_class == "DesertBackground24")
         {
            bElement = new DawnDesertStarElement(this.level,obj.@x,obj.@y,"",layer,3);
         }
         else if(obj.@_class == "DeserthouseLightBackground1")
         {
            bElement = new DesertLightElement(this.level,obj.@x,obj.@y,"",layer);
         }
         else if(obj.@_class == "CityMoonBackground")
         {
            bElement = new MoonBackgroundElement(this.level,obj.@x,obj.@y,"background_moon_1",layer);
         }
         else if(obj.@_class == "MountainNightBackgroundFlag")
         {
            bElement = new NightFlagBackgroundElement(this.level,obj.@x,obj.@y,"",layer);
         }
         else if(obj.@_class == "MountainNightSnowBackgroundFlag")
         {
            bElement = new NightSnowFlagBackgroundElement(this.level,obj.@x,obj.@y,"",layer);
         }
         else if(obj.@_class == "MountainNightBackground26")
         {
            bElement = new NightCastleTroopBackgroundElement(this.level,obj.@x,obj.@y,"",layer,(obj.@f_x == 1 ? true : false) ? Entity.RIGHT : Entity.LEFT);
         }
         else if(obj.@_class == "MountainNightBackgroundLamp")
         {
            bElement = new NightLampBackgroundElement(this.level,obj.@x,obj.@y,"",layer);
         }
         else if(obj.@_class == "BackgroundPoleLightScript")
         {
            bElement = new PoleLightBackgroundElement(this.level,obj.@x,obj.@y,"",layer,obj.@f_x == 1 ? true : false);
         }
         else if(obj.@_class == "BackgroundCastleTorchScript")
         {
            bElement = new GenericBackgroundElement(this.level,GenericBackgroundElement.CASTLE_TORCH,obj.@x,obj.@y,"",layer);
         }
         else if(obj.@_class == "BeachNightBackground2")
         {
            bElement = new DesertSunBackgroundElement(this.level,obj.@x,obj.@y,"",layer,false,1);
         }
         else if(obj.@_class == "LighthouseBackgroundSpriteScript1")
         {
            bElement = new GenericBackgroundElement(this.level,GenericBackgroundElement.LIGHTHOUSE,obj.@x,obj.@y,"",layer);
         }
         else if(obj.@_class == "BackgroundNeonScript1")
         {
            bElement = new FactoryNeonElement(this.level,obj.@x,obj.@y,"",layer,0);
         }
         else if(obj.@_class == "BackgroundNeonScript2")
         {
            bElement = new FactoryNeonElement(this.level,obj.@x,obj.@y,"",layer,1);
         }
         else if(obj.@_class == "BackgroundNeonScript3")
         {
            bElement = new FactoryNeonElement(this.level,obj.@x,obj.@y,"",layer,2);
         }
         else if(obj.@_class == "AuroraBackground1")
         {
            bElement = new AuroraBackgroundElement(this.level,obj.@x,obj.@y,"",layer,false);
         }
         if(bElement != null)
         {
            this.elements.push(bElement);
         }
      }
      
      protected function initDistanceMultipliers() : void
      {
         var dist_mult:Array = this.level.getBackgroundDistanceMultipliers();
         var foreground_point:Point = this.level.getForegroundMultipliers();
         this.mult0 = dist_mult[0].x;
         this.mult1 = dist_mult[1].x;
         this.mult1_5 = dist_mult[2].x;
         this.mult2 = dist_mult[3].x;
         this.mult_foreground = foreground_point.x;
         this.mult0_y = dist_mult[0].y;
         this.mult1_y = dist_mult[1].y;
         this.mult1_5_y = dist_mult[2].y;
         this.mult2_y = dist_mult[3].y;
         this.mult_foreground_y = foreground_point.y;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.topParticlesManager.destroy();
         this.topParticlesManager = null;
         this.particlesManager.destroy();
         this.particlesManager = null;
         for(i = 0; i < this.elements.length; i++)
         {
            this.elements[i].destroy();
            this.elements[i] = null;
         }
         this.elements = null;
         for(i = 0; i < this.particlesArea.length; i++)
         {
            this.particlesArea[i].destroy();
            this.particlesArea[i] = null;
         }
         this.particlesArea = null;
         this.backgroundContainer.removeChild(this.layer_2);
         this.backgroundContainer.removeChild(this.layer_1_5);
         this.backgroundContainer.removeChild(this.layer_1);
         this.backgroundContainer.removeChild(this.layer_0);
         this.backgroundContainer.removeChild(this.layer_static);
         this.foregroundContainer.removeChild(this.layer_foreground);
         this.layer_foreground.dispose();
         this.layer_2.dispose();
         this.layer_1_5.dispose();
         this.layer_1.dispose();
         this.layer_0.dispose();
         this.layer_static.dispose();
         this.layer_2 = this.layer_1 = this.layer_1_5 = this.layer_0 = this.layer_static = this.layer_foreground = null;
         if(this is StarryNightBackground)
         {
            Utils.foregroundWorld.removeChild(this.foregroundContainer);
         }
         else
         {
            Utils.topWorld.removeChild(this.foregroundContainer);
         }
         this.foregroundContainer.dispose();
         this.foregroundContainer = null;
         Utils.backgroundWorld.removeChild(this.backgroundContainer);
         this.backgroundContainer.dispose();
         this.backgroundContainer = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.elements.length; i++)
         {
            if(this.elements[i] != null)
            {
               this.elements[i].update();
            }
         }
         for(i = 0; i < this.particlesArea.length; i++)
         {
            if(this.particlesArea[i] != null)
            {
               this.particles(this.particlesArea[i]);
            }
         }
         this.particlesManager.update();
         this.topParticlesManager.update();
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         this.layer_0.x = int(Math.floor(this.xPos - camera.xPos) * this.mult0 + this.layer_0_x_offset);
         this.layer_0.y = int(Math.floor(this.yPos - camera.yPos) * this.mult0_y + this.layer_0_y_offset);
         this.layer_1.x = int(Math.floor(this.xPos - camera.xPos) * this.mult1);
         this.layer_1.y = int(Math.floor(this.yPos - camera.yPos) * this.mult1_y);
         this.layer_2.x = int(Math.floor(this.xPos - camera.xPos * this.mult2));
         this.layer_2.y = int(Math.floor(this.yPos - camera.yPos) * this.mult2_y);
         this.layer_foreground.x = int(Math.floor(this.xPos - camera.xPos * this.mult_foreground));
         this.layer_foreground.y = int(Math.floor(this.yPos - camera.yPos * this.mult_foreground_y));
         for(i = 0; i < this.elements.length; i++)
         {
            if(this.elements[i] != null)
            {
               this.elements[i].updateScreenPosition(camera);
            }
         }
         this.particlesManager.updateScreenPositions(camera);
         this.topParticlesManager.updateScreenPositions(camera);
      }
      
      protected function isFlipped(obj:DisplayObject) : Boolean
      {
         return obj.transform.matrix.a / obj.scaleX == -1;
      }
      
      protected function isFlippedVer(obj:DisplayObject) : Boolean
      {
         return obj.transform.matrix.d / obj.scaleY == -1;
      }
      
      public function shake() : void
      {
      }
      
      public function particles(area:ParticleArea) : void
      {
      }
   }
}
