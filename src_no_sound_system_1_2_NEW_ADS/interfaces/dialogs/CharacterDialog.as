package interfaces.dialogs
{
   import interfaces.dialogs.balloons.CharacterBalloon;
   import interfaces.texts.GameText;
   import levels.Level;
   import sprites.GameSprite;
   
   public class CharacterDialog extends Dialog
   {
       
      
      public function CharacterDialog(_level:Level, _xPos:Number, _yPos:Number, _text:String, _onComplete:Function = null, _delay:int = 0, _sprite:GameSprite = null, _isQuestionButton:Boolean = false, _time:int = -1, _price:int = -1)
      {
         margin_x = 8;
         margin_y = 6;
         spacing = 6;
         line_height = 12;
         font_height = 9;
         MAX_WIDTH = 160;
         MIN_WIDTH = 16;
         MAX_LINES = 4;
         font_pivot_x = 0;
         font_pivot_y = 8;
         char_spacing = 1;
         forceCenteredButtons = true;
         if(Utils.EnableFontStrings)
         {
            MAX_LINES = 5;
         }
         super(_level,_xPos,_yPos,_text,_onComplete,_delay,_sprite,_isQuestionButton,_price);
         TIME = _time;
         delay = _delay;
         balloon = new CharacterBalloon(this,WIDTH,HEIGHT);
         addChild(balloon);
         pivotX = int(Math.floor(WIDTH * 0.5));
         pivotY = int(HEIGHT);
         stateMachine.setState("IS_WAITING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      override public function getCharName(_color:int = 16777215) : String
      {
         if(_color == Dialog.RED)
         {
            return "dialogRedChar_";
         }
         if(_color == Dialog.BLUE)
         {
            return "dialogBlueChar_";
         }
         return "dialogChar_";
      }
      
      override public function getCharCode(code:int) : int
      {
         if(code == 73)
         {
            return code;
         }
         if(code >= 65 && code <= 90)
         {
            return code + 32;
         }
         return code;
      }
      
      override public function getCharWidth(code:int) : int
      {
         return GameText.getCharWidth(code,GameText.TYPE_SMALL_DARK);
      }
      
      override public function setPosition(_xPos:int, _yPos:int) : void
      {
         var outside_diff:Number = NaN;
         this.x = _xPos;
         this.y = _yPos;
         if(x + WIDTH * 0.5 >= Utils.WIDTH - 32)
         {
            outside_diff = int(x + WIDTH * 0.5 - (Utils.WIDTH - 32));
            this.x -= outside_diff;
            xPos -= outside_diff;
            balloon.setOffset(outside_diff);
         }
         else if(x - WIDTH * 0.5 <= 32)
         {
            outside_diff = int(32 - (x - WIDTH * 0.5));
            this.x += outside_diff;
            xPos += outside_diff;
            balloon.setOffset(-outside_diff);
         }
      }
   }
}
