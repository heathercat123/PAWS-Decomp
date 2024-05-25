package com.distriqt.extension.gameservices.auth
{
   import flash.events.IEventDispatcher;
   
   [Event(name="auth:token:success",type="com.distriqt.extension.gameservices.events.AuthUtilEvent")]
   [Event(name="auth:token:error",type="com.distriqt.extension.gameservices.events.AuthUtilEvent")]
   public interface AuthUtil extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function getToken(param1:String = "") : Boolean;
      
      function clearToken(param1:String = "") : Boolean;
   }
}
