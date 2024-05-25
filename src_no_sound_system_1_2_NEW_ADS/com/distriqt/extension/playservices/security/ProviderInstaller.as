package com.distriqt.extension.playservices.security
{
   public class ProviderInstaller
   {
      
      private static const TAG:String = "ProviderInstaller";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The singleton has already been created. Use ProviderInstaller.instance to access the functionality";
      
      private static var _instance:ProviderInstaller;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      public function ProviderInstaller()
      {
         super();
         if(!_shouldCreateInstance)
         {
            throw new Error("The singleton has already been created. Use ProviderInstaller.instance to access the functionality");
         }
      }
      
      public static function get instance() : ProviderInstaller
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new ProviderInstaller();
            _shouldCreateInstance = false;
         }
      }
      
      public function installIfNeeded() : void
      {
      }
   }
}
