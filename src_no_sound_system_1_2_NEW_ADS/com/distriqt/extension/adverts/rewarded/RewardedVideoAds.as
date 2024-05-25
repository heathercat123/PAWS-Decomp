package com.distriqt.extension.adverts.rewarded
{
   public interface RewardedVideoAds
   {
       
      
      function get isSupported() : Boolean;
      
      function createRewardedVideoAd() : RewardedVideoAd;
   }
}
