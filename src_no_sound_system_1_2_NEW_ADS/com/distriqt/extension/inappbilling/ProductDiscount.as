package com.distriqt.extension.inappbilling
{
   public class ProductDiscount
   {
      
      private static const TAG:String = "ProductDiscount";
      
      public static const TYPE_INTRODUCTORY:String = "introductory";
      
      public static const TYPE_SUBSCRIPTION:String = "subscription";
      
      public static const PAYMENTMODE_PAY_AS_YOU_GO:String = "paymentmode_payAsYouGo";
      
      public static const PAYMENTMODE_PAY_UP_FRONT:String = "paymentmode_payUpFront";
      
      public static const PAYMENTMODE_FREE_TRIAL:String = "paymentmode_freeTrial";
       
      
      public var id:String;
      
      public var currencyCode:String = "";
      
      public var currencySymbol:String = "";
      
      public var price:Number;
      
      public var priceString:String;
      
      public var paymentMode:String;
      
      public var type:String = "introductory";
      
      public var numberOfPeriods:int;
      
      public var subscriptionPeriod:SubscriptionPeriod;
      
      public var storeDeterminedEligible:Boolean = false;
      
      public function ProductDiscount()
      {
         super();
      }
      
      internal static function fromObject(param1:Object) : ProductDiscount
      {
         var _loc2_:ProductDiscount = new ProductDiscount();
         if(param1.hasOwnProperty("id"))
         {
            _loc2_.id = param1.id;
         }
         if(param1.hasOwnProperty("currencyCode"))
         {
            _loc2_.currencyCode = param1.currencyCode;
         }
         if(param1.hasOwnProperty("currencySymbol"))
         {
            _loc2_.currencySymbol = param1.currencySymbol;
         }
         if(param1.hasOwnProperty("price"))
         {
            _loc2_.price = param1.price;
         }
         if(param1.hasOwnProperty("priceString"))
         {
            _loc2_.priceString = param1.priceString;
         }
         if(param1.hasOwnProperty("paymentMode"))
         {
            _loc2_.paymentMode = param1.paymentMode;
         }
         if(param1.hasOwnProperty("type"))
         {
            _loc2_.type = param1.type;
         }
         if(param1.hasOwnProperty("numberOfPeriods"))
         {
            _loc2_.numberOfPeriods = param1.numberOfPeriods;
         }
         if(param1.hasOwnProperty("subscriptionPeriod"))
         {
            _loc2_.subscriptionPeriod = SubscriptionPeriod.fromObject(param1.subscriptionPeriod);
         }
         if(param1.hasOwnProperty("storeDeterminedEligible"))
         {
            _loc2_.storeDeterminedEligible = param1.storeDeterminedEligible;
         }
         try
         {
            if(_loc2_.priceString == null)
            {
               _loc2_.priceString = _loc2_.currencySymbol + String(_loc2_.price);
            }
         }
         catch(e:Error)
         {
         }
         return _loc2_;
      }
   }
}
