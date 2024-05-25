package com.distriqt.extension.adverts.events
{
   import flash.events.Event;
   
   public class AppOpenAdEvent extends Event
   {
      
      private static const TAG:String = "AppOpenAdEvent";
      
      public static const LOADED:String = "appopenad:loaded";
      
      public static const ERROR:String = "appopenad:error";
       
      
      public var errorCode:int = -1;
      
      public var errorMessage:String = "";
      
      public function AppOpenAdEvent(param1:String, param2:int = -1, param3:String = "", param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.errorCode = param2;
         this.errorMessage = param3;
      }
      
      override public function clone() : Event
      {
         return new AppOpenAdEvent(type,errorCode,errorMessage,bubbles,cancelable);
      }
   }
}
