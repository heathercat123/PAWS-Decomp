package com.distriqt.extension.application.events
{
   import flash.events.Event;
   
   public class DeviceStateEvent extends Event
   {
      
      private static const TAG:String = "DeviceStateEvent";
      
      public static const IDLE_MODE_CHANGED:String = "application:device:idlemode:changed";
      
      public static const POWER_SAVE_MODE_CHANGED:String = "application:device:powersavemode:changed";
       
      
      public function DeviceStateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
