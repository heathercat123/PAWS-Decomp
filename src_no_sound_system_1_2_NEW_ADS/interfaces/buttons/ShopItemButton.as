package interfaces.buttons
{
   import flash.geom.Matrix;
   import game_utils.LevelItems;
   import interfaces.texts.GameText;
   import starling.display.Button;
   import starling.display.Image;
   import starling.textures.RenderTexture;
   
   public class ShopItemButton extends Button
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var IS_HELPER:Boolean;
      
      protected var LEVEL:int;
      
      protected var upTexture:RenderTexture;
      
      protected var downTexture:RenderTexture;
      
      protected var item_icon:Image;
      
      public var item_price:Number;
      
      protected var item_price_text:GameText;
      
      protected var sold_text:GameText;
      
      protected var star_1:Image;
      
      protected var star_2:Image;
      
      protected var star_3:Image;
      
      public var index:int;
      
      protected var REDRAW_FLAG:Boolean;
      
      public var IS_VIP:Boolean;
      
      public function ShopItemButton(_iconName:String, _price:Number, _WIDTH:Number, _HEIGHT:Number, _index:int)
      {
         var _start_x:Number = NaN;
         this.WIDTH = _WIDTH;
         this.HEIGHT = _HEIGHT;
         this.IS_VIP = false;
         this.REDRAW_FLAG = false;
         this.index = _index;
         this.item_price = _price;
         if(this.item_price == -100)
         {
            this.IS_VIP = true;
         }
         this.LEVEL = -1;
         this.IS_HELPER = LevelItems.IsHelper(_index);
         this.upTexture = null;
         this.downTexture = null;
         this.createUpTexture();
         this.createDownTexture();
         super(this.upTexture,"",this.downTexture);
         this.item_icon = new Image(TextureManager.hudTextureAtlas.getTexture(_iconName));
         this.item_icon.pivotX = int(this.item_icon.width * 0.5);
         this.item_icon.pivotY = int(this.item_icon.height * 0.5);
         this.item_icon.x = int(_WIDTH * 0.5);
         this.item_icon.y = int(_HEIGHT * 0.4);
         addChild(this.item_icon);
         this.item_icon.touchable = false;
         if(this.IS_VIP)
         {
            this.item_price_text = new GameText("vip",GameText.TYPE_SMALL_WHITE,false,false,false,false,false,false,true);
         }
         else
         {
            this.item_price_text = new GameText("" + _price,GameText.TYPE_SMALL_WHITE,true);
         }
         this.item_price_text.pivotX = int(this.item_price_text.WIDTH * 0.5);
         this.item_price_text.pivotY = int(this.item_price_text.HEIGHT * 0.5);
         this.item_price_text.x = int(_WIDTH * 0.5);
         this.item_price_text.y = int(_HEIGHT * 0.82);
         addChild(this.item_price_text);
         if(_index < 0)
         {
            this.sold_text = new GameText(StringsManager.GetString("panel_remove"),GameText.TYPE_SMALL_WHITE);
         }
         else
         {
            this.sold_text = new GameText(StringsManager.GetString("panel_equip"),GameText.TYPE_SMALL_WHITE);
         }
         if(_index == -100)
         {
            this.sold_text.visible = false;
            this.item_icon.y = int(_HEIGHT * 0.5);
            alphaWhenDisabled = 1;
            enabled = false;
         }
         this.sold_text.pivotX = int(this.sold_text.WIDTH * 0.5);
         this.sold_text.pivotY = int(this.sold_text.HEIGHT * 0.5);
         this.sold_text.x = this.item_price_text.x;
         this.sold_text.y = this.item_price_text.y;
         addChild(this.sold_text);
         this.sold_text.visible = false;
         if(Utils.Lang != "_en")
         {
            if(this.sold_text.WIDTH > this.WIDTH)
            {
               this.sold_text.scaleX = 0.5;
            }
         }
         if(this.IS_HELPER)
         {
            this.sold_text.visible = false;
            this.LEVEL = Utils.Slot.playerInventory[this.index];
            this.star_1 = new Image(TextureManager.hudTextureAtlas.getTexture("star_symbol"));
            this.star_2 = new Image(TextureManager.hudTextureAtlas.getTexture(this.LEVEL >= 2 ? "star_symbol" : "star_symbol_empty"));
            this.star_3 = new Image(TextureManager.hudTextureAtlas.getTexture(this.LEVEL >= 3 ? "star_symbol" : "star_symbol_empty"));
            this.star_1.touchable = this.star_2.touchable = this.star_3.touchable = false;
            addChild(this.star_1);
            addChild(this.star_2);
            addChild(this.star_3);
            _start_x = int((this.WIDTH - 32) * 0.5);
            this.star_1.y = this.star_2.y = this.star_3.y = int(_HEIGHT * 0.75);
            this.star_1.x = _start_x;
            this.star_2.x = this.star_1.x + 11;
            this.star_3.x = this.star_2.x + 11;
         }
         else
         {
            this.star_1 = this.star_2 = this.star_3 = null;
         }
         this.refreshButton();
         this.upTexture.root.onRestore = this.restoreUp;
         this.downTexture.root.onRestore = this.restoreDown;
      }
      
      protected function restoreUp() : void
      {
         this.REDRAW_FLAG = true;
      }
      
      protected function restoreDown() : void
      {
         this.REDRAW_FLAG = true;
      }
      
      public function setAsPurchased() : void
      {
      }
      
      public function refreshButton() : void
      {
         if(this.index < 0)
         {
            this.item_price_text.visible = false;
            this.sold_text.visible = true;
            if(this.index == -100)
            {
               this.sold_text.visible = false;
            }
         }
         else if(Utils.Slot.playerInventory[this.index] > 0)
         {
            this.sold_text.visible = true;
            this.item_price_text.visible = false;
            if(this.IS_HELPER)
            {
               this.sold_text.visible = false;
               if(Utils.Slot.playerInventory[this.index] >= 3)
               {
               }
            }
         }
         else if(this.IS_HELPER)
         {
            this.star_1.visible = this.star_2.visible = this.star_3.visible = false;
         }
      }
      
      public function update() : void
      {
         if(this.REDRAW_FLAG)
         {
            this.REDRAW_FLAG = false;
            this.createUpTexture();
            this.createDownTexture();
         }
      }
      
      public function destroy() : void
      {
         if(this.star_1 != null)
         {
            removeChild(this.star_1);
            this.star_1.dispose();
            removeChild(this.star_2);
            this.star_2.dispose();
            removeChild(this.star_3);
            this.star_3.dispose();
            this.star_1 = this.star_2 = this.star_3 = null;
         }
         removeChild(this.sold_text);
         this.sold_text.destroy();
         this.sold_text.dispose();
         this.sold_text = null;
         removeChild(this.item_price_text);
         this.item_price_text.destroy();
         this.item_price_text.dispose();
         this.item_price_text = null;
         removeChild(this.item_icon);
         this.item_icon.dispose();
         this.item_icon = null;
         this.downTexture.dispose();
         this.downTexture = null;
         this.upTexture.dispose();
         this.upTexture = null;
      }
      
      protected function createUpTexture() : void
      {
         var matrix:Matrix = null;
         var image:Image = null;
         if(this.WIDTH < 0)
         {
            this.WIDTH = 2;
         }
         if(this.HEIGHT < 0)
         {
            this.HEIGHT = 2;
         }
         if(this.upTexture == null)
         {
            this.upTexture = new RenderTexture(this.WIDTH,this.HEIGHT);
         }
         else
         {
            this.upTexture.clear();
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart1"));
         this.upTexture.draw(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,0);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,0);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(this.WIDTH - 8,8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(0,8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart9"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,(this.HEIGHT - 16) / 8);
         matrix.translate(8,8);
         this.upTexture.draw(image,matrix);
      }
      
      protected function createDownTexture() : void
      {
         var matrix:Matrix = null;
         var image:Image = null;
         if(this.downTexture == null)
         {
            this.downTexture = new RenderTexture(this.WIDTH,this.HEIGHT);
         }
         else
         {
            this.downTexture.clear();
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart1"));
         matrix = new Matrix();
         matrix.translate(0,0);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,0);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,0);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(this.WIDTH - 8,8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(0,8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart9"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,(this.HEIGHT - 16) / 8);
         matrix.translate(8,8);
         this.downTexture.draw(image,matrix);
      }
   }
}
