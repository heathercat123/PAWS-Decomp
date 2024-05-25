package interfaces.dialogs
{
   import game_utils.StateMachine;
   import interfaces.buttons.BalloonTextButton;
   import levels.cameras.*;
   import sprites.GameSprite;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class Paragraph extends Sprite
   {
       
      
      public var dialog:Dialog;
      
      public var tokens:Array;
      
      public var currentToken:int;
      
      public var token_advance_x:int;
      
      public var token_advance_y:int;
      
      protected var last_spacing_x:int;
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var HEIGHT_LINES:int;
      
      public var lineWidths:Array;
      
      public var IS_BUTTON:Boolean;
      
      public var MAX_WIDTH:int;
      
      public var MAX_LINES:int;
      
      public var stateMachine:StateMachine;
      
      public var sprite:GameSprite;
      
      public var button:BalloonTextButton;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      public function Paragraph(_dialog:Dialog)
      {
         super();
         this.dialog = _dialog;
         this.tokens = new Array();
         this.sprite = null;
         this.button = null;
         this.lineWidths = new Array();
         this.lineWidths.push(0);
         this.WIDTH = 0;
         this.HEIGHT = 0;
         this.HEIGHT_LINES = 1;
         this.IS_BUTTON = false;
         this.MAX_WIDTH = this.dialog.MAX_WIDTH - this.dialog.margin_x * 2;
         this.MAX_LINES = this.dialog.MAX_LINES;
         this.currentToken = 0;
         this.token_advance_x = 0;
         this.token_advance_y = 0;
         this.last_spacing_x = 0;
         this.counter_1 = this.counter_2 = 0;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_WAITING_STATE","START_ACTION","IS_RENDERING_STATE");
         this.stateMachine.setRule("IS_RENDERING_STATE","SPRITE_ACTION","IS_RENDERING_SPRITE_STATE");
         this.stateMachine.setRule("IS_RENDERING_SPRITE_STATE","END_ACTION","IS_COMPLETE_STATE");
         this.stateMachine.setRule("IS_RENDERING_STATE","END_ACTION","IS_COMPLETE_STATE");
         this.stateMachine.setFunctionToState("IS_WAITING_STATE",this.waitingState);
         this.stateMachine.setFunctionToState("IS_RENDERING_STATE",this.renderingState);
         this.stateMachine.setFunctionToState("IS_RENDERING_SPRITE_STATE",this.renderingSpriteState);
         this.stateMachine.setFunctionToState("IS_COMPLETE_STATE",this.completeState);
         this.stateMachine.setState("IS_WAITING_STATE");
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.lineWidths = null;
         this.sprite = null;
         this.button = null;
         for(i = 0; i < this.tokens.length; i++)
         {
            if(this.tokens[i] != null)
            {
               removeChild(this.tokens[i]);
               this.tokens[i].destroy();
               this.tokens[i].dispose();
               this.tokens[i] = null;
            }
         }
         this.tokens = null;
         this.dialog = null;
      }
      
      public function pushToken(token:Token) : void
      {
         this.tokens.push(token);
         addChild(token);
         if(token.isBackspace)
         {
            this.token_advance_x -= this.dialog.spacing;
            this.token_advance_x += this.dialog.char_spacing;
            this.lineWidths[this.lineWidths.length - 1] -= this.dialog.spacing;
            this.lineWidths[this.lineWidths.length - 1] += this.dialog.char_spacing;
         }
         else if(this.token_advance_x + token.WIDTH > this.MAX_WIDTH || token.isNewLine)
         {
            ++this.HEIGHT_LINES;
            this.token_advance_x = 0;
            this.token_advance_y += this.dialog.line_height;
            this.lineWidths[this.lineWidths.length - 1] -= this.dialog.spacing;
            this.lineWidths.push(0);
         }
         token.x = this.token_advance_x;
         token.y = this.token_advance_y;
         this.last_spacing_x = this.dialog.spacing;
         if(token.isButton)
         {
            this.last_spacing_x = this.dialog.button_spacing;
         }
         this.token_advance_x += token.WIDTH + this.last_spacing_x;
         this.lineWidths[this.lineWidths.length - 1] += token.WIDTH + this.last_spacing_x;
      }
      
      public function addSprite(_sprite:GameSprite) : void
      {
         this.sprite = _sprite;
         this.sprite.pivotX = int(this.sprite.width * 0.5);
         this.sprite.gfxHandleClip().gotoAndStop(1);
      }
      
      public function addButton(_button:BalloonTextButton) : void
      {
         this.button = _button;
         this.button.pivotX = int(this.button.width * 0.5);
         this.button.x = 0;
      }
      
      public function isThereRoomForNextToken(token:Token) : Boolean
      {
         if(this.token_advance_x + token.WIDTH > this.MAX_WIDTH)
         {
            if(this.HEIGHT_LINES < this.MAX_LINES)
            {
               return true;
            }
            return false;
         }
         return true;
      }
      
      public function close() : void
      {
         var i:int = 0;
         var tok:Token = null;
         var additional_height:int = 0;
         this.lineWidths[this.lineWidths.length - 1] -= this.last_spacing_x;
         if(this.tokens[this.tokens.length - 1].isButton)
         {
            additional_height = this.dialog.button_height;
            this.IS_BUTTON = true;
         }
         else
         {
            additional_height = this.dialog.font_height;
         }
         var _max_width:int = 0;
         for(i = 0; i < this.lineWidths.length; i++)
         {
            if(this.lineWidths[i] > _max_width)
            {
               _max_width = int(this.lineWidths[i]);
            }
         }
         this.WIDTH = _max_width;
         if(Utils.EnableFontStrings)
         {
            tok = this.tokens[this.tokens.length - 1] as Token;
            this.HEIGHT = this.token_advance_y = tok.height;
         }
         else
         {
            this.HEIGHT = this.token_advance_y + additional_height;
         }
      }
      
      protected function addListenerToButtons() : void
      {
      }
      
      protected function buttonClickHandler(_event:Event) : void
      {
      }
      
      protected function centerButtons() : void
      {
      }
      
      public function update() : void
      {
         var i:int = 0;
         for(i = 0; i < this.tokens.length; i++)
         {
            this.tokens[i].update();
         }
         if(this.button != null)
         {
            this.button.pivotX = int(this.button.WIDTH * 0.5);
            this.button.x = this.WIDTH * 0.5;
         }
         if(this.stateMachine.currentState == "IS_RENDERING_STATE")
         {
            if(Utils.EnableFontStrings)
            {
               for(i = this.currentToken; i < this.tokens.length; i++)
               {
                  this.tokens[i].renderAll();
               }
               if(this.sprite != null || this.button != null)
               {
                  this.stateMachine.performAction("SPRITE_ACTION");
               }
               else
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.tokens[this.currentToken].HAS_FINISHED)
            {
               ++this.currentToken;
               if(this.currentToken >= this.tokens.length)
               {
                  if(this.sprite != null || this.button != null)
                  {
                     this.stateMachine.performAction("SPRITE_ACTION");
                  }
                  else
                  {
                     this.stateMachine.performAction("END_ACTION");
                  }
               }
               else if(this.tokens[this.currentToken].isButton)
               {
                  this.renderAll();
               }
               else
               {
                  this.tokens[this.currentToken].startRendering();
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_RENDERING_SPRITE_STATE")
         {
            ++this.counter_1;
            if(this.counter_1 > 8)
            {
               this.counter_1 = 0;
               if(this.sprite != null)
               {
                  this.sprite.alpha += 0.5;
                  if(this.sprite.alpha >= 1)
                  {
                     this.sprite.alpha = 1;
                     this.stateMachine.performAction("END_ACTION");
                  }
               }
               else if(this.button != null)
               {
                  this.button.alpha += 0.5;
                  if(this.button.alpha >= 1)
                  {
                     this.button.alpha = 1;
                     this.stateMachine.performAction("END_ACTION");
                  }
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_COMPLETE_STATE")
         {
         }
      }
      
      protected function waitingState() : void
      {
      }
      
      protected function renderingState() : void
      {
         this.tokens[this.currentToken].startRendering();
      }
      
      protected function renderingSpriteState() : void
      {
         if(this.sprite != null)
         {
            this.sprite.visible = true;
            this.sprite.alpha = 0;
            addChild(this.sprite);
            this.sprite.x = int(this.WIDTH * 0.5);
            if(Utils.EnableFontStrings)
            {
               this.sprite.y = this.token_advance_y;
            }
            else
            {
               this.sprite.y = this.token_advance_y + this.dialog.line_height;
            }
            this.sprite.gfxHandleClip().gotoAndPlay(1);
         }
         else if(this.button != null)
         {
            this.button.visible = true;
            this.button.alpha = 0;
            addChild(this.button);
            this.button.x = int(this.dialog.WIDTH * 0.5);
            if(Utils.EnableFontStrings)
            {
               this.button.y = this.token_advance_y;
            }
            else
            {
               this.button.y = this.token_advance_y + this.dialog.line_height;
            }
         }
         this.counter_1 = this.counter_2 = 0;
      }
      
      protected function completeState() : void
      {
      }
      
      public function startRendering() : void
      {
         this.stateMachine.performAction("START_ACTION");
      }
      
      public function renderAll() : void
      {
         var i:int = 0;
         for(i = this.currentToken; i < this.tokens.length; i++)
         {
            this.tokens[i].renderAll();
         }
         this.stateMachine.setState("IS_COMPLETE_STATE");
      }
   }
}
