package interfaces.panels
{
   import game_utils.CoinPrices;
   import game_utils.GameSlot;
   import interfaces.texts.GameText;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class QuestProgressionBarPanel extends Sprite
   {
       
      
      protected var bar_container:Sprite;
      
      protected var body_width:int;
      
      protected var images:Vector.<Image>;
      
      protected var barStartImage:Image;
      
      protected var barEndImage:Image;
      
      protected var barImage:Image;
      
      protected var amountText:GameText;
      
      protected var starImage:Image;
      
      protected var rewardText:GameText;
      
      public function QuestProgressionBarPanel(quest_panel_width:int)
      {
         super();
         this.body_width = int(quest_panel_width * 0.5);
         this.initImages();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.images.length; i++)
         {
            this.bar_container.removeChild(this.images[i]);
            this.images[i].dispose();
            this.images[i] = null;
         }
         this.images = null;
         removeChild(this.barStartImage);
         removeChild(this.barEndImage);
         removeChild(this.barImage);
         removeChild(this.amountText);
         removeChild(this.starImage);
         removeChild(this.rewardText);
         this.barStartImage.dispose();
         this.barEndImage.dispose();
         this.barImage.dispose();
         this.amountText.destroy();
         this.amountText.dispose();
         this.starImage.dispose();
         this.rewardText.destroy();
         this.rewardText.dispose();
         this.barStartImage = null;
         this.barEndImage = null;
         this.barImage = null;
         this.amountText = null;
         this.starImage = null;
         this.rewardText = null;
         removeChild(this.bar_container);
         this.bar_container.dispose();
         this.bar_container = null;
      }
      
      public function update() : void
      {
      }
      
      public function updateAmount(_current:int, _target:int) : void
      {
         var reward:int = 0;
         if(_current > _target)
         {
            _current = _target;
         }
         this.amountText.updateText("" + _current + "/" + _target);
         this.amountText.x = this.bar_container.x - this.amountText.WIDTH - 4;
         this.amountText.y = this.bar_container.y + 3;
         var perc:Number = _current * 100 / _target;
         this.updatePercentage(perc);
         this.starImage.visible = false;
         this.rewardText.visible = false;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_QUEST_STATUS] == 2)
         {
            this.starImage.visible = true;
         }
         else
         {
            this.rewardText.visible = true;
            reward = CoinPrices.GetPrice(CoinPrices.QUEST_REWARD);
            this.rewardText.updateText("" + reward);
         }
      }
      
      protected function updatePercentage(perc:Number) : void
      {
         if(perc < 0)
         {
            perc = 0;
         }
         else if(perc > 100)
         {
            perc = 100;
         }
         var bar_width:int = this.body_width - 6;
         var perc_pixels:int = int(perc * bar_width / 100);
         this.barStartImage.visible = this.barImage.visible = this.barEndImage.visible = false;
         if(perc_pixels >= 3 && perc_pixels < bar_width - 3)
         {
            this.barStartImage.visible = true;
            this.barImage.visible = true;
            this.barImage.width = perc_pixels - 3;
         }
         else if(perc_pixels >= bar_width - 3 && perc_pixels < bar_width)
         {
            this.barStartImage.visible = true;
            this.barImage.visible = true;
            this.barImage.width = bar_width - 6;
         }
         else if(perc_pixels >= bar_width)
         {
            this.barStartImage.visible = true;
            this.barImage.visible = true;
            this.barImage.width = bar_width - 6;
            this.barEndImage.visible = true;
         }
      }
      
      protected function initImages() : void
      {
         var image:Image = null;
         this.bar_container = new Sprite();
         addChild(this.bar_container);
         this.images = new Vector.<Image>();
         image = new Image(TextureManager.hudTextureAtlas.getTexture("quest_bar_1"));
         image.touchable = false;
         this.bar_container.addChild(image);
         this.images.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("quest_bar_2"));
         image.touchable = false;
         image.x = 8;
         image.width = this.body_width - 16;
         this.bar_container.addChild(image);
         this.images.push(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("quest_bar_1"));
         image.scaleX = -1;
         image.x = this.body_width;
         image.touchable = false;
         this.bar_container.addChild(image);
         this.images.push(image);
         this.barStartImage = new Image(TextureManager.hudTextureAtlas.getTexture("quest_bar_3"));
         this.barStartImage.touchable = false;
         this.barStartImage.x = 3;
         this.barStartImage.y = 4;
         this.bar_container.addChild(this.barStartImage);
         this.barEndImage = new Image(TextureManager.hudTextureAtlas.getTexture("quest_bar_3"));
         this.barEndImage.touchable = false;
         this.barEndImage.scaleX = -1;
         this.barEndImage.x = this.body_width - 3;
         this.barEndImage.y = 4;
         this.bar_container.addChild(this.barEndImage);
         this.barImage = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         this.barImage.touchable = false;
         this.barImage.x = 6;
         this.barImage.y = 3;
         this.barImage.width = this.body_width - 12;
         this.barImage.height = 8;
         this.bar_container.addChild(this.barImage);
         this.bar_container.x = -int(this.body_width * 0.5);
         this.bar_container.y = -7;
         this.amountText = new GameText("99/100",GameText.TYPE_SMALL_DARK);
         this.amountText.x = this.bar_container.x - this.amountText.WIDTH - 4;
         this.amountText.y = this.bar_container.y + 3;
         addChild(this.amountText);
         this.starImage = new Image(TextureManager.hudTextureAtlas.getTexture("quest_star_symbol"));
         this.starImage.touchable = false;
         addChild(this.starImage);
         this.starImage.x = this.bar_container.x + this.bar_container.width + 4;
         this.starImage.y = this.bar_container.y + 1;
         this.rewardText = new GameText("100",GameText.TYPE_SMALL_DARK,true);
         addChild(this.rewardText);
         this.rewardText.x = this.starImage.x;
         this.rewardText.y = this.amountText.y;
         this.starImage.visible = false;
      }
   }
}
