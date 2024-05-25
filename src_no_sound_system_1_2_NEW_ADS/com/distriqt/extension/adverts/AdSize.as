package com.distriqt.extension.adverts
{
   public class AdSize
   {
      
      private static const TAG:String = "AdSize";
      
      public static const AUTO_HEIGHT:int = -2;
      
      public static const FULL_WIDTH:int = -1;
      
      public static const BANNER:AdSize = AdSize.defaultType(320,50,"320x50_mb");
      
      public static const FLUID:AdSize = AdSize.defaultType(-3,-4,"fluid");
      
      public static const FULL_BANNER:AdSize = AdSize.defaultType(468,60,"468x60_as");
      
      public static const LARGE_BANNER:AdSize = AdSize.defaultType(320,100,"320x100_as");
      
      public static const LEADERBOARD:AdSize = AdSize.defaultType(728,90,"728x90_as");
      
      public static const MEDIUM_RECTANGLE:AdSize = AdSize.defaultType(300,250,"300x250_as");
      
      public static const SEARCH:AdSize = AdSize.defaultType(-3,0,"search_v2");
      
      [Deprecated(message="Use adaptive banner sizing")]
      public static const SMART_BANNER:AdSize = AdSize.defaultType(-1,-2,"smart_banner");
      
      public static const WIDE_SKYSCRAPER:AdSize = AdSize.defaultType(160,600,"160x600_as");
       
      
      public var width:int;
      
      public var height:int;
      
      private var _widthInPixels:int = -1;
      
      private var _heightInPixels:int = -1;
      
      private var _type:String = "";
      
      public function AdSize(param1:int = 320, param2:int = 50)
      {
         super();
         this.width = param1;
         this.height = param2;
      }
      
      private static function defaultType(param1:int, param2:int, param3:String) : AdSize
      {
         var _loc4_:AdSize;
         (_loc4_ = new AdSize(param1,param2))._type = param3;
         return _loc4_;
      }
      
      internal static function fromObject(param1:Object) : AdSize
      {
         var _loc2_:AdSize = new AdSize();
         if(param1.hasOwnProperty("width"))
         {
            _loc2_.width = param1.width;
         }
         if(param1.hasOwnProperty("height"))
         {
            _loc2_.height = param1.height;
         }
         if(param1.hasOwnProperty("type"))
         {
            _loc2_._type = param1.type;
         }
         if(param1.hasOwnProperty("widthInPixels"))
         {
            _loc2_._widthInPixels = param1.widthInPixels;
         }
         if(param1.hasOwnProperty("heightInPixels"))
         {
            _loc2_._heightInPixels = param1.heightInPixels;
         }
         return _loc2_;
      }
      
      public function get widthInPixels() : int
      {
         return _widthInPixels;
      }
      
      public function get heightInPixels() : int
      {
         return _heightInPixels;
      }
      
      public function get type() : String
      {
         return _type;
      }
   }
}
