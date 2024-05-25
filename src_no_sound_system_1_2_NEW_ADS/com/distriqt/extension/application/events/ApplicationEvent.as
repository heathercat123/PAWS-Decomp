package com.distriqt.extension.application.events
{
   import flash.events.Event;
   
   public class ApplicationEvent extends Event
   {
      
      public static const UI_NAVIGATION_CHANGED:String = "ui:navigation:changed";
       
      
      public var option:String = "";
      
      public function ApplicationEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.option = param2;
      }
      
      override public function clone() : Event
      {
         return new ApplicationEvent(type,option,bubbles,cancelable);
      }
   }
}
