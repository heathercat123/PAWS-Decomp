package com.distriqt.extension.adverts.consent
{
   public class ConsentOptions
   {
      
      private static const TAG:String = "ConsentOptions";
       
      
      public var privacyUrl:String;
      
      public var showNonPersonalisedAdsOption:Boolean = false;
      
      public var showPersonalisedAdsOption:Boolean = false;
      
      public var showAdFreeOption:Boolean = false;
      
      public var dialogContent:ConsentDialogContent;
      
      public function ConsentOptions(param1:String)
      {
         dialogContent = new ConsentDialogContent();
         super();
         this.privacyUrl = param1;
      }
      
      public function withPersonalizedAdsOption() : ConsentOptions
      {
         this.showPersonalisedAdsOption = true;
         return this;
      }
      
      public function withNonPersonalizedAdsOption() : ConsentOptions
      {
         this.showNonPersonalisedAdsOption = true;
         return this;
      }
      
      public function withAdFreeOption() : ConsentOptions
      {
         this.showAdFreeOption = true;
         return this;
      }
      
      public function setDialogContent(param1:ConsentDialogContent) : ConsentOptions
      {
         this.dialogContent = param1;
         return this;
      }
   }
}
