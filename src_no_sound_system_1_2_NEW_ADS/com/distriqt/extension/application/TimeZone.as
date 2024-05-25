package com.distriqt.extension.application
{
   public class TimeZone
   {
      
      private static const TAG:String = "TimeZone";
       
      
      public var id:String;
      
      public var abbreviation:String;
      
      public var description:String;
      
      public var utcOffset:Number;
      
      public function TimeZone()
      {
         super();
      }
      
      internal static function fromObject(param1:Object) : Number
      {
         return null;
      }
   }
}
