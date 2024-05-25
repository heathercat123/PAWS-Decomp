package com.distriqt.extension.adverts
{
   public class AdViewParams
   {
      
      public static const ALIGN_NONE:String = "none";
      
      public static const ALIGN_TOP:String = "top";
      
      public static const ALIGN_BOTTOM:String = "bottom";
      
      public static const ALIGN_LEFT:String = "left";
      
      public static const ALIGN_RIGHT:String = "right";
      
      public static const ALIGN_CENTER:String = "center";
       
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _x:int = 0;
      
      private var _y:int = 0;
      
      private var _verticalAlign:String = "none";
      
      private var _horizontalAlign:String = "none";
      
      public function AdViewParams()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : AdViewParams
      {
         var _loc2_:AdViewParams = new AdViewParams();
         if(param1.hasOwnProperty("x"))
         {
            _loc2_.x = param1.x;
         }
         if(param1.hasOwnProperty("y"))
         {
            _loc2_.y = param1.y;
         }
         if(param1.hasOwnProperty("width"))
         {
            _loc2_.width = param1.width;
         }
         if(param1.hasOwnProperty("height"))
         {
            _loc2_.height = param1.height;
         }
         if(param1.hasOwnProperty("horizontalAlign"))
         {
            _loc2_.horizontalAlign = param1.horizontalAlign;
         }
         if(param1.hasOwnProperty("verticalAlign"))
         {
            _loc2_.verticalAlign = param1.verticalAlign;
         }
         return _loc2_;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function set width(param1:int) : void
      {
         _width = param1;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function set height(param1:int) : void
      {
         _height = param1;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function set x(param1:int) : void
      {
         _x = param1;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function set y(param1:int) : void
      {
         _y = param1;
      }
      
      public function get verticalAlign() : String
      {
         return _verticalAlign;
      }
      
      public function set verticalAlign(param1:String) : void
      {
         _verticalAlign = param1;
      }
      
      public function get horizontalAlign() : String
      {
         return _horizontalAlign;
      }
      
      public function set horizontalAlign(param1:String) : void
      {
         _horizontalAlign = param1;
      }
      
      public function toString() : String
      {
         return String(_x) + "," + String(_y) + "," + String(_width) + "," + String(_height);
      }
   }
}
