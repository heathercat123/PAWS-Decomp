package com.distriqt.extension.adverts.events
{
   import flash.events.Event;
   
   public class NativeAdEvent extends Event
   {
      
      private static const TAG:String = "NativeAdEvent";
      
      public static const LOADED:String = "nativead:loaded";
      
      public static const ERROR:String = "nativead:error";
      
      public static const OPENED:String = "nativead:opened";
      
      public static const CLICKED:String = "nativead:clicked";
      
      public static const CLOSED:String = "nativead:closed";
       
      
      public var errorCode:int = -1;
      
      public var errorMessage:String = "";
      
      public function NativeAdEvent(param1:String, param2:int = -1, param3:String = "", param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.errorCode = param2;
         this.errorMessage = param3;
      }
      
      override public function clone() : Event
      {
         return new NativeAdEvent(type,errorCode,errorMessage,bubbles,cancelable);
      }
   }
}
