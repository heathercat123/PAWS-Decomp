package com.distriqt.extension.adverts.nativeads
{
   public class NativeAdTemplateStyle
   {
      
      private static const TAG:String = "NativeTemplateStyle";
       
      
      private var _styles:Object;
      
      public function NativeAdTemplateStyle()
      {
         super();
         _styles = {};
         setMainBackgroundColor(4294967295);
         setPrimaryTextBackgroundColor(4294967295);
         setSecondaryTextBackgroundColor(4294967295);
         setTertiaryTextBackgroundColor(4294967295);
      }
      
      public function get jsonString() : String
      {
         try
         {
            return JSON.stringify(_styles);
         }
         catch(e:Error)
         {
         }
         return "{}";
      }
      
      public function setCallToActionTextSize(param1:Number) : NativeAdTemplateStyle
      {
         _styles["callToActionTextSize"] = param1;
         return this;
      }
      
      public function setCallToActionTypefaceColor(param1:int) : NativeAdTemplateStyle
      {
         _styles["callToActionTypefaceColor"] = param1;
         return this;
      }
      
      public function setCallToActionBackgroundColor(param1:int) : NativeAdTemplateStyle
      {
         _styles["callToActionBackgroundColor"] = param1;
         return this;
      }
      
      public function setPrimaryTextSize(param1:Number) : NativeAdTemplateStyle
      {
         _styles["primaryTextSize"] = param1;
         return this;
      }
      
      public function setPrimaryTextTypefaceColor(param1:int) : NativeAdTemplateStyle
      {
         _styles["primaryTextTypefaceColor"] = param1;
         return this;
      }
      
      public function setPrimaryTextBackgroundColor(param1:int) : NativeAdTemplateStyle
      {
         _styles["primaryTextBackgroundColor"] = param1;
         return this;
      }
      
      public function setSecondaryTextSize(param1:Number) : NativeAdTemplateStyle
      {
         _styles["secondaryTextSize"] = param1;
         return this;
      }
      
      public function setSecondaryTextTypefaceColor(param1:int) : NativeAdTemplateStyle
      {
         _styles["secondaryTextTypefaceColor"] = param1;
         return this;
      }
      
      public function setSecondaryTextBackgroundColor(param1:int) : NativeAdTemplateStyle
      {
         _styles["secondaryTextBackgroundColor"] = param1;
         return this;
      }
      
      public function setTertiaryTextSize(param1:Number) : NativeAdTemplateStyle
      {
         _styles["tertiaryTextSize"] = param1;
         return this;
      }
      
      public function setTertiaryTextTypefaceColor(param1:int) : NativeAdTemplateStyle
      {
         _styles["tertiaryTextTypefaceColor"] = param1;
         return this;
      }
      
      public function setTertiaryTextBackgroundColor(param1:int) : NativeAdTemplateStyle
      {
         _styles["tertiaryTextBackgroundColor"] = param1;
         return this;
      }
      
      public function setMainBackgroundColor(param1:int) : NativeAdTemplateStyle
      {
         _styles["mainBackgroundColor"] = param1;
         return this;
      }
   }
}
