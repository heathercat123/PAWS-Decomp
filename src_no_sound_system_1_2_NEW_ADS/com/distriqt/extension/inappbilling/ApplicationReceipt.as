package com.distriqt.extension.inappbilling
{
   import flash.events.IEventDispatcher;
   
   [Event(name="applicationreceipt:refresh:success",type="com.distriqt.extension.inappbilling.events.ApplicationReceiptEvent")]
   [Event(name="applicationreceipt:refresh:failed",type="com.distriqt.extension.inappbilling.events.ApplicationReceiptEvent")]
   public interface ApplicationReceipt extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function getAppReceipt() : String;
      
      function refresh(param1:ApplicationReceiptProperties = null, param2:Function = null) : Boolean;
   }
}
