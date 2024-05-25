package com.distriqt.extension.gameservices.quests
{
   public class Quest
   {
      
      public static const STATE_UPCOMING:int = 1;
      
      public static const STATE_OPEN:int = 2;
      
      public static const STATE_ACCEPTED:int = 3;
      
      public static const STATE_COMPLETED:int = 4;
      
      public static const STATE_EXPIRED:int = 5;
      
      public static const STATE_FAILED:int = 6;
       
      
      public var questId:String = "";
      
      public var name:String = "";
      
      public var description:String = "";
      
      public var state:int = 0;
      
      public var acceptedTimestamp:Number = -1;
      
      public var startTimestamp:Number = -1;
      
      public var endTimestamp:Number = -1;
      
      public var lastUpdatedTimestamp:Number = -1;
      
      public var iconImageUrl:String = "";
      
      public var bannerImageUrl:String = "";
      
      public var isEndingSoon:Boolean = false;
      
      public var currentMilestone:Milestone = null;
      
      public function Quest()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : Quest
      {
         var _loc2_:Quest = new Quest();
         if(param1.questId)
         {
            _loc2_.questId = param1.questId;
         }
         if(param1.name)
         {
            _loc2_.name = param1.name;
         }
         if(param1.description)
         {
            _loc2_.description = param1.description;
         }
         if(param1.state)
         {
            _loc2_.state = param1.state;
         }
         if(param1.acceptedTimestamp)
         {
            _loc2_.acceptedTimestamp = param1.acceptedTimestamp;
         }
         if(param1.startTimestamp)
         {
            _loc2_.startTimestamp = param1.startTimestamp;
         }
         if(param1.endTimestamp)
         {
            _loc2_.endTimestamp = param1.endTimestamp;
         }
         if(param1.lastUpdatedTimestamp)
         {
            _loc2_.lastUpdatedTimestamp = param1.lastUpdatedTimestamp;
         }
         if(param1.iconImageUrl)
         {
            _loc2_.iconImageUrl = param1.iconImageUrl;
         }
         if(param1.bannerImageUrl)
         {
            _loc2_.bannerImageUrl = param1.bannerImageUrl;
         }
         if(param1.isEndingSoon)
         {
            _loc2_.isEndingSoon = param1.isEndingSoon;
         }
         if(param1.currentMilestone)
         {
            _loc2_.currentMilestone = Milestone.fromObject(param1.currentMilestone);
         }
         return _loc2_;
      }
   }
}
