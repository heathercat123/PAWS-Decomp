package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.recording.ScreenRecording;
   import com.distriqt.extension.gameservices.recording.ScreenRecordingOptions;
   import flash.events.EventDispatcher;
   
   internal class _ScreenRecordingImpl extends EventDispatcher implements ScreenRecording
   {
      
      private static const TAG:String = "_ScreenRecordingImpl";
       
      
      public function _ScreenRecordingImpl()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function checkAvailability(param1:Function = null) : Boolean
      {
         return false;
      }
      
      public function start(param1:ScreenRecordingOptions = null) : Boolean
      {
         return false;
      }
      
      public function stop() : Boolean
      {
         return false;
      }
   }
}
