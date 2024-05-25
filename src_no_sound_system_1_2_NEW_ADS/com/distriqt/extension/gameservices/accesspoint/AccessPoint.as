package com.distriqt.extension.gameservices.accesspoint
{
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public interface AccessPoint extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function get isVisible() : Boolean;
      
      function get isPresenting() : Boolean;
      
      function activate(param1:AccessPointOptions = null) : Boolean;
      
      function deactivate() : Boolean;
      
      function getFrame() : Rectangle;
   }
}
