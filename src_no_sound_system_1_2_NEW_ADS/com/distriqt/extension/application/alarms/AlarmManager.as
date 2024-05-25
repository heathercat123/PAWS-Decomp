package com.distriqt.extension.application.alarms
{
   import flash.events.IEventDispatcher;
   
   [Event(name="alarm",type="com.distriqt.extension.application.events.AlarmEvent")]
   public interface AlarmManager extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function register() : Boolean;
      
      function setAlarm(param1:Alarm) : Boolean;
      
      function cancelAlarm(param1:Alarm) : Boolean;
      
      function cancelAlarmById(param1:int) : Boolean;
      
      function cancelAllAlarms() : Boolean;
   }
}
