package com.distriqt.extension.ironsource.events
{
   import com.distriqt.extension.ironsource.PlacementInfo;
   import flash.events.DataEvent;
   import flash.events.Event;
   
   public class RewardedVideoAdEvent extends DataEvent
   {
      
      private static const TAG:String = "RewardedVideoAdEvent";
      
      public static const OPENED:String = "onRewardedVideoAdOpened";
      
      public static const CLOSED:String = "onRewardedVideoAdClosed";
      
      public static const AVAILABILITY_CHANGED:String = "onRewardedVideoAvailabilityChanged";
      
      public static const STARTED:String = "onRewardedVideoAdStarted";
      
      public static const ENDED:String = "onRewardedVideoAdEnded";
      
      public static const REWARDED:String = "onRewardedVideoAdRewarded";
      
      public static const SHOW_FAILED:String = "onRewardedVideoAdShowFailed";
      
      public static const CLICKED:String = "onRewardedVideoAdClicked";
       
      
      public var availability:Boolean = false;
      
      public var placementInfo:PlacementInfo = null;
      
      public function RewardedVideoAdEvent(param1:String, param2:String = null, param3:Boolean = false, param4:PlacementInfo = null, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6,param2);
         this.availability = param3;
         this.placementInfo = param4;
      }
      
      override public function clone() : Event
      {
         return new RewardedVideoAdEvent(type,data,availability,placementInfo,bubbles,cancelable);
      }
   }
}
