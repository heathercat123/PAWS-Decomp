package com.distriqt.extension.adverts.appopen
{
   public interface AppOpenAds
   {
       
      
      function get isSupported() : Boolean;
      
      function createAppOpenAd() : AppOpenAd;
   }
}
