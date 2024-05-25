package interfaces.panels
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import game_utils.GameSlot;
   import game_utils.SaveManager;
   import game_utils.TimeSpan;
   import levels.backgrounds.MenuBackgroundPortable;
   import neutronized.NeutronizedServices;
   import starling.animation.Tween;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.textures.Texture;
   import starling.textures.TextureSmoothing;
   
   public class CrossPromotionPanel extends Sprite
   {
      
      protected static var linkString:String;
      
      protected static var bannerImage:Image = null;
      
      public static var ERROR_LOADING:Boolean = false;
      
      public static var IMAGE_LOADED:Boolean = false;
      
      public static var DO_NOT_INCREASE_SLOT:Boolean = false;
       
      
      public var GET_OUT_FLAG:Boolean;
      
      public var CONTINUE_FLAG:Boolean;
      
      public var QUIT_FLAG:Boolean;
      
      public var pausePanelEntering:Boolean;
      
      public var pausePanelExiting:Boolean;
      
      public var pausePanelStaying:Boolean;
      
      protected var IMAGE_WIDTH:int;
      
      protected var IMAGE_HEIGHT:int;
      
      public var backgroundQuad:MenuBackgroundPortable;
      
      public var frameContainer:Sprite;
      
      public var frameImages:Vector.<Image>;
      
      public var frameButton:Button;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var SCALE:Number;
      
      protected var container1:Sprite;
      
      protected var container2:Sprite;
      
      public function CrossPromotionPanel()
      {
         super();
         this.GET_OUT_FLAG = false;
         this.CONTINUE_FLAG = false;
         this.QUIT_FLAG = false;
         this.pausePanelEntering = false;
         this.pausePanelExiting = false;
         this.pausePanelStaying = false;
         this.counter_1 = this.counter_2 = 0;
         this.visible = false;
         this.IMAGE_WIDTH = this.IMAGE_HEIGHT = 196;
         this.SCALE = Utils.SCREEN_HEIGHT / (this.IMAGE_HEIGHT + 64);
         this.container1 = new Sprite();
         this.container2 = new Sprite();
         Utils.rootMovie.addChild(this.container2);
         Utils.rootMovie.addChild(this.container1);
         this.container2.visible = false;
         this.container1.scaleX = this.container1.scaleY = this.SCALE;
         this.initBackground();
         this.frameContainer = null;
         this.frameImages = null;
         this.frameButton = null;
      }
      
      public static function LoadCrossPromotion() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_CROSS_PROMOTION_SLOT] >= NeutronizedServices.getInstance().crossPromotionXML.slot.length)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_CROSS_PROMOTION_SLOT] = 0;
         }
         var now:Date = new Date();
         var hours:int = int(TimeSpan.fromDates(Utils.Slot.gameDate1,now).totalHours);
         if(hours >= 1)
         {
            Utils.Slot.gameDate1 = now;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_CROSS_PROMOTION_SLOT] = 0;
            SaveManager.SaveDate1();
         }
         if(NeutronizedServices.getInstance().crossPromotionXML.slot[Utils.Slot.gameVariables[GameSlot.VARIABLE_CROSS_PROMOTION_SLOT]].__packageName == "com.neutronized.SuperCatTales2")
         {
            ++Utils.Slot.gameVariables[GameSlot.VARIABLE_CROSS_PROMOTION_SLOT];
         }
         var url:URLRequest = new URLRequest(NeutronizedServices.getInstance().crossPromotionXML.slot[Utils.Slot.gameVariables[GameSlot.VARIABLE_CROSS_PROMOTION_SLOT]].__image);
         linkString = NeutronizedServices.getInstance().crossPromotionXML.slot[Utils.Slot.gameVariables[GameSlot.VARIABLE_CROSS_PROMOTION_SLOT]].__url;
         if(!DO_NOT_INCREASE_SLOT)
         {
            ++Utils.Slot.gameVariables[GameSlot.VARIABLE_CROSS_PROMOTION_SLOT];
            SaveManager.SaveGameVariables();
         }
         var img:Loader = new Loader();
         img.load(url);
         img.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE,loadedStat);
         img.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorLoadingStat);
      }
      
      protected static function loadedStat(e:flash.events.Event) : void
      {
         ERROR_LOADING = false;
         IMAGE_LOADED = true;
         var bitmap:Bitmap = e.target.content;
         bannerImage = new Image(Texture.fromBitmap(Bitmap(e.target.content)));
         bannerImage.textureSmoothing = TextureSmoothing.NONE;
         bannerImage.x = 8;
         bannerImage.y = 8;
      }
      
      protected static function errorLoadingStat(e:IOErrorEvent) : void
      {
         ERROR_LOADING = true;
         IMAGE_LOADED = false;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.container1.removeChild(this);
         this.container1.removeChild(this.frameContainer);
         this.container2.removeChild(this.backgroundQuad);
         this.backgroundQuad.destroy();
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
         Utils.rootMovie.removeChild(this.container1);
         this.container1.dispose();
         this.container1 = null;
         Utils.rootMovie.removeChild(this.container2);
         this.container2.dispose();
         this.container2 = null;
         if(this.visible)
         {
            Utils.rootMovie.removeChild(this);
         }
         if(bannerImage != null)
         {
            bannerImage.removeEventListener(TouchEvent.TOUCH,this.touchImageHandler);
         }
         if(this.frameButton != null)
         {
            this.frameButton.removeEventListener(starling.events.Event.TRIGGERED,this.getOutHandler);
         }
         if(this.frameContainer != null)
         {
            for(i = 0; i < this.frameImages.length; i++)
            {
               this.frameContainer.removeChild(this.frameImages[i]);
               this.frameImages[i].dispose();
               this.frameImages[i] = null;
            }
            this.frameImages = null;
            this.frameContainer.removeChild(this.frameButton);
            this.frameButton.dispose();
            this.frameButton = null;
            this.frameContainer.removeChild(bannerImage);
            bannerImage.dispose();
            bannerImage = null;
            removeChild(this.frameContainer);
            this.frameContainer.dispose();
            this.frameContainer = null;
         }
      }
      
      protected function getOutHandler(event:starling.events.Event) : void
      {
         SoundSystem.PlaySound("select");
         this.enableButtons(false);
         this.popOut();
      }
      
      public function touchImageHandler(event:TouchEvent) : void
      {
         var touches:Vector.<Touch> = event.getTouches(Utils.rootStage);
         if(touches[touches.length - 1].phase == "ended")
         {
            SoundSystem.PlaySound("select");
            if(linkString != "")
            {
               navigateToURL(new URLRequest(linkString));
            }
            this.enableButtons(false);
            this.popOut();
         }
      }
      
      public function quitPanel() : void
      {
         this.enableButtons(false);
         this.popOut();
      }
      
      public function update() : void
      {
         var wait_amount:int = 0;
         var alpha_amount:Number = NaN;
         if(this.pausePanelEntering)
         {
            wait_amount = 3;
            alpha_amount = 0.2;
            this.container2.visible = true;
            ++this.counter_1;
            if(this.counter_1 > wait_amount)
            {
               this.counter_1 = 0;
               this.backgroundQuad.alpha += alpha_amount;
               if(this.backgroundQuad.alpha >= 1)
               {
                  this.backgroundQuad.alpha = 1;
                  this.popUpComplete();
               }
            }
         }
         else if(this.pausePanelExiting)
         {
            ++this.counter_1;
            if(this.counter_1 > 6)
            {
               this.counter_1 = 0;
               this.backgroundQuad.alpha -= 0.5;
               if(this.frameContainer != null)
               {
                  this.frameContainer.alpha = this.backgroundQuad.alpha;
               }
               if(this.backgroundQuad.alpha <= 0)
               {
                  if(this.frameContainer != null)
                  {
                     this.frameContainer.alpha = 0;
                  }
                  this.backgroundQuad.alpha = 0;
               }
            }
            this.popOutComplete();
         }
         this.backgroundQuad.update();
      }
      
      protected function enableButtons(value:Boolean) : void
      {
         if(this.frameContainer != null)
         {
            this.frameContainer.touchable = false;
         }
         if(this.frameButton != null)
         {
            this.frameButton.touchable = false;
         }
      }
      
      public function popUp() : void
      {
         var i:int = 0;
         var tween:Tween = null;
         this.GET_OUT_FLAG = false;
         this.CONTINUE_FLAG = false;
         this.pausePanelEntering = true;
         this.pausePanelExiting = false;
         this.pausePanelStaying = false;
         this.counter_1 = 0;
         this.counter_2 = 0;
         this.container1.addChild(this);
         this.visible = true;
         this.backgroundQuad.alpha = 0;
         this.loadURLImage();
      }
      
      protected function loadURLImage() : void
      {
         if(IMAGE_LOADED)
         {
            this.IMAGE_WIDTH = bannerImage.width;
            this.IMAGE_HEIGHT = bannerImage.height;
            this.SCALE = Utils.SCREEN_HEIGHT / (this.IMAGE_HEIGHT + 64);
            this.container1.scaleX = this.container1.scaleY = this.SCALE;
            this.initFrame();
            this.frameContainer.addChild(bannerImage);
            this.frameContainer.setChildIndex(bannerImage,0);
            this.frameContainer.x = int((Utils.SCREEN_WIDTH / this.SCALE - this.frameContainer.width) * 0.5);
            this.frameContainer.y = int((Utils.SCREEN_HEIGHT / this.SCALE - this.frameContainer.height) * 0.5);
            bannerImage.addEventListener(TouchEvent.TOUCH,this.touchImageHandler);
         }
      }
      
      protected function popOut() : void
      {
         var tween:Tween = null;
         this.pausePanelEntering = false;
         this.pausePanelExiting = true;
         this.pausePanelStaying = false;
         this.counter_1 = this.counter_2 = 0;
      }
      
      protected function popUpComplete() : void
      {
         this.pausePanelEntering = false;
         this.pausePanelStaying = true;
      }
      
      protected function popOutComplete() : void
      {
         this.pausePanelExiting = false;
         this.GET_OUT_FLAG = true;
      }
      
      public function hide() : void
      {
         Utils.rootMovie.removeChild(this);
         this.visible = false;
      }
      
      protected function initBackground() : void
      {
         this.backgroundQuad = new MenuBackgroundPortable();
         this.backgroundQuad.x = 0;
         this.backgroundQuad.y = 0;
         this.container2.addChild(this.backgroundQuad);
      }
      
      protected function initFrame() : void
      {
         var image:Image = null;
         var WIDTH:int = this.IMAGE_WIDTH + 16;
         var HEIGHT:int = this.IMAGE_HEIGHT + 16;
         this.frameContainer = new Sprite();
         this.container1.addChild(this.frameContainer);
         this.frameImages = new Vector.<Image>();
         image = new Image(TextureManager.hudTextureAtlas.getTexture("cross_promotion_side_1"));
         image.touchable = false;
         image.textureSmoothing = TextureSmoothing.NONE;
         image.x = 0;
         image.y = 0;
         this.frameContainer.addChild(image);
         this.frameImages.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("cross_promotion_side_2"));
         image.touchable = false;
         image.textureSmoothing = TextureSmoothing.NONE;
         image.x = 10;
         image.y = 0;
         image.width = WIDTH - 10;
         this.frameContainer.addChild(image);
         this.frameImages.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("cross_promotion_side_3"));
         image.touchable = false;
         image.textureSmoothing = TextureSmoothing.NONE;
         image.x = WIDTH - 10;
         image.y = 0;
         image.height = HEIGHT - 10;
         this.frameContainer.addChild(image);
         this.frameImages.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("cross_promotion_side_4"));
         image.touchable = false;
         image.textureSmoothing = TextureSmoothing.NONE;
         image.x = WIDTH - 10;
         image.y = HEIGHT - 10;
         this.frameContainer.addChild(image);
         this.frameImages.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("cross_promotion_side_5"));
         image.touchable = false;
         image.textureSmoothing = TextureSmoothing.NONE;
         image.x = 10;
         image.y = HEIGHT - 10;
         image.width = WIDTH - 20;
         this.frameContainer.addChild(image);
         this.frameImages.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("cross_promotion_side_6"));
         image.touchable = false;
         image.textureSmoothing = TextureSmoothing.NONE;
         image.x = 0;
         image.y = HEIGHT - 10;
         this.frameContainer.addChild(image);
         this.frameImages.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("cross_promotion_side_7"));
         image.touchable = false;
         image.textureSmoothing = TextureSmoothing.NONE;
         image.x = 0;
         image.y = 10;
         image.height = HEIGHT - 20;
         this.frameContainer.addChild(image);
         this.frameImages.push(image);
         this.frameButton = new Button(TextureManager.hudTextureAtlas.getTexture("hud_close_button_1"),"",TextureManager.hudTextureAtlas.getTexture("hud_close_button_2"));
         Image(Sprite(this.frameButton.getChildAt(0)).getChildAt(0)).textureSmoothing = TextureSmoothing.NONE;
         this.frameButton.x = WIDTH - 5 - this.frameButton.width * 0.6;
         this.frameButton.y = 0 + 5 - this.frameButton.height * 0.4;
         this.frameContainer.addChild(this.frameButton);
         this.frameButton.addEventListener(starling.events.Event.TRIGGERED,this.getOutHandler);
      }
   }
}
