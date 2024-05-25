package com.distriqt.extension.inappbilling.events
{
   import flash.events.DataEvent;
   import flash.events.Event;
   
   public class AvailabilityEvent extends DataEvent
   {
      
      private static const TAG:String = "AvailabilityEvent";
      
      public static const COMPLETE:String = "availability_complete";
       
      
      public function AvailabilityEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = "")
      {
         super(param1,param2,param3,param4);
      }
      
      public function get availability() : String
      {
         return this.data;
      }
      
      override public function clone() : Event
      {
         return new AvailabilityEvent(type,bubbles,cancelable,data);
      }
   }
}
