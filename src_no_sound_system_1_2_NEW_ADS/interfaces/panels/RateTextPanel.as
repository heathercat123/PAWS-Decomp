package interfaces.panels
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import interfaces.buttons.BigTextButton;
   import interfaces.texts.GameText;
   import interfaces.texts.GameTextArea;
   import sprites.GameSprite;
   import sprites.hud.RateStarHudSprite;
   import starling.display.Button;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class RateTextPanel extends Sprite
   {
       
      
      protected var bluePanel:BluePanel;
      
      protected var golden_cat_text:GameTextArea;
      
      protected var mid_x:int;
      
      protected var bottom_mid_y:int;
      
      protected var top_mid_y:int;
      
      protected var WIDTH:int;
      
      protected var HEIGHT:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var yesButton:BigTextButton;
      
      protected var noButton:BigTextButton;
      
      public var CONTINUE_FLAG:Boolean;
      
      public var QUIT_FLAG:Boolean;
      
      protected var stars:Array;
      
      protected var RATE_VALUE:int;
      
      protected var touchArea:Rectangle;
      
      public function RateTextPanel(_width:int, _height:int)
      {
         super();
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.RATE_VALUE = 0;
         this.mid_x = int(this.WIDTH * 0.5);
         this.bottom_mid_y = int(this.HEIGHT * 0.75);
         this.top_mid_y = int(this.HEIGHT * 0.25);
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT);
         addChild(this.bluePanel);
         this.initText();
         this.initImage();
         this.yesButton.allowTouch(false);
         this.yesButton.addEventListener(Event.TRIGGERED,this.onExitClick);
         this.noButton.addEventListener(Event.TRIGGERED,this.onExitClick);
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onTouchStars);
         this.CONTINUE_FLAG = false;
         this.QUIT_FLAG = false;
      }
      
      protected function onExitClick(event:Event) : void
      {
         var url:URLRequest = null;
         var button:Button = event.target as Button;
         if(button.name == "yes")
         {
            this.CONTINUE_FLAG = false;
            this.QUIT_FLAG = true;
            if(this.RATE_VALUE > 3)
            {
               if(Utils.IS_ANDROID)
               {
                  url = new URLRequest("https://play.google.com/store/apps/details?id=com.neutronized.supercattalespaws");
               }
               else
               {
                  url = new URLRequest("itms-apps://itunes.apple.com/app/id1621279892");
               }
               navigateToURL(url,"_blank");
            }
            else
            {
               if(Utils.IS_ANDROID)
               {
                  url = new URLRequest("mailto:support@neutronized.com?subject=Feedback: Super Cat Tales: PAWS - Android, ver " + Utils.ANDROID_VERSION_STRING + ", rate " + this.RATE_VALUE);
               }
               else
               {
                  url = new URLRequest("mailto:support@neutronized.com?subject=Feedback: Super Cat Tales: PAWS - Apple, ver " + Utils.VERSION_STRING + ", rate " + this.RATE_VALUE);
               }
               navigateToURL(url,"_blank");
            }
         }
         else
         {
            this.CONTINUE_FLAG = true;
            this.QUIT_FLAG = false;
         }
      }
      
      public function onTouchStars(event:TouchEvent) : void
      {
         var i:int = 0;
         if(!this.visible)
         {
            return;
         }
         if(!Utils.RateOn)
         {
            return;
         }
         if(event.target is Button)
         {
            return;
         }
         var touches:Vector.<Touch> = event.getTouches(Utils.rootStage);
         var previousPosition:Point = touches[touches.length - 1].getPreviousLocation(Utils.rootStage);
         var position:Point = touches[touches.length - 1].getLocation(Utils.rootStage);
         var localPos:Point = touches[touches.length - 1].getLocation(this);
         if(touches[touches.length - 1].phase == "began")
         {
            if(this.touchArea.containsPoint(localPos))
            {
               SoundSystem.PlaySound("select");
               for(i = 0; i < this.stars.length; i++)
               {
                  this.stars[i].gfxHandleClip().gotoAndStop(1);
               }
               this.RATE_VALUE = 0;
               for(i = 0; i < this.stars.length; i++)
               {
                  if(localPos.x > this.stars[i].x - 16)
                  {
                     ++this.RATE_VALUE;
                     this.stars[i].gfxHandleClip().gotoAndStop(2);
                  }
               }
            }
            if(this.RATE_VALUE >= 1)
            {
               this.yesButton.allowTouch(true);
            }
            else
            {
               this.yesButton.allowTouch(false);
            }
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onTouchStars);
         this.touchArea = null;
         for(i = 0; i < this.stars.length; i++)
         {
            removeChild(this.stars[i]);
            this.stars[i].destroy();
            this.stars[i].dispose();
            this.stars[i] = null;
         }
         this.stars = null;
         this.yesButton.removeEventListener(Event.TRIGGERED,this.onExitClick);
         this.noButton.removeEventListener(Event.TRIGGERED,this.onExitClick);
         removeChild(this.yesButton);
         this.yesButton.destroy();
         this.yesButton.dispose();
         this.yesButton = null;
         removeChild(this.noButton);
         this.noButton.destroy();
         this.noButton.dispose();
         this.noButton = null;
         removeChild(this.golden_cat_text);
         this.golden_cat_text.destroy();
         this.golden_cat_text.dispose();
         this.golden_cat_text = null;
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
      }
      
      public function resetValues() : void
      {
         this.CONTINUE_FLAG = false;
         this.QUIT_FLAG = false;
      }
      
      public function update() : void
      {
         var i:int = 0;
         this.golden_cat_text.x = int((this.WIDTH - this.golden_cat_text.AREA_WIDTH) * 0.5);
         if(Utils.EnableFontStrings)
         {
            this.golden_cat_text.x = int((this.WIDTH - this.golden_cat_text.WIDTH) * 0.5);
         }
         this.golden_cat_text.y = int(this.HEIGHT * 0.1);
         for(i = 0; i < this.stars.length; i++)
         {
            this.stars[i].updateScreenPosition();
         }
      }
      
      protected function initText() : void
      {
         this.golden_cat_text = new GameTextArea(StringsManager.GetString("rate_android_4"),GameText.TYPE_SMALL_WHITE,this.WIDTH - 48,128,true);
         addChild(this.golden_cat_text);
         this.noButton = new BigTextButton((this.WIDTH - 36) * 0.3,this.HEIGHT * 0.4,StringsManager.GetString("no"));
         addChild(this.noButton);
         this.noButton.name = "no";
         this.noButton.x = int(12);
         this.noButton.y = int(this.HEIGHT - int(this.HEIGHT * 0.4 + 10));
         this.yesButton = new BigTextButton((this.WIDTH - 36) * 0.7,this.HEIGHT * 0.4,StringsManager.GetString("rate_android_5"));
         addChild(this.yesButton);
         this.yesButton.name = "yes";
         this.yesButton.x = int(24 + this.noButton.WIDTH);
         this.yesButton.y = int(this.HEIGHT - int(this.HEIGHT * 0.4 + 10));
      }
      
      protected function initImage() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         this.stars = new Array();
         for(i = 0; i < 5; i++)
         {
            pSprite = new RateStarHudSprite();
            pSprite.gfxHandleClip().gotoAndStop(1);
            pSprite.name = "" + (i + 1);
            this.stars.push(pSprite);
            addChild(pSprite);
            pSprite.y = int(this.HEIGHT * 0.35);
            pSprite.x = int(this.WIDTH * 0.5 - 64 + i * 32);
         }
         this.touchArea = new Rectangle(this.stars[0].x - 32,this.stars[0].y - 20,224,40);
      }
   }
}
