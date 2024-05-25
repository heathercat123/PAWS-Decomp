package levels
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import game_utils.*;
   import levels.scripts.*;
   
   public class ScriptsManager
   {
       
      
      public var initialXPos:int;
      
      public var initialYPos:int;
      
      public var initialDirection:int;
      
      public var initialEntryType:int;
      
      public var goldenCatXPos:int;
      
      public var goldenCatYPos:int;
      
      public var levelTiles:Array;
      
      public var levelCollisions:Array;
      
      public var levelDecorations:Array;
      
      public var levelItems:Array;
      
      public var levelEnemies:Array;
      
      public var levelGroups:Array;
      
      public var levelNPCs:Array;
      
      public var levelNumberAreas:Array;
      
      public var levelWeatherAreas:Array;
      
      public var levelHeroStartPositions:Array;
      
      public var hiddenAreas:Array;
      
      public var verPathScripts:Vector.<Rectangle>;
      
      public var horPathScripts:Vector.<Rectangle>;
      
      public var ropeScripts:Vector.<Rectangle>;
      
      public var decorationScripts:Vector.<DecorationScript>;
      
      public var circularRayScripts:Vector.<Rectangle>;
      
      public var greenPlatforms:Vector.<DecorationScript>;
      
      public var level:Level;
      
      public function ScriptsManager(_level:Level)
      {
         var i:int = 0;
         var j:int = 0;
         var n:int = 0;
         var x_t:int = 0;
         var y_t:int = 0;
         var w_t:int = 0;
         var h_t:int = 0;
         var _x:int = 0;
         var _y:int = 0;
         var _direction:int = 0;
         var tile_value:int = 0;
         var rotation:Number = NaN;
         var gScript:GenericScript = null;
         var obj:DisplayObjectContainer = null;
         var tile_id:int = 0;
         var _obj:XML = null;
         super();
         this.level = _level;
         var area:Rectangle = new Rectangle();
         var levelMap:MovieClip = this.level.levelMap;
         this.goldenCatXPos = this.goldenCatYPos = 0;
         this.initialXPos = this.initialYPos = this.initialDirection = this.initialEntryType = 0;
         this.levelTiles = new Array();
         this.levelCollisions = new Array();
         this.levelDecorations = new Array();
         this.levelItems = new Array();
         this.levelEnemies = new Array();
         this.levelGroups = new Array();
         this.levelNPCs = new Array();
         this.levelNumberAreas = new Array();
         this.levelWeatherAreas = new Array();
         this.levelHeroStartPositions = new Array();
         this.verPathScripts = new Vector.<Rectangle>();
         this.horPathScripts = new Vector.<Rectangle>();
         this.ropeScripts = new Vector.<Rectangle>();
         this.decorationScripts = new Vector.<DecorationScript>();
         this.circularRayScripts = new Vector.<Rectangle>();
         this.greenPlatforms = new Vector.<DecorationScript>();
         this.hiddenAreas = new Array();
         CollisionsScriptsManager.CheckCollisionsScripts(this.level.map,this.levelCollisions);
         DecorationsScriptsManager.CheckDecorationsScripts(this.level.map,this.levelDecorations);
         EnemiesScriptsManager.CheckEnemiesScripts(this.level.map,this.levelEnemies);
         ItemsScriptsManager.CheckItemsScripts(this.level.map,this.levelItems);
         NPCsScriptsManager.CheckNPCsScripts(this.level.map,this.levelNPCs);
         for each(_obj in this.level.map.data[0].obj)
         {
            if(_obj.@_class == "StartPosition")
            {
               _x = int(_obj.@x);
               _y = int(_obj.@y);
               _direction = int(_obj.@dir);
               this.levelHeroStartPositions.push(new StartPosition(_x,_y,_direction,_obj.@type));
            }
            else if(_obj.@_class == "LevelStartScript")
            {
               this.level.levelData.START_X = _obj.@x;
               this.level.levelData.START_Y = _obj.@y;
            }
            else if(_obj.@_class == "LevelEndScript")
            {
               this.level.levelData.END_X = _obj.@x;
               this.level.levelData.END_Y = _obj.@y;
            }
            else if(_obj.@_class == "GoldenCatScript")
            {
               this.goldenCatXPos = _obj.@x;
               this.goldenCatYPos = _obj.@y;
            }
            else if(_obj.@_class == "CameraLeftMargin")
            {
               this.level.levelData.LEFT_MARGIN = _obj.@x;
            }
            else if(_obj.@_class == "CameraRightMargin")
            {
               this.level.levelData.RIGHT_MARGIN = _obj.@x;
            }
            else if(_obj.@_class == "GroupScript")
            {
               gScript = new GenericScript(0,_obj.@x,_obj.@y,_obj.@w,_obj.@h);
               this.levelGroups.push(gScript);
            }
            else if(_obj.@_class == "GroupBackScript")
            {
               gScript = new GenericScript(1,_obj.@x,_obj.@y,_obj.@w,_obj.@h);
               this.levelGroups.push(gScript);
            }
            else if(_obj.@_class == "GroupBackTopScript")
            {
               gScript = new GenericScript(2,_obj.@x,_obj.@y,_obj.@w,_obj.@h);
               this.levelGroups.push(gScript);
            }
            if(_obj.@_class == "ButterflyScript1")
            {
               this.level.levelData.butterflyPositions[0].x = _obj.@x;
               this.level.levelData.butterflyPositions[0].y = _obj.@y;
            }
            else if(_obj.@_class == "ButterflyScript2")
            {
               this.level.levelData.butterflyPositions[1].x = _obj.@x;
               this.level.levelData.butterflyPositions[1].y = _obj.@y;
            }
            else if(_obj.@_class == "ButterflyScript3")
            {
               this.level.levelData.butterflyPositions[2].x = _obj.@x;
               this.level.levelData.butterflyPositions[2].y = _obj.@y;
            }
            else if(_obj.@_class == "ButterflyScript4")
            {
               this.level.levelData.butterflyPositions[3].x = _obj.@x;
               this.level.levelData.butterflyPositions[3].y = _obj.@y;
            }
            else if(_obj.@_class == "ButterflyScript5")
            {
               this.level.levelData.butterflyPositions[4].x = _obj.@x;
               this.level.levelData.butterflyPositions[4].y = _obj.@y;
            }
            else if(_obj.@_class == "NumberScript0")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,0));
            }
            else if(_obj.@_class == "NumberScript1")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,1));
            }
            else if(_obj.@_class == "NumberScript2")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,2));
            }
            else if(_obj.@_class == "NumberScript3")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,3));
            }
            else if(_obj.@_class == "NumberScript4")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,4));
            }
            else if(_obj.@_class == "NumberScript5")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,5));
            }
            else if(_obj.@_class == "NumberScript6")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,6));
            }
            else if(_obj.@_class == "NumberScript7")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,7));
            }
            else if(_obj.@_class == "NumberScript8")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,8));
            }
            else if(_obj.@_class == "NumberScript9")
            {
               this.levelNumberAreas.push(new Rectangle(_obj.@x,_obj.@y,9));
            }
            else if(_obj.@_class == "DoorSnowScript1")
            {
               this.levelWeatherAreas.push(new Rectangle(_obj.@x,_obj.@y,1));
            }
            else if(_obj.@_class == "CircularRayScript")
            {
               this.circularRayScripts.push(new Rectangle(_obj.@x,_obj.@y,_obj.@w,_obj.@h));
            }
            else if(_obj.@_class == "GreenPlatformScript")
            {
               this.greenPlatforms.push(new DecorationScript("GreenPlatformScript",_obj.@x,_obj.@y,_obj.@w,_obj.@h));
            }
            else if(_obj.@_class == "GreenPlatformScript2")
            {
               this.greenPlatforms.push(new DecorationScript("GreenPlatformScript2",_obj.@x,_obj.@y,_obj.@w,_obj.@h));
            }
            else if(_obj.@_class == "isDecorationScript")
            {
               this.decorationScripts.push(new DecorationScript(_obj.@name,_obj.@x,_obj.@y,_obj.@w,_obj.@h,_obj.@scale_x,_obj.@scale_y,_obj.@param_1,_obj.@param_2));
            }
            else if(_obj.@_class == "HiddenAreaScript")
            {
               this.hiddenAreas.push(new Rectangle(_obj.@x,_obj.@y,_obj.@w,_obj.@h));
            }
            else if(_obj.@_class == "VerPathScript")
            {
               this.verPathScripts.push(new Rectangle(_obj.@x,_obj.@y,_obj.@w,_obj.@h));
            }
            else if(_obj.@_class == "HorPathScript")
            {
               this.horPathScripts.push(new Rectangle(_obj.@x,_obj.@y,_obj.@w,_obj.@h));
            }
            else if(_obj.@_class == "RopeScript")
            {
               this.ropeScripts.push(new Rectangle(_obj.@x,_obj.@y,_obj.@w,_obj.@h));
            }
            else if(_obj.@_class == "bg_sea_y")
            {
               this.level.levelData.bg_sea_reflections_y = _obj.@y;
            }
         }
         for(i = 0; i < this.levelHeroStartPositions.length; i++)
         {
            this.levelHeroStartPositions[i].INDEX = this.getIntersectingNumberId(this.levelHeroStartPositions[i].x,this.levelHeroStartPositions[i].y,16,16);
         }
         this.evaluateHeroStartPosition();
         this.level.levelData.init();
      }
      
      public function getIntersectingNumberId(xPos:int, yPos:int, WIDTH:int, HEIGHT:int) : int
      {
         var i:int = 0;
         var area_1:Rectangle = new Rectangle(xPos,yPos,WIDTH,HEIGHT);
         var area_2:Rectangle = new Rectangle();
         for(i = 0; i < this.levelNumberAreas.length; i++)
         {
            area_2.x = this.levelNumberAreas[i].x - 4;
            area_2.y = this.levelNumberAreas[i].y - 4;
            area_2.width = 8;
            area_2.height = 8;
            if(area_1.intersects(area_2))
            {
               return this.levelNumberAreas[i].width;
            }
         }
         return 0;
      }
      
      public function getIntersectingWeatherId(xPos:int, yPos:int, WIDTH:int, HEIGHT:int) : int
      {
         var i:int = 0;
         var area_1:Rectangle = new Rectangle(xPos,yPos,WIDTH,HEIGHT);
         var area_2:Rectangle = new Rectangle();
         for(i = 0; i < this.levelWeatherAreas.length; i++)
         {
            area_2.x = this.levelWeatherAreas[i].x - 4;
            area_2.y = this.levelWeatherAreas[i].y - 4;
            area_2.width = 8;
            area_2.height = 8;
            if(area_1.intersects(area_2))
            {
               return this.levelWeatherAreas[i].width;
            }
         }
         return 0;
      }
      
      protected function evaluateHeroStartPosition() : void
      {
         var i:int = 0;
         for(i = 0; i < this.levelHeroStartPositions.length; i++)
         {
            if(this.levelHeroStartPositions[i].INDEX == Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID])
            {
               this.initialXPos = this.levelHeroStartPositions[i].x;
               this.initialYPos = this.levelHeroStartPositions[i].y;
               this.initialDirection = this.levelHeroStartPositions[i].DIRECTION;
               this.initialEntryType = this.levelHeroStartPositions[i].TYPE;
            }
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.greenPlatforms.length; i++)
         {
            if(this.greenPlatforms[i] != null)
            {
               this.greenPlatforms[i].destroy();
            }
            this.greenPlatforms[i] = null;
         }
         this.greenPlatforms = null;
         for(i = 0; i < this.circularRayScripts.length; i++)
         {
            this.circularRayScripts[i] = null;
         }
         this.circularRayScripts = null;
         for(i = 0; i < this.ropeScripts.length; i++)
         {
            this.ropeScripts[i] = null;
         }
         this.ropeScripts = null;
         for(i = 0; i < this.decorationScripts.length; i++)
         {
            if(this.decorationScripts[i] != null)
            {
               this.decorationScripts[i].destroy();
            }
            this.decorationScripts[i] = null;
         }
         this.decorationScripts = null;
         for(i = 0; i < this.verPathScripts.length; i++)
         {
            this.verPathScripts[i] = null;
         }
         this.verPathScripts = null;
         for(i = 0; i < this.horPathScripts.length; i++)
         {
            this.horPathScripts[i] = null;
         }
         this.horPathScripts = null;
         for(i = 0; i < this.hiddenAreas.length; i++)
         {
            this.hiddenAreas[i] = null;
         }
         this.hiddenAreas = null;
         for(i = 0; i < this.levelNumberAreas.length; i++)
         {
            this.levelNumberAreas[i] = null;
         }
         this.levelNumberAreas = null;
         for(i = 0; i < this.levelWeatherAreas.length; i++)
         {
            this.levelWeatherAreas[i] = null;
         }
         this.levelWeatherAreas = null;
         for(i = 0; i < this.levelHeroStartPositions.length; i++)
         {
            this.levelHeroStartPositions[i] = null;
         }
         this.levelHeroStartPositions = null;
         for(i = 0; i < this.levelTiles.length; i++)
         {
            this.levelTiles[i] = null;
         }
         this.levelTiles = null;
         for(i = 0; i < this.levelCollisions.length; i++)
         {
            this.levelCollisions[i] = null;
         }
         this.levelCollisions = null;
         for(i = 0; i < this.levelDecorations.length; i++)
         {
            this.levelDecorations[i] = null;
         }
         this.levelDecorations = null;
         for(i = 0; i < this.levelItems.length; i++)
         {
            this.levelItems[i] = null;
         }
         this.levelItems = null;
         for(i = 0; i < this.levelEnemies.length; i++)
         {
            this.levelEnemies[i] = null;
         }
         this.levelEnemies = null;
         for(i = 0; i < this.levelGroups.length; i++)
         {
            this.levelGroups[i] = null;
         }
         this.levelGroups = null;
         for(i = 0; i < this.levelNPCs.length; i++)
         {
            this.levelNPCs[i] = null;
         }
         this.levelNPCs = null;
         this.level = null;
      }
   }
}
