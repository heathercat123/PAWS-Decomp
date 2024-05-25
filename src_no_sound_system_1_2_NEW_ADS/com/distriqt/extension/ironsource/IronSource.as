package com.distriqt.extension.ironsource
{
   import flash.events.EventDispatcher;
   import flash.utils.setTimeout;
   
   public final class IronSource extends EventDispatcher
   {
      
      public static const EXT_CONTEXT_ID:String = "com.distriqt.IronSource";
      
      private static const EXT_ID_NUMBER:int = -1;
      
      public static const VERSION:String = "3.7.4";
      
      private static const VERSION_DEFAULT:String = "0";
      
      private static const IMPLEMENTATION_DEFAULT:String = "unknown";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The extension has already been created. Use ExtensionClass.service to access the functionality of the class";
      
      public static const BANNER:String = "banner";
      
      public static const REWARDED_VIDEO:String = "rewardedvideo";
      
      public static const INTERSTITIAL:String = "interstitial";
      
      public static const OFFERWALL:String = "offerwall";
      
      private static var _instance:IronSource;
      
      private static var _shouldCreateInstance:Boolean = false;
      
      public static const POSITION_TOP:int = 1;
      
      public static const POSITION_BOTTOM:int = 2;
       
      
      protected var _extensionId:String = "";
      
      protected var _extensionIdNumber:int = -1;
      
      private var _requestAuthorisationCallbacks:Array;
      
      public function IronSource()
      {
         _requestAuthorisationCallbacks = [];
         super();
         if(_shouldCreateInstance)
         {
            _extensionId = "com.distriqt.IronSource";
            _extensionIdNumber = -1;
            return;
         }
         throw new Error("The extension has already been created. Use ExtensionClass.service to access the functionality of the class");
      }
      
      public static function get instance() : IronSource
      {
         return service;
      }
      
      public static function get service() : IronSource
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new IronSource();
            _shouldCreateInstance = false;
         }
      }
      
      public static function get isSupported() : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
         _instance = null;
      }
      
      public function get version() : String
      {
         return "3.7.4";
      }
      
      public function get nativeVersion() : String
      {
         return "0";
      }
      
      public function get implementation() : String
      {
         return "default";
      }
      
      public function setConsent(param1:Boolean) : void
      {
      }
      
      public function setMetaData(param1:String, param2:String) : void
      {
      }
      
      public function init(param1:String, param2:Array = null) : void
      {
      }
      
      public function onResume() : void
      {
      }
      
      public function onPause() : void
      {
      }
      
      public function setUserId(param1:String) : Boolean
      {
         return false;
      }
      
      public function setDynamicUserId(param1:String) : Boolean
      {
         return false;
      }
      
      public function validateIntegration() : void
      {
      }
      
      public function getAdvertiserId() : String
      {
         return "";
      }
      
      public function registerAppForAdNetworkAttribution() : void
      {
      }
      
      public function authorisationStatus() : String
      {
         return "not_determined";
      }
      
      public function requestAuthorisation(param1:Function = null) : Boolean
      {
         var callback:Function = param1;
         if(callback != null)
         {
            setTimeout(function():void
            {
               callback(authorisationStatus());
            },20);
         }
         return false;
      }
      
      public function loadBanner(param1:IronSourceBannerSize, param2:int, param3:String = "") : void
      {
      }
      
      public function hideBanner() : void
      {
      }
      
      public function displayBanner() : void
      {
      }
      
      public function destroyBanner() : void
      {
      }
      
      public function isRewardedVideoAvailable() : Boolean
      {
         return false;
      }
      
      public function isRewardedVideoCappedForPlacement(param1:String) : Boolean
      {
         return false;
      }
      
      public function showRewardedVideo(param1:String = null) : void
      {
      }
      
      public function isInterstitialReady() : Boolean
      {
         return false;
      }
      
      public function loadInterstitial() : void
      {
      }
      
      public function showInterstitial(param1:String = null) : void
      {
      }
      
      public function isOfferwallAvailable() : Boolean
      {
         return false;
      }
      
      public function showOfferwall(param1:String = null) : void
      {
      }
      
      public function getOfferwallCredits() : void
      {
      }
      
      public function setIronSourceClientSideCallbacks(param1:Boolean) : void
      {
      }
      
      public function setIronSourceOfferwallCustomParams(param1:String) : void
      {
      }
      
      public function setAdaptersDebug(param1:Boolean) : void
      {
      }
   }
}
