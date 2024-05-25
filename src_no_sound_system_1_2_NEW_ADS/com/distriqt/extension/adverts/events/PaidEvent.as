package com.distriqt.extension.adverts.events
{
   import com.distriqt.extension.adverts.AdValue;
   import flash.events.Event;
   
   public class PaidEvent extends Event
   {
      
      public static const PAID:String = "paidevent_paid";
       
      
      public var adValue:AdValue;
      
      public function PaidEvent(param1:String, param2:AdValue, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.adValue = param2;
      }
      
      override public function clone() : Event
      {
         return new PaidEvent(type,adValue,bubbles,cancelable);
      }
   }
}
