package interfaces.buttons
{
   import flash.geom.Matrix;
   import starling.display.Button;
   import starling.display.Image;
   import starling.textures.RenderTexture;
   
   public class GameButton extends Button
   {
       
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var upTexture:RenderTexture;
      
      protected var downTexture:RenderTexture;
      
      protected var REDRAW_FLAG:Boolean;
      
      protected var icon_name:String;
      
      public function GameButton(_icon:String, _WIDTH:Number, _HEIGHT:Number)
      {
         this.WIDTH = _WIDTH;
         this.HEIGHT = _HEIGHT;
         this.REDRAW_FLAG = false;
         this.upTexture = null;
         this.downTexture = null;
         this.icon_name = new String("" + _icon);
         this.createUpTexture(_icon);
         this.createDownTexture(_icon);
         super(this.upTexture,"",this.downTexture);
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
            this.createUpTexture(this.icon_name);
            this.createDownTexture(this.icon_name);
         }
      }
      
      public function destroy() : void
      {
         this.downTexture.dispose();
         this.downTexture = null;
         this.upTexture.dispose();
         this.upTexture = null;
      }
      
      protected function createUpTexture(_icon:String) : void
      {
         var matrix:Matrix = null;
         var image:Image = null;
         var x_shift:int = 0;
         var y_shift:int = 0;
         if(this.upTexture == null)
         {
            this.upTexture = new RenderTexture(this.WIDTH,this.HEIGHT);
         }
         else
         {
            this.upTexture.clear();
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart1"));
         this.upTexture.draw(image);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,0);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,0);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 24) / 8);
         matrix.translate(this.WIDTH - 8,8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 16);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 16);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 16);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 24) / 8);
         matrix.translate(0,8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1UpPart9"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,(this.HEIGHT - 24) / 8);
         matrix.translate(8,8);
         this.upTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture(_icon));
         x_shift = int((this.WIDTH - image.width) * 0.5);
         y_shift = int((this.HEIGHT - 6 - image.height) * 0.5);
         matrix = new Matrix();
         matrix.translate(x_shift,y_shift);
         this.upTexture.draw(image,matrix);
      }
      
      protected function createDownTexture(_icon:String) : void
      {
         var matrix:Matrix = null;
         var image:Image = null;
         var x_shift:int = 0;
         var y_shift:int = 0;
         if(this.downTexture == null)
         {
            this.downTexture = new RenderTexture(this.WIDTH,this.HEIGHT);
         }
         else
         {
            this.downTexture.clear();
         }
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart1"));
         matrix = new Matrix();
         matrix.translate(0,6);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart2"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,6);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart3"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,6);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart4"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 22) / 8);
         matrix.translate(this.WIDTH - 8,6 + 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart5"));
         matrix = new Matrix();
         matrix.translate(this.WIDTH - 8,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart6"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,1);
         matrix.translate(8,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart7"));
         matrix = new Matrix();
         matrix.translate(0,this.HEIGHT - 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart8"));
         matrix = new Matrix();
         matrix.scale(1,(this.HEIGHT - 22) / 8);
         matrix.translate(0,6 + 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture("button1DownPart9"));
         matrix = new Matrix();
         matrix.scale((this.WIDTH - 16) / 8,(this.HEIGHT - 22) / 8);
         matrix.translate(8,6 + 8);
         this.downTexture.draw(image,matrix);
         image = new Image(TextureManager.hudTextureAtlas.getTexture(_icon + "_pressed"));
         x_shift = int((this.WIDTH - image.width) * 0.5);
         y_shift = int((this.HEIGHT - image.height) * 0.5) + 3;
         matrix = new Matrix();
         matrix.translate(x_shift,y_shift);
         this.downTexture.draw(image,matrix);
      }
   }
}
