package com.distriqt.extension.playservices.ads
{
   import flash.events.EventDispatcher;
   
   public final class PlayServicesAds extends EventDispatcher
   {
      
      public static const EXT_CONTEXT_ID:String = "com.distriqt.playservices.Ads";
      
      public static const VERSION:String = "21.0.0";
      
      public static const VERSION_DEFAULT:String = "0";
      
      public static const IMPLEMENTATION_DEFAULT:String = "unknown";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The singleton has already been created. Use PlayServicesAds.service to access the functionality";
      
      private static var _instance:PlayServicesAds;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      public function PlayServicesAds()
      {
         super();
         if(_shouldCreateInstance)
         {
            try
            {
            }
            catch(e:Error)
            {
               throw new Error("The native extension context could not be created");
            }
            return;
         }
         throw new Error("The singleton has already been created. Use PlayServicesAds.service to access the functionality");
      }
      
      public static function get service() : PlayServicesAds
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new PlayServicesAds();
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
      
      public function dispose() : void
      {
         _instance = null;
      }
      
      public function get version() : String
      {
         return "21.0.0";
      }
      
      public function get nativeVersion() : String
      {
         return "0";
      }
      
      public function get implementation() : String
      {
         return "default";
      }
   }
}
