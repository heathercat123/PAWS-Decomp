package interfaces.panels
{
   import game_utils.LevelItems;
   import interfaces.texts.GameText;
   import sprites.GameSprite;
   import starling.display.Sprite;
   
   public class SingleItemPanel extends Sprite
   {
       
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var itemSprite:GameSprite;
      
      protected var itemText:GameText;
      
      protected var itemIndex:int;
      
      public function SingleItemPanel(_index:int)
      {
         super();
         this.itemIndex = _index;
         this.initPanel();
      }
      
      public function destroy() : void
      {
         removeChild(this.itemText);
         this.itemText.destroy();
         this.itemText.dispose();
         this.itemText = null;
         removeChild(this.itemSprite);
         this.itemSprite.destroy();
         this.itemSprite.dispose();
         this.itemSprite = null;
      }
      
      protected function initPanel() : void
      {
         var H_WIDTH:int = 0;
         this.itemSprite = LevelItems.GetItemSprite(this.itemIndex);
         this.itemSprite.gotoAndStop(3);
         this.itemSprite.updateScreenPosition();
         var string:String = "";
         var amount:int = int(Utils.Slot.playerInventory[this.itemIndex]);
         if(amount < 10)
         {
            string = "0" + amount;
         }
         else
         {
            string = "" + amount;
         }
         this.itemText = new GameText(string,GameText.TYPE_BIG);
         addChild(this.itemSprite);
         this.itemSprite.x = 16;
         this.itemSprite.y = 0;
         addChild(this.itemText);
         this.itemText.x = this.itemSprite.x + int(this.itemSprite.width * 0.5 + 4);
         this.itemText.y = -int(this.itemText.HEIGHT * 0.5);
         var T_WIDTH:int = 36 + this.itemText.WIDTH;
         H_WIDTH = int(T_WIDTH * 0.5);
         this.itemSprite.x -= H_WIDTH;
         this.itemText.x -= H_WIDTH;
      }
   }
}
