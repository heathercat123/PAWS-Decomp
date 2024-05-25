package com.distriqt.extension.inappbilling
{
   import com.distriqt.extension.inappbilling.purchases.Downloads;
   import flash.events.EventDispatcher;
   
   internal final class _DownloadsImpl extends EventDispatcher implements Downloads
   {
       
      
      public function _DownloadsImpl()
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
      
      public function startDownloads(param1:Purchase) : Boolean
      {
         return false;
      }
      
      public function pauseDownloads() : Boolean
      {
         return false;
      }
   }
}
