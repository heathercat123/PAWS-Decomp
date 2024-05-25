package com.distriqt.extension.playservices.base
{
   import flash.events.EventDispatcher;
   
   public class GoogleApiAvailability extends EventDispatcher
   {
      
      private static const TAG:String = "GoogleApiAvailability";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The singleton has already been created. Use GoogleApiAvailability.instance to access the functionality";
      
      private static var _instance:GoogleApiAvailability;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      public function GoogleApiAvailability()
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
         throw new Error("The singleton has already been created. Use GoogleApiAvailability.instance to access the functionality");
      }
      
      public static function get instance() : GoogleApiAvailability
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new GoogleApiAvailability();
            _shouldCreateInstance = false;
         }
      }
      
      public function getInstalledGooglePlayServicesVersion() : Number
      {
         return 0;
      }
      
      public function isGooglePlayServicesAvailable() : int
      {
         return -1;
      }
      
      public function isUserRecoverableError(param1:int) : Boolean
      {
         return false;
      }
      
      public function showErrorDialog(param1:int) : void
      {
      }
      
      public function showErrorNotification(param1:int) : void
      {
      }
      
      public function getErrorString(param1:int) : String
      {
         return "Unknown";
      }
      
      public function attemptResolution(param1:int) : void
      {
      }
   }
}
