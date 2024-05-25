package com.distriqt.extension.application
{
   public class OperatingSystem
   {
       
      
      public var name:String = "";
      
      public var type:String = "";
      
      public var version:String = "";
      
      public var api_level:int = 0;
      
      public function OperatingSystem(param1:Object = null)
      {
         super();
         if(param1)
         {
            if(param1.hasOwnProperty("name"))
            {
               this.name = param1.name;
            }
            if(param1.hasOwnProperty("type"))
            {
               this.type = param1.type;
            }
            if(param1.hasOwnProperty("version"))
            {
               this.version = param1.version;
            }
            if(param1.hasOwnProperty("api_level"))
            {
               this.api_level = param1.api_level;
            }
         }
      }
   }
}
