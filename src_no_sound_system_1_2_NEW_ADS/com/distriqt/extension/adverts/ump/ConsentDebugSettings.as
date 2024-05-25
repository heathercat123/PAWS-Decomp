package com.distriqt.extension.adverts.ump
{
   public class ConsentDebugSettings
   {
      
      private static const TAG:String = "ConsentDebugSettings";
       
      
      public var debugGeography:int = 0;
      
      public var testDeviceIds:Array;
      
      public function ConsentDebugSettings()
      {
         super();
         testDeviceIds = [];
      }
      
      public function setDebugGeography(param1:int) : ConsentDebugSettings
      {
         this.debugGeography = param1;
         return this;
      }
      
      public function addTestDeviceHashedId(param1:String) : ConsentDebugSettings
      {
         this.testDeviceIds.push(param1);
         return this;
      }
   }
}
