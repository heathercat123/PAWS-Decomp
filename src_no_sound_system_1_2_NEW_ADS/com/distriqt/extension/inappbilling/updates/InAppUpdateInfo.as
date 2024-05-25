package com.distriqt.extension.inappbilling.updates
{
   public class InAppUpdateInfo
   {
      
      private static const TAG:String = "InAppUpdateInfo";
       
      
      public var packageName:String = "";
      
      public var versionName:String = "";
      
      public var versionCode:int = 0;
      
      public var totalBytes:Number = 0;
      
      public function InAppUpdateInfo()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : InAppUpdateInfo
      {
         var _loc2_:InAppUpdateInfo = new InAppUpdateInfo();
         if(param1.hasOwnProperty("packageName"))
         {
            _loc2_.packageName = param1.packageName;
         }
         if(param1.hasOwnProperty("versionName"))
         {
            _loc2_.versionName = param1.versionName;
         }
         if(param1.hasOwnProperty("versionCode"))
         {
            _loc2_.versionCode = param1.versionCode;
         }
         if(param1.hasOwnProperty("totalBytes"))
         {
            _loc2_.totalBytes = param1.totalBytes;
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         return "UpdateInfo[ " + packageName + "/" + versionName + "(" + versionCode + ") size:" + totalBytes + "]";
      }
   }
}
