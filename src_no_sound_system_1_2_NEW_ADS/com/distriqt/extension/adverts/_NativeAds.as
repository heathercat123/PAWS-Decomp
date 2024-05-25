package com.distriqt.extension.adverts
{
   import com.distriqt.extension.adverts.nativeads.NativeAd;
   import com.distriqt.extension.adverts.nativeads.NativeAdOptions;
   import com.distriqt.extension.adverts.nativeads.NativeAds;
   
   internal class _NativeAds implements NativeAds
   {
      
      private static const TAG:String = "_NativeAds";
       
      
      public function _NativeAds()
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function createNativeAd(param1:String, param2:NativeAdOptions = null) : NativeAd
      {
         return null;
      }
   }
}
