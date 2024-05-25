package com.distriqt.extension.inappbilling
{
   public class Product
   {
      
      public static const TYPE_PRODUCT:String = "inapp";
      
      public static const TYPE_SUBSCRIPTION:String = "subs";
       
      
      public var id:String;
      
      public var type:String;
      
      public var title:String;
      
      public var description:String;
      
      public var currencyCode:String = "";
      
      public var currencySymbol:String = "";
      
      public var price:Number;
      
      public var priceString:String;
      
      public var locale:String = "";
      
      public var countryCode:String = "";
      
      public var source:String;
      
      public var subscriptionOffers:Vector.<SubscriptionOffer>;
      
      public var subscriptionPeriod:SubscriptionPeriod;
      
      public function Product()
      {
         super();
         subscriptionOffers = new Vector.<SubscriptionOffer>(0);
      }
      
      internal static function fromObject(param1:Object) : Product
      {
         var _loc2_:Product = new Product();
         if(param1.hasOwnProperty("id"))
         {
            _loc2_.id = param1.id;
         }
         if(param1.hasOwnProperty("title"))
         {
            _loc2_.title = param1.title;
         }
         if(param1.hasOwnProperty("description"))
         {
            _loc2_.description = param1.description;
         }
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
         if(param1.hasOwnProperty("locale"))
         {
            _loc2_.locale = param1.locale;
         }
         if(param1.hasOwnProperty("countryCode"))
         {
            _loc2_.countryCode = param1.countryCode;
         }
         if(param1.hasOwnProperty("type"))
         {
            _loc2_.type = param1.type;
         }
         if(param1.hasOwnProperty("source"))
         {
            _loc2_.source = param1.source;
         }
         if(param1.hasOwnProperty("subscriptionOffers") && param1.subscriptionOffers is Array)
         {
            _loc2_.subscriptionOffers = new Vector.<SubscriptionOffer>(0);
            for each(var _loc3_:int in param1.subscriptionOffers)
            {
               _loc2_.subscriptionOffers.push(SubscriptionOffer.fromObject(_loc3_));
            }
         }
         if(param1.hasOwnProperty("subscriptionPeriod"))
         {
            _loc2_.subscriptionPeriod = SubscriptionPeriod.fromObject(param1.subscriptionPeriod);
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
         try
         {
            if(_loc2_.type == "subs" && _loc2_.subscriptionOffers.length == 0)
            {
               _loc2_.subscriptionOffers.push(offerFromProduct(_loc2_));
            }
         }
         catch(e:Error)
         {
         }
         return _loc2_;
      }
      
      internal static function offerFromProduct(param1:Product) : SubscriptionOffer
      {
         var _loc2_:SubscriptionPhase = new SubscriptionPhase();
         _loc2_.price = param1.price;
         _loc2_.priceString = param1.priceString;
         _loc2_.currencyCode = param1.currencyCode;
         _loc2_.currencySymbol = param1.currencySymbol;
         _loc2_.subscriptionPeriod = param1.subscriptionPeriod;
         var _loc3_:SubscriptionOffer = new SubscriptionOffer();
         _loc3_.id = "baseOffer";
         _loc3_.pricingPhases.push(_loc2_);
         return _loc3_;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "{\n";
         _loc1_ += "  productId: " + id + ",\n";
         _loc1_ += "  price: " + price + ",\n";
         _loc1_ += "  priceString: " + priceString + ",\n";
         _loc1_ += "  type: " + type + ",\n";
         _loc1_ += "  title: " + title + ",\n";
         _loc1_ += "  description: " + description + ",\n";
         _loc1_ += "  locale: " + locale + ",\n";
         _loc1_ += "  countryCode: " + countryCode + ",\n";
         _loc1_ += "  currencySymbol: " + currencySymbol + ",\n";
         _loc1_ += "  currencyCode: " + currencyCode + ",\n";
         return _loc1_ + "}";
      }
   }
}
