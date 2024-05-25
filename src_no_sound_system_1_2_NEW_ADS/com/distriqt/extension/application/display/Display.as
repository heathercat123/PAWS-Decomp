package com.distriqt.extension.application.display
{
   import com.distriqt.extension.application.DisplayMetrics;
   import flash.events.IEventDispatcher;
   
   public interface Display extends IEventDispatcher
   {
       
      
      function setDisplayMode(param1:String, param2:String = "cutout_never") : Boolean;
      
      function get willCutoutAffectView() : Boolean;
      
      function getDisplayCutout() : DisplayCutout;
      
      function setSystemUiVisibility(param1:int) : Boolean;
      
      function getSystemUiVisibility() : int;
      
      function get displayMetrics() : DisplayMetrics;
      
      function setStatusBarStyle(param1:uint, param2:Boolean = false) : Boolean;
      
      function setStatusBarHidden(param1:Boolean = true, param2:String = "none") : Boolean;
      
      function setStatusBarColour(param1:uint, param2:Number = 1) : Boolean;
      
      function getStatusBarHeight() : int;
      
      function setNavigationBarColour(param1:uint) : Boolean;
      
      function setNavigationBarStyle(param1:int) : Boolean;
      
      function get userInterfaceStyle() : String;
      
      function setBrightness(param1:Number, param2:Boolean = false) : Boolean;
      
      function getBrightness() : Number;
   }
}
