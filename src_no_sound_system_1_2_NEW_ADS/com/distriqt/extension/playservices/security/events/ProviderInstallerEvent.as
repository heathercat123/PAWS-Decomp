package com.distriqt.extension.playservices.security.events
{
   import flash.events.Event;
   
   public class ProviderInstallerEvent extends Event
   {
      
      private static const TAG:String = "ProviderInstallerEvent";
      
      public static const INSTALLED:String = "providerinstaller_installed";
      
      public static const INSTALL_FAILED:String = "providerinstaller_install_failed";
       
      
      public var errorCode:int = -1;
      
      public function ProviderInstallerEvent(param1:String, param2:int = -1, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.errorCode = param2;
      }
      
      override public function clone() : Event
      {
         return new ProviderInstallerEvent(type,errorCode,bubbles,cancelable);
      }
   }
}
