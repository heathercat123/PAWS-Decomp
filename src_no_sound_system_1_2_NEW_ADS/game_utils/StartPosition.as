package game_utils
{
   public class StartPosition
   {
      
      public static const STATIC:int = 0;
      
      public static const FENCE:int = 1;
      
      public static const DOOR:int = 2;
       
      
      public var x:int;
      
      public var y:int;
      
      public var DIRECTION:int;
      
      public var TYPE:int;
      
      public var INDEX:int;
      
      public function StartPosition(_x:int, _y:int, _DIRECTION:int, _TYPE:int, _INDEX:int = 0)
      {
         super();
         this.x = _x;
         this.y = _y;
         this.DIRECTION = _DIRECTION;
         this.TYPE = _TYPE;
         this.INDEX = _INDEX;
      }
   }
}
