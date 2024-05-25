package com.distriqt.extension.application
{
   public class Locale
   {
      
      private static const TAG:String = "Locale";
       
      
      public var country:String = "";
      
      public var language:String = "";
      
      public function Locale()
      {
         super();
      }
      
      internal static function fromObject(param1:Object) : Locale
      {
         var _loc2_:Locale = null;
         if(param1 != null)
         {
            _loc2_ = new Locale();
            if(param1.hasOwnProperty("country"))
            {
               _loc2_.country = param1.country;
            }
            if(param1.hasOwnProperty("language"))
            {
               _loc2_.language = param1.language;
            }
            return _loc2_;
         }
         return null;
      }
   }
}
