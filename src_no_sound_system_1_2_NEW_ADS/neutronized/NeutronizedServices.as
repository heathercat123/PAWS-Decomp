package neutronized
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import game_utils.GameSlot;
   import interfaces.panels.CrossPromotionPanel;
   
   public class NeutronizedServices
   {
      
      private static var _instance:NeutronizedServices = null;
      
      private var _crossPromotionXML:NeutronizedCrossPromotionXML;
      
      private var _adConfigXML:NeutronizedAdConfigXML;
      
      private var loaderCrossPromotion:URLLoader;
      
      private var xmlCrossPromotion:XML;
      
      private var loaderAdConfig:URLLoader;
      
      private var xmlAdConfig:XML;
      
      public function NeutronizedServices()
      {
         super();
      }
      
      public static function getInstance() : NeutronizedServices
      {
         if(_instance == null)
         {
            _instance = new NeutronizedServices();
         }
         return _instance;
      }
      
      public function Init() : void
      {
         var crossPromotionURLRequest:URLRequest = null;
         var adConfigURLRequest:URLRequest = null;
         this._crossPromotionXML = null;
         this._adConfigXML = null;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GAME_SESSIONS] == 0)
         {
            CrossPromotionPanel.DO_NOT_INCREASE_SLOT = true;
         }
         this.xmlCrossPromotion = new XML();
         if(Utils.IS_ANDROID)
         {
            crossPromotionURLRequest = new URLRequest("http://www.neutronized.com/services/paws_crosspromotion/xml/index.xml?" + int(Math.random() * 100000000000));
         }
         else
         {
            crossPromotionURLRequest = new URLRequest("http://www.neutronized.com/services/paws_crosspromotion_ios/xml/index.xml?" + int(Math.random() * 100000000000));
         }
         this.loaderCrossPromotion = new URLLoader(crossPromotionURLRequest);
         this.loaderCrossPromotion.addEventListener(Event.COMPLETE,this.xmlCrossPromotionLoaded);
         this.loaderCrossPromotion.addEventListener(IOErrorEvent.IO_ERROR,this.xmlCrossPromotionError);
      }
      
      protected function xmlCrossPromotionLoaded(event:Event) : void
      {
         try
         {
            this.xmlCrossPromotion = XML(this.loaderCrossPromotion.data);
         }
         catch(error:Error)
         {
            return;
         }
         this._crossPromotionXML = new NeutronizedCrossPromotionXML(this.xmlCrossPromotion);
         if(this.crossPromotionXML.slot.length != 0)
         {
            CrossPromotionPanel.LoadCrossPromotion();
         }
      }
      
      protected function xmlCrossPromotionError(event:IOErrorEvent) : void
      {
         this._crossPromotionXML = null;
      }
      
      protected function xmlAdConfigLoaded(event:Event) : void
      {
         this.xmlAdConfig = XML(this.loaderAdConfig.data);
         this._adConfigXML = new NeutronizedAdConfigXML(this.xmlAdConfig);
      }
      
      protected function xmlAdConfigError(event:IOErrorEvent) : void
      {
         this._adConfigXML = null;
      }
      
      public function get crossPromotionXML() : NeutronizedCrossPromotionXML
      {
         return this._crossPromotionXML;
      }
      
      public function get adConfigXML() : NeutronizedAdConfigXML
      {
         return this._adConfigXML;
      }
      
      public function IsCrossPromotionAvailable() : Boolean
      {
         if(this._crossPromotionXML == null)
         {
            return false;
         }
         return true;
      }
      
      public function IsAdConfigAvailable() : Boolean
      {
         if(this._adConfigXML == null)
         {
            return false;
         }
         return true;
      }
   }
}

