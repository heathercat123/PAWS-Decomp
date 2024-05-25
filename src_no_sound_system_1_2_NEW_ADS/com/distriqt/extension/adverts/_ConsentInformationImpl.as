package com.distriqt.extension.adverts
{
   import com.distriqt.extension.adverts.ump.ConsentInformation;
   import com.distriqt.extension.adverts.ump.ConsentRequestParameters;
   import com.distriqt.extension.adverts.ump.events.ConsentInformationEvent;
   import flash.events.EventDispatcher;
   
   internal class _ConsentInformationImpl extends EventDispatcher implements ConsentInformation
   {
      
      private static const TAG:String = "_ConsentInformationImpl";
       
      
      public function _ConsentInformationImpl()
      {
         super();
      }
      
      public function getConsentStatus() : int
      {
         return 0;
      }
      
      public function getConsentType() : int
      {
         return 0;
      }
      
      public function isConsentFormAvailable() : Boolean
      {
         return false;
      }
      
      public function requestConsentInfoUpdate(param1:ConsentRequestParameters) : void
      {
         dispatchEvent(new ConsentInformationEvent("consentInfoUpdateFailure",new Error("Not supported",0)));
      }
      
      public function reset() : void
      {
      }
   }
}
