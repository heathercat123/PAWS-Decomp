package com.distriqt.extension.adverts
{
   import flash.events.IEventDispatcher;
   
   [Event(name="adview:loaded",type="com.distriqt.extension.adverts.events.AdViewEvent")]
   [Event(name="adview:closed",type="com.distriqt.extension.adverts.events.AdViewEvent")]
   [Event(name="adview:opened",type="com.distriqt.extension.adverts.events.AdViewEvent")]
   [Event(name="adview:leftapplication",type="com.distriqt.extension.adverts.events.AdViewEvent")]
   [Event(name="adview:error",type="com.distriqt.extension.adverts.events.AdViewEvent")]
   [Event(name="paidevent_paid",type="com.distriqt.extension.adverts.events.PaidEvent")]
   public interface AdView extends IEventDispatcher
   {
       
      
      function destroy() : void;
      
      function setAdSize(param1:AdSize) : void;
      
      function setAdaptiveAdSize(param1:int = -1, param2:String = "auto") : void;
      
      function setInlineAdaptiveAdSize(param1:int = -1, param2:String = "auto") : void;
      
      function setInlineAdaptiveAdSizeWithMaxHeight(param1:int, param2:int = -1) : void;
      
      function getAdSize() : AdSize;
      
      function setAdUnitId(param1:String) : void;
      
      function getAdUnitId() : String;
      
      function isLoading() : Boolean;
      
      function load(param1:AdRequest) : void;
      
      function setViewParams(param1:AdViewParams) : void;
      
      function show() : Boolean;
      
      function hide() : Boolean;
   }
}
