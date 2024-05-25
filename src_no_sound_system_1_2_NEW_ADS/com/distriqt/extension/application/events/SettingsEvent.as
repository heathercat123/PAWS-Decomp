package com.distriqt.extension.application.events
{
   import flash.events.Event;
   
   public class SettingsEvent extends Event
   {
      
      public static const CHANGED:String = "settings:changed";
       
      
      public var key:String;
      
      public function SettingsEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.key = param2;
      }
      
      override public function clone() : Event
      {
         return new SettingsEvent(type,key,bubbles,cancelable);
      }
   }
}
