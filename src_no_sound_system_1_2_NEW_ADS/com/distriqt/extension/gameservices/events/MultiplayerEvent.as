package com.distriqt.extension.gameservices.events
{
   import flash.events.Event;
   
   public class MultiplayerEvent extends Event
   {
      
      public static const INVITATION_RECEIVED:String = "multiplayer:invitation:received";
      
      public static const INVITATION_REMOVED:String = "multiplayer:invitation:removed";
      
      public static const LOADINVITES_SUCCESS:String = "multiplayer:loadinvites:success";
      
      public static const LOADINVITES_FAILED:String = "multiplayer:loadinvites:failed";
      
      public static const LOADINVITES_NOT_SUPPORTED:String = "multiplayer:loadinvites:notsupported";
       
      
      public var data:*;
      
      public var message:String = "";
      
      public function MultiplayerEvent(param1:String, param2:*, param3:String = "", param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.data = param2;
         this.message = param3;
      }
      
      override public function clone() : Event
      {
         return new MultiplayerEvent(type,data,message,bubbles,cancelable);
      }
   }
}
