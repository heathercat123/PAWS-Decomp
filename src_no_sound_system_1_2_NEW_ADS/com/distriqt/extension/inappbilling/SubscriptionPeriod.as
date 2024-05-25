package com.distriqt.extension.inappbilling
{
   public class SubscriptionPeriod
   {
      
      private static const TAG:String = "SubscriptionPeriod";
      
      public static const UNIT_DAY:String = "day";
      
      public static const UNIT_WEEK:String = "week";
      
      public static const UNIT_MONTH:String = "month";
      
      public static const UNIT_YEAR:String = "year";
       
      
      public var numberOfUnits:int = 0;
      
      public var unit:String = "";
      
      public function SubscriptionPeriod()
      {
         super();
      }
      
      internal static function fromObject(param1:Object) : SubscriptionPeriod
      {
         var _loc2_:SubscriptionPeriod = new SubscriptionPeriod();
         if(param1.hasOwnProperty("numberOfUnits"))
         {
            _loc2_.numberOfUnits = param1.numberOfUnits;
         }
         if(param1.hasOwnProperty("unit"))
         {
            _loc2_.unit = param1.unit;
         }
         return _loc2_;
      }
   }
}
