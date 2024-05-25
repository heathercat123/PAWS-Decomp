package interfaces.buttons
{
   import flash.geom.Matrix;
   import game_utils.InAppProductsManager;
   import interfaces.texts.GameText;
   import starling.display.Button;
   import starling.display.Image;
   import starling.textures.RenderTexture;
   
   public class BuyButton extends Button
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var upTexture:RenderTexture;
      
      protected var downTexture:RenderTexture;
      
      protected var purchaseMarkImage:Image;
      
      protected var buy_text:GameText;
      
      protected var IS_PREMIUM:Boolean;
      
      protected var REDRAW_FLAG:Boolean;
      
      public function BuyButton(_WIDTH:Number, _HEIGHT:Number, _isRestore:Boolean = false, _isUpgrade:Boolean = false, _isPremium:Boolean = false)
      {
         this.WIDTH = _WIDTH;
         this.HEIGHT = _HEIGHT;
         this.REDRAW_FLAG = false;
         this.IS_PREMIUM = _isPremium;
         this.upTexture = null;
         this.downTexture = null;
         this.createUpTexture();
         this.createDownTexture();
         super(this.upTexture,"",this.downTexture);
         if(_isRestore)
         {
            this.buy_text = new GameText(StringsManager.GetString("restore_3"),GameText.TYPE_BIG);
         }
         else if(_isUpgrade)
         {
            this.buy_text = new GameText(StringsManager.GetString("panel_shop_level_up"),GameText.TYPE_BIG);
         }
         else if(_isPremium)
         {
            if(Utils.IS_ANDROID)
            {
               this.buy_text = new GameText(InAppProductsManager.GetLocalizedPrice(Utils.ANDROID_INAPP_PREMIUM_PRODUCT),GameText.TYPE_BIG);
            }
            else
            {
               this.buy_text = new GameText(InAppProductsManager.GetLocalizedPrice("com.neutronized.supercattalespaws.premium"),GameText.TYPE_BIG);
            }
         }
         else
         {
            this.buy_text = new GameText(StringsManager.GetString("panel_buy"),GameText.TYPE_BIG);
         }
         this.buy_text.pivotX = int(this.buy_text.WIDTH * 0.5);
         this.buy_text.pivotY = int(this.buy_text.HEIGHT * 0.5);
         this.buy_text.x = int(_WIDTH * 0.5);
         this.buy_text.y = int(_HEIGHT * 0.5);
         this.buy_text.touchable = false;
         addChild(this.buy_text);
         this.purchaseMarkImage = new Image(TextureManager.hudTextureAtlas.getTexture("purchase_mark_symbol"));
         this.purchaseMarkImage.touchable = false;
         this.purchaseMarkImage.pivotX = int(this.purchaseMarkImage.width * 0.5);
         this.purchaseMarkImage.pivotY = int(this.purchaseMarkImage.width * 0.5);
         this.purchaseMarkImage.x = this.buy_text.x;
         this.purchaseMarkImage.y = this.buy_text.y;
         this.purchaseMarkImage.visible = false;
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
      
      public function update() : void
      {
         if(this.REDRAW_FLAG)
         {
            this.REDRAW_FLAG = false;
            this.createUpTexture();
            this.createDownTexture();
         }
      }
      
      public function updatePurchased(purchased:Boolean, _isApparel:Boolean) : void
      {
         if(purchased)
         {
            this.touchable = true;
            this.buy_text.visible = true;
            this.purchaseMarkImage.visible = false;
            this.buy_text.updateText(StringsManager.GetString("panel_equip"));
            this.buy_text.pivotX = int(this.buy_text.WIDTH * 0.5);
            this.buy_text.pivotY = int(this.buy_text.HEIGHT * 0.5);
            this.buy_text.x = int(this.WIDTH * 0.5);
            this.buy_text.y = int(this.HEIGHT * 0.5);
         }
         else
         {
            this.touchable = true;
            this.buy_text.visible = true;
            this.purchaseMarkImage.visible = false;
         }
      }
      
      public function updateText(price:Number) : void
      {
         this.buy_text.updateText(StringsManager.GetString("panel_buy"));
         this.buy_text.pivotX = int(this.buy_text.WIDTH * 0.5);
         this.buy_text.pivotY = int(this.buy_text.HEIGHT * 0.5);
         this.buy_text.x = int(this.WIDTH * 0.5);
         this.buy_text.y = int(this.HEIGHT * 0.5);
      }
      
      public function destroy() : void
      {
         removeChild(this.purchaseMarkImage);
         this.purchaseMarkImage.dispose();
         this.purchaseMarkImage = null;
         this.downTexture.dispose();
         this.downTexture = null;
         this.upTexture.dispose();
         this.upTexture = null;
         removeChild(this.buy_text);
         this.buy_text.destroy();
         this.buy_text = null;
      }
      
      protected function createUpTexture() : void
      {
         var matrix:Matrix = null;
         var image:Image = null;
         if(this.upTexture == null)
         {
            this.upTexture = new RenderTexture(this.WIDTH,this.HEIGHT);
         }
         else
         {
            this.upTexture.clear();
         }
         var _index:int = 2;
         if(this.IS_PREMIUM)
         {
            _index = 3;
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "UpPart1"));
         this.upTexture.draw(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "UpPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,0);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "UpPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,0);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "UpPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(this.WIDTH - 8,8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "UpPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "UpPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "UpPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "UpPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(0,8);
         this.upTexture.draw(image,matrix);
         if(this.IS_PREMIUM)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("yellowQuad"));
         }
         else
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart9"));
         }
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / image.width,(this.HEIGHT - 16) / image.height);
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
         var _index:int = 2;
         if(this.IS_PREMIUM)
         {
            _index = 3;
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "DownPart1"));
         matrix = new Matrix();
         matrix.translate(0,0);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "DownPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,0);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "DownPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,0);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "DownPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(this.WIDTH - 8,8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "DownPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "DownPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "DownPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button" + _index + "DownPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(0,8);
         this.downTexture.draw(image,matrix);
         if(this.IS_PREMIUM)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         }
         else
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart9"));
         }
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / image.width,(this.HEIGHT - 16) / image.height);
         matrix.translate(8,8);
         this.downTexture.draw(image,matrix);
      }
   }
}
