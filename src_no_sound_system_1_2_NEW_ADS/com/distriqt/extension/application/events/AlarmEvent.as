package com.distriqt.extension.application.events
{
   import flash.events.Event;
   
   public class AlarmEvent extends Event
   {
      
      public static const ALARM:String = "alarm";
       
      
      public var id:int = 0;
      
      public var data:String = "";
      
      public function AlarmEvent(param1:String, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.id = param2;
         this.data = param3;
      }
      
      override public function clone() : Event
      {
         return new AlarmEvent(type,id,data,bubbles,cancelable);
      }
   }
}
