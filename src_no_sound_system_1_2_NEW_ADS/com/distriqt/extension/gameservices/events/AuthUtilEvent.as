package com.distriqt.extension.gameservices.events
{
   import flash.events.Event;
   
   public class AuthUtilEvent extends Event
   {
      
      public static const AUTH_TOKEN_SUCCESS:String = "auth:token:success";
      
      public static const AUTH_TOKEN_ERROR:String = "auth:token:error";
       
      
      public var data:Object;
      
      public function AuthUtilEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new AuthUtilEvent(type,data,bubbles,cancelable);
      }
   }
}
