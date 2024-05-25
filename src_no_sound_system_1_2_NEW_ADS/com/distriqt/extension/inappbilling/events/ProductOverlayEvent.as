package com.distriqt.extension.inappbilling.events
{
   import flash.events.Event;
   
   public class ProductOverlayEvent extends Event
   {
      
      public static const LOADED:String = "productoverlay:loaded";
      
      public static const FAILED:String = "productoverlay:failed";
      
      public static const DISPLAYED:String = "productoverlay:displayed";
      
      public static const DISMISSED:String = "productoverlay:dismissed";
       
      
      public var error:String = "";
      
      public var errorCode:String = "";
      
      public function ProductOverlayEvent(param1:String, param2:String = "", param3:String = "", param4:Boolean = false, param5:Boolean = false)
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
