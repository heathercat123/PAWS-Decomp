package com.distriqt.extension.adverts.nativeads
{
   import com.distriqt.extension.adverts.AdRequest;
   import com.distriqt.extension.adverts.AdViewParams;
   import flash.events.IEventDispatcher;
   
   [Event(name="nativead:loaded",type="com.distriqt.extension.adverts.events.NativeAdEvent")]
   [Event(name="nativead:error",type="com.distriqt.extension.adverts.events.NativeAdEvent")]
   [Event(name="nativead:opened",type="com.distriqt.extension.adverts.events.NativeAdEvent")]
   [Event(name="nativead:clicked",type="com.distriqt.extension.adverts.events.NativeAdEvent")]
   [Event(name="nativead:closed",type="com.distriqt.extension.adverts.events.NativeAdEvent")]
   public interface NativeAd extends IEventDispatcher
   {
       
      
      function destroy() : void;
      
      function get isLoaded() : Boolean;
      
      function get isLoading() : Boolean;
      
      function load(param1:AdRequest) : void;
      
      function showWithTemplate(param1:String, param2:AdViewParams, param3:NativeAdTemplateStyle = null) : Boolean;
      
      function get visible() : Boolean;
      
      function set visible(param1:Boolean) : void;
      
      function setViewParams(param1:AdViewParams) : void;
      
      function getViewParams() : AdViewParams;
   }
}
