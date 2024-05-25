package com.distriqt.extension.application
{
   import flash.events.IEventDispatcher;
   
   public interface Device extends IEventDispatcher
   {
       
      
      function uniqueId(param1:String = "vendor", param2:Boolean = false) : String;
      
      function get name() : String;
      
      function get brand() : String;
      
      function get manufacturer() : String;
      
      function get device() : String;
      
      function get model() : String;
      
      function get product() : String;
      
      function get os() : OperatingSystem;
      
      function get yearClass() : int;
      
      function get phone() : String;
      
      function get displayMetrics() : DisplayMetrics;
      
      function getFilesDir() : String;
      
      function getExternalFilesDir() : String;
      
      function isDeviceIdleMode() : Boolean;
      
      function isPowerSaveMode() : Boolean;
      
      function isAutoTimeEnabled() : Boolean;
      
      function isAutoTimeZoneEnabled() : Boolean;
      
      function get deviceOrientation() : String;
      
      function startGeneratingDeviceOrientationEvents() : Boolean;
      
      function stopGeneratingDeviceOrientationEvents() : Boolean;
      
      function get locale() : Locale;
   }
}
