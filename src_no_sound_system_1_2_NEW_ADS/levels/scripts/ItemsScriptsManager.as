package levels.scripts
{
   import flash.display.DisplayObject;
   import game_utils.*;
   import levels.GenericScript;
   
   public class ItemsScriptsManager
   {
      
      public function ItemsScriptsManager()
      {
         super();
      }
      
      public static function CheckItemsScripts(map:XML, array:Array) : void
      {
         var obj:XML = null;
         var gScript:GenericScript = null;
         for each(obj in map.items[0].obj)
         {
            gScript = new GenericScript(obj.@type,obj.@x,obj.@y,obj.@w,obj.@h,obj.@rot);
            gScript.ai = obj.@ai;
            gScript.value1 = obj.@val_1;
            gScript.value2 = obj.@val_2;
            gScript.value3 = obj.@val_3;
            array.push(gScript);
         }
      }
      
      protected static function getParam(_string:String, _index:int) : int
      {
         var array:Array = _string.split("_");
         return Number(array[_index]);
      }
      
      protected static function isFlipped(obj:DisplayObject) : Boolean
      {
         return obj.transform.matrix.a / obj.scaleX == -1;
      }
      
      protected static function isFlippedVer(obj:DisplayObject) : Boolean
      {
         return obj.transform.matrix.d / obj.scaleY == -1;
      }
   }
}

