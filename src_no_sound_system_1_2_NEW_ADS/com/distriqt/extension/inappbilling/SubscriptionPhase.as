package com.distriqt.extension.inappbilling
{
   public class SubscriptionPhase
   {
      
      public static const RECURRENCE_MODE_INFINITE:String = "infinite";
      
      public static const RECURRENCE_MODE_FINITE:String = "finite";
      
      public static const RECURRENCE_MODE_NONE:String = "none";
       
      
      public var price:Number;
      
      public var priceString:String;
      
      public var currencyCode:String = "";
      
      public var currencySymbol:String = "";
      
      public var subscriptionPeriod:SubscriptionPeriod;
      
      public var recurrenceMode:String = "infinite";
      
      public var numberOfPeriods:int = 0;
      
      public var paymentMode:String = "paymentmode_payAsYouGo";
      
      public function SubscriptionPhase()
      {
         super();
      }
      
      internal static function fromObject(param1:Object) : SubscriptionPhase
      {
         var _loc2_:SubscriptionPhase = new SubscriptionPhase();
         if(param1.hasOwnProperty("price"))
         {
            _loc2_.price = param1.price;
         }
         if(param1.hasOwnProperty("priceString"))
         {
            _loc2_.priceString = param1.priceString;
         }
         if(param1.hasOwnProperty("currencySymbol"))
         {
            _loc2_.currencySymbol = param1.currencySymbol;
         }
         if(param1.hasOwnProperty("currencyCode"))
         {
            _loc2_.currencyCode = param1.currencyCode;
         }
         if(param1.hasOwnProperty("subscriptionPeriod"))
         {
            _loc2_.subscriptionPeriod = SubscriptionPeriod.fromObject(param1.subscriptionPeriod);
         }
         if(param1.hasOwnProperty("recurrenceMode"))
         {
            _loc2_.recurrenceMode = param1.recurrenceMode;
         }
         if(param1.hasOwnProperty("numberOfPeriods"))
         {
            _loc2_.numberOfPeriods = param1.numberOfPeriods;
         }
         if(param1.hasOwnProperty("paymentMode"))
         {
            _loc2_.paymentMode = param1.paymentMode;
         }
         return _loc2_;
      }
   }
}
