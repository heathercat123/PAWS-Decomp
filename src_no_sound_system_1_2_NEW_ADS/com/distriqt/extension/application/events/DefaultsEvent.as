package com.distriqt.extension.application.events
{
   import flash.events.Event;
   
   public class DefaultsEvent extends Event
   {
      
      public static const CHANGED:String = "defaults:changed";
       
      
      public var key:String;
      
      public function DefaultsEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.key = param2;
      }
      
      override public function clone() : Event
      {
         return new DefaultsEvent(type,key,bubbles,cancelable);
      }
   }
}
