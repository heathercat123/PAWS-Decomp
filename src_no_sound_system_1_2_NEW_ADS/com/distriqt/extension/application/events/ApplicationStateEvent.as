package com.distriqt.extension.application.events
{
   import flash.events.Event;
   
   public class ApplicationStateEvent extends Event
   {
      
      public static const DEACTIVATE:String = "applicationstate:deactivate";
      
      public static const ACTIVATE:String = "applicationstate:activate";
      
      public static const BACKGROUND:String = "applicationstate:background";
      
      public static const FOREGROUND:String = "applicationstate:foreground";
      
      public static const CODE_HOME:String = "deactivate:home";
      
      public static const CODE_LOCK:String = "deactivate:lock";
       
      
      public var code:String;
      
      public var description:String;
      
      public function ApplicationStateEvent(param1:String, param2:String, param3:String = "", param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.code = param2;
         this.description = param3;
      }
      
      override public function clone() : Event
      {
         return new ApplicationStateEvent(type,code,description,bubbles,cancelable);
      }
   }
}
