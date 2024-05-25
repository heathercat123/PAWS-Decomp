package com.distriqt.extension.adverts.events
{
   import flash.events.Event;
   
   public class FullScreenContentEvent extends Event
   {
      
      private static const TAG:String = "FullScreenContentEvent";
      
      public static const DISMISSED:String = "fullscreencontent_dismissed";
      
      public static const FAILED_TO_SHOW:String = "fullscreencontent_failedtoshow";
      
      public static const SHOW:String = "fullscreencontent_show";
       
      
      public var errorCode:int = -1;
      
      public var errorMessage:String = "";
      
      public function FullScreenContentEvent(param1:String, param2:int = -1, param3:String = "", param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.errorCode = param2;
         this.errorMessage = param3;
      }
      
      override public function clone() : Event
      {
         return new FullScreenContentEvent(type,errorCode,errorMessage,bubbles,cancelable);
      }
   }
}
