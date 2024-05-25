package com.distriqt.extension.application
{
   import com.distriqt.extension.application.display.Display;
   import com.distriqt.extension.application.display.DisplayCutout;
   import flash.display.Stage;
   import flash.events.EventDispatcher;
   
   internal class _DisplayImpl extends EventDispatcher implements Display
   {
      
      private static const TAG:String = "_DisplayImpl";
       
      
      private var _stage:Stage;
      
      private var _displayMetrics:_DisplayMetricsImpl = null;
      
      public function _DisplayImpl(param1:Stage)
      {
         super();
         setStage(param1);
      }
      
      public function dispose() : void
      {
         _stage = null;
      }
      
      public function setStage(param1:Stage) : void
      {
         _stage = param1;
      }
      
      public function setDisplayMode(param1:String, param2:String = "cutout_never") : Boolean
      {
         if(_stage != null)
         {
            switch(param1)
            {
               case "fullscreen":
               case "immersive":
                  _stage.displayState = "fullScreen";
                  break;
               case "normal":
                  _stage.displayState = "normal";
            }
            return true;
         }
         return false;
      }
      
      public function get willCutoutAffectView() : Boolean
      {
         return false;
      }
      
      public function setSystemUiVisibility(param1:int) : Boolean
      {
         return false;
      }
      
      public function getSystemUiVisibility() : int
      {
         return 0;
      }
      
      public function getDisplayCutout() : DisplayCutout
      {
         return null;
      }
      
      public function get userInterfaceStyle() : String
      {
         return "unspecified";
      }
      
      public function get displayMetrics() : DisplayMetrics
      {
         try
         {
            if(_displayMetrics == null)
            {
               _displayMetrics = new _DisplayMetricsImpl(null);
            }
         }
         catch(e:Error)
         {
         }
         return _displayMetrics;
      }
      
      public function setStatusBarStyle(param1:uint, param2:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function setStatusBarHidden(param1:Boolean = true, param2:String = "none") : Boolean
      {
         return false;
      }
      
      public function setStatusBarColour(param1:uint, param2:Number = 1) : Boolean
      {
         return false;
      }
      
      public function getStatusBarHeight() : int
      {
         return -1;
      }
      
      public function setNavigationBarColour(param1:uint) : Boolean
      {
         return false;
      }
      
      public function setNavigationBarStyle(param1:int) : Boolean
      {
         return false;
      }
      
      public function setBrightness(param1:Number, param2:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function getBrightness() : Number
      {
         return -1;
      }
   }
}
