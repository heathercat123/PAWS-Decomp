package com.distriqt.extension.ironsource
{
   public class IronSourceBannerSize
   {
      
      private static const TAG:String = "IronSourceBannerSize";
      
      public static const BANNER:IronSourceBannerSize = new IronSourceBannerSize(0,50,"BANNER");
      
      public static const LARGE:IronSourceBannerSize = new IronSourceBannerSize(0,90,"LARGE");
      
      public static const RECTANGLE:IronSourceBannerSize = new IronSourceBannerSize(0,250,"RECTANGLE");
      
      public static const SMART:IronSourceBannerSize = new IronSourceBannerSize(0,50,"SMART");
       
      
      private var width:int;
      
      private var height:int;
      
      private var description:String;
      
      public function IronSourceBannerSize(param1:int, param2:int, param3:String = "CUSTOM")
      {
         super();
         this.width = param1;
         this.height = param2;
         this.description = param3;
      }
      
      public function get Width() : int
      {
         return width;
      }
      
      public function get Height() : int
      {
         return height;
      }
      
      public function get Description() : String
      {
         return description;
      }
   }
}
