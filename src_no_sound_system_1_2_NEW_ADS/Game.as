package
{
   import com.distriqt.extension.adverts.AdvertPlatform;
   import com.distriqt.extension.adverts.Adverts;
   import com.distriqt.extension.adverts.events.AdvertsEvent;
   import com.distriqt.extension.core.Core;
   import com.distriqt.extension.gameservices.GameServices;
   import com.distriqt.extension.gameservices.Service;
   import com.distriqt.extension.gameservices.events.GameServicesEvent;
   import com.distriqt.extension.gameservices.events.SavedGamesEvent;
   import com.distriqt.extension.gameservices.savedgames.SavedGame;
   import com.distriqt.extension.inappbilling.BillingService;
   import com.distriqt.extension.inappbilling.InAppBilling;
   import com.distriqt.extension.inappbilling.Product;
   import com.distriqt.extension.inappbilling.Purchase;
   import com.distriqt.extension.inappbilling.events.InAppBillingEvent;
   import com.distriqt.extension.inappbilling.events.PurchaseEvent;
   import com.distriqt.extension.playservices.base.ConnectionResult;
   import com.distriqt.extension.playservices.base.GoogleApiAvailability;
   import game_utils.GameSlot;
   import game_utils.InAppProduct;
   import game_utils.InAppProductsManager;
   import game_utils.LevelItems;
   import game_utils.QuestsManager;
   import game_utils.SaveManager;
   import interfaces.panels.SettingsPanel;
   import neutronized.NeutronizedServices;
   import starling.display.Sprite;
   import starling.events.Event;
   import states.*;
   import states.fading.*;
   
   public class Game extends Sprite
   {
      
      private static const TIME_PER_FRAME:* = 1 / 60;
       
      
      private var currentState:IState;
      
      private var currentFadeState:IState;
      
      private var previousState:IState;
      
      private var counter:int;
      
      private var gameEntryState:GameEntryState;
      
      private var logoState:LogoState;
      
      private var introState:IntroState;
      
      private var splashState:SplashState;
      
      private var mapState:MapState;
      
      private var levelState:LevelState;
      
      private var minigameState:MinigameState;
      
      private var crossPromotionState:CrossPromotionState;
      
      private var demoLevelSelectionState:DemoLevelSelectionState;
      
      private var tilesTestState:TilesTestState;
      
      private var ANDROID_PREMIUM_RECEIVED:Boolean;
      
      private var ANDROID_TIER_1_RECEIVED:Boolean;
      
      private var ANDROID_TIER_2_RECEIVED:Boolean;
      
      private var ANDROID_TIER_3_RECEIVED:Boolean;
      
      private var fadeState:IState;
      
      private var notNull:Boolean;
      
      public var fadingOut:Boolean = true;
      
      public var FADE_IN_FLAG:Boolean;
      
      public var FADE_OUT_FLAG:Boolean;
      
      public var playMenuMusicFlag:Boolean;
      
      public function Game()
      {
         super();
         this.playMenuMusicFlag = false;
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(event:Event) : void
      {
         var result:int = 0;
         var service:Service = null;
         var _service:BillingService = null;
         this.currentState = null;
         this.currentFadeState = null;
         this.counter = 0;
         this.FADE_IN_FLAG = false;
         this.FADE_OUT_FLAG = false;
         this.ANDROID_PREMIUM_RECEIVED = this.ANDROID_TIER_1_RECEIVED = this.ANDROID_TIER_2_RECEIVED = this.ANDROID_TIER_3_RECEIVED = false;
         SaveManager.Init();
         InAppProductsManager.Init();
         TextureManager.Init();
         Utils.Init(stage);
         SaveManager.LoadSlot();
         StringsManager.Init();
         QuestsManager.Init();
         LevelItems.Init();
         Utils.rootMovie = this;
         NeutronizedServices.getInstance().Init();
         SoundSystem.InitSounds();
         Utils.FLAIR = Utils.FLAIR_HALLOWEEN;
         if(Utils.IS_ON_WINDOWS == false)
         {
            Core.init();
            try
            {
               if(Adverts.isSupported)
               {
                  if(Adverts.service.isPlatformSupported(AdvertPlatform.PLATFORM_ADMOB))
                  {
                     Adverts.service.setup(AdvertPlatform.PLATFORM_ADMOB,"ca-app-pub-6892794320149398~8973360822");
                     Adverts.service.addEventListener(AdvertsEvent.INITIALISED,function(event:AdvertsEvent):void
                     {
                        trace("initialised");
                     });
                     Adverts.service.initialise();
                  }
                  else
                  {
                     trace("No platform supported");
                  }
               }
               else
               {
                  trace("Not supported...");
               }
            }
            catch(e:Error)
            {
               trace(e.message);
            }
            result = int(GoogleApiAvailability.instance.isGooglePlayServicesAvailable());
            if(result != ConnectionResult.SUCCESS)
            {
               if(GoogleApiAvailability.instance.isUserRecoverableError(result))
               {
                  GoogleApiAvailability.instance.showErrorDialog(result);
               }
               else
               {
                  trace("Google Play Services aren\'t available on this device");
               }
            }
            else
            {
               trace("Google Play Services are Available");
            }
            if(GameServices.service.isServiceSupported(Service.GOOGLE_PLAY_GAME_SERVICES))
            {
               service = new Service(Service.GOOGLE_PLAY_GAME_SERVICES);
               service.enableSavedGames = true;
               GameServices.service.addEventListener(GameServicesEvent.INITIALISED,this.initialisedHandler);
               GameServices.service.addEventListener(GameServicesEvent.SIGN_IN_SUCCESS,this.signInSuccessHandler);
               GameServices.service.initialiseService(service);
            }
            if(InAppBilling.isSupported)
            {
               InAppBilling.service.addEventListener(PurchaseEvent.PURCHASES_UPDATED,this.purchases_updatedHandler);
               InAppBilling.service.addEventListener(InAppBillingEvent.RESTORE_PURCHASES_SUCCESS,this.restorePurchases_successHandler);
               InAppBilling.service.addEventListener(InAppBillingEvent.RESTORE_PURCHASES_FAILED,this.restorePurchases_failedHandler);
               InAppBilling.service.addEventListener(InAppBillingEvent.SETUP_SUCCESS,this.setup_successHandler);
               InAppBilling.service.addEventListener(InAppBillingEvent.PRODUCTS_LOADED,this.products_loadedHandler);
               _service = new BillingService().setGooglePlayPublicKey("MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjjAyYKXVrOWASNjcyhMkeH8X4o27jbCZf1PW3RSGS4RNSWILNXWPmY1FCGgNgAPt/iTq3aw8prJzlVQ6p9muCtUHPq+gfF6wXh92lOp0VgkXqEyslQXZfyJNnZvSgFpJDqcxM3NvhdzlWl2gvx5Nqkmh086DBDvbAKKTJRuzMM6hrsGHFnqkL3I36SURBu6yQ0/XFOEdbdWCsbmGh0IqfagRFsEDFZBXElabwIA48zAqkODqyG61eCWVU8ImPZbxQ346GXP8WG6KYcsN7aCWdt/Oh30ZLQDRxE7BehowNr9Cpn3RfsNmNn5GxUx8xJm4nRC32sHoD9/eHGgU0QB9dwIDAQAB");
               InAppBilling.service.setup(_service);
            }
         }
         stage.addEventListener(Event.ENTER_FRAME,this.update);
         this.notNull = false;
         this.gameEntryState = new GameEntryState();
         this.changeState(this.gameEntryState);
      }
      
      public function enterGameEntryState() : void
      {
         this.counter = 0;
      }
      
      public function updateGameEntryState() : void
      {
         if(this.counter++ == 10)
         {
            this.fadeState = new BlackFadeState();
            this.setFadeOut();
         }
         if(this.FADE_OUT_FLAG)
         {
            this.counter = 0;
            this.FADE_OUT_FLAG = false;
            this.logoState = new LogoState();
            this.changeState(this.logoState);
         }
      }
      
      public function exitGameEntryState() : void
      {
         this.gameEntryState = null;
      }
      
      public function update() : void
      {
         if(!Utils.PauseOn && !Utils.FreezeOn && !Utils.CatOn && !Utils.RateOn && !Utils.ShopOn && !Utils.HelperOn && !Utils.GameOverOn && !Utils.GateUnlockOn && !Utils.PremiumOn && !Utils.QuestOn && !Utils.QuestAvailablePanelOn && !Utils.DoubleCoinsOn)
         {
            Utils.juggler.advanceTime(TIME_PER_FRAME);
         }
         if(!Utils.PauseOn && !Utils.CatOn && !Utils.RateOn && !Utils.ShopOn && !Utils.HelperOn && !Utils.GameOverOn && !Utils.GateUnlockOn && !Utils.PremiumOn && !Utils.QuestOn && !Utils.QuestAvailablePanelOn && !Utils.DoubleCoinsOn)
         {
            Utils.freeze_juggler.advanceTime(TIME_PER_FRAME);
         }
         this.currentState.updateState(this);
         if(this.currentFadeState)
         {
            this.currentFadeState.updateState(this);
         }
         SoundSystem.Update();
      }
      
      private function changeState(newState:IState) : void
      {
         if(this.currentState)
         {
            TextureManager.UnloadTexture();
            this.currentState.exitState(this);
            this.currentState = null;
         }
         this.currentState = newState;
         TextureManager.LoadTexture();
         this.currentState.enterState(this);
      }
      
      private function setFadeOut() : void
      {
         this.fadingOut = true;
         this.currentFadeState = this.fadeState;
         this.currentFadeState.enterState(this);
      }
      
      private function setFadeIn() : void
      {
         this.fadingOut = false;
         this.currentFadeState.enterState(this);
      }
      
      public function removeFader() : void
      {
         this.currentFadeState.exitState(this);
         this.currentFadeState = null;
         this.FADE_IN_FLAG = true;
      }
      
      public function enterLogoState() : *
      {
         this.counter = 0;
         this.setFadeIn();
      }
      
      public function updateLogoState() : *
      {
         if(this.counter >= 0)
         {
            ++this.counter;
         }
         if(this.counter == 180 || this.logoState.GET_OUT_FLAG)
         {
            this.logoState.GET_OUT_FLAG = false;
            this.counter = -1;
            this.fadeState = new BlackFadeState();
            this.setFadeOut();
         }
         if(this.FADE_OUT_FLAG)
         {
            this.counter = 0;
            this.FADE_OUT_FLAG = false;
            if(CrossPromotionState.IsTimeForCrossPromotion() && Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 0)
            {
               this.crossPromotionState = new CrossPromotionState();
               this.changeState(this.crossPromotionState);
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_SKIP_INTRO] > 0)
            {
               this.splashState = new SplashState();
               this.changeState(this.splashState);
               this.splashState.stateMachine.setState("IS_NORMAL_STATE");
            }
            else
            {
               this.introState = new IntroState();
               this.changeState(this.introState);
            }
         }
      }
      
      public function exitLogoState() : *
      {
         this.logoState = null;
      }
      
      public function enterCrossPromotionState() : *
      {
         this.setFadeIn();
         SoundSystem.PlayMusic("outside_desert");
      }
      
      public function updateCrossPromotionState() : *
      {
         if(this.crossPromotionState.GET_OUT_FLAG)
         {
            SoundSystem.StopMusic();
            this.crossPromotionState.GET_OUT_FLAG = false;
            this.fadeState = new BlackFadeState();
            this.setFadeOut();
         }
         if(this.FADE_OUT_FLAG)
         {
            this.counter = 0;
            this.FADE_OUT_FLAG = false;
            this.playMenuMusicFlag = true;
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_SKIP_INTRO] > 0)
            {
               this.splashState = new SplashState();
               this.changeState(this.splashState);
               this.splashState.stateMachine.setState("IS_NORMAL_STATE");
            }
            else
            {
               this.introState = new IntroState();
               this.changeState(this.introState);
            }
         }
      }
      
      public function exitCrossPromotionState() : *
      {
         this.crossPromotionState = null;
      }
      
      public function enterSplashState() : *
      {
         this.setFadeIn();
      }
      
      public function updateSplashState() : *
      {
         if(this.splashState.GET_OUT_FLAG)
         {
            this.splashState.GET_OUT_FLAG = false;
            if(this.splashState.choice == 1)
            {
               this.fadeState = new BlackFadeState();
            }
            else
            {
               this.fadeState = new WhiteFadeState();
            }
            SoundSystem.StopMusic();
            this.setFadeOut();
         }
         if(this.FADE_OUT_FLAG)
         {
            this.FADE_OUT_FLAG = false;
            switch(this.splashState.choice)
            {
               case 0:
                  Utils.CutsceneDelayTime = 60;
                  Utils.SpeedUpMapMusic = true;
                  this.mapState = new MapState();
                  this.changeState(this.mapState);
                  this.playMenuMusicFlag = true;
                  break;
               case 1:
                  this.introState = new IntroState();
                  this.changeState(this.introState);
                  break;
               case 2:
                  this.levelState = new LevelState();
                  this.changeState(this.levelState);
            }
         }
      }
      
      public function exitSplashState() : *
      {
         this.splashState = null;
      }
      
      public function enterMapState() : void
      {
         this.setFadeIn();
         if(this.playMenuMusicFlag)
         {
            this.playMenuMusicFlag = false;
         }
         SettingsPanel.iCloudRestoreCoins();
      }
      
      public function updateMapState() : void
      {
         if(this.mapState.GET_OUT_FLAG)
         {
            this.mapState.GET_OUT_FLAG = false;
            if(this.mapState.choice == 1)
            {
               this.fadeState = new LevelIntroFadeState();
            }
            else
            {
               this.fadeState = new BlackFadeState();
            }
            if(this.mapState.choice != 2)
            {
               SoundSystem.StopMusic();
               this.playMenuMusicFlag = true;
            }
            this.setFadeOut();
         }
         if(this.FADE_OUT_FLAG)
         {
            this.counter = 0;
            this.FADE_OUT_FLAG = false;
            this.notNull = false;
            switch(this.mapState.choice)
            {
               case 0:
                  this.splashState = new SplashState();
                  this.changeState(this.splashState);
                  this.splashState.stateMachine.setState("IS_NORMAL_STATE");
                  break;
               case 1:
                  this.levelState = new LevelState();
                  this.changeState(this.levelState);
                  break;
               case 2:
                  Utils.CutsceneDelayTime = 60;
                  this.notNull = true;
                  this.mapState = new MapState();
                  this.mapState.doNotForceMusic = true;
                  this.changeState(this.mapState);
            }
         }
      }
      
      public function exitMapState() : void
      {
         SettingsPanel.iCloudRestoreCoins();
         if(!this.notNull)
         {
            this.mapState = null;
         }
         Utils.PauseOn = false;
         Utils.FreezeOn = false;
         Utils.CatOn = false;
         Utils.RateOn = false;
         Utils.GameOverOn = false;
         Utils.ShopOn = false;
         Utils.HelperOn = false;
         Utils.DoubleCoinsOn = false;
      }
      
      public function enterDemoLevelSelectionState() : void
      {
         this.setFadeIn();
      }
      
      public function updateDemoLevelSelectionState() : void
      {
         if(this.demoLevelSelectionState.GET_OUT_FLAG)
         {
            this.demoLevelSelectionState.GET_OUT_FLAG = false;
            this.fadeState = new LevelIntroFadeState();
            SoundSystem.StopMusic();
            this.playMenuMusicFlag = true;
            this.setFadeOut();
         }
         if(this.FADE_OUT_FLAG)
         {
            this.counter = 0;
            this.FADE_OUT_FLAG = false;
            this.levelState = new LevelState();
            this.changeState(this.levelState);
         }
      }
      
      public function exitDemoLevelSelectionState() : void
      {
         this.demoLevelSelectionState = null;
         Utils.PauseOn = false;
         Utils.FreezeOn = false;
         Utils.CatOn = false;
         Utils.RateOn = false;
         Utils.GameOverOn = false;
         Utils.DoubleCoinsOn = false;
      }
      
      public function enterIntroState() : *
      {
         this.setFadeIn();
         SoundSystem.PlayMusic("intro");
      }
      
      public function updateIntroState() : *
      {
         if(this.introState.GET_OUT_FLAG)
         {
            this.introState.GET_OUT_FLAG = false;
            if(this.introState.choice == 0)
            {
               this.fadeState = new WhiteFadeState();
            }
            else
            {
               this.fadeState = new WhiteQuickFadeState();
            }
            if(this.introState.choice == 1)
            {
               SoundSystem.StopMusic();
               this.playMenuMusicFlag = true;
            }
            this.setFadeOut();
         }
         if(this.FADE_OUT_FLAG)
         {
            this.counter = 0;
            this.FADE_OUT_FLAG = false;
            switch(this.introState.choice)
            {
               case 0:
                  this.splashState = new SplashState();
                  this.changeState(this.splashState);
                  this.splashState.stateMachine.setState("IS_INTRO_STATE");
                  break;
               case 1:
                  this.splashState = new SplashState();
                  this.changeState(this.splashState);
                  this.splashState.stateMachine.setState("IS_INTRO_SHORTCUT_STATE");
            }
         }
      }
      
      public function exitIntroState() : *
      {
         this.introState = null;
      }
      
      public function enterLevelState() : *
      {
         this.counter = 0;
         if(this.playMenuMusicFlag)
         {
            Utils.CutsceneDelayTime = 120;
            this.playMenuMusicFlag = false;
            SoundSystem.PlayLevelMusic();
         }
         this.setFadeIn();
      }
      
      public function updateLevelState() : *
      {
         if(this.levelState.GET_OUT_FLAG)
         {
            this.levelState.GET_OUT_FLAG = false;
            if(this.levelState.choice == 0 || this.levelState.choice == 5)
            {
               this.fadeState = new BlackFadeState();
            }
            else if(this.levelState.choice == 3)
            {
               this.fadeState = new LevelCompleteFadeState();
            }
            else
            {
               SoundSystem.StopMusic();
               if(this.levelState.level.GAME_OVER_FLAG)
               {
                  this.fadeState = new BlackFadeState();
               }
               else
               {
                  this.fadeState = new WhiteFadeState();
               }
            }
            this.setFadeOut();
            if(this.levelState.choice == 3)
            {
               this.levelState.updateSlotDataAndSave();
            }
         }
         if(this.FADE_OUT_FLAG)
         {
            Utils.MapFromLevelWon = false;
            this.FADE_OUT_FLAG = false;
            this.notNull = false;
            switch(this.levelState.choice)
            {
               case 0:
                  this.notNull = true;
                  this.levelState = new LevelState();
                  this.changeState(this.levelState);
                  break;
               case 1:
                  this.playMenuMusicFlag = true;
                  Utils.SpeedUpMapMusic = true;
                  Utils.MapFromLevelWon = true;
                  this.mapState = new MapState(true);
                  this.changeState(this.mapState);
                  break;
               case 2:
                  Utils.ResetGameplay();
                  this.notNull = true;
                  this.levelState = new LevelState();
                  this.changeState(this.levelState);
                  break;
               case 3:
                  Utils.MapFromLevelWon = true;
                  this.mapState = new MapState(true);
                  this.changeState(this.mapState);
                  break;
               case 4:
                  break;
               case 5:
                  this.minigameState = new MinigameState();
                  this.changeState(this.minigameState);
            }
         }
      }
      
      public function exitLevelState() : *
      {
         if(this.levelState.choice == 3)
         {
            SoundSystem.StopMusic();
         }
         if(!this.notNull)
         {
            this.levelState = null;
         }
      }
      
      public function enterMinigameState() : *
      {
         this.counter = 0;
         this.setFadeIn();
      }
      
      public function updateMinigameState() : *
      {
         if(this.minigameState.GET_OUT_FLAG)
         {
            this.minigameState.GET_OUT_FLAG = false;
            this.fadeState = new BlackFadeState();
            this.setFadeOut();
         }
         if(this.FADE_OUT_FLAG)
         {
            this.FADE_OUT_FLAG = false;
            this.notNull = false;
            switch(this.minigameState.choice)
            {
               case 0:
                  this.levelState = new LevelState();
                  this.changeState(this.levelState);
            }
         }
      }
      
      public function exitMinigameState() : *
      {
         this.minigameState = null;
      }
      
      public function enterTilesTestState() : void
      {
         this.setFadeIn();
      }
      
      public function updateTilesTestState() : void
      {
      }
      
      public function exitTilesTestState() : void
      {
      }
      
      internal function initialisedHandler(event:GameServicesEvent) : void
      {
         if(!GameServices.service.isSignedIn())
         {
         }
      }
      
      internal function signInSuccessHandler(event:GameServicesEvent) : void
      {
      }
      
      internal function loadSuccessHandler(event:SavedGamesEvent) : void
      {
         var s:SavedGame = null;
         for each(s in event.data)
         {
            trace("GAME: [" + s.uniqueName + "] " + s.description);
         }
      }
      
      internal function loadErrorHandler(event:SavedGamesEvent) : void
      {
         trace("SAVED GAMES LOAD ERROR" + event.data);
      }
      
      internal function setup_successHandler(event:InAppBillingEvent) : void
      {
         var productIdList:Array = new Array();
         productIdList.push(Utils.ANDROID_INAPP_PREMIUM_PRODUCT);
         productIdList.push(Utils.ANDROID_INAPP_GATE_PRODUCT);
         productIdList.push(Utils.ANDROID_INAPP_TIER1_PRODUCT);
         productIdList.push(Utils.ANDROID_INAPP_TIER2_PRODUCT);
         productIdList.push(Utils.ANDROID_INAPP_TIER3_PRODUCT);
         InAppBilling.service.getProducts(productIdList);
      }
      
      internal function products_loadedHandler(event:InAppBillingEvent) : void
      {
         var inAppProduct:InAppProduct = null;
         var product:Product = null;
         var p:Purchase = null;
         InAppProductsManager.Reset();
         var SET_PLAYPASS:int = 0;
         for each(product in event.data)
         {
            inAppProduct = new InAppProduct(product.id,product.title,product.description,product.priceString,product.priceString);
            InAppProductsManager.products.push(inAppProduct);
            if(product.price <= 0.05)
            {
               SET_PLAYPASS = 1;
            }
            else
            {
               SET_PLAYPASS = 2;
            }
         }
         if(SET_PLAYPASS == 1)
         {
            Utils.SetPlayPass(true);
         }
         else if(SET_PLAYPASS == 2)
         {
            Utils.SetPlayPass(false);
         }
         if(Utils.IS_ANDROID)
         {
            InAppBilling.service.restorePurchases();
         }
         for each(p in InAppBilling.service.getPendingPurchases())
         {
            trace("Pending purchase = " + p.productId);
         }
      }
      
      internal function purchases_updatedHandler(event:PurchaseEvent) : void
      {
         var purchase:Purchase = null;
         if(Utils.PURCHASE_ORIGIN != 0)
         {
            return;
         }
         for each(purchase in event.data)
         {
            if(purchase.transactionState == Purchase.STATE_RESTORED || purchase.transactionState == Purchase.STATE_PURCHASED)
            {
               if(purchase.productId == Utils.ANDROID_INAPP_PREMIUM_PRODUCT)
               {
                  this.ANDROID_PREMIUM_RECEIVED = true;
               }
               else if(purchase.productId == Utils.ANDROID_INAPP_TIER1_PRODUCT || purchase.productId == Utils.ANDROID_INAPP_TIER2_PRODUCT || purchase.productId == Utils.ANDROID_INAPP_TIER3_PRODUCT || purchase.productId == Utils.ANDROID_INAPP_GATE_PRODUCT)
               {
                  if(purchase.transactionState == Purchase.STATE_PURCHASED || purchase.transactionState == Purchase.STATE_RESTORED)
                  {
                     InAppBilling.service.consumePurchase(purchase);
                  }
               }
            }
         }
      }
      
      internal function restorePurchases_successHandler(event:InAppBillingEvent) : void
      {
         if(this.ANDROID_PREMIUM_RECEIVED)
         {
            Utils.SetPremium();
         }
      }
      
      internal function restorePurchases_failedHandler(event:InAppBillingEvent) : void
      {
      }
   }
}
