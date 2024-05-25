package interfaces.panels
{
   import interfaces.buttons.BigTextButton;
   import interfaces.texts.GameText;
   import starling.display.Button;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class ExitTextPanel extends Sprite
   {
       
      
      protected var bluePanel:BluePanel;
      
      protected var golden_cat_text:GameText;
      
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
      
      public function ExitTextPanel(_width:int, _height:int)
      {
         super();
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.mid_x = int(this.WIDTH * 0.5);
         this.bottom_mid_y = int(this.HEIGHT * 0.75);
         this.top_mid_y = int(this.HEIGHT * 0.25);
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT);
         addChild(this.bluePanel);
         this.initText();
         this.initImage();
         this.yesButton.addEventListener(Event.TRIGGERED,this.onExitClick);
         this.noButton.addEventListener(Event.TRIGGERED,this.onExitClick);
         this.CONTINUE_FLAG = false;
         this.QUIT_FLAG = false;
      }
      
      protected function onExitClick(event:Event) : void
      {
         var button:Button = event.target as Button;
         if(button.name == "yes")
         {
            this.CONTINUE_FLAG = false;
            this.QUIT_FLAG = true;
         }
         else
         {
            this.CONTINUE_FLAG = true;
            this.QUIT_FLAG = false;
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
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
         this.golden_cat_text.x = int((this.WIDTH - this.golden_cat_text.WIDTH) * 0.5);
         if(Utils.EnableFontStrings)
         {
            this.golden_cat_text.x = int((this.WIDTH - this.golden_cat_text.WIDTH) * 0.5);
         }
         this.golden_cat_text.y = int(this.HEIGHT * 0.225);
      }
      
      protected function initText() : void
      {
         this.golden_cat_text = new GameText(StringsManager.GetString("reset_line_0"),GameText.TYPE_BIG);
         this.golden_cat_text.x = int((this.WIDTH - this.golden_cat_text.WIDTH) * 0.5);
         addChild(this.golden_cat_text);
         this.yesButton = new BigTextButton((this.WIDTH - 36) * 0.5,this.HEIGHT * 0.4,StringsManager.GetString("yes"));
         addChild(this.yesButton);
         this.yesButton.name = "yes";
         this.yesButton.x = int(12);
         this.yesButton.y = int(this.HEIGHT - int(this.HEIGHT * 0.4 + 10));
         this.noButton = new BigTextButton((this.WIDTH - 36) * 0.5,this.HEIGHT * 0.4,StringsManager.GetString("no"));
         addChild(this.noButton);
         this.noButton.name = "no";
         this.noButton.x = int(24 + this.yesButton.WIDTH);
         this.noButton.y = int(this.HEIGHT - int(this.HEIGHT * 0.4 + 10));
      }
      
      protected function initImage() : void
      {
      }
   }
}
