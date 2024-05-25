package com.distriqt.extension.playservices.appset
{
   public class AppSetIdInfo
   {
      
      private static const TAG:String = "AppSetIdInfo";
      
      public static const SCOPE_APP:int = 1;
      
      public static const SCOPE_DEVELOPER:int = 2;
       
      
      public var scope:int;
      
      public var id:String;
      
      public function AppSetIdInfo()
      {
         super();
      }
      
      internal static function fromObject(param1:Object) : AppSetIdInfo
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:AppSetIdInfo = new AppSetIdInfo();
         if(param1.hasOwnProperty("id"))
         {
            _loc2_.id = param1.id;
         }
         if(param1.hasOwnProperty("scope"))
         {
            _loc2_.scope = param1.scope;
         }
         return _loc2_;
      }
   }
}
