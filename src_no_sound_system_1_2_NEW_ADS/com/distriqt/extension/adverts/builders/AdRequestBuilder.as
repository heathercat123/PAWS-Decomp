package com.distriqt.extension.adverts.builders
{
   import com.distriqt.extension.adverts.AdRequest;
   
   public class AdRequestBuilder
   {
      
      private static const TAG:String = "AdRequestBuilder";
       
      
      private var _request:AdRequest;
      
      public function AdRequestBuilder()
      {
         super();
         _request = new AdRequest();
      }
      
      [Deprecated(message="No longer supported")]
      public function setGender(param1:int) : AdRequestBuilder
      {
         _request.gender = param1;
         return this;
      }
      
      [Deprecated(message="No longer supported")]
      public function setBirthday(param1:Date) : AdRequestBuilder
      {
         _request.birthday = param1;
         return this;
      }
      
      public function addKeyword(param1:String) : AdRequestBuilder
      {
         _request.keywords.push(param1);
         return this;
      }
      
      [Deprecated(message="Use RequestConfiguration")]
      public function addTestDevice(param1:String) : AdRequestBuilder
      {
         _request.testDevices.push(param1);
         return this;
      }
      
      public function setIsDesignedForFamilies(param1:Boolean) : AdRequestBuilder
      {
         _request.isDesignedForFamilies = param1 ? 1 : 0;
         return this;
      }
      
      [Deprecated(message="Use RequestConfiguration")]
      public function tagForChildDirectedTreatment(param1:Boolean) : AdRequestBuilder
      {
         _request.tagForChildDirectedTreatment = param1 ? 1 : 0;
         return this;
      }
      
      public function nonPersonalisedAds(param1:Boolean = true) : AdRequestBuilder
      {
         _request.networkExtras["npa"] = param1 ? "1" : "0";
         return this;
      }
      
      [Deprecated(message="Use RequestConfiguration")]
      public function maxAdContentRating(param1:String) : AdRequestBuilder
      {
         _request.networkExtras["max_ad_content_rating"] = param1;
         return this;
      }
      
      [Deprecated(message="Use RequestConfiguration")]
      public function tagForUnderAgeOfConsent(param1:Boolean = false) : AdRequestBuilder
      {
         _request.networkExtras["tag_for_under_age_of_consent"] = param1;
         return this;
      }
      
      public function build() : AdRequest
      {
         return _request;
      }
   }
}
