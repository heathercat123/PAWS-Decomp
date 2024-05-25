package com.distriqt.extension.gameservices.events
{
   import com.distriqt.extension.gameservices.quests.Quest;
   import flash.events.Event;
   
   public class QuestEvent extends Event
   {
      
      public static const QUESTS_UI_CLOSED:String = "quests:ui:closed";
      
      public static const QUESTS_LOAD_SUCCESS:String = "quests:load:success";
      
      public static const QUESTS_LOAD_ERROR:String = "quests:load:error";
      
      public static const QUEST_COMPLETED:String = "quests:quest:completed";
      
      public static const QUEST_ACCEPT_SUCCESS:String = "quests:quest:accept:success";
      
      public static const QUEST_ACCEPT_ERROR:String = "quests:quest:accept:error";
      
      public static const QUEST_CLAIM_SUCCESS:String = "quests:quest:claim:success";
      
      public static const QUEST_CLAIM_ERROR:String = "quests:quest:claim:error";
       
      
      public var quests:Vector.<Quest>;
      
      public var errorCode:int;
      
      public var message:String;
      
      public function QuestEvent(param1:String, param2:Vector.<Quest> = null, param3:String = "", param4:int = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.quests = param2;
         this.errorCode = param4;
         this.message = param3;
      }
      
      override public function clone() : Event
      {
         return new QuestEvent(type,quests,message,errorCode,bubbles,cancelable);
      }
   }
}
