package interfaces.panels
{
   import game_utils.LevelItems;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class MapItemsPanel extends Sprite
   {
       
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var bellImage:Image;
      
      protected var bell_amount:int;
      
      protected var digits:Array;
      
      public var HEIGHT:int;
      
      public function MapItemsPanel()
      {
         super();
         this.bell_amount = Utils.Slot.playerInventory[LevelItems.ITEM_BELL];
         this.initPanel();
         this.HEIGHT = 16;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         removeChild(this.bellImage);
         this.bellImage.dispose();
         this.bellImage = null;
         for(i = 0; i < this.digits.length; i++)
         {
            removeChild(this.digits[i]);
            this.digits[i].dispose();
            this.digits[i] = null;
         }
         this.digits = null;
      }
      
      public function update() : void
      {
      }
      
      protected function initPanel() : void
      {
         var i:int = 0;
         var string:String = null;
         var image:Image = null;
         var advance:int = 20;
         string = "" + this.bell_amount;
         if(this.bell_amount < 10)
         {
            string = "0" + this.bell_amount;
         }
         this.bellImage = new Image(TextureManager.hudTextureAtlas.getTexture("bell_map_icon"));
         this.bellImage.touchable = false;
         this.bellImage.x = this.bellImage.y = 0;
         addChild(this.bellImage);
         this.digits = new Array();
         for(i = 0; i < string.length; i++)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("map_digit_" + (string.charCodeAt(i) - 48)));
            image.touchable = false;
            addChild(image);
            image.x = advance;
            image.y = 1;
            advance += this.getDigitWidth(string.charCodeAt(i) - 48);
         }
      }
      
      protected function getDigitWidth(index:int) : int
      {
         var __width:int = 0;
         if(index == 1)
         {
            __width = 11;
         }
         else if(index == 7)
         {
            __width = 13;
         }
         else
         {
            __width = 14;
         }
         return __width;
      }
      
      public function updateAmount() : void
      {
      }
      
      protected function pauseState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = 0;
      }
      
      protected function levelCompleteState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = 20;
      }
      
      protected function animationOverState() : void
      {
      }
   }
}
