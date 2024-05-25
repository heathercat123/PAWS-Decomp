package com.distriqt.extension.inappbilling.user
{
   public class UserData
   {
      
      private static const TAG:String = "UserData";
       
      
      public var userId:String;
      
      public function UserData()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : UserData
      {
         var _loc2_:UserData = null;
         if(param1 != null)
         {
            _loc2_ = new UserData();
            if(param1.hasOwnProperty("userId"))
            {
               _loc2_.userId = param1.userId;
            }
            return _loc2_;
         }
         return null;
      }
   }
}
