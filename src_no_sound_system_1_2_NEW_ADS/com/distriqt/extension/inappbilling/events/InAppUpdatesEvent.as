package com.distriqt.extension.inappbilling.events
{
   import com.distriqt.extension.inappbilling.updates.InAppUpdateInfo;
   import flash.events.Event;
   
   public class InAppUpdatesEvent extends Event
   {
      
      private static const TAG:String = "InAppUpdatesEvent";
      
      public static const CHECK_APP_UPDATES_SUCCESS:String = "inappupdates:checkAppUpdate:success";
      
      public static const CHECK_APP_UPDATES_FAILED:String = "inappupdates:checkAppUpdate:failed";
       
      
      public var updateAvailability:int;
      
      public var updateInfo:InAppUpdateInfo;
      
      public var errorCode:int;
      
      public var message:String;
      
      public function InAppUpdatesEvent(param1:String, param2:int, param3:InAppUpdateInfo, param4:int = 0, param5:String = null, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         this.updateAvailability = param2;
         this.updateInfo = param3;
         this.errorCode = param4;
         this.message = param5;
      }
      
      override public function clone() : Event
      {
         return new InAppUpdatesEvent(type,updateAvailability,updateInfo,errorCode,message,bubbles,cancelable);
      }
   }
}
