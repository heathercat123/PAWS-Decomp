package com.distriqt.extension.androidx.vectordrawable
{
   import flash.events.EventDispatcher;
   
   public final class VectorDrawable extends EventDispatcher
   {
      
      public static const EXT_CONTEXT_ID:String = "androidx.vectordrawable";
      
      private static const EXT_ID_NUMBER:int = -1;
      
      public static const VERSION:String = "1.1.1";
      
      private static const VERSION_DEFAULT:String = "0";
      
      private static const IMPLEMENTATION_DEFAULT:String = "unknown";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The extension has already been created. Use ExtensionClass.service to access the functionality of the class";
      
      private static var _instance:VectorDrawable;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      protected var _extensionId:String = "";
      
      protected var _extensionIdNumber:int = -1;
      
      public function VectorDrawable()
      {
         super();
         if(_shouldCreateInstance)
         {
            _extensionId = "androidx.vectordrawable";
            _extensionIdNumber = -1;
            return;
         }
         throw new Error("The extension has already been created. Use ExtensionClass.service to access the functionality of the class");
      }
      
      public static function get instance() : VectorDrawable
      {
         createInstance();
         return _instance;
      }
      
      public static function get service() : VectorDrawable
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new VectorDrawable();
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
         return "1.1.1";
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
