package com.distriqt.extension.adverts.ump.events
{
   import flash.events.Event;
   
   public class ConsentInformationEvent extends Event
   {
      
      private static const TAG:String = "ConsentInformationEvent";
      
      public static const CONSENT_INFO_UPDATE_SUCCESS:String = "consentInfoUpdateSuccess";
      
      public static const CONSENT_INFO_UPDATE_FAILURE:String = "consentInfoUpdateFailure";
       
      
      public var error:Error;
      
      public function ConsentInformationEvent(param1:String, param2:Error = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.error = param2;
      }
      
      override public function clone() : Event
      {
         return new ConsentInformationEvent(type,error,bubbles,cancelable);
      }
   }
}
