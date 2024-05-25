package com.distriqt.extension.application
{
   import com.distriqt.extension.application.keyboard.SoftKeyboard;
   import flash.display.Stage;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   
   internal final class _SoftKeyboardImpl extends EventDispatcher implements SoftKeyboard
   {
       
      
      private var _stage:Stage;
      
      public function _SoftKeyboardImpl(param1:Stage = null)
      {
         super();
         setStage(param1);
      }
      
      public function init() : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function setStage(param1:Stage) : void
      {
         _stage = param1;
      }
      
      public function get x() : int
      {
         if(_stage != null)
         {
            return softKeyboardRect.x;
         }
         return 0;
      }
      
      public function get y() : int
      {
         if(_stage != null)
         {
            return softKeyboardRect.y;
         }
         return -1;
      }
      
      public function get height() : int
      {
         if(_stage != null)
         {
            return softKeyboardRect.height;
         }
         return -1;
      }
      
      public function get width() : int
      {
         if(_stage != null)
         {
            return softKeyboardRect.width;
         }
         return 0;
      }
      
      public function get softKeyboardRect() : Rectangle
      {
         if(_stage != null)
         {
            return _stage.softKeyboardRect;
         }
         return new Rectangle(0,0,0,0);
      }
      
      public function setAdjustMode(param1:String) : Boolean
      {
         return false;
      }
      
      public function show() : void
      {
      }
   }
}
