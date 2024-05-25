package com.distriqt.extension.application
{
   import flash.events.EventDispatcher;
   
   internal final class _Accessibility extends EventDispatcher implements Accessibility
   {
       
      
      public function _Accessibility()
      {
         super();
      }
      
      public function get voiceOverEnabled() : Boolean
      {
         return false;
      }
   }
}
