package com.distriqt.extension.application
{
   import com.distriqt.extension.application.alarms.Alarm;
   import com.distriqt.extension.application.alarms.AlarmManager;
   import flash.events.EventDispatcher;
   
   internal final class _AlarmManagerImpl extends EventDispatcher implements AlarmManager
   {
       
      
      public function _AlarmManagerImpl()
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
      
      public function register() : Boolean
      {
         return false;
      }
      
      public function setAlarm(param1:Alarm) : Boolean
      {
         return false;
      }
      
      public function cancelAlarm(param1:Alarm) : Boolean
      {
         return false;
      }
      
      public function cancelAlarmById(param1:int) : Boolean
      {
         return false;
      }
      
      public function cancelAllAlarms() : Boolean
      {
         return false;
      }
   }
}
