package com.distriqt.extension.adverts.appopen
{
   import com.distriqt.extension.adverts.AdRequest;
   import flash.events.IEventDispatcher;
   
   [Event(name="appopenad:loaded",type="com.distriqt.extension.adverts.events.AppOpenAdEvent")]
   [Event(name="appopenad:error",type="com.distriqt.extension.adverts.events.AppOpenAdEvent")]
   [Event(name="fullscreencontent_dismissed",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="fullscreencontent_show",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="fullscreencontent_failedtoshow",type="com.distriqt.extension.adverts.events.FullScreenContentEvent")]
   [Event(name="paidevent_paid",type="com.distriqt.extension.adverts.events.PaidEvent")]
   public interface AppOpenAd extends IEventDispatcher
   {
       
      
      function destroy() : void;
      
      function setAdUnitId(param1:String) : void;
      
      function getAdUnitId() : String;
      
      function load(param1:AdRequest, param2:int) : void;
      
      function isLoaded() : Boolean;
      
      function show() : Boolean;
   }
}
