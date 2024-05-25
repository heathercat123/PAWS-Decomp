package com.distriqt.extension.inappbilling
{
   import com.distriqt.extension.inappbilling.promotions.Promotions;
   import flash.events.EventDispatcher;
   
   internal class _PromotionsImpl extends EventDispatcher implements Promotions
   {
      
      private static const TAG:String = "_PromotionsImpl";
       
      
      public function _PromotionsImpl()
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
      
      public function getStoreVisibility(param1:String) : Boolean
      {
         return false;
      }
      
      public function updateStoreVisibility(param1:String, param2:int) : Boolean
      {
         return false;
      }
      
      public function getStoreOrder() : Boolean
      {
         return false;
      }
      
      public function updateStoreOrder(param1:Array) : Boolean
      {
         return false;
      }
      
      public function showCodeRedemptionDialog() : Boolean
      {
         return false;
      }
   }
}
