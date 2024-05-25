package interfaces.panels
{
   import game_utils.LevelItems;
   import interfaces.texts.GameText;
   import sprites.minigames.GachaToySprite;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class GachaShowcasePanel extends Sprite
   {
      
      protected static var LAST_SEEN_INDEX:int = 0;
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var bg:Image;
      
      protected var sxButton:Button;
      
      protected var dxButton:Button;
      
      protected var toySprites:Vector.<GachaToySprite>;
      
      protected var nameText:GameText;
      
      protected var unlockedImage:Image;
      
      public function GachaShowcasePanel(_WIDTH:int, _HEIGHT:int)
      {
         super();
         this.WIDTH = _WIDTH;
         this.HEIGHT = _HEIGHT;
         this.bg = new Image(TextureManager.hudTextureAtlas.getTexture("redQuad"));
         this.bg.touchable = false;
         this.bg.width = this.WIDTH - 8;
         this.bg.height = this.HEIGHT - 8;
         this.bg.x = this.bg.y = 4;
         addChild(this.bg);
         this.initToySprites();
         this.toySprites[LAST_SEEN_INDEX].visible = true;
         this.unlockedImage = new Image(TextureManager.hudTextureAtlas.getTexture("shopRemoveIcon"));
         this.unlockedImage.touchable = false;
         this.unlockedImage.pivotX = int(this.unlockedImage.width * 0.5);
         this.unlockedImage.pivotY = int(this.unlockedImage.height * 0.5);
         addChild(this.unlockedImage);
         this.unlockedImage.x = int(this.WIDTH * 0.5);
         this.unlockedImage.y = int(this.HEIGHT * 0.5);
         this.sxButton = new Button(TextureManager.hudTextureAtlas.getTexture("sx_arrow_button1"),"",TextureManager.hudTextureAtlas.getTexture("sx_arrow_button2"));
         this.sxButton.name = "sx";
         Image(Sprite(this.sxButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.dxButton = new Button(TextureManager.hudTextureAtlas.getTexture("dx_arrow_button1"),"",TextureManager.hudTextureAtlas.getTexture("dx_arrow_button2"));
         this.dxButton.name = "dx";
         Image(Sprite(this.dxButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         addChild(this.sxButton);
         addChild(this.dxButton);
         this.sxButton.x = int(this.WIDTH * 0.15 - this.sxButton.width * 0.5);
         this.dxButton.x = int(this.WIDTH * 0.85 - this.dxButton.width * 0.5);
         this.sxButton.y = this.dxButton.y = int(this.HEIGHT * 0.5 - this.sxButton.height * 0.5);
         this.sxButton.addEventListener(Event.TRIGGERED,this.onClick);
         this.dxButton.addEventListener(Event.TRIGGERED,this.onClick);
         this.nameText = new GameText("TEST",GameText.TYPE_BIG);
         this.nameText.pivotX = int(this.nameText.WIDTH * 0.5);
         this.nameText.pivotY = int(this.nameText.HEIGHT * 0.5);
         addChild(this.nameText);
         this.nameText.x = int(this.WIDTH * 0.5);
         this.nameText.y = int(this.HEIGHT * 0.9);
         if(Utils.Slot.playerInventory[LevelItems.ITEM_GACHA_1] >> GachaShowcasePanel.LAST_SEEN_INDEX)
         {
            this.toySprites[GachaShowcasePanel.LAST_SEEN_INDEX].visible = true;
         }
         else
         {
            this.toySprites[GachaShowcasePanel.LAST_SEEN_INDEX].visible = false;
         }
         this.unlockedImage.visible = !this.toySprites[GachaShowcasePanel.LAST_SEEN_INDEX].visible;
         this.updateText();
      }
      
      public function setEnabled(_value:Boolean) : void
      {
      }
      
      protected function switchOption(isSx:Boolean) : void
      {
         var i:int = 0;
         for(i = 0; i < this.toySprites.length; i++)
         {
            this.toySprites[i].visible = false;
         }
         if(isSx)
         {
            --GachaShowcasePanel.LAST_SEEN_INDEX;
            if(GachaShowcasePanel.LAST_SEEN_INDEX < 0)
            {
               GachaShowcasePanel.LAST_SEEN_INDEX = 19;
            }
         }
         else
         {
            ++GachaShowcasePanel.LAST_SEEN_INDEX;
            if(GachaShowcasePanel.LAST_SEEN_INDEX >= 20)
            {
               GachaShowcasePanel.LAST_SEEN_INDEX = 0;
            }
         }
         if(Utils.Slot.playerInventory[LevelItems.ITEM_GACHA_1] >> GachaShowcasePanel.LAST_SEEN_INDEX)
         {
            this.toySprites[GachaShowcasePanel.LAST_SEEN_INDEX].visible = true;
         }
         else
         {
            this.toySprites[GachaShowcasePanel.LAST_SEEN_INDEX].visible = false;
         }
         this.unlockedImage.visible = !this.toySprites[GachaShowcasePanel.LAST_SEEN_INDEX].visible;
         this.updateText();
      }
      
      protected function updateText() : void
      {
         if(GachaShowcasePanel.LAST_SEEN_INDEX < 9)
         {
            this.nameText.updateText("#0" + (GachaShowcasePanel.LAST_SEEN_INDEX + 1));
         }
         else
         {
            this.nameText.updateText("#" + (GachaShowcasePanel.LAST_SEEN_INDEX + 1));
         }
         this.nameText.pivotX = int(this.nameText.WIDTH * 0.5);
      }
      
      public function onClick(event:Event) : void
      {
         if(!this.visible)
         {
            return;
         }
         SoundSystem.PlaySound("select");
         var button:Button = event.target as Button;
         if(button.name == "sx")
         {
            this.switchOption(true);
         }
         else if(button.name == "dx")
         {
            this.switchOption(false);
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         removeChild(this.nameText);
         this.nameText.destroy();
         this.nameText.dispose();
         this.nameText = null;
         removeChild(this.unlockedImage);
         this.unlockedImage.dispose();
         this.unlockedImage = null;
         for(i = 0; i < this.toySprites.length; i++)
         {
            removeChild(this.toySprites[i]);
            this.toySprites[i].destroy();
            this.toySprites[i].dispose();
            this.toySprites[i] = null;
         }
         this.toySprites = null;
         this.sxButton.removeEventListener(Event.TRIGGERED,this.onClick);
         this.dxButton.removeEventListener(Event.TRIGGERED,this.onClick);
         removeChild(this.bg);
         this.bg.dispose();
         this.bg = null;
         removeChild(this.sxButton);
         removeChild(this.dxButton);
         this.sxButton.dispose();
         this.dxButton.dispose();
         this.sxButton = null;
         this.dxButton = null;
      }
      
      protected function initToySprites() : void
      {
         var i:int = 0;
         var gachaSprite:GachaToySprite = null;
         var amount:int = 20;
         this.toySprites = new Vector.<GachaToySprite>();
         for(i = 0; i < 20; i++)
         {
            gachaSprite = new GachaToySprite(i);
            addChild(gachaSprite);
            gachaSprite.x = int(this.WIDTH * 0.5);
            gachaSprite.y = int(this.HEIGHT * 0.5);
            gachaSprite.visible = false;
            this.toySprites.push(gachaSprite);
         }
      }
   }
}
