package com.distriqt.extension.adverts
{
   import flash.events.IEventDispatcher;
   
   public interface Interstitials extends IEventDispatcher
   {
       
      
      function get isSupported() : Boolean;
      
      function createInterstitialAd() : InterstitialAd;
   }
}
