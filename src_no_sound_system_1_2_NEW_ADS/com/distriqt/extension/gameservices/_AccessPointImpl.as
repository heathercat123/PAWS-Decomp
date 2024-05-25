package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.accesspoint.AccessPoint;
   import com.distriqt.extension.gameservices.accesspoint.AccessPointOptions;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   
   internal class _AccessPointImpl extends EventDispatcher implements AccessPoint
   {
      
      private static const TAG:String = "_AccessPointImpl";
       
      
      public function _AccessPointImpl()
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function get isVisible() : Boolean
      {
         return false;
      }
      
      public function get isPresenting() : Boolean
      {
         return false;
      }
      
      public function activate(param1:AccessPointOptions = null) : Boolean
      {
         return false;
      }
      
      public function deactivate() : Boolean
      {
         return false;
      }
      
      public function getFrame() : Rectangle
      {
         return null;
      }
      
      public function get isFocused() : Boolean
      {
         return false;
      }
      
      public function focus(param1:Boolean = true) : Boolean
      {
         return false;
      }
   }
}
