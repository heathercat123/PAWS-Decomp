package com.distriqt.extension.adverts
{
   public class AdRequest
   {
      
      public static const GENDER_UNKNOWN:int = 0;
      
      public static const GENDER_MALE:int = 1;
      
      public static const GENDER_FEMALE:int = 2;
      
      public static const DEVICE_ID_EMULATOR:String = "B3EEABB8EE11C2BE770B684D95219ECB";
       
      
      public var gender:int = -1;
      
      public var birthday:Date = null;
      
      public var testDevices:Array;
      
      public var keywords:Array;
      
      public var tagForChildDirectedTreatment:int = -1;
      
      public var isDesignedForFamilies:int = -1;
      
      public var networkExtras:Object;
      
      public function AdRequest()
      {
         super();
         testDevices = [];
         keywords = [];
         networkExtras = {};
      }
      
      public function get networkExtrasJSON() : String
      {
         return JSON.stringify(networkExtras);
      }
   }
}
