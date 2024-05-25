package com.distriqt.extension.inappbilling
{
   import com.distriqt.extension.inappbilling.updates.InAppUpdates;
   import flash.events.EventDispatcher;
   
   public class _InAppUpdatesImpl extends EventDispatcher implements InAppUpdates
   {
      
      private static const TAG:String = "_InAppUpdatesImpl";
       
      
      public function _InAppUpdatesImpl()
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function checkAppUpdate() : Boolean
      {
         return false;
      }
      
      public function startAppUpdate(param1:Boolean = false) : Boolean
      {
         return false;
      }
   }
}
