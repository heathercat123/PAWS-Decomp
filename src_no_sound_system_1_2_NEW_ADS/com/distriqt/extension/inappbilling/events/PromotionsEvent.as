package com.distriqt.extension.inappbilling.events
{
   import flash.events.Event;
   
   public class PromotionsEvent extends Event
   {
      
      private static const TAG:String = "PromotionsEvent";
      
      public static const GET_STORE_VISIBILITY_COMPLETE:String = "promotions:getStoreVisbility:complete";
      
      public static const GET_STORE_VISIBILITY_ERROR:String = "promotions:getStoreVisbility:error";
      
      public static const UPDATE_STORE_VISIBILITY_COMPLETE:String = "promotions:updateStoreVisbility:complete";
      
      public static const UPDATE_STORE_VISIBILITY_ERROR:String = "promotions:updateStoreVisbility:error";
      
      public static const GET_STORE_ORDER_COMPLETE:String = "promotions:getStoreOrder:complete";
      
      public static const GET_STORE_ORDER_ERROR:String = "promotions:getStoreOrder:error";
      
      public static const UPDATE_STORE_ORDER_COMPLETE:String = "promotions:updateStoreOrder:complete";
      
      public static const UPDATE_STORE_ORDER_ERROR:String = "promotions:updateStoreOrder:error";
       
      
      public var productId:String = null;
      
      public var visibility:int = 0;
      
      public var productIdOrder:Array = null;
      
      public var error:String = null;
      
      public var errorCode:int = -1;
      
      public function PromotionsEvent(param1:String, param2:String = null, param3:int = -1, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.error = param2;
         this.errorCode = param3;
      }
      
      override public function clone() : Event
      {
         var _loc1_:PromotionsEvent = new PromotionsEvent(type,error,errorCode,bubbles,cancelable);
         _loc1_.productId = productId;
         _loc1_.visibility = visibility;
         _loc1_.productIdOrder = productIdOrder;
         return _loc1_;
      }
   }
}
