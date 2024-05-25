package com.distriqt.extension.application
{
   import com.distriqt.extension.application.events.DefaultsEvent;
   import flash.events.EventDispatcher;
   import flash.net.SharedObject;
   import flash.utils.setTimeout;
   
   internal class _DefaultsImpl extends EventDispatcher implements Defaults
   {
      
      public static const PREFS_NAME:String = "dt_application_defaults";
       
      
      private var _preferences:SharedObject;
      
      public function _DefaultsImpl()
      {
         super();
         _preferences = SharedObject.getLocal("dt_application_defaults");
      }
      
      public function dispose() : void
      {
      }
      
      public function save() : Boolean
      {
         _preferences.flush();
         return true;
      }
      
      public function remove(param1:String) : void
      {
         try
         {
            delete _preferences.data[param1];
            _preferences.flush();
         }
         catch(e:Error)
         {
         }
      }
      
      public function setBoolean(param1:String, param2:Boolean) : Boolean
      {
         var key:String = param1;
         var value:Boolean = param2;
         try
         {
            _preferences.data[key] = value;
            _preferences.flush();
            setTimeout(function():void
            {
               dispatchEvent(new DefaultsEvent("defaults:changed",key));
            },50);
            return true;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function getBoolean(param1:String) : Boolean
      {
         if(_preferences.data.hasOwnProperty(param1))
         {
            return Boolean(_preferences.data[param1]);
         }
         return false;
      }
      
      public function setString(param1:String, param2:String) : Boolean
      {
         var key:String = param1;
         var value:String = param2;
         try
         {
            _preferences.data[key] = value;
            _preferences.flush();
            setTimeout(function():void
            {
               dispatchEvent(new DefaultsEvent("defaults:changed",key));
            },50);
            return true;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function getString(param1:String) : String
      {
         if(_preferences.data.hasOwnProperty(param1))
         {
            return String(_preferences.data[param1]);
         }
         return null;
      }
      
      public function setNumber(param1:String, param2:Number) : Boolean
      {
         var key:String = param1;
         var value:Number = param2;
         try
         {
            _preferences.data[key] = value;
            _preferences.flush();
            setTimeout(function():void
            {
               dispatchEvent(new DefaultsEvent("defaults:changed",key));
            },50);
            return true;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function getNumber(param1:String) : Number
      {
         if(_preferences.data.hasOwnProperty(param1))
         {
            return Number(_preferences.data[param1]);
         }
         return null;
      }
      
      public function setInt(param1:String, param2:int) : Boolean
      {
         var key:String = param1;
         var value:int = param2;
         try
         {
            _preferences.data[key] = value;
            _preferences.flush();
            setTimeout(function():void
            {
               dispatchEvent(new DefaultsEvent("defaults:changed",key));
            },50);
            return true;
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function getInt(param1:String) : int
      {
         if(_preferences.data.hasOwnProperty(param1))
         {
            return int(_preferences.data[param1]);
         }
         return null;
      }
      
      public function setObject(param1:String, param2:Object) : Boolean
      {
         var _loc3_:String = null;
         try
         {
            _loc3_ = JSON.stringify(param2);
            return setString(param1,_loc3_);
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function getObject(param1:String) : Object
      {
         var _loc2_:String = null;
         try
         {
            if(_preferences.data.hasOwnProperty(param1))
            {
               _loc2_ = getString(param1);
               return JSON.parse(_loc2_);
            }
         }
         catch(e:Error)
         {
         }
         return null;
      }
   }
}
