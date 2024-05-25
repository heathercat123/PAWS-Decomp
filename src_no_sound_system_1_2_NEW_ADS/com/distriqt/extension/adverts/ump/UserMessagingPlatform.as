package com.distriqt.extension.adverts.ump
{
   import flash.events.IEventDispatcher;
   
   public interface UserMessagingPlatform extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function getConsentInformation() : ConsentInformation;
      
      function loadConsentForm() : Boolean;
      
      function showConsentForm() : Boolean;
   }
}
