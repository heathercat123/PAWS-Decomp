package interfaces.panels
{
   import game_utils.GameSlot;
   import game_utils.QuestsManager;
   import game_utils.SaveManager;
   import interfaces.texts.GameText;
   import interfaces.texts.GameTextArea;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Button;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class QuestPanel extends Sprite
   {
       
      
      public var GET_OUT_FLAG:Boolean;
      
      public var CONTINUE_FLAG:Boolean;
      
      public var QUIT_FLAG:Boolean;
      
      public var REPEAT_FLAG:Boolean;
      
      public var pausePanelEntering:Boolean;
      
      public var pausePanelExiting:Boolean;
      
      public var pausePanelStaying:Boolean;
      
      public var backgroundQuad:Quad;
      
      public var container:Sprite;
      
      protected var notepadContainer:Sprite;
      
      protected var notepadImages:Vector.<Image>;
      
      public var backButton:Button;
      
      protected var titleText:GameText;
      
      protected var descriptionText:GameTextArea;
      
      protected var nextQuestText:GameText;
      
      protected var winningStreakText:GameText;
      
      protected var progressionBar:QuestProgressionBarPanel;
      
      public var counter:int;
      
      protected var body_percentage:Number;
      
      protected var column_percentage:Number;
      
      protected var inner_margin_percentage:Number;
      
      protected var body_height_percentage:Number;
      
      protected var body_width:int;
      
      protected var body_height:int;
      
      protected var column_width:int;
      
      protected var button_height:int;
      
      protected var inner_margin:int;
      
      protected var outer_x_margin:int;
      
      protected var outer_y_margin:int;
      
      protected var sin_counter_1:Number;
      
      protected var sin_counter_2:Number;
      
      protected var sin_counter_3:Number;
      
      protected var sin_counter_4:Number;
      
      protected var sin_speed_1:Number;
      
      protected var sin_speed_2:Number;
      
      protected var sin_speed_3:Number;
      
      protected var sin_speed_4:Number;
      
      protected var fade_counter_1:int;
      
      protected var fade_counter_2:int;
      
      protected var fade_counter_3:int;
      
      protected var is_timer_visible:Boolean;
      
      protected var clock_image_1:Image;
      
      protected var clock_image_2:Image;
      
      public var TYPE:int;
      
      public function QuestPanel(type:int = 0)
      {
         super();
         this.GET_OUT_FLAG = false;
         this.CONTINUE_FLAG = false;
         this.QUIT_FLAG = false;
         this.REPEAT_FLAG = false;
         this.sin_counter_1 = Math.random() * Math.PI * 2;
         this.sin_counter_2 = Math.random() * Math.PI * 2;
         this.sin_counter_3 = Math.random() * Math.PI * 2;
         this.sin_counter_4 = Math.random() * Math.PI * 2;
         this.sin_speed_1 = Math.random() * 0.025 + 0.025;
         this.sin_speed_2 = Math.random() * 0.025 + 0.025;
         this.sin_speed_3 = Math.random() * 0.025 + 0.025;
         this.sin_speed_4 = Math.random() * 0.025 + 0.025;
         this.pausePanelEntering = false;
         this.pausePanelExiting = false;
         this.pausePanelStaying = false;
         this.is_timer_visible = true;
         this.fade_counter_1 = this.fade_counter_2 = this.fade_counter_3 = 0;
         this.counter = 0;
         this.TYPE = type;
         this.visible = false;
         this.scaleX = this.scaleY = Utils.GFX_SCALE;
         this.evaluatePercentages();
         this.initBackground();
         this.container = new Sprite();
         this.container.x = 0;
         this.container.y = Utils.HEIGHT;
         addChild(this.container);
         this.initBluePanel();
         this.initText();
         this.initButtons();
         this.backButton.addEventListener(Event.TRIGGERED,this.clickHandler);
      }
      
      public function backButtonAndroid() : void
      {
         this.quitPanel();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         if(this.visible)
         {
            Utils.rootMovie.removeChild(this);
         }
         this.backButton.removeEventListener(Event.TRIGGERED,this.clickHandler);
         this.container.removeChild(this.backButton);
         this.backButton.dispose();
         this.backButton = null;
         this.notepadContainer.removeChild(this.progressionBar);
         this.progressionBar.destroy();
         this.progressionBar.dispose();
         this.progressionBar = null;
         this.notepadContainer.removeChild(this.winningStreakText);
         this.winningStreakText.destroy();
         this.winningStreakText.dispose();
         this.winningStreakText = null;
         this.notepadContainer.removeChild(this.nextQuestText);
         this.nextQuestText.destroy();
         this.nextQuestText.dispose();
         this.nextQuestText = null;
         this.notepadContainer.removeChild(this.descriptionText);
         this.descriptionText.destroy();
         this.descriptionText.dispose();
         this.descriptionText = null;
         for(i = 0; i < this.notepadImages.length; i++)
         {
            this.notepadContainer.removeChild(this.notepadImages[i]);
            this.notepadImages[i].dispose();
            this.notepadImages[i] = null;
         }
         this.notepadImages = null;
         this.notepadContainer.removeChild(this.titleText);
         this.titleText.destroy();
         this.titleText.dispose();
         this.titleText = null;
         this.container.removeChild(this.notepadContainer);
         this.notepadContainer.dispose();
         this.notepadContainer = null;
         removeChild(this.container);
         this.container.dispose();
         this.container = null;
         removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
      }
      
      public function update() : void
      {
         this.updateTimeText();
         this.progressionBar.update();
         ++this.fade_counter_1;
         if(this.fade_counter_1 == 120)
         {
            if(this.is_timer_visible)
            {
               this.winningStreakText.visible = true;
               this.winningStreakText.alpha = 0;
            }
            else
            {
               this.nextQuestText.visible = true;
               this.nextQuestText.alpha = 0;
               this.clock_image_1.visible = this.clock_image_2.visible = this.nextQuestText.visible;
               this.clock_image_1.alpha = this.clock_image_2.alpha = this.nextQuestText.alpha;
            }
         }
         else if(this.fade_counter_1 > 120)
         {
            if(this.fade_counter_2++ > 3)
            {
               this.fade_counter_2 = 0;
               if(this.is_timer_visible)
               {
                  this.nextQuestText.alpha -= 0.3;
                  this.clock_image_1.alpha = this.clock_image_2.alpha = this.nextQuestText.alpha;
                  this.winningStreakText.alpha += 0.3;
                  if(this.winningStreakText.alpha >= 1)
                  {
                     this.is_timer_visible = false;
                     this.winningStreakText.alpha = 1;
                     this.nextQuestText.visible = false;
                     this.clock_image_1.visible = this.clock_image_2.visible = this.nextQuestText.visible;
                     this.fade_counter_1 = -60;
                  }
               }
               else
               {
                  this.nextQuestText.alpha += 0.3;
                  this.clock_image_1.alpha = this.clock_image_2.alpha = this.nextQuestText.alpha;
                  this.winningStreakText.alpha -= 0.3;
                  if(this.nextQuestText.alpha >= 1)
                  {
                     this.is_timer_visible = true;
                     this.nextQuestText.alpha = 1;
                     this.clock_image_1.alpha = this.clock_image_2.alpha = this.nextQuestText.alpha;
                     this.winningStreakText.visible = true;
                     this.fade_counter_1 = -60;
                  }
               }
            }
         }
         this.sin_counter_1 += this.sin_speed_1;
         if(this.sin_counter_1 > Math.PI * 2)
         {
            this.sin_counter_1 -= Math.PI * 2;
            this.sin_speed_1 = Math.random() * 0.04 + 0.025;
         }
         this.sin_counter_2 += this.sin_speed_2;
         if(this.sin_counter_2 > Math.PI * 2)
         {
            this.sin_counter_2 -= Math.PI * 2;
            this.sin_speed_2 = Math.random() * 0.04 + 0.025;
         }
         this.sin_counter_3 += this.sin_speed_3;
         if(this.sin_counter_3 > Math.PI * 2)
         {
            this.sin_counter_3 -= Math.PI * 2;
            this.sin_speed_3 = Math.random() * 0.04 + 0.025;
         }
         this.sin_counter_4 += this.sin_speed_4;
         if(this.sin_counter_4 > Math.PI * 2)
         {
            this.sin_counter_4 -= Math.PI * 2;
            this.sin_speed_4 = Math.random() * 0.04 + 0.025;
         }
         this.backgroundQuad.setVertexColor(0,16773608);
         this.backgroundQuad.setVertexColor(1,16773608);
         this.backgroundQuad.setVertexColor(2,16773608);
         this.backgroundQuad.setVertexColor(3,16773608);
         this.backgroundQuad.setVertexAlpha(0,0.75 + Math.sin(this.sin_counter_1) * 0.25);
         this.backgroundQuad.setVertexAlpha(1,0.75 + Math.sin(this.sin_counter_2) * 0.25);
         this.backgroundQuad.setVertexAlpha(2,0.75 + Math.sin(this.sin_counter_3) * 0.25);
         this.backgroundQuad.setVertexAlpha(3,0.75 + Math.sin(this.sin_counter_4) * 0.25);
      }
      
      protected function clickHandler(event:Event) : void
      {
         if(this.pausePanelStaying)
         {
            if(DisplayObject(event.target).name == "quitButton")
            {
               this.quitPanel();
            }
         }
      }
      
      public function continuePanel() : void
      {
         if(this.CONTINUE_FLAG)
         {
            return;
         }
         if(Utils.IS_ON_WINDOWS)
         {
            this.unlockSuccessful();
            this.setButtonsTouchable(false);
         }
         else
         {
            this.setButtonsTouchable(false);
         }
      }
      
      protected function updateTimeText() : void
      {
         var hours_string:String = null;
         var minutes_string:String = null;
         var seconds_string:String = null;
         var now:Date = new Date();
         var hours:int = 24 - now.hours;
         var minutes:int = 60 - now.minutes;
         var seconds:int = 60 - now.seconds;
         if(seconds == 60)
         {
            seconds = 0;
         }
         else
         {
            minutes--;
         }
         if(minutes == 60)
         {
            minutes = 0;
         }
         else
         {
            hours--;
         }
         if(minutes < 0)
         {
            minutes = 0;
         }
         if(hours < 0)
         {
            hours = 0;
         }
         if(hours < 10)
         {
            hours_string = "0" + hours;
         }
         else
         {
            hours_string = "" + hours;
         }
         if(minutes < 10)
         {
            minutes_string = "0" + minutes;
         }
         else
         {
            minutes_string = "" + minutes;
         }
         if(seconds < 10)
         {
            seconds_string = "0" + seconds;
         }
         else
         {
            seconds_string = "" + seconds;
         }
         this.nextQuestText.updateText(StringsManager.GetString("quest_next_quest") + " " + hours_string + ":" + minutes_string + ":" + seconds_string);
         if(seconds % 2 != 0)
         {
            this.nextQuestText.setColonsInvisible();
         }
      }
      
      protected function unlockSuccessful() : void
      {
         SoundSystem.PlaySound("purchase");
         this.CONTINUE_FLAG = true;
         this.popOut();
      }
      
      public function quitPanel() : void
      {
         if(this.GET_OUT_FLAG)
         {
            return;
         }
         SoundSystem.PlaySound("selectBack");
         this.CONTINUE_FLAG = false;
         this.popOut();
         this.setButtonsTouchable(false);
      }
      
      public function popUp() : void
      {
         var i:int = 0;
         var tween:Tween = null;
         var targetY:int = 0;
         this.GET_OUT_FLAG = false;
         this.CONTINUE_FLAG = false;
         this.pausePanelEntering = true;
         this.pausePanelExiting = false;
         this.pausePanelStaying = false;
         this.counter = 0;
         Utils.rootMovie.addChild(this);
         this.visible = true;
         this.backgroundQuad.alpha = 0;
         this.backButton.touchable = false;
         tween = new Tween(this.backgroundQuad,0.25,Transitions.EASE_OUT);
         tween.fadeTo(0.8);
         Starling.juggler.add(tween);
         tween = new Tween(this.container,0.25,Transitions.EASE_OUT_BACK);
         tween.moveTo(0,int(Utils.HEIGHT * 0.2));
         tween.delay = 0;
         tween.roundToInt = true;
         Starling.juggler.add(tween);
         tween.onComplete = this.popUpComplete;
         this.progressionBar.updateAmount(Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_ACTION],QuestsManager.Quests[Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_INDEX]].amount);
         this.winningStreakText.updateText(StringsManager.GetString("quest_win_streak") + " " + Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STREAK]);
         this.winningStreakText.x = int((this.body_width - this.winningStreakText.WIDTH) * 0.5);
      }
      
      protected function popOut() : void
      {
         var tween:Tween = null;
         this.pausePanelEntering = false;
         this.pausePanelExiting = true;
         this.pausePanelStaying = false;
         this.counter = 0;
         tween = new Tween(this.backgroundQuad,0.15);
         tween.fadeTo(0);
         Starling.juggler.add(tween);
         tween = new Tween(this.container,0.15,Transitions.EASE_IN_BACK);
         tween.moveTo(0,int(Utils.HEIGHT));
         tween.delay = 0;
         tween.roundToInt = true;
         tween.onComplete = this.popOutComplete;
         Starling.juggler.add(tween);
      }
      
      protected function popUpComplete() : void
      {
         this.pausePanelEntering = false;
         this.pausePanelStaying = true;
         this.backButton.touchable = true;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS] == 0)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS] = 1;
            SaveManager.SaveQuestData();
         }
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
      
      protected function evaluatePercentages() : void
      {
         var WIDTH:int = int(Utils.SCREEN_WIDTH * Utils.GFX_INV_SCALE);
         var HEIGHT:int = int(Utils.SCREEN_HEIGHT * Utils.GFX_INV_SCALE);
         WIDTH -= Utils.X_SCREEN_MARGIN;
         HEIGHT -= Utils.Y_SCREEN_MARGIN;
         this.body_percentage = 0.58;
         this.column_percentage = 0.15;
         this.inner_margin_percentage = 0.15;
         if(int(WIDTH * this.column_percentage) < 40)
         {
            this.body_percentage = 0.56;
            this.column_percentage = 0.18;
            this.inner_margin_percentage = 0.12;
         }
         this.body_width = int(WIDTH * this.body_percentage);
         this.column_width = int(WIDTH * this.column_percentage);
         this.inner_margin = int(this.column_width * this.inner_margin_percentage);
         this.outer_x_margin = this.outer_y_margin = int((WIDTH - (this.body_width + this.column_width * 2 + this.inner_margin * 2)) * 0.5);
         this.outer_x_margin += int(Utils.X_SCREEN_MARGIN * 0.5);
         this.body_height = int(HEIGHT - this.outer_y_margin * 2);
         this.button_height = int((this.body_height - this.inner_margin * 2) / 3);
      }
      
      protected function initBackground() : void
      {
         this.backgroundQuad = new Quad(Utils.WIDTH,Utils.HEIGHT,16773608);
         this.backgroundQuad.width = Utils.WIDTH;
         this.backgroundQuad.height = Utils.HEIGHT;
         this.backgroundQuad.x = 0;
         this.backgroundQuad.y = 0;
         addChild(this.backgroundQuad);
      }
      
      protected function initButtons() : void
      {
         this.backButton = new Button(TextureManager.hudTextureAtlas.getTexture("hud_close_button_1"),"",TextureManager.hudTextureAtlas.getTexture("hud_close_button_2"));
         this.backButton.name = "quitButton";
         this.backButton.pivotX = int(this.backButton.width * 0.6);
         this.backButton.pivotY = int(this.backButton.height * 0.4);
         this.backButton.x = this.notepadContainer.x + this.notepadContainer.width - 8;
         this.backButton.y = this.notepadContainer.y;
         this.container.addChild(this.backButton);
      }
      
      protected function initBluePanel() : void
      {
         var i:int = 0;
         var amount:int = 0;
         var start_x:int = 0;
         var image:Image = null;
         this.titleText = new GameText(StringsManager.GetString("quest_title"),GameText.TYPE_BIG);
         if(this.body_width - 40 < this.titleText.WIDTH)
         {
            this.body_width = this.titleText.WIDTH + 40;
         }
         this.notepadContainer = new Sprite();
         this.container.addChild(this.notepadContainer);
         this.notepadImages = new Vector.<Image>();
         image = new Image(TextureManager.hudTextureAtlas.getTexture("quest_panel1Part1"));
         image.touchable = false;
         this.notepadContainer.addChild(image);
         this.notepadImages.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("quest_panel1Part2"));
         image.touchable = false;
         this.notepadContainer.addChild(image);
         this.notepadImages.push(image);
         image.width = this.body_width - 16;
         image.x = 8;
         image = new Image(TextureManager.hudTextureAtlas.getTexture("quest_panel1Part1"));
         image.scaleX = -1;
         image.touchable = false;
         this.notepadContainer.addChild(image);
         this.notepadImages.push(image);
         image.x = this.body_width;
         image = new Image(TextureManager.hudTextureAtlas.getTexture("quest_panel1Part3"));
         image.touchable = false;
         image.height = Utils.HEIGHT;
         image.y = 42;
         this.notepadContainer.addChild(image);
         this.notepadImages.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         image.touchable = false;
         image.width = this.body_width - 16;
         image.height = Utils.HEIGHT;
         image.x = 8;
         image.y = 42;
         this.notepadContainer.addChild(image);
         this.notepadImages.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("quest_panel1Part3"));
         image.scaleX = -1;
         image.height = Utils.HEIGHT;
         image.touchable = false;
         this.notepadContainer.addChild(image);
         this.notepadImages.push(image);
         image.x = this.body_width;
         image.y = 42;
         this.notepadContainer.addChild(this.titleText);
         this.titleText.y = 16;
         this.titleText.x = int((this.body_width - this.titleText.WIDTH) * 0.5);
         this.notepadContainer.x = int((Utils.WIDTH - this.notepadContainer.width) * 0.5);
         amount = int((this.body_width - 24) / 24);
         start_x = int((this.body_width - (amount - 1) * 24) * 0.5);
         for(i = 0; i < amount; i++)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("quest_panel1Part4"));
            image.touchable = false;
            image.pivotX = 5;
            image.x = start_x + i * 24;
            image.y = -4;
            this.notepadContainer.addChild(image);
            this.notepadImages.push(image);
         }
      }
      
      protected function initText() : void
      {
         var image:Image = null;
         var description_string:String = "- " + QuestsManager.Quests[Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_INDEX]].description;
         this.descriptionText = new GameTextArea(description_string,GameText.TYPE_SMALL_DARK,this.body_width - 24,64);
         if(Utils.EnableFontStrings)
         {
            this.descriptionText.setColor(8267091);
         }
         this.notepadContainer.addChild(this.descriptionText);
         this.descriptionText.x = 12;
         this.descriptionText.y = 42 + 8;
         var now:Date = new Date();
         var tomorrow:Date = new Date();
         var hours:int = 23 - tomorrow.hours;
         var minutes:int = 59 - tomorrow.minutes;
         var seconds:int = 60 - tomorrow.seconds;
         this.nextQuestText = new GameText(StringsManager.GetString("quest_next") + " " + hours + ":" + minutes + ":" + seconds,GameText.TYPE_SMALL_DARK);
         this.updateTimeText();
         this.notepadContainer.addChild(this.nextQuestText);
         this.nextQuestText.x = int((this.body_width - this.nextQuestText.WIDTH) * 0.5);
         this.nextQuestText.y = int(Utils.HEIGHT * 0.8 - (this.nextQuestText.HEIGHT + 4));
         if(Utils.IS_IPHONE_X)
         {
            this.nextQuestText.y -= 4;
         }
         this.winningStreakText = new GameText(StringsManager.GetString("quest_win_streak") + " " + Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STREAK],GameText.TYPE_SMALL_DARK);
         this.notepadContainer.addChild(this.winningStreakText);
         this.winningStreakText.x = this.nextQuestText.x;
         this.winningStreakText.y = this.nextQuestText.y;
         this.winningStreakText.alpha = 0;
         this.winningStreakText.visible = false;
         this.clock_image_1 = new Image(TextureManager.hudTextureAtlas.getTexture("clock_symbol"));
         this.clock_image_1.touchable = false;
         this.clock_image_1.x = this.nextQuestText.x - (this.clock_image_1.width + 5);
         this.clock_image_1.y = this.nextQuestText.y - 2;
         this.notepadContainer.addChild(this.clock_image_1);
         this.notepadImages.push(this.clock_image_1);
         this.clock_image_2 = new Image(TextureManager.hudTextureAtlas.getTexture("clock_symbol"));
         this.clock_image_2.touchable = false;
         this.clock_image_2.x = this.nextQuestText.x + this.nextQuestText.WIDTH + 5;
         this.clock_image_2.y = this.nextQuestText.y - 2;
         this.notepadContainer.addChild(this.clock_image_2);
         this.notepadImages.push(this.clock_image_2);
         this.progressionBar = new QuestProgressionBarPanel(this.body_width);
         this.notepadContainer.addChild(this.progressionBar);
         this.progressionBar.x = int(this.body_width * 0.5);
         this.progressionBar.y = this.descriptionText.y + this.descriptionText.height + 4;
      }
      
      protected function setButtonsTouchable(value:Boolean) : void
      {
         this.backButton.touchable = value;
      }
   }
}
