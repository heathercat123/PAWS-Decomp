package com.distriqt.extension.gameservices.recording
{
   import flash.display.BitmapData;
   import flash.filesystem.File;
   import flash.globalization.DateTimeFormatter;
   
   public class ScreenRecordingOptions
   {
      
      private static const TAG:String = "ScreenRecordingOptions";
      
      public static const HIGH:String = "high_quality";
      
      public static const MEDIUM:String = "medium_quality";
      
      public static const LOW:String = "low_quality";
       
      
      public var quality:String = "high_quality";
      
      public var filepath:String = "";
      
      public var uiOverlayEnabled:Boolean = true;
      
      public var uiOverlayStopButton:BitmapData = null;
      
      public var microphoneEnabled:Boolean = false;
      
      public function ScreenRecordingOptions()
      {
         super();
         var _loc1_:Date = new Date();
         var _loc2_:DateTimeFormatter = new DateTimeFormatter("en-US");
         _loc2_.setDateTimePattern("yyyyMMdd_hhmmss");
         var _loc3_:String = _loc2_.format(_loc1_) + ".mp4";
         filepath = File.documentsDirectory.resolvePath(_loc3_).nativePath;
      }
   }
}
