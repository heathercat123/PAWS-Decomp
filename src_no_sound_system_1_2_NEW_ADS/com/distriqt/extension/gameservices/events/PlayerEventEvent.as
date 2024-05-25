package com.distriqt.extension.gameservices.events
{
   import com.distriqt.extension.gameservices.quests.PlayerEvent;
   import flash.events.Event;
   
   public class PlayerEventEvent extends Event
   {
      
      public static const EVENTS_LOAD_SUCCESS:String = "events:load:success";
      
      public static const EVENTS_LOAD_ERROR:String = "events:load:error";
       
      
      public var events:Vector.<com.distriqt.extension.gameservices.quests.PlayerEvent>;
      
      public var errorCode:int;
      
      public var message:String;
      
      public function PlayerEventEvent(param1:String, param2:Vector.<com.distriqt.extension.gameservices.quests.PlayerEvent> = null, param3:String = "", param4:int = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.events = param2;
         this.errorCode = param4;
         this.message = param3;
      }
      
      override public function clone() : Event
      {
         return new PlayerEventEvent(type,events,message,errorCode,bubbles,cancelable);
      }
   }
}
