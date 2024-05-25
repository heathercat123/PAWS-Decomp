package com.distriqt.extension.application
{
   public class ApplicationDisplayModes
   {
      
      public static const NORMAL:String = "normal";
      
      public static const FULLSCREEN:String = "fullscreen";
      
      public static const FULLSCREEN_WITH_STATUSBAR:String = "fullscreenStatusBar";
      
      public static const IMMERSIVE:String = "immersive";
      
      public static const UI_NAVIGATION_HIDE:String = "ui:navigation:hide";
      
      public static const UI_NAVIGATION_LOW_PROFILE:String = "ui:navigation:lowprofile";
      
      public static const UI_NAVIGATION_VISIBLE:String = "ui:navigation:visible";
       
      
      public function ApplicationDisplayModes()
      {
         super();
      }
      
      public static function toDisplayMode(param1:String) : String
      {
         switch(param1)
         {
            default:
            case "normal":
               break;
            case "fullscreen":
               return "fullscreen";
            case "immersive":
               return "immersive";
            case "fullscreenStatusBar":
               return "fullscreen";
         }
         return "normal";
      }
   }
}
