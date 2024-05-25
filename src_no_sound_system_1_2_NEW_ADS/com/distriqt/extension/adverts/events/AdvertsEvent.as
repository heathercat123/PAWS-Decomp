package com.distriqt.extension.adverts.events
{
   import flash.events.Event;
   
   public class AdvertsEvent extends Event
   {
      
      private static const TAG:String = "AdvertsEvent";
      
      public static const INITIALISED:String = "adverts_initialised";
       
      
      public var adapterStatus:Array;
      
      public function AdvertsEvent(param1:String, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.adapterStatus = param2;
      }
      
      override public function clone() : Event
      {
         return new AdvertsEvent(type,adapterStatus,bubbles,cancelable);
      }
   }
}
