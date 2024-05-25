package interfaces.panels
{
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class BluePanel extends Sprite
   {
      
      public static var TYPE_A:int = 1;
      
      public static var TYPE_B:int = 2;
      
      public static var TYPE_C:int = 3;
       
      
      public var type:int;
      
      public var part1:Image;
      
      public var part2:Image;
      
      public var part3:Image;
      
      public var part4:Image;
      
      public var part5:Image;
      
      public var part6:Image;
      
      public var part7:Image;
      
      public var part8:Image;
      
      public var part9:Image;
      
      public var WIDTH:Number;
      
      public var HEIGHT:Number;
      
      public var lines:Array;
      
      public function BluePanel(_WIDTH:Number, _HEIGHT:Number, _type:int = 1)
      {
         super();
         this.type = _type;
         this.WIDTH = int(_WIDTH);
         this.HEIGHT = int(_HEIGHT);
         this.lines = new Array();
         this.part1 = new Image(TextureManager.hudTextureAtlas.getTexture("panel" + this.type + "Part1"));
         this.part1.textureSmoothing = Utils.getSmoothing();
         this.part1.x = 0;
         this.part1.y = 0;
         addChild(this.part1);
         this.part2 = new Image(TextureManager.hudTextureAtlas.getTexture("panel" + this.type + "Part2"));
         this.part2.textureSmoothing = Utils.getSmoothing();
         this.part2.x = 8;
         this.part2.y = 0;
         this.part2.width = this.WIDTH - 16;
         addChild(this.part2);
         this.part3 = new Image(TextureManager.hudTextureAtlas.getTexture("panel" + this.type + "Part3"));
         this.part3.textureSmoothing = Utils.getSmoothing();
         this.part3.x = this.WIDTH - 8;
         if(_type == 3)
         {
            this.part3.x = this.WIDTH - 9;
         }
         this.part3.y = 0;
         addChild(this.part3);
         this.part4 = new Image(TextureManager.hudTextureAtlas.getTexture("panel" + this.type + "Part4"));
         this.part4.textureSmoothing = Utils.getSmoothing();
         this.part4.x = this.WIDTH - 8;
         this.part4.y = 8;
         this.part4.height = this.HEIGHT - 16;
         addChild(this.part4);
         this.part5 = new Image(TextureManager.hudTextureAtlas.getTexture("panel" + this.type + "Part5"));
         this.part5.textureSmoothing = Utils.getSmoothing();
         this.part5.x = this.WIDTH - 8;
         this.part5.y = this.HEIGHT - 8;
         if(this.type == 3)
         {
            this.part5.x = this.WIDTH - 9;
            this.part5.y = this.HEIGHT - 9;
         }
         addChild(this.part5);
         this.part6 = new Image(TextureManager.hudTextureAtlas.getTexture("panel" + this.type + "Part6"));
         this.part6.textureSmoothing = Utils.getSmoothing();
         this.part6.x = 8;
         this.part6.y = this.HEIGHT - 8;
         this.part6.width = this.WIDTH - 16;
         addChild(this.part6);
         this.part7 = new Image(TextureManager.hudTextureAtlas.getTexture("panel" + this.type + "Part7"));
         this.part7.textureSmoothing = Utils.getSmoothing();
         this.part7.x = 0;
         this.part7.y = this.HEIGHT - 8;
         if(this.type == 3)
         {
            this.part7.y = this.HEIGHT - 9;
         }
         addChild(this.part7);
         this.part8 = new Image(TextureManager.hudTextureAtlas.getTexture("panel" + this.type + "Part8"));
         this.part8.textureSmoothing = Utils.getSmoothing();
         this.part8.x = 0;
         this.part8.y = 8;
         this.part8.height = this.HEIGHT - 16;
         addChild(this.part8);
         if(this.type == BluePanel.TYPE_C)
         {
            this.part9 = new Image(TextureManager.hudTextureAtlas.getTexture("whiteQuad"));
         }
         else
         {
            this.part9 = new Image(TextureManager.hudTextureAtlas.getTexture("panel" + this.type + "Part9"));
         }
         this.part9.textureSmoothing = Utils.getSmoothing();
         this.part9.width = this.WIDTH - 16;
         this.part9.height = this.HEIGHT - 16;
         this.part9.x = 8;
         this.part9.y = 8;
         addChild(this.part9);
         if(this.type == 3)
         {
            setChildIndex(this.part9,0);
         }
      }
      
      public function resizePanel(_new_width:int, _new_height:int) : void
      {
         this.WIDTH = _new_width;
         this.HEIGHT = _new_height;
         this.part2.width = this.WIDTH - 16;
         this.part3.x = this.WIDTH - 8;
         this.part4.x = this.WIDTH - 8;
         this.part4.height = this.HEIGHT - 16;
         this.part5.x = this.WIDTH - 8;
         this.part5.y = this.HEIGHT - 8;
         this.part6.y = this.HEIGHT - 8;
         this.part6.width = this.WIDTH - 16;
         this.part7.y = this.HEIGHT - 8;
         this.part8.height = this.HEIGHT - 16;
         this.part9.width = this.WIDTH - 16;
         this.part9.height = this.HEIGHT - 16;
      }
      
      public function drawLine(xPos:Number, yPos:Number, __width:Number) : void
      {
         var image:Image = null;
         if(this.type == BluePanel.TYPE_C)
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("greyQuad"));
            addChild(image);
            image.x = xPos;
            image.y = yPos;
            image.width = __width;
            image.height = 2;
            this.lines.push(image);
         }
         else
         {
            image = new Image(TextureManager.hudTextureAtlas.getTexture("line_part_1"));
            addChild(image);
            image.x = xPos;
            image.y = yPos;
            this.lines.push(image);
            image = new Image(TextureManager.hudTextureAtlas.getTexture("line_part_2"));
            addChild(image);
            image.x = xPos + 4;
            image.y = yPos;
            image.width = __width - 8;
            this.lines.push(image);
            image = new Image(TextureManager.hudTextureAtlas.getTexture("line_part_1"));
            image.scaleX = -1;
            addChild(image);
            image.x = xPos + __width;
            image.y = yPos;
            this.lines.push(image);
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         removeChild(this.part9);
         this.part9.dispose();
         this.part9 = null;
         removeChild(this.part8);
         this.part8.dispose();
         this.part8 = null;
         removeChild(this.part7);
         this.part7.dispose();
         this.part7 = null;
         removeChild(this.part6);
         this.part6.dispose();
         this.part6 = null;
         removeChild(this.part5);
         this.part5.dispose();
         this.part5 = null;
         removeChild(this.part4);
         this.part4.dispose();
         this.part4 = null;
         removeChild(this.part3);
         this.part3.dispose();
         this.part3 = null;
         removeChild(this.part2);
         this.part2.dispose();
         this.part2 = null;
         removeChild(this.part1);
         this.part1.dispose();
         this.part1 = null;
         for(i = 0; i < this.lines.length; i++)
         {
            removeChild(this.lines[i]);
            this.lines[i].dispose();
            this.lines[i] = null;
         }
         this.lines = null;
      }
   }
}
