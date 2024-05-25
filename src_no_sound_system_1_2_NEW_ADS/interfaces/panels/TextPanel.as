package interfaces.panels
{
   import interfaces.texts.GameText;
   import starling.display.Sprite;
   
   public class TextPanel extends Sprite
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var gameText:GameText;
      
      protected var bluePanel:BluePanel;
      
      public function TextPanel(text:String, _WIDTH:Number = 0, _HEIGHT:Number = 0)
      {
         super();
         this.WIDTH = _WIDTH;
         this.HEIGHT = _HEIGHT;
         this.gameText = new GameText(text);
         if(this.WIDTH == 0)
         {
            this.WIDTH = this.gameText.WIDTH + 32;
            this.HEIGHT = this.gameText.HEIGHT + 12;
         }
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT,BluePanel.TYPE_B);
         addChild(this.bluePanel);
         addChild(this.gameText);
         this.gameText.x = int(this.WIDTH * 0.5 - this.gameText.WIDTH * 0.5);
         this.gameText.y = int(this.HEIGHT * 0.5 - this.gameText.HEIGHT * 0.5);
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
         this.fit();
      }
      
      public function fit() : void
      {
         if(this.gameText.WIDTH > this.WIDTH - 8)
         {
            this.gameText.width = this.WIDTH - 16;
            this.gameText.WIDTH = this.WIDTH - 16;
            this.gameText.x = int(width * 0.5 - this.gameText.width * 0.5);
         }
      }
      
      public function destroy() : void
      {
         removeChild(this.gameText);
         this.gameText.destroy();
         this.gameText.dispose();
         this.gameText = null;
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
      }
      
      public function updateText(_newString:String) : void
      {
         this.gameText.updateText(_newString);
         this.gameText.x = int(this.WIDTH * 0.5 - this.gameText.WIDTH * 0.5);
      }
   }
}
