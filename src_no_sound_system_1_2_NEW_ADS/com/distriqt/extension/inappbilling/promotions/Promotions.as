package com.distriqt.extension.inappbilling.promotions
{
   import flash.events.IEventDispatcher;
   
   [Event(name="",type="com.distriqt.extension.inappbilling.events.PromotionsEvent")]
   [Event(name="",type="com.distriqt.extension.inappbilling.events.PromotionsEvent")]
   [Event(name="",type="com.distriqt.extension.inappbilling.events.PromotionsEvent")]
   [Event(name="",type="com.distriqt.extension.inappbilling.events.PromotionsEvent")]
   [Event(name="",type="com.distriqt.extension.inappbilling.events.PromotionsEvent")]
   [Event(name="",type="com.distriqt.extension.inappbilling.events.PromotionsEvent")]
   [Event(name="",type="com.distriqt.extension.inappbilling.events.PromotionsEvent")]
   [Event(name="",type="com.distriqt.extension.inappbilling.events.PromotionsEvent")]
   public interface Promotions extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function getStoreVisibility(param1:String) : Boolean;
      
      function updateStoreVisibility(param1:String, param2:int) : Boolean;
      
      function getStoreOrder() : Boolean;
      
      function updateStoreOrder(param1:Array) : Boolean;
      
      function showCodeRedemptionDialog() : Boolean;
   }
}
