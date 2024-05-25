package com.distriqt.extension.adverts.events
{
   import flash.events.Event;
   
   public class ConsentEvent extends Event
   {
      
      private static const TAG:String = "ConsentEvent";
      
      public static const STATUS_UPDATED:String = "consent:status:updated";
      
      public static const STATUS_ERROR:String = "consent:status:error";
      
      public static const FORM_CLOSED:String = "consent:form:closed";
      
      public static const FORM_ERROR:String = "consent:form:error";
       
      
      public var status:String = "unknown";
      
      public var inEeaOrUnknown:Boolean = false;
      
      public var userPrefersAdFree:Boolean = false;
      
      public var error:String = "";
      
      public function ConsentEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:ConsentEvent = new ConsentEvent(type,bubbles,cancelable);
         _loc1_.status = this.status;
         _loc1_.inEeaOrUnknown = this.inEeaOrUnknown;
         _loc1_.userPrefersAdFree = this.userPrefersAdFree;
         _loc1_.error = this.error;
         return _loc1_;
      }
   }
}
