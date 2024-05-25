package com.distriqt.extension.adverts
{
   import com.distriqt.extension.adverts.appopen.AppOpenAd;
   import com.distriqt.extension.adverts.appopen.AppOpenAds;
   
   internal class _AppOpenAdsImpl implements AppOpenAds
   {
      
      private static const TAG:String = "_AppOpenAdsImpl";
       
      
      public function _AppOpenAdsImpl()
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function createAppOpenAd() : AppOpenAd
      {
         return null;
      }
   }
}
