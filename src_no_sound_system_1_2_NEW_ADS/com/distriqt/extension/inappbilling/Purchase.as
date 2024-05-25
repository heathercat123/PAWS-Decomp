package com.distriqt.extension.inappbilling
{
   import com.distriqt.extension.inappbilling.user.UserData;
   
   public class Purchase
   {
      
      public static const STATE_UNKNOWN:String = "transaction:unknown";
      
      public static const STATE_PURCHASING:String = "transaction:purchasing";
      
      public static const STATE_DEFERRED:String = "transaction:deferred";
      
      public static const STATE_PURCHASED:String = "transaction:purchased";
      
      public static const STATE_FAILED:String = "transaction:failed";
      
      public static const STATE_RESTORED:String = "transaction:restored";
      
      public static const STATE_REFUNDED:String = "transaction:refunded";
      
      public static const STATE_REMOVED:String = "transaction:removed";
      
      public static const STATE_CANCELLED:String = "transaction:cancelled";
      
      public static const STATE_NOTALLOWED:String = "transaction:notallowed";
       
      
      public var productId:String = "";
      
      public var quantity:int = 1;
      
      public var transactionDate:Date;
      
      public var cancelDate:Date;
      
      public var transactionId:String = "";
      
      public var transactionState:String = "transaction:unknown";
      
      public var transactionReceipt:String = "";
      
      public var originalPurchase:Purchase = null;
      
      public var developerPayload:String = "";
      
      public var applicationUsername:String = "";
      
      public var profileId:String = "";
      
      public var signature:String = "";
      
      public var originalMessage:String = "";
      
      public var error:String = "";
      
      public var errorCode:String = "";
      
      public var userData:UserData;
      
      public var isAutoRenewing:Boolean;
      
      public function Purchase(param1:String = "", param2:int = 1)
      {
         super();
         this.productId = param1;
         this.quantity = param2;
         this.transactionDate = new Date(0);
      }
      
      public static function fromObject(param1:Object) : Purchase
      {
         if(param1 == null || param1 is String)
         {
            return null;
         }
         var _loc2_:Purchase = new Purchase();
         try
         {
            if(param1.hasOwnProperty("productId"))
            {
               _loc2_.productId = param1.productId;
            }
            if(param1.hasOwnProperty("quantity"))
            {
               _loc2_.quantity = param1.quantity;
            }
            if(param1.hasOwnProperty("transactionDate"))
            {
               _loc2_.transactionDate = new Date(param1.transactionDate);
            }
            if(param1.hasOwnProperty("transactionTimestamp"))
            {
               _loc2_.transactionDate = new Date(param1.transactionTimestamp);
            }
            if(param1.hasOwnProperty("transactionIdentifier"))
            {
               _loc2_.transactionId = param1.transactionIdentifier;
            }
            if(param1.hasOwnProperty("transactionState"))
            {
               _loc2_.transactionState = param1.transactionState;
            }
            if(param1.hasOwnProperty("transactionReceipt"))
            {
               _loc2_.transactionReceipt = param1.transactionReceipt;
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
            if(param1.hasOwnProperty("signature"))
            {
               _loc2_.signature = param1.signature;
            }
            if(param1.hasOwnProperty("error"))
            {
               _loc2_.error = param1.error;
            }
            if(param1.hasOwnProperty("errorCode"))
            {
               _loc2_.errorCode = param1.errorCode;
            }
            if(param1.hasOwnProperty("cancelTimestamp"))
            {
               _loc2_.cancelDate = new Date(param1.cancelTimestamp);
            }
            if(param1.hasOwnProperty("originalTransaction"))
            {
               _loc2_.originalPurchase = Purchase.fromObject(param1.originalTransaction);
            }
            if(param1.hasOwnProperty("originalMessage"))
            {
               _loc2_.originalMessage = decodeURIComponent(param1.originalMessage);
            }
            else
            {
               _loc2_.originalMessage = JSON.stringify(param1);
            }
            if(param1.hasOwnProperty("userData"))
            {
               _loc2_.userData = UserData.fromObject(param1.userData);
            }
            if(param1.hasOwnProperty("isAutoRenewing"))
            {
               _loc2_.isAutoRenewing = param1.isAutoRenewing;
            }
         }
         catch(e:Error)
         {
         }
         return _loc2_;
      }
      
      public function get transactionTimestamp() : Number
      {
         return transactionDate.time;
      }
      
      public function get cancelTimestamp() : Number
      {
         return cancelDate == null ? -1 : cancelDate.time;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "{\n";
         _loc1_ += "  productId: " + (productId == null ? "null" : productId) + ",\n";
         _loc1_ += "  transactionState: " + (transactionState == null ? "null" : transactionState) + ",\n";
         _loc1_ += "  transactionId: " + (transactionId == null ? "null" : transactionId) + ",\n";
         _loc1_ += "  transactionDate: " + (transactionDate == null ? "null" : transactionDate.toString()) + ",\n";
         _loc1_ += "  applicationUsername: " + (applicationUsername == null ? "" : applicationUsername) + ",\n";
         _loc1_ += "  developerPayload: " + (developerPayload == null ? "" : developerPayload) + ",\n";
         _loc1_ += "  error: " + (error == null ? "" : error) + ",\n";
         _loc1_ += "  errorCode: " + errorCode + ",\n";
         if(userData != null)
         {
            _loc1_ += "  userData.userId: " + (userData.userId == null ? "" : userData.userId) + ",\n";
         }
         return _loc1_ + "}";
      }
   }
}
