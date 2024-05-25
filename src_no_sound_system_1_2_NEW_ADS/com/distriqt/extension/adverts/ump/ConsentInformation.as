package com.distriqt.extension.adverts.ump
{
   import flash.events.IEventDispatcher;
   
   public interface ConsentInformation extends IEventDispatcher
   {
       
      
      function getConsentStatus() : int;
      
      function getConsentType() : int;
      
      function isConsentFormAvailable() : Boolean;
      
      function requestConsentInfoUpdate(param1:ConsentRequestParameters) : void;
      
      function reset() : void;
   }
}
