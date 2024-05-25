package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.auth.AuthUtil;
   import flash.events.EventDispatcher;
   
   internal class _AuthUtilImpl extends EventDispatcher implements AuthUtil
   {
       
      
      public function _AuthUtilImpl()
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function getToken(param1:String = "") : Boolean
      {
         return false;
      }
      
      public function clearToken(param1:String = "") : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
      }
   }
}
