package com.distriqt.extension.application.events
{
   import flash.events.Event;
   
   public class DeviceOrientationEvent extends Event
   {
      
      public static const CHANGED:String = "orientation:changed";
       
      
      public var orientation:String = "unknown";
      
      public function DeviceOrientationEvent(param1:String, param2:String = "unknown", param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.orientation = param2;
      }
      
      override public function clone() : Event
      {
         return new DeviceOrientationEvent(type,orientation,bubbles,cancelable);
      }
   }
}
