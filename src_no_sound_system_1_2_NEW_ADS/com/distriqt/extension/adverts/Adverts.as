package com.distriqt.extension.adverts
{
   import com.distriqt.extension.adverts.appopen.AppOpenAds;
   import com.distriqt.extension.adverts.consent.Consent;
   import com.distriqt.extension.adverts.nativeads.NativeAds;
   import com.distriqt.extension.adverts.rewarded.RewardedVideoAds;
   import com.distriqt.extension.adverts.rewardedinterstitial.RewardedInterstitialAds;
   import com.distriqt.extension.adverts.ump.UserMessagingPlatform;
   import flash.events.EventDispatcher;
   
   public class Adverts extends EventDispatcher
   {
      
      public static const EXT_CONTEXT_ID:String = "com.distriqt.Adverts";
      
      private static const EXT_ID_NUMBER:int = 21;
      
      public static const VERSION:String = "13.7.5";
      
      private static const VERSION_DEFAULT:String = "0";
      
      private static const IMPLEMENTATION_DEFAULT:String = "unknown";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The extension has already been created. Use [ExtensionClass].service to access the functionality of the class";
      
      public static const ADVERTISING:String = "advertising";
      
      public static const VENDOR:String = "vendor";
      
      private static var _instance:Adverts;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      protected var _extensionId:String = "";
      
      protected var _extensionIdNumber:int = -1;
      
      private var _interstitials:Interstitials = null;
      
      private var _rewardedVideoAds:RewardedVideoAds = null;
      
      private var _rewardedInterstitialAds:RewardedInterstitialAds = null;
      
      private var _nativeAds:NativeAds = null;
      
      private var _appOpenAds:AppOpenAds = null;
      
      private var _consent:Consent = null;
      
      private var _ump:UserMessagingPlatform = null;
      
      public function Adverts()
      {
         super();
         if(_shouldCreateInstance)
         {
            _extensionId = "com.distriqt.Adverts";
            _extensionIdNumber = 21;
            return;
         }
         throw new Error("The extension has already been created. Use [ExtensionClass].service to access the functionality of the class");
      }
      
      public static function get service() : Adverts
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new Adverts();
            _shouldCreateInstance = false;
         }
      }
      
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
         return "13.7.5";
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
         if(_interstitials)
         {
            _InterstitialsImpl(_interstitials).dispose();
            _interstitials = null;
         }
         if(_rewardedVideoAds)
         {
            _RewardedVideoAdsImpl(_rewardedVideoAds).dispose();
            _rewardedVideoAds = null;
         }
         _instance = null;
      }
      
      public function isPlatformSupported(param1:String) : Boolean
      {
         return false;
      }
      
      [Deprecated(message="You should now use setup followed by initialise")]
      public function initialisePlatform(param1:String, param2:String = "") : void
      {
         setup(param1,param2);
         initialise();
      }
      
      public function setup(param1:String, param2:String = "") : void
      {
      }
      
      public function initialise() : void
      {
      }
      
      public function get platformVersion() : String
      {
         return "";
      }
      
      public function setAppMuted(param1:Boolean) : void
      {
      }
      
      public function setAppVolume(param1:Number) : void
      {
      }
      
      public function getAdvertisingId(param1:Function = null) : String
      {
         return "";
      }
      
      [Deprecated(replacement="getAdvertisingId()")]
      public function uniqueId(param1:String = "vendor") : String
      {
         return "";
      }
      
      public function getRequestConfiguration() : RequestConfiguration
      {
         return new RequestConfiguration();
      }
      
      public function setRequestConfiguration(param1:RequestConfiguration) : void
      {
      }
      
      public function createAdView() : AdView
      {
         return null;
      }
      
      public function get interstitials() : Interstitials
      {
         if(_interstitials == null)
         {
            _interstitials = new _InterstitialsImpl();
         }
         return _interstitials;
      }
      
      public function get rewardedVideoAds() : RewardedVideoAds
      {
         if(_rewardedVideoAds == null)
         {
            _rewardedVideoAds = new _RewardedVideoAdsImpl();
         }
         return _rewardedVideoAds;
      }
      
      public function get rewardedInterstitialAds() : RewardedInterstitialAds
      {
         if(_rewardedInterstitialAds == null)
         {
            _rewardedInterstitialAds = new _RewardedInterstitialAdsImpl();
         }
         return _rewardedInterstitialAds;
      }
      
      public function get nativeAds() : NativeAds
      {
         if(_nativeAds == null)
         {
            _nativeAds = new _NativeAds();
         }
         return _nativeAds;
      }
      
      public function get appOpenAds() : AppOpenAds
      {
         if(_appOpenAds == null)
         {
            _appOpenAds = new _AppOpenAdsImpl();
         }
         return _appOpenAds;
      }
      
      public function get consent() : Consent
      {
         if(_consent == null)
         {
            _consent = new _ConsentImpl();
         }
         return _consent;
      }
      
      public function get ump() : UserMessagingPlatform
      {
         return userMessagingPlatform;
      }
      
      public function get userMessagingPlatform() : UserMessagingPlatform
      {
         if(_ump == null)
         {
            _ump = new _UserMessagingPlatformImpl();
         }
         return _ump;
      }
   }
}
