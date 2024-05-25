package interfaces.buttons
{
   import flash.geom.Matrix;
   import interfaces.texts.GameText;
   import starling.display.Button;
   import starling.display.Image;
   import starling.textures.RenderTexture;
   
   public class BigTextButton extends Button
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var upTexture:RenderTexture;
      
      protected var downTexture:RenderTexture;
      
      protected var buy_text:GameText;
      
      public function BigTextButton(_WIDTH:Number, _HEIGHT:Number, _text:String)
      {
         this.WIDTH = _WIDTH;
         this.HEIGHT = _HEIGHT;
         this.upTexture = this.createUpTexture();
         this.downTexture = this.createDownTexture();
         super(this.upTexture,"",this.downTexture);
         this.buy_text = new GameText(_text,GameText.TYPE_BIG);
         this.buy_text.pivotX = int(this.buy_text.WIDTH * 0.5);
         this.buy_text.pivotY = int(this.buy_text.HEIGHT * 0.5);
         this.buy_text.x = int(_WIDTH * 0.5);
         this.buy_text.y = int(_HEIGHT * 0.5);
         if(this.buy_text.WIDTH > this.WIDTH)
         {
            this.buy_text.width = this.WIDTH - 16;
            this.buy_text.WIDTH = this.WIDTH - 16;
            this.buy_text.x = int(_WIDTH * 0.5);
         }
         this.buy_text.touchable = false;
         addChild(this.buy_text);
      }
      
      public function allowTouch(isTouchAllowed:Boolean) : void
      {
         touchable = isTouchAllowed;
         if(isTouchAllowed)
         {
            this.buy_text.alpha = 1;
         }
         else
         {
            this.buy_text.alpha = 0.5;
         }
      }
      
      public function updatePurchased(purchased:Boolean) : void
      {
         if(purchased)
         {
            this.touchable = false;
            this.buy_text.visible = false;
         }
         else
         {
            this.touchable = true;
            this.buy_text.visible = true;
         }
      }
      
      public function destroy() : void
      {
         this.downTexture.dispose();
         this.downTexture = null;
         this.upTexture.dispose();
         this.upTexture = null;
         removeChild(this.buy_text);
         this.buy_text.destroy();
         this.buy_text = null;
      }
      
      protected function createUpTexture() : RenderTexture
      {
         var matrix:Matrix = null;
         var image:Image = null;
         var renderTexture:RenderTexture = new RenderTexture(this.WIDTH,this.HEIGHT);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart1"));
         renderTexture.draw(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,0);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,0);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(this.WIDTH - 8,8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2UpPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(0,8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart9"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,(this.HEIGHT - 16) / 8);
         matrix.translate(8,8);
         renderTexture.draw(image,matrix);
         return renderTexture;
      }
      
      protected function createDownTexture() : RenderTexture
      {
         var matrix:Matrix = null;
         var image:Image = null;
         var renderTexture:RenderTexture = new RenderTexture(this.WIDTH,this.HEIGHT);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart1"));
         matrix = new Matrix();
         matrix.translate(0,0);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,0);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,0);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(this.WIDTH - 8,8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button2DownPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 16) / 8);
         matrix.translate(0,8);
         renderTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart9"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,(this.HEIGHT - 16) / 8);
         matrix.translate(8,8);
         renderTexture.draw(image,matrix);
         return renderTexture;
      }
   }
}
