package interfaces.dialogs
{
   import interfaces.dialogs.balloons.CaptionBalloon;
   import interfaces.texts.GameText;
   import levels.Level;
   import sprites.GameSprite;
   
   public class NarrationDialog extends Dialog
   {
       
      
      protected var time_alive:int;
      
      public function NarrationDialog(_level:Level, _xPos:Number, _yPos:Number, _text:String, _onComplete:Function = null, _delay:int = 0, _sprite:GameSprite = null, _isRateButton:Boolean = false, _time_alive:int = 60)
      {
         margin_x = 8;
         margin_y = 6;
         spacing = 6;
         line_height = 12;
         font_height = 9;
         MAX_WIDTH = Utils.WIDTH * 0.75;
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
         this.time_alive = _time_alive;
         super(_level,_xPos,_yPos,_text,_onComplete,_delay,_sprite,_isRateButton);
         delay = _delay;
         balloon = new CaptionBalloon(this,WIDTH,HEIGHT);
         addChild(balloon);
         pivotX = int(Math.floor(WIDTH * 0.5));
         pivotY = int(Math.floor(HEIGHT * 0.5));
         stateMachine.setState("IS_WAITING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         balloon.visible = false;
         if(stateMachine.currentState == "IS_WAITING_INPUT_STATE")
         {
            --this.time_alive;
            if(this.time_alive == 0)
            {
               stateMachine.performAction("INPUT_ACTION");
            }
         }
      }
      
      override public function getCharRenderTime() : int
      {
         return 2;
      }
      
      override public function getCharName(_color:int = 16777215) : String
      {
         return "whiteSmallFontChar_";
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
         return GameText.getCharWidth(code,GameText.TYPE_SMALL_WHITE);
      }
      
      override public function setPosition(_xPos:int, _yPos:int) : void
      {
         this.x = _xPos;
         this.y = _yPos;
      }
      
      override public function processInput() : void
      {
      }
   }
}
