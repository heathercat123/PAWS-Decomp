package com.distriqt.extension.adverts
{
   import com.distriqt.extension.adverts.consent.Consent;
   import com.distriqt.extension.adverts.consent.ConsentOptions;
   import flash.events.EventDispatcher;
   
   public class _ConsentImpl extends EventDispatcher implements Consent
   {
      
      private static const TAG:String = "_ConsentImpl";
       
      
      public function _ConsentImpl()
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function addTestDevice(param1:String) : void
      {
      }
      
      public function setDebugGeography(param1:int) : void
      {
      }
      
      public function getConsentStatus(param1:String) : void
      {
      }
      
      public function setConsentStatus(param1:String) : void
      {
      }
      
      public function askForConsent(param1:ConsentOptions) : Boolean
      {
         return false;
      }
   }
}
