package com.distriqt.extension.adverts.consent
{
   import flash.events.IEventDispatcher;
   
   [Event(name="consent:status:updated",type="com.distriqt.extension.adverts.events.ConsentEvent")]
   [Event(name="consent:status:error",type="com.distriqt.extension.adverts.events.ConsentEvent")]
   [Event(name="consent:form:closed",type="com.distriqt.extension.adverts.events.ConsentEvent")]
   [Event(name="consent:form:error",type="com.distriqt.extension.adverts.events.ConsentEvent")]
   public interface Consent extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function addTestDevice(param1:String) : void;
      
      function setDebugGeography(param1:int) : void;
      
      function getConsentStatus(param1:String) : void;
      
      function setConsentStatus(param1:String) : void;
      
      function askForConsent(param1:ConsentOptions) : Boolean;
   }
}
