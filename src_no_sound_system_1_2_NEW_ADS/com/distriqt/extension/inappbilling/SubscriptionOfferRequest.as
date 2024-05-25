package com.distriqt.extension.inappbilling
{
   public class SubscriptionOfferRequest
   {
      
      private static const TAG:String = "SubscriptionOfferRequest";
       
      
      public var offer:SubscriptionOffer;
      
      public var keyIdentifier:String = "";
      
      public var nonce:String = "";
      
      public var signature:String = "";
      
      public var timestamp:Number = 0;
      
      public function SubscriptionOfferRequest()
      {
         super();
      }
      
      internal static function fromObject(param1:Object) : SubscriptionOfferRequest
      {
         var _loc2_:SubscriptionOfferRequest = new SubscriptionOfferRequest();
         if(param1.hasOwnProperty("keyIdentifier"))
         {
            _loc2_.keyIdentifier = param1.keyIdentifier;
         }
         if(param1.hasOwnProperty("nonce"))
         {
            _loc2_.nonce = param1.nonce;
         }
         if(param1.hasOwnProperty("signature"))
         {
            _loc2_.signature = param1.signature;
         }
         if(param1.hasOwnProperty("timestamp"))
         {
            _loc2_.timestamp = param1.timestamp;
         }
         if(param1.hasOwnProperty("offer"))
         {
            _loc2_.offer = SubscriptionOffer.fromObject(param1.offer);
         }
         return _loc2_;
      }
      
      public function setSubscriptionOffer(param1:SubscriptionOffer) : SubscriptionOfferRequest
      {
         this.offer = param1;
         return this;
      }
      
      public function setSignature(param1:String, param2:String, param3:String, param4:Number) : SubscriptionOfferRequest
      {
         this.keyIdentifier = param1;
         this.nonce = param2;
         this.signature = param3;
         this.timestamp = param4;
         return this;
      }
   }
}
