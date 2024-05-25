package com.distriqt.extension.adverts
{
   public class RequestConfiguration
   {
      
      private static const TAG:String = "RequestConfiguration";
      
      public static const TAG_FOR_CHILD_DIRECTED_TREATMENT_UNSPECIFIED:int = -1;
      
      public static const TAG_FOR_CHILD_DIRECTED_TREATMENT_FALSE:int = 0;
      
      public static const TAG_FOR_CHILD_DIRECTED_TREATMENT_TRUE:int = 1;
      
      public static const TAG_FOR_UNDER_AGE_OF_CONSENT_TRUE:int = 1;
      
      public static const TAG_FOR_UNDER_AGE_OF_CONSENT_FALSE:int = 0;
      
      public static const TAG_FOR_UNDER_AGE_OF_CONSENT_UNSPECIFIED:int = -1;
      
      public static const MAX_AD_CONTENT_RATING_UNSPECIFIED:String = "";
      
      public static const MAX_AD_CONTENT_RATING_G:String = "G";
      
      public static const MAX_AD_CONTENT_RATING_PG:String = "PG";
      
      public static const MAX_AD_CONTENT_RATING_T:String = "T";
      
      public static const MAX_AD_CONTENT_RATING_MA:String = "MA";
       
      
      private var _tagForChildDirectedTreatment:int = -1;
      
      private var _tagForUnderAgeOfConsent:int = -1;
      
      private var _maxAdContentRating:String = "";
      
      private var _testDeviceIds:Array;
      
      public function RequestConfiguration()
      {
         super();
         _testDeviceIds = [];
      }
      
      internal static function fromObject(param1:Object) : RequestConfiguration
      {
         var _loc2_:RequestConfiguration = null;
         if(param1 != null)
         {
            _loc2_ = new RequestConfiguration();
            if(param1.hasOwnProperty("tagForChildDirectedTreatment"))
            {
               _loc2_.setTagForChildDirectedTreatment(param1.tagForChildDirectedTreatment);
            }
            if(param1.hasOwnProperty("tagForUnderAgeOfConsent"))
            {
               _loc2_.setTagForUnderAgeOfConsent(param1.tagForUnderAgeOfConsent);
            }
            if(param1.hasOwnProperty("maxAdContentRating"))
            {
               _loc2_.setMaxAdContentRating(param1.maxAdContentRating);
            }
            if(param1.hasOwnProperty("testDeviceIds"))
            {
               _loc2_.setTestDeviceIds(param1.testDeviceIds);
            }
            return _loc2_;
         }
         return null;
      }
      
      public function setTagForChildDirectedTreatment(param1:int) : RequestConfiguration
      {
         _tagForChildDirectedTreatment = param1;
         return this;
      }
      
      public function setTagForUnderAgeOfConsent(param1:int) : RequestConfiguration
      {
         _tagForUnderAgeOfConsent = param1;
         return this;
      }
      
      public function setMaxAdContentRating(param1:String) : RequestConfiguration
      {
         _maxAdContentRating = param1;
         return this;
      }
      
      public function setTestDeviceIds(param1:Array) : RequestConfiguration
      {
         _testDeviceIds = param1;
         return this;
      }
      
      public function toString() : String
      {
         return toJSONString();
      }
      
      internal function toObject() : Object
      {
         return {
            "tagForChildDirectedTreatment":_tagForChildDirectedTreatment,
            "tagForUnderAgeOfConsent":_tagForUnderAgeOfConsent,
            "maxAdContentRating":_maxAdContentRating,
            "testDeviceIds":_testDeviceIds
         };
      }
      
      internal function toJSONString() : String
      {
         return JSON.stringify(toObject());
      }
   }
}
