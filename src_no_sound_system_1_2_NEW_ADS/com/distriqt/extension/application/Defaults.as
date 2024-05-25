package com.distriqt.extension.application
{
   import flash.events.IEventDispatcher;
   
   [Event(name="defaults:changed",type="com.distriqt.extension.application.events.DefaultsEvent")]
   public interface Defaults extends IEventDispatcher
   {
       
      
      function save() : Boolean;
      
      function remove(param1:String) : void;
      
      function setBoolean(param1:String, param2:Boolean) : Boolean;
      
      function getBoolean(param1:String) : Boolean;
      
      function setString(param1:String, param2:String) : Boolean;
      
      function getString(param1:String) : String;
      
      function setNumber(param1:String, param2:Number) : Boolean;
      
      function getNumber(param1:String) : Number;
      
      function setInt(param1:String, param2:int) : Boolean;
      
      function getInt(param1:String) : int;
      
      function setObject(param1:String, param2:Object) : Boolean;
      
      function getObject(param1:String) : Object;
   }
}
