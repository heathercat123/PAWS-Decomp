package interfaces.buttons
{
   import flash.geom.Matrix;
   import interfaces.texts.GameText;
   import sprites.GameSprite;
   import sprites.hud.ShopTierSprite;
   import starling.display.Button;
   import starling.display.Image;
   import starling.textures.RenderTexture;
   
   public class ShopTierButton extends Button
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var upTexture:RenderTexture;
      
      protected var downTexture:RenderTexture;
      
      protected var item_icon:Image;
      
      protected var item_sprite:GameSprite;
      
      public var item_price:String;
      
      protected var item_price_text:GameText;
      
      public var IS_PURCHASED:Boolean;
      
      protected var purchaseMarkImage:Image;
      
      protected var REDRAW_FLAG:Boolean;
      
      public var index:int;
      
      public function ShopTierButton(_iconName:String, _price:String, _WIDTH:Number, _HEIGHT:Number)
      {
         this.WIDTH = _WIDTH;
         this.HEIGHT = _HEIGHT;
         this.item_price = _price;
         this.index = 0;
         this.REDRAW_FLAG = false;
         this.upTexture = null;
         this.downTexture = null;
         this.createUpTexture();
         this.createDownTexture();
         super(this.upTexture,"",this.downTexture);
         if(_iconName == "tierShopAnim_diamond" || _iconName == "moreCoinsTierShop1Anim_a" || _iconName == "moreCoinsTierShop2Anim_a" || _iconName == "moreCoinsTierShop3Anim_a")
         {
            if(_iconName == "moreCoinsTierShop1Anim_a")
            {
               this.item_sprite = new ShopTierSprite();
               this.item_sprite.gotoAndStop(1);
               this.item_sprite.updateScreenPosition();
            }
            else if(_iconName == "moreCoinsTierShop2Anim_a")
            {
               this.item_sprite = new ShopTierSprite();
               this.item_sprite.gotoAndStop(2);
               this.item_sprite.updateScreenPosition();
            }
            else if(_iconName == "moreCoinsTierShop3Anim_a")
            {
               this.item_sprite = new ShopTierSprite();
               this.item_sprite.gotoAndStop(3);
               this.item_sprite.updateScreenPosition();
            }
            this.item_icon = null;
            this.item_sprite.x = int(_WIDTH * 0.5);
            this.item_sprite.y = int(_HEIGHT * 0.375);
            addChild(this.item_sprite);
            this.item_sprite.touchable = false;
         }
         else
         {
            this.item_icon = new Image(TextureManager.hudTextureAtlas.getTexture(_iconName));
            this.item_icon.pivotX = int(this.item_icon.width * 0.5);
            this.item_icon.pivotY = int(this.item_icon.height * 0.5);
            this.item_sprite = null;
            this.item_icon.x = int(_WIDTH * 0.5);
            this.item_icon.y = int(_HEIGHT * 0.4);
            addChild(this.item_icon);
            this.item_icon.touchable = false;
         }
         this.item_price_text = new GameText("" + this.item_price,GameText.TYPE_BIG);
         this.item_price_text.pivotX = int(this.item_price_text.WIDTH * 0.5);
         this.item_price_text.pivotY = int(this.item_price_text.HEIGHT * 0.5);
         this.item_price_text.x = int(_WIDTH * 0.5);
         this.item_price_text.y = int(_HEIGHT * 0.82);
         this.IS_PURCHASED = false;
         this.purchaseMarkImage = new Image(TextureManager.hudTextureAtlas.getTexture("purchase_mark_symbol"));
         this.purchaseMarkImage.touchable = false;
         this.purchaseMarkImage.pivotX = int(this.purchaseMarkImage.width * 0.5);
         this.purchaseMarkImage.pivotY = int(this.purchaseMarkImage.width * 0.5);
         this.purchaseMarkImage.x = this.item_price_text.x;
         this.purchaseMarkImage.y = this.item_price_text.y;
         this.purchaseMarkImage.visible = false;
         this.item_price_text.visible = true;
         addChild(this.item_price_text);
         addChild(this.purchaseMarkImage);
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
      
      public function destroy() : void
      {
         removeChild(this.purchaseMarkImage);
         this.purchaseMarkImage.dispose();
         this.purchaseMarkImage = null;
         removeChild(this.item_price_text);
         this.item_price_text.destroy();
         this.item_price_text.dispose();
         this.item_price_text = null;
         if(this.item_icon != null)
         {
            removeChild(this.item_icon);
            this.item_icon.dispose();
            this.item_icon = null;
         }
         if(this.item_sprite != null)
         {
            removeChild(this.item_sprite);
            this.item_sprite.destroy();
            this.item_sprite.dispose();
            this.item_sprite = null;
         }
         this.downTexture.dispose();
         this.downTexture = null;
         this.upTexture.dispose();
         this.upTexture = null;
      }
      
      public function update() : void
      {
         if(this.item_sprite != null)
         {
            if(this.item_sprite.gfxHandleClip().isComplete)
            {
               this.item_sprite.gfxHandleClip().setFrameDuration(0,Math.random() * 1.5 + 0.2);
               this.item_sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         if(this.REDRAW_FLAG)
         {
            this.REDRAW_FLAG = false;
            this.createUpTexture();
            this.createDownTexture();
         }
      }
      
      public function refreshButton() : void
      {
      }
      
      public function setAsPurchased() : void
      {
         this.item_price_text.visible = false;
         this.purchaseMarkImage.visible = true;
         this.IS_PURCHASED = true;
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
