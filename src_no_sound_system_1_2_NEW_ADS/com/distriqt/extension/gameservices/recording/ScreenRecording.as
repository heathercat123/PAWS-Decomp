package com.distriqt.extension.gameservices.recording
{
   import flash.events.IEventDispatcher;
   
   [Event(name="screenrecording:supported:updated",type="com.distriqt.extension.gameservices.events.ScreenRecordingEvent")]
   [Event(name="screenrecording:started",type="com.distriqt.extension.gameservices.events.ScreenRecordingEvent")]
   [Event(name="screenrecording:stopped",type="com.distriqt.extension.gameservices.events.ScreenRecordingEvent")]
   [Event(name="screenrecording:error",type="com.distriqt.extension.gameservices.events.ScreenRecordingEvent")]
   [Event(name="screenrecording:controls:shown",type="com.distriqt.extension.gameservices.events.ScreenRecordingEvent")]
   [Event(name="screenrecording:controls:closed",type="com.distriqt.extension.gameservices.events.ScreenRecordingEvent")]
   [Event(name="screenrecording:preview:shown",type="com.distriqt.extension.gameservices.events.ScreenRecordingEvent")]
   [Event(name="screenrecording:preview:closed",type="com.distriqt.extension.gameservices.events.ScreenRecordingEvent")]
   public interface ScreenRecording extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function checkAvailability(param1:Function = null) : Boolean;
      
      function start(param1:ScreenRecordingOptions = null) : Boolean;
      
      function stop() : Boolean;
   }
}
