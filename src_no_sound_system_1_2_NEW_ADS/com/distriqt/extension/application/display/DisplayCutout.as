package com.distriqt.extension.application.display
{
   public class DisplayCutout
   {
      
      private static const TAG:String = "DisplayCutout";
       
      
      public var safeInsetTop:int = 0;
      
      public var safeInsetLeft:int = 0;
      
      public var safeInsetRight:int = 0;
      
      public var safeInsetBottom:int = 0;
      
      public function DisplayCutout()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : DisplayCutout
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:DisplayCutout = new DisplayCutout();
         if(param1.hasOwnProperty("top"))
         {
            _loc2_.safeInsetTop = param1.top;
         }
         if(param1.hasOwnProperty("left"))
         {
            _loc2_.safeInsetLeft = param1.left;
         }
         if(param1.hasOwnProperty("right"))
         {
            _loc2_.safeInsetRight = param1.right;
         }
         if(param1.hasOwnProperty("bottom"))
         {
            _loc2_.safeInsetBottom = param1.bottom;
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         return "[" + safeInsetTop + "," + safeInsetLeft + "," + safeInsetRight + "," + safeInsetBottom + "]";
      }
   }
}
