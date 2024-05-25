package com.distriqt.extension.inappbilling.events
{
   import flash.events.Event;
   
   public class ProductViewEvent extends Event
   {
      
      public static const LOADED:String = "productview:loaded";
      
      public static const FAILED:String = "productview:failed";
      
      public static const DISPLAYED:String = "productview:displayed";
      
      public static const DISMISSED:String = "productview:dismissed";
       
      
      public var error:String = "";
      
      public var errorCode:String = "";
      
      public function ProductViewEvent(param1:String, param2:String = "", param3:String = "", param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.error = param2;
         this.errorCode = param3;
      }
      
      override public function clone() : Event
      {
         return new ProductViewEvent(type,error,errorCode,bubbles,cancelable);
      }
   }
}
