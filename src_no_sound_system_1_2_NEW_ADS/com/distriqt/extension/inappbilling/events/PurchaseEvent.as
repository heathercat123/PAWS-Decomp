package com.distriqt.extension.inappbilling.events
{
   import com.distriqt.extension.inappbilling.Purchase;
   import flash.events.Event;
   
   public class PurchaseEvent extends Event
   {
      
      [Deprecated(replacement="PurchaseEvent.PURCHASES_UPDATED")]
      public static const PURCHASE_SUCCESS:String = "purchase:success";
      
      [Deprecated(replacement="PurchaseEvent.PURCHASES_UPDATED")]
      public static const PURCHASE_CANCELLED:String = "purchase:cancelled";
      
      [Deprecated(replacement="PurchaseEvent.PURCHASES_UPDATED")]
      public static const PURCHASE_PURCHASING:String = "purchase:purchasing";
      
      [Deprecated(replacement="PurchaseEvent.PURCHASES_UPDATED")]
      public static const PURCHASE_RESTORED:String = "purchase:restored";
      
      [Deprecated(replacement="PurchaseEvent.PURCHASES_UPDATED")]
      public static const PURCHASE_REFUNDED:String = "purchase:refunded";
      
      [Deprecated(replacement="PurchaseEvent.PURCHASES_UPDATED")]
      public static const PURCHASE_REMOVED:String = "purchase:removed";
      
      [Deprecated(replacement="PurchaseEvent.PURCHASES_UPDATED")]
      public static const PURCHASE_NOTALLOWED:String = "purchase:notallowed";
      
      [Deprecated(replacement="PurchaseEvent.PURCHASES_UPDATED")]
      public static const PURCHASE_DEFERRED:String = "purchase:deferred";
      
      public static const PURCHASE_FAILED:String = "purchase:failed";
      
      public static const PURCHASES_UPDATED:String = "purchases:updated";
      
      public static const GET_PURCHASES_COMPLETE:String = "get:purchases:complete";
      
      public static const GET_PURCHASES_FAILED:String = "get:purchases:failed";
       
      
      public var data:Vector.<Purchase>;
      
      public var message:String = "";
      
      public var errorCode:String = "";
      
      public function PurchaseEvent(param1:String, param2:Vector.<Purchase>, param3:String = "", param4:String = "", param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.data = param2;
         this.errorCode = param3;
         this.message = param4;
      }
      
      override public function clone() : Event
      {
         return new PurchaseEvent(type,data,errorCode,message,bubbles,cancelable);
      }
   }
}
