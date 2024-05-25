package com.distriqt.extension.adverts
{
   public class AdValue
   {
      
      private static const TAG:String = "AdValue";
       
      
      public var value:Number;
      
      public var currencyCode:String;
      
      public var precisionType:int;
      
      public var adapterClassName:String;
      
      public function AdValue()
      {
         super();
      }
      
      internal static function fromObject(param1:Object) : AdValue
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:AdValue = new AdValue();
         if(param1.hasOwnProperty("value"))
         {
            _loc2_.value = param1.value;
         }
         if(param1.hasOwnProperty("currencyCode"))
         {
            _loc2_.currencyCode = param1.currencyCode;
         }
         if(param1.hasOwnProperty("precisionType"))
         {
            _loc2_.precisionType = param1.precisionType;
         }
         if(param1.hasOwnProperty("adapterClassName"))
         {
            _loc2_.adapterClassName = param1.adapterClassName;
         }
         return _loc2_;
      }
   }
}
