package com.distriqt.extension.adverts
{
   import flash.events.EventDispatcher;
   
   internal class _InterstitialsImpl extends EventDispatcher implements Interstitials
   {
       
      
      public function _InterstitialsImpl()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get isSupported() : Boolean
      {
         return false;
      }
      
      public function createInterstitialAd() : InterstitialAd
      {
         return null;
      }
   }
}
