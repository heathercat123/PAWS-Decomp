package com.distriqt.extension.core
{
   import flash.events.EventDispatcher;
   
   public final class Core extends EventDispatcher
   {
      
      public static const EXT_CONTEXT_ID:String = "com.distriqt.Core";
      
      public static const VERSION:String = "7.2.0";
      
      private static const VERSION_DEFAULT:String = "0";
      
      private static const IMPLEMENTATION_DEFAULT:String = "unknown";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The extension has already been created. Use ExtensionClass.service to access the functionality of the class";
      
      private static var _instance:Core;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      private var _extensionId:String = "";
      
      public function Core()
      {
         super();
         if(_shouldCreateInstance)
         {
            _extensionId = "com.distriqt.Core";
            return;
         }
         throw new Error("The extension has already been created. Use ExtensionClass.service to access the functionality of the class");
      }
      
      public static function get service() : Core
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new Core();
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
      
      public function dispose() : void
      {
         _instance = null;
      }
      
      public function get version() : String
      {
         return "7.2.0";
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
