package com.distriqt.extension.ironsource.events
{
   import flash.events.DataEvent;
   import flash.events.Event;
   
   public class BannerAdEvent extends DataEvent
   {
      
      private static const TAG:String = "BannerAdEvent";
      
      public static const LOADED:String = "onBannerAdLoaded";
      
      public static const LOAD_FAILED:String = "onBannerAdLoadFailed";
      
      public static const CLICKED:String = "onBannerAdClicked";
      
      public static const SCREEN_PRESENTED:String = "onBannerAdScreenPresented";
      
      public static const SCREEN_DISMISSED:String = "onBannerAdScreenDismissed";
      
      public static const LEFT_APPLICATION:String = "onBannerAdLeftApplication";
       
      
      public function BannerAdEvent(param1:String, param2:String = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4,param2);
      }
      
      override public function clone() : Event
      {
         return new BannerAdEvent(type,data,bubbles,cancelable);
      }
   }
}
