package interfaces.panels
{
   import interfaces.texts.GameText;
   import starling.display.Sprite;
   
   public class TapToPlayPanel extends Sprite
   {
       
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var bluePanel:BluePanel;
      
      protected var gameText:GameText;
      
      public var HEIGHT:int;
      
      public var IS_BLINKING:Boolean;
      
      public function TapToPlayPanel()
      {
         super();
         this.gameText = new GameText(StringsManager.GetString("panel_tap_to_play"),GameText.TYPE_SMALL_WHITE);
         this.HEIGHT = int(Utils.HEIGHT * 0.085);
         if(this.HEIGHT < 16)
         {
            this.HEIGHT = 16;
         }
         this.IS_BLINKING = false;
         this.bluePanel = new BluePanel(this.gameText.WIDTH + 48,this.HEIGHT);
         addChild(this.bluePanel);
         addChild(this.gameText);
         this.gameText.pivotX = int(this.gameText.WIDTH * 0.5);
         this.gameText.pivotY = int(this.gameText.HEIGHT * 0.5);
         this.gameText.x = int(this.bluePanel.WIDTH * 0.5);
         this.gameText.y = int(this.HEIGHT * 0.5) - 1;
         if(Utils.IS_ANDROID)
         {
            if(Utils.EnableFontStrings)
            {
               if(Utils.Lang == "_tr" || Utils.Lang == "_ru")
               {
                  this.gameText.y += 1;
               }
               else
               {
                  this.gameText.y += 2;
               }
            }
         }
      }
      
      public function destroy() : void
      {
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
         removeChild(this.gameText);
         this.gameText.destroy();
         this.gameText.dispose();
         this.gameText = null;
      }
      
      public function blink() : void
      {
         this.IS_BLINKING = true;
         this.gameText.visible = true;
         this.counter_1 = 0;
         this.counter_2 = 0;
      }
      
      public function update() : void
      {
         if(this.IS_BLINKING)
         {
            ++this.counter_1;
            if(this.counter_1 >= 4)
            {
               this.counter_1 = 0;
               this.gameText.visible = !this.gameText.visible;
            }
            ++this.counter_2;
            if(this.counter_2 >= 60)
            {
               this.gameText.visible = true;
            }
         }
         else
         {
            ++this.counter_1;
            if(this.counter_1 < 30)
            {
               this.gameText.visible = true;
            }
            else if(this.counter_1 >= 30 && this.counter_1 < 40)
            {
               this.gameText.visible = false;
            }
            else if(this.counter_1 >= 40 && this.counter_1 < 100)
            {
               this.gameText.visible = true;
            }
            else if(this.counter_1 >= 100 && this.counter_1 < 106)
            {
               this.gameText.visible = false;
            }
            else if(this.counter_1 >= 106 && this.counter_1 < 112)
            {
               this.gameText.visible = true;
            }
            else if(this.counter_1 >= 112 && this.counter_1 < 118)
            {
               this.gameText.visible = false;
            }
            else
            {
               this.counter_1 = -30;
            }
         }
      }
   }
}
