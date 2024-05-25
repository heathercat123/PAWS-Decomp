package com.distriqt.extension.application
{
   import com.distriqt.extension.application.alarms.AlarmManager;
   import com.distriqt.extension.application.display.Display;
   import com.distriqt.extension.application.events.ApplicationStateEvent;
   import com.distriqt.extension.application.keyboard.SoftKeyboard;
   import flash.desktop.NativeApplication;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Application extends EventDispatcher
   {
      
      public static const EXT_CONTEXT_ID:String = "com.distriqt.Application";
      
      private static const EXT_ID_NUMBER:int = 20;
      
      public static const VERSION:String = "6.8.1";
      
      private static const VERSION_DEFAULT:String = "0";
      
      private static const IMPLEMENTATION_DEFAULT:String = "unknown";
      
      public static const ERROR_CREATION:String = "The native extension context could not be created";
      
      public static const ERROR_SINGLETON:String = "The singleton has already been created. Use [ExtensionClass].instance to access the functionality";
      
      private static var _instance:Application;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      protected var _extensionId:String = "";
      
      protected var _extensionIdNumber:int = -1;
      
      private var _stage:Stage = null;
      
      private var _device:Device;
      
      private var _defaults:Defaults;
      
      private var _keychain:Keychain;
      
      private var _settings:Settings;
      
      private var _alarmManager:AlarmManager;
      
      private var _keyboard:SoftKeyboard;
      
      private var _display:Display;
      
      private var _accessibility:Accessibility;
      
      public function Application()
      {
         super();
         if(_shouldCreateInstance)
         {
            try
            {
               _extensionId = "com.distriqt.Application";
               _extensionIdNumber = 20;
               NativeApplication.nativeApplication.addEventListener("deactivate",nativeApplication_deactivateHandler);
               NativeApplication.nativeApplication.addEventListener("activate",nativeApplication_activateHandler);
            }
            catch(e:Error)
            {
               throw new Error("The native extension context could not be created");
            }
            return;
         }
         throw new Error("The singleton has already been created. Use [ExtensionClass].instance to access the functionality");
      }
      
      public static function get service() : Application
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new Application();
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
         createInstance();
         return false;
      }
      
      public function get version() : String
      {
         return "6.8.1";
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
         NativeApplication.nativeApplication.removeEventListener("activate",nativeApplication_activateHandler);
         NativeApplication.nativeApplication.removeEventListener("deactivate",nativeApplication_deactivateHandler);
         if(_device)
         {
            _DeviceImpl(_device).dispose();
            _device = null;
         }
         if(_defaults)
         {
            _DefaultsImpl(_defaults).dispose();
            _defaults = null;
         }
         if(_keychain)
         {
            _KeychainImpl(_keychain).dispose();
            _keychain = null;
         }
         if(_settings)
         {
            _SettingsImpl(_settings).dispose();
            _settings = null;
         }
         if(_alarmManager)
         {
            _AlarmManagerImpl(_alarmManager).dispose();
            _alarmManager = null;
         }
         if(_keyboard)
         {
            _SoftKeyboardImpl(_keyboard).dispose();
            _keyboard = null;
         }
         if(_display)
         {
            _DisplayImpl(_display).dispose();
            _display = null;
         }
         _instance = null;
      }
      
      public function setStage(param1:Stage) : void
      {
         _stage = param1;
         if(_display)
         {
            _DisplayImpl(_display).setStage(_stage);
         }
         if(_keyboard)
         {
            _SoftKeyboardImpl(_keyboard).setStage(_stage);
         }
      }
      
      public function authorisationStatus() : String
      {
         return "unknown";
      }
      
      public function hasAccess() : Boolean
      {
         return false;
      }
      
      public function requestAccess() : Boolean
      {
         return false;
      }
      
      public function hasAutoStartPermission() : Boolean
      {
         return false;
      }
      
      public function requestAutoStartPermission() : Boolean
      {
         return false;
      }
      
      public function setAutoStart(param1:Boolean) : Boolean
      {
         return false;
      }
      
      public function isAutoStartEnabled() : Boolean
      {
         return false;
      }
      
      public function wasAutoStarted() : Boolean
      {
         return false;
      }
      
      [Deprecated(message="See Display.setDisplayMode")]
      public function setDisplayMode(param1:String) : void
      {
      }
      
      public function checkUrlSchemeSupport(param1:String) : Boolean
      {
         return false;
      }
      
      [Deprecated(replacement="Display#setStatusBarStyle")]
      public function setStatusBarStyle(param1:uint, param2:Boolean = false) : Boolean
      {
         return display.setStatusBarStyle(param1,param2);
      }
      
      [Deprecated(replacement="Display#setStatusBarHidden")]
      public function setStatusBarHidden(param1:Boolean = true, param2:String = "none") : Boolean
      {
         return display.setStatusBarHidden(param1,param2);
      }
      
      [Deprecated(replacement="Display#setStatusBarColour")]
      public function setStatusBarColour(param1:uint, param2:Number = 1) : Boolean
      {
         return display.setStatusBarColour(param1,param2);
      }
      
      [Deprecated(replacement="Display#getStatusBarHeight")]
      public function getStatusBarHeight() : int
      {
         return display.getStatusBarHeight();
      }
      
      public function setRequestedOrientation(param1:String) : Boolean
      {
         return false;
      }
      
      public function get device() : Device
      {
         if(_device == null)
         {
            _device = new _DeviceImpl();
         }
         return _device;
      }
      
      public function get defaults() : Defaults
      {
         if(_defaults == null)
         {
            _defaults = new _DefaultsImpl();
         }
         return _defaults;
      }
      
      public function get keychain() : Keychain
      {
         if(_keychain == null)
         {
            _keychain = new _KeychainImpl();
         }
         return _keychain;
      }
      
      public function get settings() : Settings
      {
         if(_settings == null)
         {
            _settings = new _SettingsImpl();
         }
         return _settings;
      }
      
      public function get alarmManager() : AlarmManager
      {
         if(_alarmManager == null)
         {
            _alarmManager = new _AlarmManagerImpl();
         }
         return _alarmManager;
      }
      
      public function get keyboard() : SoftKeyboard
      {
         if(_keyboard == null)
         {
            _keyboard = new _SoftKeyboardImpl(_stage);
         }
         return _keyboard;
      }
      
      public function get display() : Display
      {
         if(_display == null)
         {
            _display = new _DisplayImpl(_stage);
         }
         return _display;
      }
      
      public function blackScreenHelper() : void
      {
      }
      
      public function backButtonHelper() : void
      {
      }
      
      public function addBitmapOverlay(param1:BitmapData) : void
      {
      }
      
      public function removeBitmapOverlay() : void
      {
      }
      
      public function get accessibility() : Accessibility
      {
         if(_accessibility == null)
         {
            _accessibility = new _Accessibility();
         }
         return _accessibility;
      }
      
      private function nativeApplication_activateHandler(param1:Event) : void
      {
         dispatchEvent(new ApplicationStateEvent("applicationstate:activate",""));
         dispatchEvent(new ApplicationStateEvent("applicationstate:foreground",""));
      }
      
      private function nativeApplication_deactivateHandler(param1:Event) : void
      {
         var _loc2_:String = "deactivate:home";
         dispatchEvent(new ApplicationStateEvent("applicationstate:deactivate",_loc2_,""));
         dispatchEvent(new ApplicationStateEvent("applicationstate:background",_loc2_,""));
      }
   }
}
