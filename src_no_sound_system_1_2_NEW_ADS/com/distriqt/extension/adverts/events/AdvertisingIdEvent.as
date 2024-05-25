package com.distriqt.extension.adverts.events
{
   import com.distriqt.extension.adverts.AdvertisingIdInfo;
   import flash.events.Event;
   
   public class AdvertisingIdEvent extends Event
   {
      
      public static const ADVERTISING_ID:String = "advert:advertisingid";
       
      
      public var info:AdvertisingIdInfo;
      
      public function AdvertisingIdEvent(param1:String, param2:AdvertisingIdInfo, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.info = param2;
      }
      
      override public function clone() : Event
      {
         return new AdvertisingIdEvent(type,info,bubbles,cancelable);
      }
   }
}
