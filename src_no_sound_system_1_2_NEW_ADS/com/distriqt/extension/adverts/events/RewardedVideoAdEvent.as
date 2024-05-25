package com.distriqt.extension.adverts.events
{
   import flash.events.Event;
   
   public class RewardedVideoAdEvent extends Event
   {
      
      private static const TAG:String = "RewardedVideoAdEvent";
      
      public static const LOADED:String = "rewardedvideoad:loaded";
      
      public static const ERROR:String = "rewardedvideoad:error";
      
      public static const REWARD:String = "rewardedvideoad:reward";
       
      
      public var errorCode:int = -1;
      
      public var errorMessage:String = "";
      
      public var rewardAmount:int = 0;
      
      public var rewardType:String = "";
      
      public function RewardedVideoAdEvent(param1:String, param2:int = 0, param3:String = "", param4:int = -1, param5:String = "", param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         this.errorCode = param4;
         this.errorMessage = param5;
         this.rewardAmount = param2;
         this.rewardType = param3;
      }
      
      override public function clone() : Event
      {
         return new RewardedVideoAdEvent(type,rewardAmount,rewardType,errorCode,errorMessage,bubbles,cancelable);
      }
   }
}
