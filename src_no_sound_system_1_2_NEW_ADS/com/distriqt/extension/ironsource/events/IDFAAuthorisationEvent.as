package com.distriqt.extension.ironsource.events
{
   import flash.events.Event;
   
   public class IDFAAuthorisationEvent extends Event
   {
      
      private static const TAG:String = "IDFAAuthorisationEvent";
      
      public static const CHANGED:String = "idfa:authorisation:changed";
       
      
      public var authorisationStatus:String;
      
      public function IDFAAuthorisationEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.authorisationStatus = param2;
      }
      
      override public function clone() : Event
      {
         return new IDFAAuthorisationEvent(type,authorisationStatus,bubbles,cancelable);
      }
   }
}
