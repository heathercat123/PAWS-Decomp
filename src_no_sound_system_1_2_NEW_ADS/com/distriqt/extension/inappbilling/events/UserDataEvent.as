package com.distriqt.extension.inappbilling.events
{
   import com.distriqt.extension.inappbilling.user.UserData;
   import flash.events.Event;
   
   public class UserDataEvent extends Event
   {
      
      private static const TAG:String = "UserDataEvent";
      
      public static const GET_SUCCESS:String = "userdata:get:success";
      
      public static const GET_FAILED:String = "userdata:get:failed";
       
      
      public var userData:UserData;
      
      public function UserDataEvent(param1:String, param2:UserData, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.userData = param2;
      }
      
      override public function clone() : Event
      {
         return new UserDataEvent(type,userData,bubbles,cancelable);
      }
   }
}
