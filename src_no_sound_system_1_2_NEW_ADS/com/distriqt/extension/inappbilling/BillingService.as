package com.distriqt.extension.inappbilling
{
   public class BillingService
   {
      
      private static const TAG:String = "BillingService";
      
      public static const OPERATION_MODE_PRODUCTION:String = "production";
      
      public static const OPERATION_MODE_TEST:String = "test";
      
      public static const OPERATION_MODE_TEST_FAILURE:String = "test_failure";
       
      
      public var type:String = "default";
      
      public var googlePlayPublicKey:String = "";
      
      public var huaweiAppGalleryPublicKey:String = "";
      
      public var operationMode:String = "production";
      
      public function BillingService(param1:String = "")
      {
         super();
         this.type = param1 == "" ? "default" : param1;
      }
      
      public function setServiceType(param1:String) : BillingService
      {
         this.type = param1;
         return this;
      }
      
      public function setGooglePlayPublicKey(param1:String) : BillingService
      {
         this.googlePlayPublicKey = param1;
         return this;
      }
      
      public function setHuaweiIAPPublicKey(param1:String) : BillingService
      {
         this.huaweiAppGalleryPublicKey = param1;
         return this;
      }
      
      public function setOperationMode(param1:String) : BillingService
      {
         this.operationMode = param1;
         return this;
      }
   }
}
