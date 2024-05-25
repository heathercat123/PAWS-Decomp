package com.distriqt.extension.application.alarms
{
   public class AlarmBuilder
   {
       
      
      private var _alarm:Alarm;
      
      public function AlarmBuilder()
      {
         super();
         _alarm = new Alarm();
      }
      
      public function setId(param1:int) : AlarmBuilder
      {
         _alarm.id = param1;
         return this;
      }
      
      public function setExact(param1:Boolean = true) : AlarmBuilder
      {
         _alarm.isExact = param1;
         return this;
      }
      
      public function setAllowWhileIdle(param1:Boolean = true) : AlarmBuilder
      {
         _alarm.allowWhileIdle = param1;
         return this;
      }
      
      public function setWillLaunchApplication(param1:Boolean = true) : AlarmBuilder
      {
         _alarm.willLaunchApplication = param1;
         return this;
      }
      
      public function setTime(param1:Number) : AlarmBuilder
      {
         _alarm.timestamp = param1;
         return this;
      }
      
      public function setDate(param1:Date) : AlarmBuilder
      {
         _alarm.timestamp = param1.time;
         return this;
      }
      
      public function setRepeatInterval(param1:Number) : AlarmBuilder
      {
         _alarm.interval = param1;
         return this;
      }
      
      public function setData(param1:String) : AlarmBuilder
      {
         _alarm.data = param1;
         return this;
      }
      
      public function build() : Alarm
      {
         if(_alarm.timestamp <= 0)
         {
            throw new Error("Alarm must have a timestamp, see AlarmBuilder.setTime");
         }
         return _alarm;
      }
   }
}
