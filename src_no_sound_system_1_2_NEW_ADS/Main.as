package
{
   import com.distriqt.extension.application.Application;
   import com.distriqt.extension.application.display.DisplayMode;
   import com.distriqt.extension.application.display.LayoutMode;
   import flash.desktop.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.system.*;
   import flash.utils.*;
   import game_utils.LevelTimer;
   import starling.core.Starling;
   
   public dynamic class Main extends MovieClip
   {
      
      public static var rootStage:Stage;
      
      private var myStarling:Starling;
      
      private var game:Game;
      
      public function Main()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         var viewport:Rectangle = null;
         var screenWidth:Number = NaN;
         var screenHeight:Number = NaN;
         var myOS:String = null;
         var myOSLowerCase:String = null;
         var screenRatio:Number = NaN;
         stage.quality = StageQuality.LOW;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_RIGHT;
         Utils.IS_BROWSER = false;
         Utils.DEBUG = false;
         Utils.LOW_RES = false;
         rootStage = stage;
         if(Capabilities.os.toLowerCase() == "windows 7" || Capabilities.os.toLowerCase() == "windows 10")
         {
            Utils.IS_ON_WINDOWS = true;
         }
         if(Utils.IS_ON_WINDOWS == false)
         {
            Application.service.setStage(Main.rootStage);
         }
         Application.service.display.setDisplayMode(DisplayMode.IMMERSIVE,LayoutMode.CUTOUT_SHORT_EDGES);
         Utils.IS_ANDROID = true;
         if(Utils.IS_BROWSER)
         {
            viewport = new Rectangle(0,0,640,480);
         }
         else
         {
            myOS = Capabilities.os;
            myOSLowerCase = myOS.toLowerCase();
            Utils.OS = myOSLowerCase;
            if(Utils.OS == "windows 7" || Utils.OS == "windows 10")
            {
               Utils.IS_ON_WINDOWS = true;
               screenWidth = stage.stageWidth;
               screenHeight = stage.stageHeight;
               Utils.MODEL = Utils.OS;
               Utils.LOW_RES = false;
               if(screenWidth == 812 && screenHeight == 375)
               {
                  Utils.IS_IPHONE_X = true;
               }
               else if(screenWidth == 896 && screenHeight == 414)
               {
                  Utils.IS_IPHONE_X = true;
               }
               else if(screenWidth == 1334 && screenHeight == 621)
               {
                  Utils.IS_IPHONE_X = true;
               }
               else if(screenWidth == 2016 && screenHeight == 931)
               {
                  Utils.IS_IPHONE_X = true;
               }
               else if(screenWidth == 1792 && screenHeight == 828)
               {
                  Utils.IS_IPHONE_X = true;
               }
               else if(screenWidth == 1344 && screenHeight == 621)
               {
                  Utils.IS_IPHONE_X = true;
               }
               else if(screenWidth == 1840 && screenHeight == 860)
               {
                  Utils.IS_IPHONE_X = true;
               }
               else if(screenWidth == 1024 && screenHeight == 768)
               {
                  Utils.IS_IPAD = true;
               }
            }
            else
            {
               screenWidth = stage.fullScreenWidth;
               screenHeight = stage.fullScreenHeight;
               screenWidth = Number(Screen.mainScreen.visibleBounds.width);
               if(Utils.IS_ON_WINDOWS == false)
               {
                  screenWidth = Number(Application.service.display.displayMetrics.screenWidth);
               }
               Utils.IS_ON_WINDOWS = false;
            }
            screenRatio = Number(screenWidth / screenHeight);
            Utils.ratio = screenRatio;
            Utils.__width = screenWidth;
            Utils.__height = screenHeight;
            viewport = new Rectangle(0,0,screenWidth,screenHeight);
         }
         if(Utils.IS_ON_WINDOWS == false)
         {
            Starling.multitouchEnabled = true;
         }
         this.myStarling = new Starling(Game,stage,viewport);
         this.myStarling.antiAliasing = 1;
         this.myStarling.simulateMultitouch = true;
         this.myStarling.stage.color = 2698291;
         this.myStarling.start();
         this.myStarling.skipUnchangedFrames = true;
         this.fetchLanguage();
         NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,this.activate);
         NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE,this.deactivate);
      }
      
      private function fetchLanguage() : void
      {
         Utils.Lang = "_en";
         var languageSettings:Array = Capabilities.languages;
         var locale:String = languageSettings[0].toString().toLowerCase();
         var __lang:String = "" + locale.charAt(0) + locale.charAt(1);
         var __sublang:String = "";
         if(locale.length >= 5)
         {
            __sublang = "" + locale.charAt(3) + locale.charAt(4);
            __sublang.toLocaleLowerCase();
         }
         if(__lang == "fr")
         {
            Utils.Lang = "_fr";
         }
         else if(__lang == "it")
         {
            Utils.Lang = "_it";
         }
         else if(__lang == "de")
         {
            Utils.Lang = "_de";
         }
         else if(__lang == "es")
         {
            Utils.Lang = "_es";
         }
         else if(__lang == "pt")
         {
            if(__sublang == "br")
            {
               Utils.Lang = "_pt";
            }
            else
            {
               Utils.Lang = "_pt";
            }
         }
         else if(__lang == "ru")
         {
            Utils.Lang = "_ru";
         }
         else
         {
            Utils.Lang = "_en";
         }
         Utils.EnableFontStrings = false;
         Utils.IsLanguageWithNoSpaces = false;
      }
      
      private function keyHandler(event:KeyboardEvent) : void
      {
      }
      
      protected function activate(e:Event) : void
      {
         this.myStarling.start();
         if(Utils.IS_ANDROID)
         {
            SoundSystem.PlayLastMusic(true);
         }
      }
      
      protected function deactivate(e:Event) : void
      {
         this.myStarling.stop();
         if(!Utils.PauseOn && !Utils.FreezeOn && !Utils.CatOn && !Utils.RateOn && !Utils.ShopOn && !Utils.HelperOn && !Utils.GameOverOn && !Utils.GateUnlockOn && !Utils.PremiumOn && !Utils.QuestOn && !Utils.QuestAvailablePanelOn && !Utils.DoubleCoinsOn)
         {
            Utils.CheckPause = true;
            LevelTimer.getInstance().startPause();
         }
         if(Utils.IS_ANDROID)
         {
            SoundSystem.StopMusic(true,true);
         }
      }
      
      private function getWords(_string:String, _index:int) : String
      {
         var array:Array = _string.split(" ");
         return array[_index];
      }
      
      private function getIOSWords(_string:String, _index:int) : String
      {
         var array:Array = _string.split(",");
         return array[_index];
      }
      
      internal function focusHandler(event:Event) : void
      {
         trace("focus = " + event.type);
      }
   }
}

