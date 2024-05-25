package com.distriqt.extension.gameservices.quests
{
   public class PlayerEvent
   {
       
      
      public var eventId:String = "";
      
      public var name:String = "";
      
      public var description:String = "";
      
      public var iconImageUrl:String = "";
      
      public var value:Number = -1;
      
      public var formattedValue:String = "";
      
      public var isVisible:Boolean = false;
      
      public function PlayerEvent()
      {
         super();
      }
      
      public static function fromObject(param1:Object) : PlayerEvent
      {
         var _loc2_:PlayerEvent = new PlayerEvent();
         if(param1.eventId)
         {
            _loc2_.eventId = param1.eventId;
         }
         if(param1.name)
         {
            _loc2_.name = param1.name;
         }
         if(param1.description)
         {
            _loc2_.description = param1.description;
         }
         if(param1.iconImageUrl)
         {
            _loc2_.iconImageUrl = param1.iconImageUrl;
         }
         if(param1.value)
         {
            _loc2_.value = param1.value;
         }
         if(param1.formattedValue)
         {
            _loc2_.formattedValue = param1.formattedValue;
         }
         if(param1.isVisible)
         {
            _loc2_.isVisible = param1.isVisible;
         }
         return _loc2_;
      }
   }
}
