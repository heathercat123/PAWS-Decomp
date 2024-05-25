package com.distriqt.extension.inappbilling
{
   public class PurchaseChangeRequest
   {
      
      private static const TAG:String = "PurchaseChangeRequest";
      
      public static const IMMEDIATE_WITH_TIME_PRORATION:int = 1;
      
      public static const IMMEDIATE_AND_CHARGE_PRORATED_PRICE:int = 2;
      
      public static const IMMEDIATE_WITHOUT_PRORATION:int = 3;
      
      public static const DEFERRED:int = 4;
      
      public static const IMMEDIATE_AND_CHARGE_FULL_PRICE:int = 5;
       
      
      public var currentProductId:String = "";
      
      public var currentTransactionId:String = "";
      
      public var newProductId:String = "";
      
      public var applicationUsername:String = "";
      
      public var prorationMode:int = 1;
      
      public var subscriptionOfferRequest:SubscriptionOfferRequest;
      
      public function PurchaseChangeRequest()
      {
         super();
      }
      
      [Deprecated(message="Use setCurrentDetails()")]
      public function setCurrentProductId(param1:String) : PurchaseChangeRequest
      {
         this.currentProductId = param1;
         return this;
      }
      
      public function setCurrentDetails(param1:String, param2:String) : PurchaseChangeRequest
      {
         this.currentProductId = param1;
         this.currentTransactionId = param2;
         return this;
      }
      
      public function setCurrentPurchase(param1:Purchase) : PurchaseChangeRequest
      {
         this.currentProductId = param1.productId;
         this.currentTransactionId = param1.transactionId;
         return this;
      }
      
      public function setNewProductId(param1:String) : PurchaseChangeRequest
      {
         this.newProductId = param1;
         return this;
      }
      
      public function setProrationMode(param1:int) : PurchaseChangeRequest
      {
         this.prorationMode = param1;
         return this;
      }
      
      public function setApplicationUsername(param1:String) : PurchaseChangeRequest
      {
         this.applicationUsername = param1;
         return this;
      }
      
      public function setSubscriptionOfferRequest(param1:SubscriptionOfferRequest) : PurchaseChangeRequest
      {
         this.subscriptionOfferRequest = param1;
         return this;
      }
   }
}
