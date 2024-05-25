package com.distriqt.extension.ironsource.events
{
   import flash.events.DataEvent;
   import flash.events.Event;
   
   public class InterstitialAdEvent extends DataEvent
   {
      
      private static const TAG:String = "InterstitialAdEvent";
      
      public static const READY:String = "onInterstitialAdReady";
      
      public static const FAILED:String = "onInterstitialAdLoadFailed";
      
      public static const OPENED:String = "onInterstitialAdOpened";
      
      public static const CLOSED:String = "onInterstitialAdClosed";
      
      public static const SHOW_SUCCEEDED:String = "onInterstitialAdShowSucceeded";
      
      public static const SHOW_FAILED:String = "onInterstitialAdShowFailed";
      
      public static const CLICKED:String = "onInterstitialAdClicked";
       
      
      public function InterstitialAdEvent(param1:String, param2:String = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4,param2);
      }
      
      override public function clone() : Event
      {
         return new InterstitialAdEvent(type,data,bubbles,cancelable);
      }
   }
}
