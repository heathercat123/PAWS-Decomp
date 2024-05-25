package levels.scripts
{
   import flash.display.DisplayObject;
   import game_utils.*;
   import levels.GenericScript;
   
   public class EnemiesScriptsManager
   {
       
      
      public function EnemiesScriptsManager()
      {
         super();
      }
      
      public static function CheckEnemiesScripts(map:XML, array:Array) : void
      {
         var obj:XML = null;
         var _obj:XML = null;
         var i:int = 0;
         var amount:int = 0;
         var step:Number = NaN;
         var gScript:GenericScript = null;
         for each(obj in map.enemies[0].obj)
         {
            gScript = new GenericScript(obj.@type,obj.@x,obj.@y,obj.@w,obj.@h,obj.@rot);
            gScript.ai = obj.@ai;
            gScript.value1 = obj.@val_1;
            gScript.value2 = obj.@val_2;
            gScript.value3 = obj.@val_3;
            array.push(gScript);
         }
         for each(_obj in map.data[0].obj)
         {
            if(_obj.@_class == "JellyfishCircleScript1")
            {
               amount = _obj.@w / 20;
               step = Math.PI * 1.25 / amount;
               for(i = 0; i < amount; i++)
               {
                  gScript = new GenericScript(39,int(_obj.@x - 8),int(_obj.@y),_obj.@f_x);
                  gScript.ai = 1;
                  gScript.value1 = _obj.@w * 0.5;
                  gScript.value2 = step * i;
                  array.push(gScript);
               }
            }
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
