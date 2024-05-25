package com.distriqt.extension.inappbilling
{
   public class PurchaseRequest
   {
       
      
      public var productId:String = "";
      
      public var quantity:int = 1;

      public var developerPayload:String = "";
      
      public var applicationUsername:String = "";
      
      public var profileId:String = "";
      
      public var simulatePurchase:Boolean = false;
      
      public var subscriptionOfferRequest:SubscriptionOfferRequest;
      
      public function PurchaseRequest(param1:String = "", param2:int = 1)
      {
         super();
         this.productId = param1;
         this.quantity = param2;
      }
      
      internal static function fromObject(param1:Object) : PurchaseRequest
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:PurchaseRequest = new PurchaseRequest();
         if(param1.hasOwnProperty("productId"))
         {
            _loc2_.productId = param1.productId;
         }
         if(param1.hasOwnProperty("quantity"))
         {
            _loc2_.quantity = param1.quantity;
         }
         if(param1.hasOwnProperty("developerPayload"))
         {
            _loc2_.developerPayload = param1.developerPayload;
         }
         if(param1.hasOwnProperty("applicationUsername"))
         {
            _loc2_.applicationUsername = param1.applicationUsername;
         }
         if(param1.hasOwnProperty("profileId"))
         {
            _loc2_.profileId = param1.profileId;
         }
         if(param1.hasOwnProperty("simulatePurchase"))
         {
            _loc2_.simulatePurchase = param1.simulatePurchase;
         }
         if(param1.hasOwnProperty("subscriptionOfferRequest"))
         {
            _loc2_.subscriptionOfferRequest = SubscriptionOfferRequest.fromObject(param1.subscriptionOfferRequest);
         }
         return _loc2_;
      }
      
      public function setProductId(param1:String) : PurchaseRequest
      {
         this.productId = param1;
         return this;
      }
      
      public function setQuantity(param1:int) : PurchaseRequest
      {
         this.quantity = param1;
         return this;
      }
      
      [Deprecated]
      public function setDeveloperPayload(param1:String) : PurchaseRequest
      {
         this.developerPayload = param1;
         return this;
      }
      
      public function setApplicationUsername(param1:String) : PurchaseRequest
      {
         this.applicationUsername = param1;
         return this;
      }
      
      public function setProfileId(param1:String) : PurchaseRequest
      {
         this.profileId = param1;
         return this;
      }
      
      public function setSimulatePurchase(param1:Boolean) : PurchaseRequest
      {
         this.simulatePurchase = param1;
         return this;
      }
      
      public function setSubscriptionOfferRequest(param1:SubscriptionOfferRequest) : PurchaseRequest
      {
         this.subscriptionOfferRequest = param1;
         return this;
      }
   }
}
