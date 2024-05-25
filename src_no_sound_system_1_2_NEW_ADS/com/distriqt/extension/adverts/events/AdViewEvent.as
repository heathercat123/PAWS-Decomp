package com.distriqt.extension.adverts.events
{
   import flash.events.Event;
   
   public class AdViewEvent extends Event
   {
      
      private static const TAG:String = "AdViewEvent";
      
      public static const LOADED:String = "adview:loaded";
      
      public static const OPENED:String = "adview:opened";
      
      public static const CLOSED:String = "adview:closed";
      
      public static const ERROR:String = "adview:error";
       
      
      public var errorCode:int = -1;
      
      public function AdViewEvent(param1:String, param2:int = -1, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.errorCode = param2;
      }
      
      override public function clone() : Event
      {
         return new AdViewEvent(type,errorCode,bubbles,cancelable);
      }
   }
}
