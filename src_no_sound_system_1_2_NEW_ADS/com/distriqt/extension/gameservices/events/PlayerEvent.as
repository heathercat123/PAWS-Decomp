package com.distriqt.extension.gameservices.events
{
   import com.distriqt.extension.gameservices.Player;
   import flash.events.Event;
   
   public class PlayerEvent extends Event
   {
      
      public static const ERROR:String = "player:error";
      
      public static const LOADED:String = "player:loaded";
       
      
      public var player:Player;
      
      public var error:String;
      
      public function PlayerEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Player = null, param5:String = "")
      {
         super(param1,param2,param3);
         this.player = param4;
         this.error = param5;
      }
      
      override public function clone() : Event
      {
         return new PlayerEvent(type,bubbles,cancelable,player,error);
      }
   }
}
