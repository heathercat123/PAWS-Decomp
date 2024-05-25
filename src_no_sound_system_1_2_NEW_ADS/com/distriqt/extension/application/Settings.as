package com.distriqt.extension.application
{
   import flash.events.IEventDispatcher;
   
   [Event(name="settings:changed",type="com.distriqt.extension.application.events.SettingsEvent")]
   public interface Settings extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function openSettingsScreen() : Boolean;
      
      function setBoolean(param1:String, param2:Boolean) : Boolean;
      
      function getBoolean(param1:String) : Boolean;
      
      function setString(param1:String, param2:String) : Boolean;
      
      function getString(param1:String) : String;
      
      function setNumber(param1:String, param2:Number) : Boolean;
      
      function getNumber(param1:String) : Number;
      
      function setInt(param1:String, param2:int) : Boolean;
      
      function getInt(param1:String) : int;
   }
}
