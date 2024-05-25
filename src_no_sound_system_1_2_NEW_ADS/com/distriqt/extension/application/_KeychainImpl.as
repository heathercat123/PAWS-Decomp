package com.distriqt.extension.application
{
   import flash.events.EventDispatcher;
   
   internal class _KeychainImpl extends EventDispatcher implements Keychain
   {
       
      
      public function _KeychainImpl()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function set(param1:String, param2:String, param3:String = null) : int
      {
         return 0;
      }
      
      public function get(param1:String, param2:String = null) : String
      {
         return null;
      }
      
      public function remove(param1:String, param2:String = null) : int
      {
         return 0;
      }
   }
}
