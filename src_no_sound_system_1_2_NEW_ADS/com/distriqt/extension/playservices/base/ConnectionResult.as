package com.distriqt.extension.playservices.base
{
   public class ConnectionResult
   {
      
      public static const SUCCESS:int = 0;
      
      public static const SERVICE_MISSING:int = 1;
      
      public static const SERVICE_VERSION_UPDATE_REQUIRED:int = 2;
      
      public static const SERVICE_DISABLED:int = 3;
      
      public static const SERVICE_INVALID:int = 9;
      
      public static const SERVICE_UPDATING:int = 18;
       
      
      public function ConnectionResult()
      {
         super();
      }
   }
}
