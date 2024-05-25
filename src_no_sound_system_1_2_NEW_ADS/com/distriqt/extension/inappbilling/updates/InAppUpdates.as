package com.distriqt.extension.inappbilling.updates
{
   import flash.events.IEventDispatcher;
   
   public interface InAppUpdates extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function checkAppUpdate() : Boolean;
      
      function startAppUpdate(param1:Boolean = false) : Boolean;
   }
}
