package com.distriqt.extension.ironsource
{
   public class PlacementInfo
   {
      
      private static const TAG:String = "PlacementInfo";
       
      
      public var placementId:String = "";
      
      public var placementName:String = "";
      
      public var rewardName:String = "";
      
      public var rewardAmount:Number = -1;
      
      public function PlacementInfo()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : PlacementInfo
      {
         var _loc2_:PlacementInfo = null;
         if(param1 != null)
         {
            _loc2_ = new PlacementInfo();
            if(param1.hasOwnProperty("placementId"))
            {
               _loc2_.placementId = param1.placementId;
            }
            if(param1.hasOwnProperty("placementName"))
            {
               _loc2_.placementName = param1.placementName;
            }
            if(param1.hasOwnProperty("rewardName"))
            {
               _loc2_.rewardName = param1.rewardName;
            }
            if(param1.hasOwnProperty("rewardAmount"))
            {
               _loc2_.rewardAmount = param1.rewardAmount;
            }
            return _loc2_;
         }
         return null;
      }
   }
}
