package com.distriqt.extension.inappbilling.purchases
{
   import com.distriqt.extension.inappbilling.Purchase;
   import flash.events.IEventDispatcher;
   
   public interface Downloads extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function startDownloads(param1:Purchase) : Boolean;
      
      function pauseDownloads() : Boolean;
   }
}
