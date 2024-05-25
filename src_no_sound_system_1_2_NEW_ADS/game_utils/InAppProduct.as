package game_utils
{
   public class InAppProduct
   {
       
      
      public var product_id:String;
      
      public var product_title:String;
      
      public var product_description:String;
      
      public var product_localized_price:String;
      
      public var product_price:String;
      
      public function InAppProduct(_id:String, _title:String, _description:String, _loc_price:String, _price:String)
      {
         super();
         this.product_id = _id;
         this.product_title = _title;
         this.product_description = _description;
         this.product_localized_price = _loc_price;
         this.product_price = _price;
      }
   }
}
