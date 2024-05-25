package com.distriqt.extension.inappbilling
{
   import com.distriqt.extension.inappbilling.promotions.Promotions;
   import com.distriqt.extension.inappbilling.purchases.Downloads;
   import com.distriqt.extension.inappbilling.updates.InAppUpdates;
   import flash.events.EventDispatcher;
   
   [Event(name="inappbilling:setup:success",type="com.distriqt.extension.inappbilling.events.InAppBillingEvent")]
   [Event(name="inappbilling:setup:failure",type="com.distriqt.extension.inappbilling.events.InAppBillingEvent")]
   [Event(name="inappbilling:products:loaded",type="com.distriqt.extension.inappbilling.events.InAppBillingEvent")]
   [Event(name="inappbilling:products:failed",type="com.distriqt.extension.inappbilling.events.InAppBillingEvent")]
   [Event(name="inappbilling:product:invalid",type="com.distriqt.extension.inappbilling.events.InAppBillingEvent")]
   [Event(name="inappbilling:restore:purchases:success",type="com.distriqt.extension.inappbilling.events.InAppBillingEvent")]
   [Event(name="inappbilling:restore:purchases:failed",type="com.distriqt.extension.inappbilling.events.InAppBillingEvent")]
   [Event(name="inappbilling:consume:success",type="com.distriqt.extension.inappbilling.events.InAppBillingEvent")]
   [Event(name="inappbilling:consume:failed",type="com.distriqt.extension.inappbilling.events.InAppBillingEvent")]
   [Event(name="purchases:updated",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="purchase:failed",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="purchase:success",deprecatedReplacement="com.distriqt.extension.inappbilling.events.PurchaseEvent.PURCHASES_UPDATED",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="purchase:cancelled",deprecatedReplacement="com.distriqt.extension.inappbilling.events.PurchaseEvent.PURCHASES_UPDATED",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="purchase:removed",deprecatedReplacement="com.distriqt.extension.inappbilling.events.PurchaseEvent.PURCHASES_UPDATED",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="purchase:notallowed",deprecatedReplacement="com.distriqt.extension.inappbilling.events.PurchaseEvent.PURCHASES_UPDATED",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="purchase:deferred",deprecatedReplacement="com.distriqt.extension.inappbilling.events.PurchaseEvent.PURCHASES_UPDATED",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="purchase:purchasing",deprecatedReplacement="com.distriqt.extension.inappbilling.events.PurchaseEvent.PURCHASES_UPDATED",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="purchase:restored",deprecatedReplacement="com.distriqt.extension.inappbilling.events.PurchaseEvent.PURCHASES_UPDATED",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="get:purchases:complete",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="get:purchases:failed",type="com.distriqt.extension.inappbilling.events.PurchaseEvent")]
   [Event(name="productview:loaded",type="com.distriqt.extension.inappbilling.events.ProductViewEvent")]
   [Event(name="productview:failed",type="com.distriqt.extension.inappbilling.events.ProductViewEvent")]
   [Event(name="productview:displayed",type="com.distriqt.extension.inappbilling.events.ProductViewEvent")]
   [Event(name="productview:dismissed",type="com.distriqt.extension.inappbilling.events.ProductViewEvent")]
   [Event(name="should:add:purchase",type="com.distriqt.extension.inappbilling.events.PurchaseRequestEvent")]
   [Event(name="userdata:get:success",type="com.distriqt.extension.inappbilling.events.UserDataEvent")]
   [Event(name="userdata:get:failed",type="com.distriqt.extension.inappbilling.events.UserDataEvent")]
   public class InAppBilling extends EventDispatcher
   {
      
      public static const EXT_CONTEXT_ID:String = "com.distriqt.InAppBilling";
      
      private static const EXT_ID_NUMBER:int = 15;
      
      public static const VERSION:String = "14.4.1";
      
      private static const VERSION_DEFAULT:String = "0";
      
      private static const IMPLEMENTATION_DEFAULT:String = "unknown";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The extension has already been created. Use [ExtensionClass].service to access the functionality of the class";
      
      private static var _instance:InAppBilling;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      protected var _extensionId:String = "";
      
      protected var _extensionIdNumber:int = -1;
      
      private var _applicationReceipt:ApplicationReceipt;
      
      private var _downloads:Downloads;
      
      private var _promotions:Promotions = null;
      
      private var _inAppUpdates:InAppUpdates = null;
      
      public function InAppBilling()
      {
         super();
         if(_shouldCreateInstance)
         {
            _extensionId = "com.distriqt.InAppBilling";
            _extensionIdNumber = 15;
            return;
         }
         throw new Error("The extension has already been created. Use [ExtensionClass].service to access the functionality of the class");
      }
      
      public static function get service() : InAppBilling
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new InAppBilling();
            _shouldCreateInstance = false;
         }
      }
      
      [Deprecated(message="You no longer need to use an application key")]
      public static function init(param1:String = "") : void
      {
         createInstance();
      }
      
      public static function get isSupported() : Boolean
      {
         return false;
      }
      
      public function get version() : String
      {
         return "14.4.1";
      }
      
      public function get nativeVersion() : String
      {
         return "0";
      }
      
      public function get implementation() : String
      {
         return "default";
      }
      
      public function dispose() : void
      {
         if(_applicationReceipt != null)
         {
            _ApplicationReceiptImpl(_applicationReceipt).dispose();
            _applicationReceipt = null;
         }
         if(_downloads != null)
         {
            _DownloadsImpl(_downloads).dispose();
            _downloads = null;
         }
         if(_promotions != null)
         {
            _PromotionsImpl(_promotions).dispose();
            _promotions = null;
         }
         _instance = null;
      }
      
      public function get canMakePayments() : Boolean
      {
         return false;
      }
      
      [Deprecated(message="You should pass the service type to the setup function in your BillingService")]
      public function setServiceType(param1:String) : String
      {
         return "";
      }
      
      public function setup(param1:* = "") : Boolean
      {
         return false;
      }
      
      public function isServiceSupported(param1:String) : Boolean
      {
         return false;
      }
      
      public function cleanup() : void
      {
      }
      
      public function getProducts(param1:Array, param2:Array = null, param3:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function get activeProducts() : Array
      {
         return [];
      }
      
      public function get activeProductIds() : Array
      {
         return [];
      }
      
      public function get isProductViewSupported() : Boolean
      {
         return false;
      }
      
      public function showProductView(param1:String) : Boolean
      {
         return false;
      }
      
      public function get applicationReceipt() : ApplicationReceipt
      {
         if(_applicationReceipt == null)
         {
            _applicationReceipt = new _ApplicationReceiptImpl();
         }
         return _applicationReceipt;
      }
      
      public function makePurchase(param1:PurchaseRequest) : Boolean
      {
         return false;
      }
      
      public function get isChangePurchaseSupported() : Boolean
      {
         return false;
      }
      
      public function changePurchase(param1:PurchaseChangeRequest) : Boolean
      {
         return false;
      }
      
      public function finishPurchase(param1:Purchase) : Boolean
      {
         return false;
      }
      
      public function consumePurchase(param1:Purchase) : Boolean
      {
         return false;
      }
      
      public function consumePurchaseByProductId(param1:String) : Boolean
      {
         return consumePurchase(new Purchase(param1));
      }
      
      public function shouldAddPurchase(param1:PurchaseRequest, param2:Boolean) : Boolean
      {
         return false;
      }
      
      public function checkPurchaseRequestValid(param1:PurchaseRequest) : Boolean
      {
         return false;
      }
      
      public function get isGetPurchasesSupported() : Boolean
      {
         return false;
      }
      
      public function getPurchases(param1:Boolean = true) : Boolean
      {
         return false;
      }
      
      public function restorePurchases(param1:String = "") : void
      {
      }
      
      public function getPendingPurchases() : Array
      {
         return [];
      }
      
      public function get downloads() : Downloads
      {
         if(_downloads == null)
         {
            _downloads = new _DownloadsImpl();
         }
         return _downloads;
      }
      
      public function get promotions() : Promotions
      {
         if(_promotions == null)
         {
            _promotions = new _PromotionsImpl();
         }
         return _promotions;
      }
      
      public function get inAppUpdates() : InAppUpdates
      {
         if(_inAppUpdates == null)
         {
            _inAppUpdates = new _InAppUpdatesImpl();
         }
         return _inAppUpdates;
      }
   }
}
