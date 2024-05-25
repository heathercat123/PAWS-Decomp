package com.distriqt.extension.adverts
{
   import flash.events.IEventDispatcher;
   
   [Event(name="interstitial:loaded",type="com.distriqt.extension.adverts.events.InterstitialAdEvent")]
   [Event(name="interstitial:error",type="com.distriqt.extension.adverts.events.InterstitialAdEvent")]
   [Event(name="fullscreencontent_dismissed",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="fullscreencontent_failedtoshow",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="fullscreencontent_show",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="paidevent_paid",type="com.distriqt.extension.adverts.events.PaidEvent")]
   public interface InterstitialAd extends IEventDispatcher
   {
       
      
      function destroy() : void;
      
      function setAdUnitId(param1:String) : void;
      
      function getAdUnitId() : String;
      
      function isLoading() : Boolean;
      
      function load(param1:AdRequest) : void;
      
      function isLoaded() : Boolean;
      
      function show() : Boolean;
      
      function hide() : Boolean;
   }
}
