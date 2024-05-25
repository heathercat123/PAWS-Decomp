package interfaces
{
   import entities.Easings;
   import interfaces.dialogs.DialogsManager;
   import interfaces.texts.GameText;
   import interfaces.unlocks.CatUnlocksManager;
   import levels.Level;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Hud
   {
      
      public static var SET_HUD_INVISIBLE:Boolean = false;
       
      
      public var level:Level;
      
      public var dialogsManager:DialogsManager;
      
      public var catUnlockManager:CatUnlocksManager;
      
      protected var topBar:Image;
      
      protected var bottomBar:Image;
      
      protected var BAR_HEIGHT:int;
      
      public var MOVE_IN_FLAG:Boolean;
      
      public var MOVE_OUT_FLAG:Boolean;
      
      public var top_container:Sprite;
      
      protected var container:Sprite;
      
      public var t_time:Number;
      
      public var t_tick:Number;
      
      public var darkFade:Image;
      
      protected var whiteFade:Image;
      
      public var IS_DARK_FADE_SHOWING:Boolean;
      
      public var IS_DARK_FADE_HIDING:Boolean;
      
      public var IS_DARK_FADE_ON:Boolean;
      
      public var dark_fade_counter1:int;
      
      public var dark_fade_counter2:int;
      
      public var dark_fade_time_unit:Number;
      
      public var IS_WHITE_FADE_SHOWING:Boolean;
      
      public var IS_WHITE_FADE_HIDING:Boolean;
      
      public var white_fade_counter1:int;
      
      public var white_fade_counter2:int;
      
      public var white_fade_time_unit:Number;
      
      protected var ALLOW_CONTINUE_TEXT:Boolean;
      
      protected var continueText:GameText;
      
      protected var continue_timer:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      public function Hud(_level:Level)
      {
         super();
         this.level = _level;
         this.dialogsManager = new DialogsManager(this.level);
         this.catUnlockManager = new CatUnlocksManager(this.level);
         this.initBackground();
         this.initCutsceneElements();
         this.initFade();
         this.ALLOW_CONTINUE_TEXT = true;
         this.continue_timer = -1;
         this.counter_1 = this.counter_2 = 0;
         this.IS_DARK_FADE_SHOWING = this.IS_DARK_FADE_HIDING = this.IS_WHITE_FADE_SHOWING = this.IS_WHITE_FADE_HIDING = this.IS_DARK_FADE_ON = false;
         this.dark_fade_counter1 = this.dark_fade_counter2 = this.dark_fade_time_unit = this.white_fade_counter1 = this.white_fade_counter2 = this.white_fade_time_unit = 0;
         this.MOVE_IN_FLAG = false;
         this.MOVE_OUT_FLAG = false;
         this.top_container.setChildIndex(this.continueText,this.top_container.numChildren - 1);
      }
      
      public function destroy() : void
      {
         this.level = null;
         this.container.removeChild(this.topBar);
         this.container.removeChild(this.bottomBar);
         this.top_container.removeChild(this.continueText);
         this.topBar.dispose();
         this.bottomBar.dispose();
         this.continueText.destroy();
         this.continueText.dispose();
         this.topBar = null;
         this.bottomBar = null;
         this.continueText = null;
         this.catUnlockManager.destroy();
         this.catUnlockManager = null;
         this.dialogsManager.destroy();
         this.dialogsManager = null;
         this.top_container.removeChild(this.darkFade);
         this.darkFade.dispose();
         this.darkFade = null;
         this.top_container.removeChild(this.whiteFade);
         this.whiteFade.dispose();
         this.whiteFade = null;
         Utils.rootMovie.removeChild(this.container);
         this.container.dispose();
         this.container = null;
         Utils.rootMovie.removeChild(this.top_container);
         this.top_container.dispose();
         this.top_container = null;
      }
      
      public function update() : void
      {
         if(this.IS_DARK_FADE_SHOWING)
         {
            ++this.dark_fade_counter1;
            if(this.dark_fade_counter1 >= this.dark_fade_time_unit)
            {
               this.dark_fade_counter1 = 0;
               this.darkFade.alpha += 0.1;
               if(this.darkFade.alpha >= 1)
               {
                  this.IS_DARK_FADE_SHOWING = false;
                  this.darkFade.alpha = 1;
               }
            }
         }
         else if(this.IS_DARK_FADE_HIDING)
         {
            ++this.dark_fade_counter1;
            if(this.dark_fade_counter1 >= this.dark_fade_time_unit)
            {
               this.dark_fade_counter1 = 0;
               this.darkFade.alpha -= 0.1;
               if(this.darkFade.alpha <= 0)
               {
                  this.IS_DARK_FADE_ON = false;
                  this.IS_DARK_FADE_HIDING = false;
                  this.darkFade.alpha = 0;
               }
            }
         }
         if(this.IS_WHITE_FADE_SHOWING)
         {
            ++this.white_fade_counter1;
            if(this.white_fade_counter1 >= this.white_fade_time_unit)
            {
               this.white_fade_counter1 = 0;
               this.whiteFade.alpha += 0.1;
               if(this.whiteFade.alpha >= 1)
               {
                  this.IS_WHITE_FADE_SHOWING = false;
                  this.whiteFade.alpha = 1;
               }
            }
         }
         else if(this.IS_WHITE_FADE_HIDING)
         {
            ++this.white_fade_counter1;
            if(this.white_fade_counter1 >= this.white_fade_time_unit)
            {
               this.white_fade_counter1 = 0;
               this.whiteFade.alpha -= 0.1;
               if(this.whiteFade.alpha <= 0)
               {
                  this.IS_WHITE_FADE_HIDING = false;
                  this.whiteFade.alpha = 0;
               }
            }
         }
         if(this.MOVE_IN_FLAG)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               this.MOVE_IN_FLAG = false;
            }
            this.topBar.y = int(Math.floor(Easings.linear(this.t_tick,-this.BAR_HEIGHT,this.BAR_HEIGHT,this.t_time)));
            this.bottomBar.y = int(Math.floor(Easings.linear(this.t_tick,Utils.HEIGHT,-this.BAR_HEIGHT,this.t_time)));
         }
         else if(this.MOVE_OUT_FLAG)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               this.MOVE_OUT_FLAG = false;
               this.topBar.visible = false;
               this.bottomBar.visible = false;
            }
            this.topBar.y = int(Math.floor(Easings.linear(this.t_tick,0,-this.BAR_HEIGHT,this.t_time)));
            this.bottomBar.y = int(Math.floor(Easings.linear(this.t_tick,Utils.HEIGHT - this.BAR_HEIGHT,this.BAR_HEIGHT,this.t_time)));
         }
         if(this.continue_timer >= 0 && this.ALLOW_CONTINUE_TEXT)
         {
            ++this.continue_timer;
            if(this.continue_timer >= 240)
            {
               ++this.counter_1;
               if(this.counter_1 <= 30)
               {
                  this.continueText.visible = true;
               }
               else if(this.counter_1 > 30 && this.counter_1 <= 40)
               {
                  this.continueText.visible = false;
               }
               else if(this.counter_1 > 40)
               {
                  this.counter_1 = 0;
               }
            }
         }
         this.dialogsManager.update();
         this.dialogsManager.updateScreenPositions(this.level.camera);
         this.catUnlockManager.update();
         Utils.rootMovie.setChildIndex(this.top_container,Utils.rootMovie.numChildren - 1);
      }
      
      public function setCutsceneBarsVisible(_value:Boolean) : void
      {
         this.topBar.visible = _value;
         this.bottomBar.visible = _value;
      }
      
      public function setContinueTextDisplayable(_value:Boolean) : void
      {
         this.ALLOW_CONTINUE_TEXT = _value;
      }
      
      public function startCutscene() : void
      {
         this.MOVE_IN_FLAG = true;
         this.t_tick = 0;
         this.t_time = 0.25;
         this.topBar.visible = this.bottomBar.visible = true;
         this.topBar.y = -this.topBar.height;
         this.bottomBar.y = Utils.HEIGHT;
         this.continue_timer = -1;
         this.counter_1 = this.counter_2 = 0;
      }
      
      public function endCutscene() : void
      {
         this.MOVE_OUT_FLAG = true;
         this.t_tick = 0;
         this.t_time = 0.25;
      }
      
      public function resetCutsceneContinueTimer() : void
      {
         this.continue_timer = this.counter_1 = this.counter_2 = 0;
      }
      
      public function endContinue() : void
      {
         this.continue_timer = -1;
         this.counter_1 = this.counter_2 = 0;
         this.continueText.visible = false;
      }
      
      public function showDarkFade(_time:int) : void
      {
         this.IS_DARK_FADE_ON = true;
         this.IS_DARK_FADE_SHOWING = false;
         this.IS_DARK_FADE_HIDING = false;
         this.dark_fade_counter1 = this.dark_fade_counter2 = 0;
         if(_time <= 0)
         {
            this.darkFade.visible = true;
            this.darkFade.alpha = 1;
         }
         else
         {
            this.IS_DARK_FADE_SHOWING = true;
            this.darkFade.visible = true;
            this.darkFade.alpha = 0;
            this.dark_fade_time_unit = int(_time / 10);
         }
      }
      
      public function hideDarkFade(_time:int) : void
      {
         this.IS_DARK_FADE_SHOWING = false;
         this.IS_DARK_FADE_HIDING = false;
         this.dark_fade_counter1 = this.dark_fade_counter2 = 0;
         if(_time <= 0)
         {
            this.IS_DARK_FADE_ON = false;
            this.darkFade.visible = false;
            this.darkFade.alpha = 0;
         }
         else
         {
            this.IS_DARK_FADE_HIDING = true;
            this.darkFade.visible = true;
            this.darkFade.alpha = 1;
            this.dark_fade_time_unit = int(_time / 5);
         }
      }
      
      public function showWhiteFade(_time:int) : void
      {
         this.IS_WHITE_FADE_SHOWING = false;
         this.IS_WHITE_FADE_HIDING = false;
         this.white_fade_counter1 = this.white_fade_counter2 = 0;
         if(_time <= 0)
         {
            this.whiteFade.visible = true;
            this.whiteFade.alpha = 1;
         }
         else
         {
            this.IS_WHITE_FADE_SHOWING = true;
            this.whiteFade.visible = true;
            this.whiteFade.alpha = 0;
            this.white_fade_time_unit = int(_time / 10);
         }
      }
      
      public function hideWhiteFade(_time:int) : void
      {
         this.IS_WHITE_FADE_SHOWING = false;
         this.IS_WHITE_FADE_HIDING = false;
         this.white_fade_counter1 = this.dark_fade_counter2 = 0;
         if(_time <= 0)
         {
            this.whiteFade.visible = false;
            this.whiteFade.alpha = 0;
         }
         else
         {
            this.IS_WHITE_FADE_HIDING = true;
            this.whiteFade.visible = true;
            this.whiteFade.alpha = 1;
            this.white_fade_time_unit = int(_time / 5);
         }
      }
      
      public function hideHud() : void
      {
      }
      
      public function unHideHud() : void
      {
      }
      
      protected function updateDigits() : void
      {
      }
      
      public function onTop() : void
      {
      }
      
      protected function updatePoints() : void
      {
      }
      
      public function removeHeart() : void
      {
      }
      
      public function removeAllHearts() : void
      {
      }
      
      public function stopAllSprites() : void
      {
      }
      
      public function playAllSprites() : void
      {
      }
      
      protected function initBackground() : void
      {
         this.container = new Sprite();
         Utils.rootMovie.addChild(this.container);
         this.container.x = this.container.y = 0;
         this.top_container = new Sprite();
         Utils.rootMovie.addChild(this.top_container);
         this.top_container.x = this.top_container.y = 0;
         this.container.scaleX = this.container.scaleY = Utils.GFX_SCALE;
         this.top_container.scaleX = this.top_container.scaleY = Utils.GFX_SCALE;
      }
      
      protected function initCutsceneElements() : void
      {
         if(Utils.IS_IPHONE_X)
         {
            this.BAR_HEIGHT = 28;
         }
         else
         {
            this.BAR_HEIGHT = 26;
         }
         this.topBar = new Image(TextureManager.hudTextureAtlas.getTexture("blackQuad"));
         this.bottomBar = new Image(TextureManager.hudTextureAtlas.getTexture("blackQuad"));
         this.container.addChild(this.topBar);
         this.container.addChild(this.bottomBar);
         this.topBar.width = this.bottomBar.width = Utils.WIDTH;
         this.topBar.height = this.bottomBar.height = this.BAR_HEIGHT;
         this.topBar.visible = this.bottomBar.visible = false;
         this.continueText = new GameText(StringsManager.GetString("continue"),GameText.TYPE_SMALL_WHITE);
         this.top_container.addChild(this.continueText);
         this.continueText.pivotX = this.continueText.WIDTH;
         this.continueText.pivotY = this.continueText.HEIGHT;
         this.continueText.x = Utils.WIDTH - (4 + Utils.X_SCREEN_MARGIN);
         if(Utils.IS_IPHONE_X)
         {
            this.continueText.y = Utils.HEIGHT - (8 + Utils.Y_SCREEN_MARGIN);
         }
         else
         {
            this.continueText.y = Utils.HEIGHT - (4 + Utils.Y_SCREEN_MARGIN);
         }
         this.continueText.visible = false;
         this.topBar.y = -this.topBar.height;
         this.bottomBar.y = Utils.HEIGHT;
      }
      
      protected function initFade() : void
      {
         this.darkFade = new Image(TextureManager.hudTextureAtlas.getTexture("blackQuad"));
         this.darkFade.touchable = false;
         this.top_container.addChild(this.darkFade);
         this.darkFade.x = this.darkFade.y = 0;
         this.darkFade.width = Utils.WIDTH;
         this.darkFade.height = Utils.HEIGHT;
         this.darkFade.visible = false;
         this.darkFade.alpha = 0;
         this.whiteFade = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         this.whiteFade.touchable = false;
         this.top_container.addChild(this.whiteFade);
         this.whiteFade.x = this.whiteFade.y = 0;
         this.whiteFade.width = Utils.WIDTH;
         this.whiteFade.height = Utils.HEIGHT;
         this.whiteFade.visible = false;
         this.whiteFade.alpha = 0;
      }
   }
}
