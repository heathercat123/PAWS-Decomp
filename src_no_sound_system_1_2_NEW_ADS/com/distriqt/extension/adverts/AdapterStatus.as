package com.distriqt.extension.adverts
{
   public class AdapterStatus
   {
      
      private static const TAG:String = "AdapterStatus";
      
      public static const READY:String = "READY";
      
      public static const NOT_READY:String = "NOT_READY";
       
      
      public var name:String = "";
      
      public var description:String = "";
      
      public var state:String = "NOT_READY";
      
      public var latency:int = -1;
      
      public function AdapterStatus()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : AdapterStatus
      {
         var _loc2_:AdapterStatus = new AdapterStatus();
         if(param1.hasOwnProperty("name"))
         {
            _loc2_.name = param1.name;
         }
         if(param1.hasOwnProperty("description"))
         {
            _loc2_.description = param1.description;
         }
         if(param1.hasOwnProperty("latency"))
         {
            _loc2_.latency = param1.latency;
         }
         if(param1.hasOwnProperty("state"))
         {
            _loc2_.state = param1.state;
         }
         return _loc2_;
      }
   }
}
