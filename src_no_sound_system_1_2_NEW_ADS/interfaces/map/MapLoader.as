package interfaces.map
{
   import flash.display.DisplayObject;
   import game_utils.GameSlot;
   import levels.GenericScript;
   
   public class MapLoader
   {
      
      public static const World_Map_1:Class = MapLoader_World_Map_1;
      
      public static const World_Map_2:Class = MapLoader_World_Map_2;
       
      
      public var mapTiles:Array;
      
      public var mapLevels:Array;
      
      public var mapDecorations:Array;
      
      public var mapCoins:Array;
      
      public var worldMap:WorldMap;
      
      public var mapEndX:Number;
      
      public function MapLoader(_worldMap:WorldMap)
      {
         var i:int = 0;
         var gScript:GenericScript = null;
         var map:XML = null;
         var _obj:XML = null;
         super();
         this.mapEndX = 848 - 24;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 0)
         {
            map = new XML(new World_Map_1());
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_WORLD_MAP_ID] == 1)
         {
            map = new XML(new World_Map_2());
         }
         else
         {
            map = new XML(new World_Map_1());
         }
         this.worldMap = _worldMap;
         this.mapTiles = new Array();
         this.mapLevels = new Array();
         this.mapDecorations = new Array();
         this.mapCoins = new Array();
         for each(_obj in map.data[0].obj)
         {
            if(_obj.@_class == "LevelEndScript")
            {
               this.mapEndX = _obj.@x - 24;
            }
         }
         for each(_obj in map.decorations[0].obj)
         {
            gScript = new GenericScript(_obj.@type,_obj.@x,_obj.@y,_obj.@w,_obj.@h,_obj.@rot);
            gScript.value1 = _obj.@val_1;
            gScript.value2 = _obj.@val_2;
            this.mapDecorations.push(gScript);
         }
         for each(_obj in map.buttons[0].obj)
         {
            gScript = new GenericScript(_obj.@type,_obj.@x,_obj.@y,_obj.@w);
            this.mapLevels.push(gScript);
         }
         for each(_obj in map.items[0].obj)
         {
            gScript = new GenericScript(_obj.@type,_obj.@x,_obj.@y,_obj.@w);
            this.mapCoins.push(gScript);
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.mapTiles.length; i++)
         {
            this.mapTiles[i] = null;
         }
         for(i = 0; i < this.mapLevels.length; i++)
         {
            this.mapLevels[i] = null;
         }
         for(i = 0; i < this.mapDecorations.length; i++)
         {
            this.mapDecorations[i] = null;
         }
         for(i = 0; i < this.mapCoins.length; i++)
         {
            this.mapCoins[i] = null;
         }
         this.mapTiles = null;
         this.mapLevels = null;
         this.mapDecorations = null;
         this.mapCoins = null;
         this.worldMap = null;
      }
      
      protected function isTileScript(object:DisplayObject) : Boolean
      {
         return false;
      }
      
      protected function getTileId(object:DisplayObject) : int
      {
         return 0;
      }
      
      protected function isDecorationScript(object:DisplayObject) : Boolean
      {
         if(this.getDecorationId(object) >= 0)
         {
            return true;
         }
         return false;
      }
      
      protected function getDecorationId(object:DisplayObject) : int
      {
         return -1;
      }
      
      protected function getParam(_string:String, _index:int) : int
      {
         var array:Array = _string.split("_");
         return Number(array[_index]);
      }
      
      protected function isFlipped(obj:DisplayObject) : Boolean
      {
         return obj.transform.matrix.a / obj.scaleX == -1;
      }
      
      protected function isFlippedVer(obj:DisplayObject) : Boolean
      {
         return obj.transform.matrix.d / obj.scaleY == -1;
      }
   }
}
