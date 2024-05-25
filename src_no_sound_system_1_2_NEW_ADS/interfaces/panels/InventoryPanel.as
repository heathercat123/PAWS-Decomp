package interfaces.panels
{
   import game_utils.LevelItems;
   import interfaces.texts.GameText;
   import sprites.GameSprite;
   import starling.display.Sprite;
   
   public class InventoryPanel extends Sprite
   {
       
      
      protected var bluePanel:BluePanel;
      
      protected var coinsPanel:CoinsPanel;
      
      protected var mid_x:int;
      
      protected var bottom_mid_y:int;
      
      protected var top_mid_y:int;
      
      protected var WIDTH:int;
      
      protected var HEIGHT:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var item_container:Sprite;
      
      protected var itemsAmount:Array;
      
      protected var animation_index:int;
      
      protected var margin:int;
      
      public function InventoryPanel(_width:int, _height:int)
      {
         super();
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.margin = int(8);
         this.mid_x = int(this.WIDTH * 0.5);
         this.bottom_mid_y = int(this.HEIGHT * 0.65);
         this.top_mid_y = int(this.HEIGHT * 0.15);
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT);
         this.bluePanel.drawLine(this.margin,this.HEIGHT * 0.3 - 2,this.WIDTH - this.margin * 2);
         addChild(this.bluePanel);
         this.initCoins();
         this.initItems();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.itemsAmount.length; i++)
         {
            this.item_container.removeChild(this.itemsAmount[i]);
            this.itemsAmount[i].destroy();
            this.itemsAmount[i].dispose();
            this.itemsAmount[i] = null;
         }
         this.itemsAmount = null;
         removeChild(this.item_container);
         this.item_container.dispose();
         this.item_container = null;
         removeChild(this.coinsPanel);
         this.coinsPanel.destroy();
         this.coinsPanel.dispose();
         this.coinsPanel = null;
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
      }
      
      public function update() : void
      {
      }
      
      protected function initCoins() : void
      {
         var inner_height:int = int(this.HEIGHT * 0.3);
         this.coinsPanel = new CoinsPanel();
         this.coinsPanel.pivotY = int(this.coinsPanel.HEIGHT * 0.5);
         addChild(this.coinsPanel);
         this.coinsPanel.x = int(this.margin * 1.5);
         this.coinsPanel.y = int(inner_height * 0.5);
      }
      
      protected function initItems() : void
      {
         var pSprite:GameSprite = null;
         var tAmount:GameText = null;
         var singleItem:SingleItemPanel = null;
         var step:int = int(this.WIDTH * 0.28);
         var innerWidth:int = int(this.WIDTH - this.margin * 2);
         this.item_container = new Sprite();
         addChild(this.item_container);
         this.item_container.x = this.mid_x;
         this.item_container.y = this.bottom_mid_y;
         this.itemsAmount = new Array();
         singleItem = new SingleItemPanel(LevelItems.ITEM_BELL);
         this.itemsAmount.push(singleItem);
         this.item_container.addChild(singleItem);
         singleItem.x = -int(innerWidth * 0.25);
         singleItem.y = 0;
         singleItem = new SingleItemPanel(LevelItems.ITEM_KEY);
         this.itemsAmount.push(singleItem);
         this.item_container.addChild(singleItem);
         singleItem.x = int(innerWidth * 0.25);
         singleItem.y = 0;
      }
      
      public function refreshContent() : void
      {
         this.coinsPanel.updateAmount();
      }
      
      protected function pauseState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = 0;
      }
      
      protected function levelCompleteState() : void
      {
         this.counter_1 = 0;
         this.counter_2 = -10;
         this.animation_index = 0;
      }
   }
}
