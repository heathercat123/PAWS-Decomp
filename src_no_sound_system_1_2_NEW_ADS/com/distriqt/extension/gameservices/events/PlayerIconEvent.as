package com.distriqt.extension.gameservices.events
{
   import com.distriqt.extension.gameservices.Player;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class PlayerIconEvent extends Event
   {
      
      public static const ERROR:String = "player:icon:error";
      
      public static const LOADED:String = "player:icon:loaded";
       
      
      public var player:Player;
      
      public var icon:BitmapData;
      
      public var error:String;
      
      public function PlayerIconEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Player = null, param5:BitmapData = null, param6:String = "")
      {
         super(param1,param2,param3);
         this.player = param4;
         this.icon = param5;
         this.error = param6;
      }
      
      override public function clone() : Event
      {
         return new PlayerIconEvent(type,bubbles,cancelable,player,icon,error);
      }
   }
}
