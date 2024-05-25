package com.distriqt.extension.adverts.rewarded
{
   public class ServerSideVerificationOptions
   {
      
      private static const TAG:String = "ServerSideVerificationOptions";
       
      
      public var customData:String = "";
      
      public var userId:String = "";
      
      public function ServerSideVerificationOptions()
      {
         super();
      }
      
      public function setCustomData(param1:String) : ServerSideVerificationOptions
      {
         this.customData = param1;
         return this;
      }
      
      public function setUserId(param1:String) : ServerSideVerificationOptions
      {
         this.userId = param1;
         return this;
      }
   }
}
