package interfaces.dialogs
{
   import entities.Entity;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import interfaces.buttons.BalloonTextButton;
   import interfaces.dialogs.balloons.*;
   import interfaces.texts.GameText;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class Dialog extends Sprite
   {
      
      public static const WHITE:int = 16777215;
      
      public static const RED:int = 16711680;
      
      public static const CYAN:int = 10092543;
      
      public static const YELLOW:int = 16776960;
      
      public static const GREEN:int = 65280;
      
      public static const BLUE:int = 255;
      
      public static const NONE:int = 0;
      
      public static const SHAKE:int = 1;
      
      public static const WAVE:int = 2;
      
      public static const HOR_WAVE:int = 3;
      
      public static const RADIO:int = 4;
      
      public static const SOUND_NORMAL:int = 0;
      
      public static const SOUND_YELLOW_GENERAL:int = 1;
      
      public static const SOUND_CAT:int = 2;
      
      public static const NO_SOUND:int = 3;
      
      public static const BREAK:int = 1;
      
      public static const LINE:int = 2;
      
      public static const BACKSPACE:int = 3;
      
      public static const PAUSE:int = 4;
       
      
      public var level:Level;
      
      public var text:String;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      public var margin_x:int;
      
      public var margin_y:int;
      
      public var spacing:int;
      
      public var button_spacing:int;
      
      public var line_height:int;
      
      public var button_height:int;
      
      public var font_height:int;
      
      public var font_pivot_x:int;
      
      public var font_pivot_y:int;
      
      public var char_spacing:int;
      
      protected var delay:int;
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var MAX_WIDTH:int;
      
      public var MIN_WIDTH:int;
      
      public var MAX_LINES:int;
      
      public var forceCenteredButtons:Boolean;
      
      protected var TIME:int;
      
      public var balloon:Balloon;
      
      public var tokens:Array;
      
      public var paragraphs:Array;
      
      public var stateMachine:StateMachine;
      
      public var dead:Boolean;
      
      public var currentParagraph:int;
      
      public var onComplete:Function;
      
      public var entity:Entity;
      
      protected var ACTION:int;
      
      protected var COLOR:uint;
      
      protected var ANIMATION:int;
      
      protected var PARAGRAPH:int;
      
      protected var IS_BUTTON:Boolean;
      
      protected var anim_counter1:int;
      
      protected var anim_counter2:int;
      
      protected var anim_counter3:int;
      
      public var anim_x:int;
      
      public var anim_y:int;
      
      public var char_index:int;
      
      public var answerIndex:int;
      
      public var tick_since_complete:int;
      
      protected var sprite:GameSprite;
      
      protected var isQuestionButton:Boolean;
      
      protected var questionButton:BalloonTextButton;
      
      protected var price:int;
      
      protected var questionFunction:Function;
      
      public var ABSOLUTE_POSITION:Boolean;
      
      private var last_random_angle:Number = 0;
      
      private var random_angle:Number = 0;
      
      public var wave_sin_counter:Number = 0;
      
      public function Dialog(_level:Level, _xPos:Number, _yPos:Number, _text:String, _onComplete:Function = null, _delay:int = 0, _sprite:GameSprite = null, _isQuestionButton:Boolean = false, _price:int = -1)
      {
         var i:int = 0;
         var words:Array = null;
         var token:Token = null;
         var gText:GameText = null;
         var ___width:int = 0;
         super();
         this.level = _level;
         this.xPos = _xPos;
         this.yPos = _yPos;
         this.text = _text;
         this.onComplete = _onComplete;
         this.entity = null;
         this.sprite = _sprite;
         this.isQuestionButton = _isQuestionButton;
         this.price = _price;
         this.questionFunction = null;
         this.ABSOLUTE_POSITION = false;
         this.TIME = -1;
         if(this.isQuestionButton)
         {
            if(this.price > -1)
            {
               gText = new GameText("$ " + this.price,GameText.TYPE_SMALL_DARK);
            }
            else
            {
               gText = new GameText(StringsManager.GetString("question_dialog_1"),GameText.TYPE_SMALL_DARK);
            }
            ___width = gText.WIDTH + 8;
            if(___width < 48)
            {
               ___width = 48;
            }
            if(this.price > -1)
            {
               this.questionButton = new BalloonTextButton("$ " + this.price,___width,19);
            }
            else
            {
               this.questionButton = new BalloonTextButton(StringsManager.GetString("question_dialog_1"),___width,19);
            }
            this.questionButton.addEventListener(Event.TRIGGERED,this.questionHandler);
         }
         else
         {
            this.questionButton = null;
         }
         this.button_height = 27;
         this.button_spacing = 16;
         this.dead = false;
         this.answerIndex = -1;
         this.WIDTH = this.HEIGHT = 0;
         this.currentParagraph = 0;
         this.tick_since_complete = 0;
         this.delay = 0;
         this.ACTION = this.ANIMATION = this.PARAGRAPH = 0;
         this.IS_BUTTON = false;
         this.COLOR = 16777215;
         this.anim_counter1 = this.anim_counter2 = this.anim_counter3 = this.anim_x = this.anim_y = this.char_index = 0;
         if(Utils.EnableFontStrings)
         {
            words = new Array();
            words.push(_text);
         }
         else
         {
            words = this.text.split(" ");
         }
         this.tokens = new Array();
         for(i = 0; i < words.length; i++)
         {
            if(!this.isScript(words[i]))
            {
               token = new Token(this,words[i],this.ACTION,this.COLOR,this.ANIMATION,this.IS_BUTTON);
               this.tokens.push(token);
               this.ACTION = 0;
               this.IS_BUTTON = false;
               if(this.PARAGRAPH == BREAK)
               {
                  this.PARAGRAPH = 0;
                  token.isNewParagraph = true;
               }
               else if(this.PARAGRAPH == LINE)
               {
                  this.PARAGRAPH = 0;
                  token.isNewLine = true;
               }
               else if(this.PARAGRAPH == BACKSPACE)
               {
                  this.PARAGRAPH = 0;
                  token.isBackspace = true;
               }
               else if(this.PARAGRAPH == PAUSE)
               {
                  this.PARAGRAPH = 0;
                  token.isPause = true;
               }
            }
         }
         this.paragraphs = new Array();
         this.paragraphs.push(new Paragraph(this));
         for(i = 0; i < this.tokens.length; i++)
         {
            this.paragraphs[this.paragraphs.length - 1].pushToken(this.tokens[i]);
            if(i < this.tokens.length - 1)
            {
               if(this.paragraphs[this.paragraphs.length - 1].isThereRoomForNextToken(this.tokens[i + 1]) == false || Boolean(this.tokens[i + 1].isNewParagraph))
               {
                  this.paragraphs[this.paragraphs.length - 1].close();
                  this.paragraphs.push(new Paragraph(this));
               }
            }
         }
         this.paragraphs[this.paragraphs.length - 1].close();
         if(this.sprite != null)
         {
            this.paragraphs[this.paragraphs.length - 1].addSprite(this.sprite);
         }
         if(this.questionButton != null)
         {
            this.paragraphs[this.paragraphs.length - 1].addButton(this.questionButton);
         }
         var _m_width:int = 0;
         var _m_height:int = 0;
         for(i = 0; i < this.paragraphs.length; i++)
         {
            if(this.paragraphs[i].WIDTH > _m_width)
            {
               _m_width = int(this.paragraphs[i].WIDTH);
            }
            if(this.paragraphs[i].HEIGHT > _m_height)
            {
               _m_height = int(this.paragraphs[i].HEIGHT);
            }
         }
         this.WIDTH = _m_width + this.margin_x * 2;
         if(this.WIDTH < this.MIN_WIDTH)
         {
            this.WIDTH = this.MIN_WIDTH;
         }
         this.HEIGHT = _m_height + this.margin_y * 2;
         if(this.sprite != null)
         {
            this.HEIGHT += this.sprite.height;
         }
         if(this.questionButton != null)
         {
            this.HEIGHT += this.questionButton.HEIGHT;
         }
         if(this.forceCenteredButtons)
         {
            if(this.tokens[this.tokens.length - 1].isButton)
            {
               this.centerButtons();
            }
         }
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_WAITING_STATE","END_ACTION","IS_BALLOON_APPEARING_STATE");
         this.stateMachine.setRule("IS_BALLOON_APPEARING_STATE","END_ACTION","IS_ADDING_PARAGRAPH_STATE");
         this.stateMachine.setRule("IS_ADDING_PARAGRAPH_STATE","END_ACTION","IS_RENDERING_PARAGRAPH_STATE");
         this.stateMachine.setRule("IS_RENDERING_PARAGRAPH_STATE","INPUT_ACTION","IS_QUICK_RENDERING_STATE");
         this.stateMachine.setRule("IS_QUICK_RENDERING_STATE","END_ACTION","IS_WAITING_INPUT_STATE");
         this.stateMachine.setRule("IS_RENDERING_PARAGRAPH_STATE","END_ACTION","IS_WAITING_INPUT_STATE");
         this.stateMachine.setRule("IS_WAITING_INPUT_STATE","INPUT_ACTION","IS_EVALUATING_STATE");
         this.stateMachine.setRule("IS_EVALUATING_STATE","NEXT_PARAGRAPH_ACTION","IS_CLEARING_STATE");
         this.stateMachine.setRule("IS_CLEARING_STATE","END_ACTION","IS_ADDING_PARAGRAPH_STATE");
         this.stateMachine.setRule("IS_EVALUATING_STATE","END_ACTION","IS_BALLOON_DISAPPEARING_STATE");
         this.stateMachine.setRule("IS_BALLOON_DISAPPEARING_STATE","END_ACTION","IS_DESTROY_STATE");
         this.stateMachine.setRule("IS_BALLOON_APPEARING_STATE","DISAPPEAR_ACTION","IS_BALLOON_DISAPPEARING_STATE");
         this.stateMachine.setRule("IS_WAITING_INPUT_STATE","DISAPPEAR_ACTION","IS_BALLOON_DISAPPEARING_STATE");
         this.stateMachine.setRule("IS_RENDERING_PARAGRAPH_STATE","DISAPPEAR_ACTION","IS_BALLOON_DISAPPEARING_STATE");
         this.stateMachine.setFunctionToState("IS_WAITING_STATE",this.waitingState);
         this.stateMachine.setFunctionToState("IS_BALLOON_APPEARING_STATE",this.balloonAppearingState);
         this.stateMachine.setFunctionToState("IS_ADDING_PARAGRAPH_STATE",this.addParagraphState);
         this.stateMachine.setFunctionToState("IS_RENDERING_PARAGRAPH_STATE",this.renderParagraphState);
         this.stateMachine.setFunctionToState("IS_QUICK_RENDERING_STATE",this.quickRenderingState);
         this.stateMachine.setFunctionToState("IS_WAITING_INPUT_STATE",this.waitingInputState);
         this.stateMachine.setFunctionToState("IS_EVALUATING_STATE",this.evaluatingState);
         this.stateMachine.setFunctionToState("IS_CLEARING_STATE",this.clearState);
         this.stateMachine.setFunctionToState("IS_BALLOON_DISAPPEARING_STATE",this.balloonDisappearingState);
         this.stateMachine.setFunctionToState("IS_DESTROY_STATE",this.destroyState);
      }
      
      private function splitStringInChunks(string:String, size:int) : Array
      {
         var array:Array = new Array();
         var index:int = 0;
         while(index < string.length)
         {
            array.push(string.substr(index,Math.min(index + size,string.length)));
            index += size;
         }
         return array;
      }
      
      protected function questionHandler(event:Event) : void
      {
         if(this.questionFunction != null)
         {
            if(this.price > -1)
            {
               if(LevelItems.GetCoinsAmount() >= this.price)
               {
                  this.questionFunction(1);
               }
               else
               {
                  this.questionFunction(0);
               }
            }
            else
            {
               SoundSystem.PlaySound("select");
               this.questionFunction(1);
            }
            this.endRendering();
         }
      }
      
      public function setQuestionHandler(_function:Function) : void
      {
         this.questionFunction = _function;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         if(this.stateMachine != null)
         {
            this.stateMachine.destroy();
            this.stateMachine = null;
         }
         this.questionFunction = null;
         if(this.balloon != null)
         {
            removeChild(this.balloon);
            this.balloon.destroy();
            this.balloon.dispose();
            this.balloon = null;
         }
         if(this.tokens != null)
         {
            for(i = 0; i < this.tokens.length; i++)
            {
               if(this.tokens[i] != null)
               {
                  this.tokens[i].destroy();
                  this.tokens[i].dispose();
                  this.tokens[i] = null;
               }
            }
         }
         if(this.paragraphs != null)
         {
            for(i = 0; i < this.paragraphs.length; i++)
            {
               if(this.paragraphs[i] != null)
               {
                  this.paragraphs[i].destroy();
                  this.paragraphs[i].dispose();
                  this.paragraphs[i] = null;
               }
            }
         }
         this.tokens = null;
         this.paragraphs = null;
         if(this.questionButton != null)
         {
            this.questionButton.removeEventListener(Event.TRIGGERED,this.questionHandler);
            this.questionButton.destroy();
            this.questionButton.dispose();
            this.questionButton = null;
         }
         this.sprite = null;
         this.entity = null;
         this.onComplete = null;
         this.text = null;
         this.level = null;
      }
      
      public function getCharRenderTime() : int
      {
         return 1;
      }
      
      public function processInput() : void
      {
         if(this.TIME > -1)
         {
            return;
         }
         if(this.stateMachine.currentState == "IS_WAITING_INPUT_STATE")
         {
            if(!this.paragraphs[this.currentParagraph - 1].IS_BUTTON)
            {
               this.stateMachine.performAction("INPUT_ACTION");
            }
         }
         else
         {
            this.stateMachine.performAction("INPUT_ACTION");
         }
      }
      
      public function processButtonInput(index:int) : void
      {
         if(this.stateMachine.currentState == "IS_WAITING_INPUT_STATE")
         {
            this.answerIndex = index;
            this.stateMachine.performAction("INPUT_ACTION");
         }
      }
      
      public function endRendering() : void
      {
         if(this.dead)
         {
            return;
         }
         this.stateMachine.performAction("DISAPPEAR_ACTION");
      }
      
      protected function centerButtons() : void
      {
         var i:int = 0;
         var diff_x:int = 0;
         var total_button_width:Number = 0;
         for(i = 0; i < this.tokens.length; i++)
         {
            if(this.tokens[i].isButton)
            {
               total_button_width += this.tokens[i].WIDTH + this.button_spacing;
            }
         }
         total_button_width -= this.button_spacing;
         diff_x = int(this.WIDTH - this.margin_x * 2 - total_button_width) * 0.5;
         for(i = 0; i < this.tokens.length; i++)
         {
            if(this.tokens[i].isButton)
            {
               this.tokens[i].x += diff_x;
            }
         }
      }
      
      protected function isScript(word:String) : Boolean
      {
         if(word.charAt(0) != "[")
         {
            return false;
         }
         if(word == "[br]")
         {
            this.PARAGRAPH = BREAK;
         }
         else if(word == "[line]")
         {
            this.PARAGRAPH = LINE;
         }
         else if(word == "[backspace]")
         {
            this.PARAGRAPH = BACKSPACE;
         }
         else if(word == "[pause]")
         {
            this.PARAGRAPH = PAUSE;
         }
         if(word == "[nervous]")
         {
            this.ACTION = 1;
         }
         else if(word == "[surprised]")
         {
            this.ACTION = 2;
         }
         if(word == "[red]")
         {
            this.COLOR = RED;
         }
         else if(word == "[cyan]")
         {
            this.COLOR = CYAN;
         }
         else if(word == "[yellow]")
         {
            this.COLOR = YELLOW;
         }
         else if(word == "[green]")
         {
            this.COLOR = GREEN;
         }
         else if(word == "[blue]")
         {
            this.COLOR = BLUE;
         }
         else if(word == "[/red]" || word == "[/cyan]" || word == "[/yellow]" || word == "[/green]" || word == "[/blue]")
         {
            this.COLOR = WHITE;
         }
         if(word == "[shake]")
         {
            this.ANIMATION = SHAKE;
         }
         else if(word == "[wave]")
         {
            this.ANIMATION = WAVE;
         }
         else if(word == "[hor_wave]")
         {
            this.ANIMATION = HOR_WAVE;
         }
         else if(word == "[radio]")
         {
            this.ANIMATION = RADIO;
         }
         else if(word == "[/shake]" || word == "[/wave]" || word == "[/hor_wave]" || word == "[/radio]")
         {
            this.ANIMATION = 0;
         }
         if(word == "[button]")
         {
            this.IS_BUTTON = true;
         }
         return true;
      }
      
      public function update() : void
      {
         var i:int = 0;
         if(this.paragraphs != null)
         {
            for(i = 0; i < this.paragraphs.length; i++)
            {
               if(this.paragraphs[i] != null)
               {
                  this.paragraphs[i].update();
               }
            }
         }
         if(this.balloon != null)
         {
            this.balloon.update();
         }
         if(this.stateMachine != null)
         {
            if(this.stateMachine.currentState == "IS_WAITING_STATE")
            {
               --this.delay;
               if(this.delay <= 0)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState == "IS_BALLOON_APPEARING_STATE")
            {
               if(this.balloon.stateMachine.currentState == "IS_STAYING_STATE")
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            if(this.stateMachine.currentState == "IS_RENDERING_PARAGRAPH_STATE")
            {
               if(this.paragraphs[this.currentParagraph].stateMachine.currentState == "IS_COMPLETE_STATE")
               {
                  ++this.currentParagraph;
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState == "IS_WAITING_INPUT_STATE")
            {
               ++this.tick_since_complete;
               if(this.TIME > -1)
               {
                  --this.TIME;
                  if(this.TIME == 1)
                  {
                     this.TIME = 0;
                     this.stateMachine.performAction("INPUT_ACTION");
                  }
                  if(this.TIME <= 0)
                  {
                     this.TIME = 0;
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_BALLOON_DISAPPEARING_STATE")
            {
               if(this.balloon.stateMachine.currentState == "IS_OVER_STATE")
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         this.updateAnimationVariables();
      }
      
      protected function waitingState() : void
      {
         this.balloon.visible = false;
      }
      
      protected function balloonAppearingState() : void
      {
         this.balloon.fadeIn();
         this.balloon.visible = true;
      }
      
      protected function balloonDisappearingState() : void
      {
         var i:int = 0;
         for(i = 0; i < this.paragraphs.length; i++)
         {
            this.paragraphs[i].visible = false;
         }
         this.balloon.fadeOut();
      }
      
      protected function addParagraphState() : void
      {
         addChild(this.paragraphs[this.currentParagraph]);
         this.paragraphs[this.currentParagraph].x = this.margin_x;
         this.paragraphs[this.currentParagraph].y = this.margin_y;
         this.paragraphs[this.currentParagraph].startRendering();
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function renderParagraphState() : void
      {
         this.tick_since_complete = 0;
      }
      
      public function renderAll() : void
      {
         this.paragraphs[this.currentParagraph].renderAll();
         ++this.currentParagraph;
      }
      
      protected function quickRenderingState() : void
      {
         this.paragraphs[this.currentParagraph].renderAll();
         ++this.currentParagraph;
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function waitingInputState() : void
      {
      }
      
      protected function evaluatingState() : void
      {
         if(this.currentParagraph >= this.paragraphs.length)
         {
            this.stateMachine.performAction("END_ACTION");
         }
         else
         {
            this.stateMachine.performAction("NEXT_PARAGRAPH_ACTION");
         }
      }
      
      protected function clearState() : void
      {
         this.paragraphs[this.currentParagraph - 1].visible = false;
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function destroyState() : void
      {
         if(this.onComplete != null)
         {
            if(this.answerIndex > -1)
            {
               this.onComplete({"answer":this.answerIndex});
            }
            else
            {
               this.onComplete();
            }
         }
         this.dead = true;
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         if(this.ABSOLUTE_POSITION)
         {
            x = int(Math.floor(this.xPos));
            y = int(Math.floor(this.yPos));
         }
         else
         {
            x = int(Math.floor(this.xPos - camera.xPos));
            y = int(Math.floor(this.yPos - camera.yPos));
         }
      }
      
      public function getCharName(_color:int = 16777215) : String
      {
         return null;
      }
      
      public function getCharCode(code:int) : int
      {
         return code;
      }
      
      public function getCharWidth(code:int) : int
      {
         return 0;
      }
      
      public function setPosition(_xPos:int, _yPos:int) : void
      {
         this.x = _xPos;
         this.y = _yPos;
      }
      
      public function getCurrentParagraph() : Paragraph
      {
         return this.paragraphs[this.currentParagraph];
      }
      
      private function updateAnimationVariables() : void
      {
         ++this.anim_counter1;
         if(this.anim_counter1 > 2)
         {
            this.anim_counter1 = 0;
            do
            {
               this.random_angle = Math.random() * Math.PI * 2;
            }
            while(Math.abs(this.random_angle - this.last_random_angle) < Math.PI * 0.75);
            
            this.last_random_angle = this.random_angle;
            this.anim_x = Math.round(Math.sin(this.random_angle) * 1.5);
            this.anim_y = Math.round(Math.cos(this.random_angle) * 1.5);
         }
         this.wave_sin_counter += 0.15;
         if(this.wave_sin_counter >= Math.PI * 2)
         {
            this.wave_sin_counter -= Math.PI * 2;
         }
      }
   }
}
