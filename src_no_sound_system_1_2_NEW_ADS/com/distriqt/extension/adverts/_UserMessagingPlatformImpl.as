package com.distriqt.extension.adverts
{
   import com.distriqt.extension.adverts.ump.ConsentInformation;
   import com.distriqt.extension.adverts.ump.UserMessagingPlatform;
   import com.distriqt.extension.adverts.ump.events.UserMessagingPlatformEvent;
   import flash.events.EventDispatcher;
   
   internal class _UserMessagingPlatformImpl extends EventDispatcher implements UserMessagingPlatform
   {
      
      private static const TAG:String = "_UserMessagingPlatformImpl";
       
      
      private var _consentInformation:ConsentInformation;
      
      public function _UserMessagingPlatformImpl()
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function getConsentInformation() : ConsentInformation
      {
         if(_consentInformation == null)
         {
            _consentInformation = new _ConsentInformationImpl();
         }
         return _consentInformation;
      }
      
      public function loadConsentForm() : Boolean
      {
         dispatchEvent(new UserMessagingPlatformEvent("consentFormLoadFailure",new Error("Not supported",0)));
         return false;
      }
      
      public function showConsentForm() : Boolean
      {
         return false;
      }
   }
}
