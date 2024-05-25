package com.distriqt.extension.application.events
{
   import flash.events.Event;
   
   public class AuthorisationEvent extends Event
   {
      
      public static const CHANGED:String = "authorisation:changed";
       
      
      public var status:String = "unknown";
      
      public function AuthorisationEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.status = param2;
      }
      
      override public function clone() : Event
      {
         return new AuthorisationEvent(type,status,bubbles,cancelable);
      }
   }
}
