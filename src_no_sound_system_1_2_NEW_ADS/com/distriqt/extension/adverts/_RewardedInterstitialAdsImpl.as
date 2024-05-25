package com.distriqt.extension.adverts
{
   import com.distriqt.extension.adverts.rewardedinterstitial.RewardedInterstitialAd;
   import com.distriqt.extension.adverts.rewardedinterstitial.RewardedInterstitialAds;
   
   internal class _RewardedInterstitialAdsImpl implements RewardedInterstitialAds
   {
      
      private static const TAG:String = "_RewardedVideoAdsImpl";
       
      
      public function _RewardedInterstitialAdsImpl()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function createRewardedInterstitialAd() : RewardedInterstitialAd
      {
         return null;
      }
   }
}
