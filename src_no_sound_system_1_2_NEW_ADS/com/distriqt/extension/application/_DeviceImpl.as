package com.distriqt.extension.application
{
   import flash.events.EventDispatcher;
   import flash.filesystem.File;
   
   internal class _DeviceImpl extends EventDispatcher implements Device
   {
       
      
      private var _name:String;
      
      private var _brand:String;
      
      private var _manufacturer:String;
      
      private var _device:String;
      
      private var _model:String;
      
      private var _product:String;
      
      private var _yearClass:int = -2147483648;
      
      private var _phone:String;
      
      private var _displayMetrics:_DisplayMetricsImpl = null;
      
      public function _DeviceImpl()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function uniqueId(param1:String = "vendor", param2:Boolean = false) : String
      {
         return "";
      }
      
      public function get name() : String
      {
         if(_name == null)
         {
            update();
         }
         return _name;
      }
      
      public function get brand() : String
      {
         if(_brand == null)
         {
            update();
         }
         return _brand;
      }
      
      public function get manufacturer() : String
      {
         if(_manufacturer == null)
         {
            update();
         }
         return _manufacturer;
      }
      
      public function get device() : String
      {
         if(_device == null)
         {
            update();
         }
         return _device;
      }
      
      public function get model() : String
      {
         if(_model == null)
         {
            update();
         }
         return _model;
      }
      
      public function get product() : String
      {
         if(_product == null)
         {
            update();
         }
         return _product;
      }
      
      public function get yearClass() : int
      {
         if(_yearClass == -2147483648)
         {
            update();
         }
         return _yearClass;
      }
      
      public function get phone() : String
      {
         if(_phone == null)
         {
            update();
         }
         return _phone;
      }
      
      public function get os() : OperatingSystem
      {
         return new OperatingSystem();
      }
      
      public function getFilesDir() : String
      {
         return File.applicationStorageDirectory.nativePath;
      }
      
      public function getExternalFilesDir() : String
      {
         return File.applicationStorageDirectory.nativePath;
      }
      
      public function get displayMetrics() : DisplayMetrics
      {
         try
         {
            if(_displayMetrics == null)
            {
               _displayMetrics = new _DisplayMetricsImpl(null);
            }
         }
         catch(e:Error)
         {
         }
         return _displayMetrics;
      }
      
      public function isDeviceIdleMode() : Boolean
      {
         return false;
      }
      
      public function isPowerSaveMode() : Boolean
      {
         return false;
      }
      
      public function isAutoTimeEnabled() : Boolean
      {
         return false;
      }
      
      public function isAutoTimeZoneEnabled() : Boolean
      {
         return false;
      }
      
      public function get deviceOrientation() : String
      {
         return "unknown";
      }
      
      public function startGeneratingDeviceOrientationEvents() : Boolean
      {
         return false;
      }
      
      public function stopGeneratingDeviceOrientationEvents() : Boolean
      {
         return false;
      }
      
      public function get locale() : Locale
      {
         return new Locale();
      }
      
      public function get localTimeZone(): Number
      {
         return null;
      }
      
      private function update(param1:Object = null) : void
      {
         if(param1 == null)
         {
            param1 = {
               "name":"",
               "brand":"unknown",
               "manufacturer":"unknown",
               "device":"unknown",
               "model":"unknown",
               "product":"unknown",
               "yearClass":-1,
               "phone":""
            };
         }
         if(param1 != null)
         {
            if(param1.hasOwnProperty("name"))
            {
               this._name = param1.name;
            }
            if(param1.hasOwnProperty("brand"))
            {
               this._brand = param1.brand;
            }
            if(param1.hasOwnProperty("manufacturer"))
            {
               this._manufacturer = param1.manufacturer;
            }
            if(param1.hasOwnProperty("device"))
            {
               this._device = param1.device;
            }
            if(param1.hasOwnProperty("model"))
            {
               this._model = param1.model;
            }
            if(param1.hasOwnProperty("product"))
            {
               this._product = param1.product;
            }
            if(param1.hasOwnProperty("yearClass"))
            {
               this._yearClass = param1.yearClass;
            }
            if(param1.hasOwnProperty("phone"))
            {
               this._phone = param1.phone;
            }
         }
      }
   }
}
