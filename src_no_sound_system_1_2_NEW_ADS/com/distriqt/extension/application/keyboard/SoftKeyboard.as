package com.distriqt.extension.application.keyboard
{
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   [Event(name="softKeyboardActivate",type="flash.events.SoftKeyboardEvent")]
   [Event(name="softKeyboardDeactivate",type="flash.events.SoftKeyboardEvent")]
   public interface SoftKeyboard extends IEventDispatcher
   {
       
      
      function init() : void;
      
      function get height() : int;
      
      function get y() : int;
      
      function get softKeyboardRect() : Rectangle;
      
      function setAdjustMode(param1:String) : Boolean;
      
      function show() : void;
   }
}
