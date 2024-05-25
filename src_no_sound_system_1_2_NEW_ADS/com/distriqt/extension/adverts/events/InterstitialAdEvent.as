package com.distriqt.extension.adverts.events
{
   import flash.events.Event;
   
   public class InterstitialAdEvent extends Event
   {
      
      public static const LOADED:String = "interstitial:loaded";
      
      public static const ERROR:String = "interstitial:error";
       
      
      public var errorCode:int = -1;
      
      public function InterstitialAdEvent(param1:String, param2:int = -1, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.errorCode = param2;
      }
      
      override public function clone() : Event
      {
         return new InterstitialAdEvent(type,errorCode,bubbles,cancelable);
      }
   }
}
