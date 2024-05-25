package com.distriqt.extension.application
{
   import flash.events.EventDispatcher;
   import flash.external.ExtensionContext;
   
   internal class _DisplayMetricsImpl extends EventDispatcher implements DisplayMetrics
   {
       
      
      private var _density:Number = 0;
      
      private var _densityDpi:int = 0;
      
      private var _screenHeight:int = 0;
      
      private var _screenWidth:int = 0;
      
      private var _xdpi:Number = 0;
      
      private var _ydpi:Number = 0;
      
      private var _nativeScale:Number = 1;
      
      public function _DisplayMetricsImpl(param1:ExtensionContext)
      {
         super();
         try
         {
         }
         catch(e:Error)
         {
         }
      }
      
      public function get density() : Number
      {
         return _density;
      }
      
      public function set density(param1:Number) : void
      {
         _density = param1;
      }
      
      public function get densityDpi() : int
      {
         return _densityDpi;
      }
      
      public function set densityDpi(param1:int) : void
      {
         _densityDpi = param1;
      }
      
      public function get screenHeight() : int
      {
         return _screenHeight;
      }
      
      public function set screenHeight(param1:int) : void
      {
         _screenHeight = param1;
      }
      
      public function get screenWidth() : int
      {
         return _screenWidth;
      }
      
      public function set screenWidth(param1:int) : void
      {
         _screenWidth = param1;
      }
      
      public function get xdpi() : Number
      {
         return _xdpi;
      }
      
      public function set xdpi(param1:Number) : void
      {
         _xdpi = param1;
      }
      
      public function get ydpi() : Number
      {
         return _ydpi;
      }
      
      public function set ydpi(param1:Number) : void
      {
         _ydpi = param1;
      }
      
      public function get nativeScale() : Number
      {
         return _nativeScale;
      }
      
      public function set nativeScale(param1:Number) : void
      {
         _nativeScale = param1;
      }
      
      override public function toString() : String
      {
         return "[" + screenWidth + "x" + screenHeight + "]";
      }
   }
}
