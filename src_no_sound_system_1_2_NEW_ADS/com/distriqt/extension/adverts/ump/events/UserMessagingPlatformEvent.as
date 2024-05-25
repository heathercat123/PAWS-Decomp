package com.distriqt.extension.adverts.ump.events
{
   import flash.events.Event;
   
   public class UserMessagingPlatformEvent extends Event
   {
      
      private static const TAG:String = "UserMessagingPlatformEvent";
      
      public static const CONSENT_FORM_LOAD_SUCCESS:String = "consentFormLoadSuccess";
      
      public static const CONSENT_FORM_LOAD_FAILURE:String = "consentFormLoadFailure";
      
      public static const CONSENT_FORM_DISMISSED:String = "consentFormDismissed";
       
      
      public var error:Error;
      
      public function UserMessagingPlatformEvent(param1:String, param2:Error = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.error = param2;
      }
      
      override public function clone() : Event
      {
         return new UserMessagingPlatformEvent(type,error,bubbles,cancelable);
      }
   }
}
