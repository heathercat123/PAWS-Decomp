package com.distriqt.extension.adverts.rewardedinterstitial
{
   public interface RewardedInterstitialAds
   {
       
      
      function get isSupported() : Boolean;
      
      function createRewardedInterstitialAd() : RewardedInterstitialAd;
   }
}
