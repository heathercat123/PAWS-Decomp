package com.distriqt.extension.adverts
{
   public class AdvertisingIdInfo
   {
      
      private static const TAG:String = "AdvertisingIdInfo";
       
      
      public var advertisingId:String = "";
      
      public var isLimitAdTrackingEnabled:Boolean = false;
      
      public function AdvertisingIdInfo()
      {
         super();
      }
      
      internal static function fromObject(param1:Object) : AdvertisingIdInfo
      {
         var _loc2_:AdvertisingIdInfo = new AdvertisingIdInfo();
         if(param1.hasOwnProperty("advertisingId"))
         {
            _loc2_.advertisingId = param1.advertisingId;
         }
         if(param1.hasOwnProperty("isLimitAdTrackingEnabled"))
         {
            _loc2_.isLimitAdTrackingEnabled = param1.isLimitAdTrackingEnabled;
         }
         return _loc2_;
      }
   }
}
