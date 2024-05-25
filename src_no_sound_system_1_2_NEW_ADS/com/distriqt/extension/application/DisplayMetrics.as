package com.distriqt.extension.application
{
   public interface DisplayMetrics
   {
       
      
      function get density() : Number;
      
      function get densityDpi() : int;
      
      function get screenHeight() : int;
      
      function get screenWidth() : int;
      
      function get xdpi() : Number;
      
      function get ydpi() : Number;
      
      function get nativeScale() : Number;
      
      function toString() : String;
   }
}
