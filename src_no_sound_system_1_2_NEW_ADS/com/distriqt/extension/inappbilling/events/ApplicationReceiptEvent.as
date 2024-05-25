package com.distriqt.extension.inappbilling.events
{
   import flash.events.Event;
   
   public class ApplicationReceiptEvent extends Event
   {
      
      public static const REFRESH_SUCCESS:String = "applicationreceipt:refresh:success";
      
      public static const REFRESH_FAILED:String = "applicationreceipt:refresh:failed";
       
      
      public var error:String = "";
      
      public var errorCode:String = "";
      
      public function ApplicationReceiptEvent(param1:String, param2:String = "", param3:String = "", param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.error = param2;
         this.errorCode = param3;
      }
      
      override public function clone() : Event
      {
         return new ApplicationReceiptEvent(type,error,errorCode,bubbles,cancelable);
      }
   }
}
