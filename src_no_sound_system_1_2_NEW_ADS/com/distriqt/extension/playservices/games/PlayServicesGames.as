package com.distriqt.extension.playservices.games
{
   import flash.events.EventDispatcher;
   
   public final class PlayServicesGames extends EventDispatcher
   {
      
      public static const EXT_CONTEXT_ID:String = "com.distriqt.playservices.Games";
      
      public static const VERSION:String = "22.0.101";
      
      public static const VERSION_DEFAULT:String = "0";
      
      public static const IMPLEMENTATION_DEFAULT:String = "unknown";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The singleton has already been created. Use PlayServicesGames.service to access the functionality";
      
      private static var _instance:PlayServicesGames;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      public function PlayServicesGames()
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
         throw new Error("The singleton has already been created. Use PlayServicesGames.service to access the functionality");
      }
      
      public static function get service() : PlayServicesGames
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new PlayServicesGames();
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
         return "22.0.101";
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
