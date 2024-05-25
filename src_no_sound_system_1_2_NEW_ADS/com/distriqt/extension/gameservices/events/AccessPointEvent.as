package com.distriqt.extension.gameservices.events
{
   import flash.events.Event;
   
   public class AccessPointEvent extends Event
   {
      
      private static const TAG:String = "AccessPointEvent";
      
      public static const FRAME_CHANGED:String = "accesspoint_frame_changed";
       
      
      public function AccessPointEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new AccessPointEvent(type,bubbles,cancelable);
      }
   }
}
