package com.distriqt.extension.application.alarms
{
   public class Alarm
   {
       
      
      public var id:int = 0;
      
      public var interval:Number = 0;
      
      public var timestamp:Number = 0;
      
      public var data:String = "";
      
      public var isExact:Boolean = false;
      
      public var willLaunchApplication:Boolean = false;
      
      public var allowWhileIdle:Boolean = false;
      
      public function Alarm()
      {
         super();
      }
   }
}
