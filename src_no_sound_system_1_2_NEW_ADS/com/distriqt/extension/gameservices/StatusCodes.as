package com.distriqt.extension.gameservices
{
   public class StatusCodes
   {
      
      private static const TAG:String = "SignInStatusCodes";
      
      public static const SIGN_IN_REQUIRED:int = 4;
      
      public static const NETWORK_ERROR:int = 7;
      
      public static const INVALID_ACCOUNT:int = 5;
      
      public static const INTERNAL_ERROR:int = 8;
      
      public static const DEVELOPER_ERROR:int = 10;
      
      public static const INTERRUPTED:int = 14;
      
      public static const TIMEOUT:int = 15;
      
      public static const CANCELED:int = 16;
      
      public static const SIGN_IN_CANCELLED:int = 12501;
      
      public static const SIGN_IN_CURRENTLY_IN_PROGRESS:int = 12502;
      
      public static const SIGN_IN_FAILED:int = 12500;
       
      
      public function StatusCodes()
      {
         super();
      }
   }
}
