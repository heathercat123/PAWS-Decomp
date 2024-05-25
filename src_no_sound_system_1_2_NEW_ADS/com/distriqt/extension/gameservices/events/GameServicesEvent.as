package com.distriqt.extension.gameservices.events
{
   import flash.events.Event;
   
   public class GameServicesEvent extends Event
   {
      
      public static const INITIALISED:String = "initialised";
      
      public static const SIGN_IN_SUCCESS:String = "signin:success";
      
      public static const SIGN_IN_FAILED:String = "signin:failed";
      
      public static const SIGN_OUT_SUCCESS:String = "signout:success";
      
      public static const UI_CLOSED:String = "ui:closed";
       
      
      public var message:String = "";
      
      public var code:int = -1;
      
      public function GameServicesEvent(param1:String, param2:String = "", param3:int = -1, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.message = param2;
         this.code = param3;
      }
      
      override public function clone() : Event
      {
         return new GameServicesEvent(type,message,code,bubbles,cancelable);
      }
   }
}
