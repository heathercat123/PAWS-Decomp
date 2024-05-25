package com.distriqt.extension.inappbilling
{
   import flash.events.EventDispatcher;
   
   internal class _ApplicationReceiptImpl extends EventDispatcher implements ApplicationReceipt
   {
       
      
      public function _ApplicationReceiptImpl()
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
      
      public function getAppReceipt() : String
      {
         return "";
      }
      
      public function refresh(param1:ApplicationReceiptProperties = null, param2:Function = null) : Boolean
      {
         return false;
      }
      
      public function cleanup() : void
      {
      }
   }
}
