package com.distriqt.extension.gameservices.events
{
   import flash.events.Event;
   
   public class ScreenRecordingEvent extends Event
   {
      
      private static const TAG:String = "ScreenRecordingEvent";
      
      public static const AVAILABILITY_CHANGED:String = "screenrecording:availability:changed";
      
      public static const STARTED:String = "screenrecording:started";
      
      public static const STOPPED:String = "screenrecording:stopped";
      
      public static const COMPLETE:String = "screenrecording:complete";
      
      public static const ERROR:String = "screenrecording:error";
      
      public static const CONTROLS_SHOWN:String = "screenrecording:controls:shown";
      
      public static const CONTROLS_CLOSED:String = "screenrecording:controls:closed";
      
      public static const PREVIEW_SHOWN:String = "screenrecording:preview:shown";
      
      public static const PREVIEW_CLOSED:String = "screenrecording:preview:closed";
       
      
      public var filepath:String = "";
      
      public var message:String = "";
      
      public var errorCode:int = -1;
      
      public function ScreenRecordingEvent(param1:String, param2:String = null, param3:String = "", param4:int = -1, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.filepath = param2;
         this.message = param3;
         this.errorCode = param4;
      }
      
      override public function clone() : Event
      {
         return new ScreenRecordingEvent(type,message,filepath,errorCode,bubbles,cancelable);
      }
   }
}
