package com.distriqt.extension.adverts.rewarded
{
   import com.distriqt.extension.adverts.AdRequest;
   import flash.events.IEventDispatcher;
   
   [Event(name="fullscreencontent_dismissed",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="fullscreencontent_failedtoshow",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="fullscreencontent_show",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="rewardedvideoad:loaded",type="com.distriqt.extension.adverts.events.RewardedVideoAdEvent")]
   [Event(name="rewardedvideoad:error",type="com.distriqt.extension.adverts.events.RewardedVideoAdEvent")]
   [Event(name="rewardedvideoad:reward",type="com.distriqt.extension.adverts.events.RewardedVideoAdEvent")]
   [Event(name="paidevent_paid",type="com.distriqt.extension.adverts.events.PaidEvent")]
   public interface RewardedVideoAd extends IEventDispatcher
   {
       
      
      function destroy() : void;
      
      [Deprecated]
      function getUserId() : String;
      
      [Deprecated(message="Use setServerSideVerificationOptions instead")]
      function setUserId(param1:String) : void;
      
      function setAdUnitId(param1:String) : void;
      
      function getAdUnitId() : String;
      
      function load(param1:AdRequest) : void;
      
      function isLoaded() : Boolean;
      
      function show() : Boolean;
      
      function setServerSideVerificationOptions(param1:ServerSideVerificationOptions) : void;
   }
}
