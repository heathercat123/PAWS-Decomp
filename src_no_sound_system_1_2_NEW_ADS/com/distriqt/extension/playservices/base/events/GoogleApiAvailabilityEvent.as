package com.distriqt.extension.playservices.base.events
{
   import flash.events.Event;
   
   public class GoogleApiAvailabilityEvent extends Event
   {
      
      private static const TAG:String = "GoogleApiAvailabilityEvent";
      
      public static const ERROR_DIALOG_CLOSED:String = "apiavailability_error_dialog_closed";
       
      
      public function GoogleApiAvailabilityEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new GoogleApiAvailabilityEvent(type,bubbles,cancelable);
      }
   }
}
