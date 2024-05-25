package com.distriqt.extension.adverts.nativeads
{
   public interface NativeAds
   {
       
      
      function get isSupported() : Boolean;
      
      function createNativeAd(param1:String, param2:NativeAdOptions = null) : NativeAd;
   }
}
