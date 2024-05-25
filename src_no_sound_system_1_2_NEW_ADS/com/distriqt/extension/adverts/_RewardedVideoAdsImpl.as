package com.distriqt.extension.adverts
{
   import com.distriqt.extension.adverts.rewarded.RewardedVideoAd;
   import com.distriqt.extension.adverts.rewarded.RewardedVideoAds;
   
   internal class _RewardedVideoAdsImpl implements RewardedVideoAds
   {
      
      private static const TAG:String = "_RewardedVideoAdsImpl";
       
      
      public function _RewardedVideoAdsImpl()
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
      
      public function createRewardedVideoAd() : RewardedVideoAd
      {
         return null;
      }
   }
}
