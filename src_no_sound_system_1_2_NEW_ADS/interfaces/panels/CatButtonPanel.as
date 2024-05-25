package interfaces.panels
{
   import sprites.hud.ItemSmallIconHudSprite;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class CatButtonPanel extends Sprite
   {
       
      
      public var slotButton:Button;
      
      public var catButton:Button;
      
      public var hintButton:Button;
      
      public var additional_x_margin:int;
      
      public var additional_y_margin:int;
      
      public var itemSprite:ItemSmallIconHudSprite;
      
      public var itemHintSprite:ItemSmallIconHudSprite;
      
      public function CatButtonPanel()
      {
         super();
         if(Utils.IS_IPHONE_X)
         {
            this.additional_x_margin = 16;
            this.additional_y_margin = -2;
         }
         else
         {
            this.additional_x_margin = -4;
            this.additional_y_margin = -3;
         }
         this.slotButton = new Button(TextureManager.hudTextureAtlas.getTexture("itemSlotButton1"),"",TextureManager.hudTextureAtlas.getTexture("itemSlotButton2"));
         this.catButton = new Button(TextureManager.hudTextureAtlas.getTexture("catButton1"),"",TextureManager.hudTextureAtlas.getTexture("catButton2"));
         this.hintButton = new Button(TextureManager.hudTextureAtlas.getTexture("hud_item_hint_balloon"),"",TextureManager.hudTextureAtlas.getTexture("hud_item_hint_balloon"));
         Image(Sprite(this.slotButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         Image(Sprite(this.catButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         Image(Sprite(this.hintButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.slotButton.x = this.additional_x_margin;
         this.slotButton.y = -this.catButton.height;
         this.catButton.x = this.additional_x_margin;
         this.catButton.y = -this.catButton.height;
         this.itemSprite = new ItemSmallIconHudSprite();
         this.itemHintSprite = new ItemSmallIconHudSprite();
         this.itemHintSprite.touchable = false;
         this.itemHintSprite.visible = false;
         this.hintButton.visible = false;
         addChild(this.catButton);
         addChild(this.slotButton);
         addChild(this.itemSprite);
         addChild(this.hintButton);
         addChild(this.itemHintSprite);
      }
      
      public function showSlotButton() : void
      {
         if(Utils.IS_IPHONE_X)
         {
            this.additional_x_margin = 16 + 8;
            this.additional_y_margin = -2;
         }
         else
         {
            this.additional_x_margin = 4;
            this.additional_y_margin = -3;
         }
         this.slotButton.x = this.additional_x_margin;
         this.slotButton.y = 4;
         this.catButton.x += this.slotButton.width + 8;
      }
      
      public function destroy() : void
      {
         removeChild(this.hintButton);
         this.hintButton.dispose();
         this.hintButton = null;
         removeChild(this.slotButton);
         this.slotButton.dispose();
         this.slotButton = null;
         removeChild(this.catButton);
         this.catButton.dispose();
         this.catButton = null;
         removeChild(this.itemSprite);
         this.itemSprite.destroy();
         this.itemSprite.dispose();
         this.itemSprite = null;
         removeChild(this.itemHintSprite);
         this.itemHintSprite.destroy();
         this.itemHintSprite.dispose();
         this.itemHintSprite = null;
      }
   }
}
