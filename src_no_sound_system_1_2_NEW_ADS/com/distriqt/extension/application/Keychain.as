package com.distriqt.extension.application
{
   public interface Keychain
   {
       
      
      function get isSupported() : Boolean;
      
      function set(param1:String, param2:String, param3:String = null) : int;
      
      function get(param1:String, param2:String = null) : String;
      
      function remove(param1:String, param2:String = null) : int;
   }
}
