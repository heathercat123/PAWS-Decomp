package interfaces.buttons
{
   import flash.geom.Matrix;
   import game_utils.LevelItems;
   import interfaces.texts.GameText;
   import starling.display.Button;
   import starling.display.Image;
   import starling.textures.RenderTexture;
   
   public class ShopInventoryButton extends Button
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var upTexture:RenderTexture;
      
      protected var downTexture:RenderTexture;
      
      protected var item_icon:Image;
      
      public var item_amount:Number;
      
      protected var item_amount_text:GameText;
      
      protected var REDRAW_FLAG:Boolean;
      
      public var index:int;
      
      public function ShopInventoryButton(_iconName:String, _amount:Number, _WIDTH:Number, _HEIGHT:Number, _index:int)
      {
         this.WIDTH = _WIDTH;
         this.HEIGHT = _HEIGHT;
         this.index = _index;
         this.item_amount = _amount;
         this.REDRAW_FLAG = false;
         this.upTexture = null;
         this.downTexture = null;
         this.createUpTexture();
         this.createDownTexture();
         super(this.upTexture,"",this.downTexture);
         if(_iconName == null)
         {
            this.item_icon = new Image(TextureManager.hudTextureAtlas.getTexture("shopRemoveIcon"));
            this.item_icon.visible = false;
         }
         else
         {
            this.item_icon = new Image(TextureManager.hudTextureAtlas.getTexture(_iconName));
         }
         this.item_icon.pivotX = int(this.item_icon.width * 0.5);
         this.item_icon.pivotY = int(this.item_icon.height * 0.5);
         this.item_icon.x = int(_WIDTH * 0.5);
         this.item_icon.y = int(_HEIGHT * 0.5);
         addChild(this.item_icon);
         this.item_icon.touchable = false;
         this.item_amount_text = new GameText("" + _amount,GameText.TYPE_SMALL_WHITE);
         this.item_amount_text.pivotX = int(this.item_amount_text.WIDTH);
         this.item_amount_text.pivotY = int(this.item_amount_text.HEIGHT);
         this.item_amount_text.x = int(_WIDTH - 4);
         this.item_amount_text.y = int(_HEIGHT - 3);
         addChild(this.item_amount_text);
         if(this.item_icon.visible == false || this.index == LevelItems.ITEM_GACHA_1)
         {
            this.item_amount_text.visible = false;
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
      }
      
      public function update() : void
      {
         if(this.item_icon.visible == false)
         {
            touchable = false;
         }
         if(this.REDRAW_FLAG)
         {
            this.REDRAW_FLAG = false;
            this.createUpTexture();
            this.createDownTexture();
         }
      }
      
      public function destroy() : void
      {
         removeChild(this.item_amount_text);
         this.item_amount_text.destroy();
         this.item_amount_text.dispose();
         this.item_amount_text = null;
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
