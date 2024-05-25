package com.distriqt.extension.adverts.ump
{
   public class ConsentRequestParameters
   {
      
      private static const TAG:String = "ConsentRequestParameters";
       
      
      public var tagForUnderAgeOfConsent:Boolean = false;
      
      public var debugSettings:ConsentDebugSettings;
      
      public function ConsentRequestParameters()
      {
         super();
      }
      
      public function setTagForUnderAgeOfConsent(param1:Boolean) : ConsentRequestParameters
      {
         this.tagForUnderAgeOfConsent = param1;
         return this;
      }
      
      public function setConsentDebugSettings(param1:ConsentDebugSettings) : ConsentRequestParameters
      {
         this.debugSettings = param1;
         return this;
      }
   }
}
