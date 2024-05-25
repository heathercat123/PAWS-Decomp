package com.distriqt.extension.gameservices.quests
{
   import flash.events.IEventDispatcher;
   
   [Event(name="events:load:success",type="com.distriqt.extension.gameservices.events.PlayerEventEvent")]
   [Event(name="events:load:error",type="com.distriqt.extension.gameservices.events.PlayerEventEvent")]
   [Event(name="quests:ui:closed",type="com.distriqt.extension.gameservices.events.QuestEvent")]
   [Event(name="quests:load:success",type="com.distriqt.extension.gameservices.events.QuestEvent")]
   [Event(name="quests:load:error",type="com.distriqt.extension.gameservices.events.QuestEvent")]
   [Event(name="quests:quest:completed",type="com.distriqt.extension.gameservices.events.QuestEvent")]
   [Event(name="quests:quest:accept:success",type="com.distriqt.extension.gameservices.events.QuestEvent")]
   [Event(name="quests:quest:accept:error",type="com.distriqt.extension.gameservices.events.QuestEvent")]
   [Event(name="quests:quest:claim:success",type="com.distriqt.extension.gameservices.events.QuestEvent")]
   [Event(name="quests:quest:claim:error",type="com.distriqt.extension.gameservices.events.QuestEvent")]
   public interface Quests extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function displayUI() : Boolean;
      
      function loadQuests(param1:Boolean = false) : Boolean;
      
      function accept(param1:String) : Boolean;
      
      function claim(param1:String, param2:String) : Boolean;
      
      function listenForCompletion() : Boolean;
      
      function loadEvents(param1:Boolean = false) : Boolean;
      
      function incrementEvent(param1:String, param2:int = 1) : Boolean;
   }
}
