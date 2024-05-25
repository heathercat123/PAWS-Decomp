package com.distriqt.extension.ironsource.events
{
   import flash.events.DataEvent;
   import flash.events.Event;
   
   public class OfferwallEvent extends DataEvent
   {
      
      private static const TAG:String = "OfferwallEvent";
      
      public static const AVAILABLE:String = "onOfferwallAvailable";
      
      public static const OPENED:String = "onOfferwallOpened";
      
      public static const SHOW_FAILED:String = "onOfferwallShowFailed";
      
      public static const AD_CREDITED:String = "onOfferwallAdCredited";
      
      public static const CLOSED:String = "onOfferwallClosed";
      
      public static const GETOFFERWALLCREDITS_FAILED:String = "onGetOfferwallCreditsFailed";
       
      
      public var availability:Boolean = false;
      
      public var credits:int = 0;
      
      public var totalCredits:int = 0;
      
      public var totalCreditsFlag:Boolean = false;
      
      public function OfferwallEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         var _loc5_:Object = null;
         super(param1,param3,param4,param2);
         availability = param2 == "true";
         try
         {
            if((_loc5_ = JSON.parse(param2)).hasOwnProperty("credits"))
            {
               credits = _loc5_.credits;
            }
            if(_loc5_.hasOwnProperty("totalCredits"))
            {
               totalCredits = _loc5_.totalCredits;
            }
            if(_loc5_.hasOwnProperty("totalCreditsFlag"))
            {
               totalCreditsFlag = _loc5_.totalCreditsFlag;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function clone() : Event
      {
         return new OfferwallEvent(type,data,bubbles,cancelable);
      }
   }
}
