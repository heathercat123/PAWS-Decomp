package game_utils
{
   import flash.display.*;
   import flash.net.*;
   
   public class InAppProductsManager
   {
      
      public static var products:Vector.<InAppProduct>;
       
      
      public function InAppProductsManager()
      {
         super();
      }
      
      public static function Init() : void
      {
         products = new Vector.<InAppProduct>();
         products.push(new InAppProduct("com.neutronized.supercattalespaws.inapp_tier1","tier1","tier1","$1.09","1.09"));
         products.push(new InAppProduct("com.neutronized.supercattalespaws.inapp_tier2","tier2","tier2","$2.29","2.29"));
         products.push(new InAppProduct("com.neutronized.supercattalespaws.inapp_tier3","tier3","tier3","$3.49","3.49"));
         products.push(new InAppProduct("com.neutronized.supercattalespaws.premium","premium","premium","$4.99","4.99"));
         products.push(new InAppProduct("com.neutronized.supercattalespaws.gate_ticket","ticket","ticket","$2.29","2.29"));
      }
      
      public static function GetPrice(_id:String) : Number
      {
         var i:int = 0;
         var price:Number = 0.99;
         for(i = 0; i < products.length; i++)
         {
            if(products[i].product_id == _id)
            {
               price = Number(products[i].product_localized_price);
            }
         }
         return price;
      }
      
      public static function GetLocalizedPrice(_id:String) : String
      {
         var i:int = 0;
         var price:String = "0.99";
         for(i = 0; i < products.length; i++)
         {
            if(products[i].product_id == _id)
            {
               price = products[i].product_localized_price;
            }
         }
         return price;
      }
      
      public static function Reset() : void
      {
         products = new Vector.<InAppProduct>();
      }
   }
}
