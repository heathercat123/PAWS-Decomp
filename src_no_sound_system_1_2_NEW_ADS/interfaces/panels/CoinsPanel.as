package interfaces.panels
{
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import interfaces.buttons.MoreCoinsButton;
   import interfaces.texts.GameText;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class CoinsPanel extends Sprite
   {
       
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var coinImage:Image;
      
      protected var coinText:GameText;
      
      protected var coin_amount:int;
      
      public var moreCoinsButton:MoreCoinsButton;
      
      public var HEIGHT:int;
      
      public var WIDTH:int;
      
      public function CoinsPanel(_withButton:Boolean = false)
      {
         super();
         this.coin_amount = Utils.Slot.playerInventory[LevelItems.ITEM_COIN];
         this.initPanel();
         this.HEIGHT = 16;
         this.moreCoinsButton = null;
         if(_withButton)
         {
            this.moreCoinsButton = new MoreCoinsButton();
            addChild(this.moreCoinsButton);
            this.moreCoinsButton.x = -(this.moreCoinsButton.WIDTH + 4);
            this.moreCoinsButton.y = 0;
         }
      }
      
      public function destroy() : void
      {
         if(this.moreCoinsButton != null)
         {
            removeChild(this.moreCoinsButton);
            this.moreCoinsButton.destroy();
            this.moreCoinsButton.dispose();
            this.moreCoinsButton = null;
         }
         removeChild(this.coinImage);
         this.coinImage.dispose();
         this.coinImage = null;
         removeChild(this.coinText);
         this.coinText.destroy();
         this.coinText.dispose();
         this.coinText = null;
      }
      
      public function update() : void
      {
         if(this.moreCoinsButton != null)
         {
            this.moreCoinsButton.update();
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_IS_PLAYPASS] == 1)
            {
               this.moreCoinsButton.visible = false;
            }
         }
      }
      
      protected function initPanel() : void
      {
         this.coinImage = new Image(TextureManager.hudTextureAtlas.getTexture("coin_icon_1"));
         addChild(this.coinImage);
         this.coinText = new GameText("" + this.coin_amount,GameText.TYPE_SMALL_WHITE);
         addChild(this.coinText);
         this.coinText.x = int(this.coinImage.width + 4);
         this.coinText.y = int((this.coinImage.height - this.coinText.HEIGHT) * 0.5);
         this.WIDTH = 17 + this.coinText.WIDTH;
      }
      
      public function updateAmount() : void
      {
         this.coin_amount = Utils.Slot.playerInventory[LevelItems.ITEM_COIN];
         this.coinText.updateText("" + this.coin_amount);
         this.WIDTH = 15 + this.coinText.WIDTH;
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
