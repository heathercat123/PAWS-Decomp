package com.distriqt.extension.application
{
   import flash.events.EventDispatcher;
   
   internal class _SettingsImpl extends EventDispatcher implements Settings
   {
      
      private static const TAG:String = "_SettingsImpl";
       
      
      public function _SettingsImpl()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function openSettingsScreen() : Boolean
      {
         return false;
      }
      
      public function setBoolean(param1:String, param2:Boolean) : Boolean
      {
         return false;
      }
      
      public function getBoolean(param1:String) : Boolean
      {
         return false;
      }
      
      public function setString(param1:String, param2:String) : Boolean
      {
         return false;
      }
      
      public function getString(param1:String) : String
      {
         return "";
      }
      
      public function setNumber(param1:String, param2:Number) : Boolean
      {
         return false;
      }
      
      public function getNumber(param1:String) : Number
      {
         return 0;
      }
      
      public function setInt(param1:String, param2:int) : Boolean
      {
         return false;
      }
      
      public function getInt(param1:String) : int
      {
         return 0;
      }
   }
}
