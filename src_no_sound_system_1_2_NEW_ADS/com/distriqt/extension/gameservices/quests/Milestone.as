package com.distriqt.extension.gameservices.quests
{
   import com.distriqt.extension.gameservices.utils.Base64;
   import flash.utils.ByteArray;
   
   public class Milestone
   {
      
      public static const STATE_CLAIMED:int = 4;
      
      public static const STATE_COMPLETED_NOT_CLAIMED:int = 3;
      
      public static const STATE_NOT_COMPLETED:int = 2;
      
      public static const STATE_NOT_STARTED:int = 1;
       
      
      public var milestoneId:String;
      
      public var state:int;
      
      public var eventId:String;
      
      public var currentProgress:Number;
      
      public var targetProgress:Number;
      
      public var rewardData:ByteArray;
      
      public function Milestone()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : Milestone
      {
         var _loc2_:Milestone = new Milestone();
         if(param1.milestoneId)
         {
            _loc2_.milestoneId = param1.milestoneId;
         }
         if(param1.state)
         {
            _loc2_.state = param1.state;
         }
         if(param1.eventId)
         {
            _loc2_.eventId = param1.eventId;
         }
         if(param1.currentProgress)
         {
            _loc2_.currentProgress = param1.currentProgress;
         }
         if(param1.targetProgress)
         {
            _loc2_.targetProgress = param1.targetProgress;
         }
         if(param1.rewardData)
         {
            _loc2_.rewardData = Base64.decodeToByteArray(param1.rewardData);
         }
         return _loc2_;
      }
   }
}
