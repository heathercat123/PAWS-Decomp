package com.distriqt.extension.adverts.rewardedinterstitial
{
   import com.distriqt.extension.adverts.AdRequest;
   import com.distriqt.extension.adverts.rewarded.ServerSideVerificationOptions;
   import flash.events.IEventDispatcher;
   
   [Event(name="fullscreencontent_dismissed",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="fullscreencontent_failedtoshow",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="fullscreencontent_show",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="rewardedinterstitialad:loaded",type="com.distriqt.extension.adverts.events.RewardedInterstitialAdEvent")]
   [Event(name="rewardedinterstitialad:error",type="com.distriqt.extension.adverts.events.RewardedInterstitialAdEvent")]
   [Event(name="rewardedinterstitialad:reward",type="com.distriqt.extension.adverts.events.RewardedInterstitialAdEvent")]
   [Event(name="paidevent_paid",type="com.distriqt.extension.adverts.events.PaidEvent")]
   public interface RewardedInterstitialAd extends IEventDispatcher
   {
       
      
      function destroy() : void;
      
      function setAdUnitId(param1:String) : void;
      
      function getAdUnitId() : String;
      
      function load(param1:AdRequest) : void;
      
      function isLoaded() : Boolean;
      
      function show() : Boolean;
      
      function setServerSideVerificationOptions(param1:ServerSideVerificationOptions) : void;
   }
}
