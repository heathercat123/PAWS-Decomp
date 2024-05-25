package com.distriqt.extension.inappbilling.events
{
   import com.distriqt.extension.inappbilling.PurchaseRequest;
   import flash.events.Event;
   
   public class PurchaseRequestEvent extends Event
   {
      
      private static const TAG:String = "PurchaseRequestEvent";
      
      public static const SHOULD_ADD_PURCHASE:String = "should:add:purchase";
       
      
      public var request:PurchaseRequest;
      
      public function PurchaseRequestEvent(param1:String, param2:PurchaseRequest, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.request = param2;
      }
      
      override public function clone() : Event
      {
         return new PurchaseRequestEvent(type,request,bubbles,cancelable);
      }
   }
}
