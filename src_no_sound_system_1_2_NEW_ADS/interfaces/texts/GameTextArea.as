package interfaces.texts
{
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.textures.RenderTexture;
   import starling.textures.Texture;
   import starling.textures.TextureSmoothing;
   import starling.utils.Align;
   
   public class GameTextArea extends Sprite
   {
       
      
      protected var images:Array;
      
      protected var advance_x:int;
      
      protected var advance_y:int;
      
      protected var spacing:int;
      
      public var line_height:int;
      
      protected var pitch:int;
      
      protected var pivot_x:int;
      
      protected var pivot_y:int;
      
      public var LAST_WIDTH:int;
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var AREA_WIDTH:int;
      
      public var AREA_HEIGHT:int;
      
      public var LINES_AMOUNT:int;
      
      public var LINES_WIDTH:Array;
      
      public var type:int;
      
      public var CENTERED:Boolean;
      
      public var containers:Array;
      
      public var _textField:TextField;
      
      public var _image:Image;
      
      public function GameTextArea(_text:String, _type:int = 0, _area_width:Number = 128, _area_height:Number = 64, _centered:Boolean = false)
      {
         var i:int = 0;
         super();
         this.type = _type;
         this.advance_x = 0;
         this.advance_y = 0;
         this.LAST_WIDTH = -1;
         this.LINES_AMOUNT = 0;
         this.CENTERED = _centered;
         this.LINES_WIDTH = new Array();
         this.AREA_WIDTH = _area_width;
         this.AREA_HEIGHT = _area_height;
         this._textField = null;
         this._image = null;
         if(this.type == GameText.TYPE_BIG)
         {
            this.spacing = 8;
            this.pitch = -1;
            this.pivot_x = 0;
            this.pivot_y = 10;
            this.line_height = 16;
            this.WIDTH = 0;
            this.HEIGHT = 14;
         }
         else
         {
            this.spacing = 6;
            this.pitch = 1;
            this.pivot_x = 0;
            this.pivot_y = 8;
            this.line_height = 10;
            this.WIDTH = 0;
            this.HEIGHT = 8;
            if(this.type == GameText.TYPE_SMALL_WHITE_SHORT_SPACING || this.type == GameText.TYPE_SMALL_WHITE)
            {
               this.spacing = 9;
            }
         }
         this.images = new Array();
         this.containers = new Array();
         if(Utils.EnableFontStrings)
         {
            this.generateFontText(_text);
         }
         else
         {
            this.generateText(_text);
            if(this.CENTERED)
            {
               this.centerText();
            }
         }
      }
      
      public function destroy() : void
      {
         var j:int = 0;
         var i:int = 0;
         this.LINES_WIDTH = null;
         if(this._textField != null)
         {
            removeChild(this._textField);
            this._textField.dispose();
            this._textField = null;
         }
         if(this._image != null)
         {
            removeChild(this._image);
            this._image.dispose();
            this._image = null;
         }
         for(j = 0; j < this.containers.length; j++)
         {
            for(i = 0; i < this.containers[j].numChildren; i++)
            {
               this.containers[j].removeChild(this.containers[j].getChildAt(i));
            }
            removeChild(this.containers[j]);
            this.containers[j].dispose();
            this.containers[j] = null;
         }
         for(i = 0; i < this.images.length; i++)
         {
            this.images[i].dispose();
            this.images[i] = null;
         }
         this.containers = null;
         this.images = null;
      }
      
      public function setColor(color:uint) : void
      {
         var i:int = 0;
         for(i = 0; i < this.images.length; i++)
         {
            this.images[i].color = color;
         }
      }
      
      public function updateText(new_string:String) : void
      {
         var i:int = 0;
         var j:int = 0;
         this.LAST_WIDTH = -1;
         for(j = 0; j < this.containers.length; j++)
         {
            for(i = 0; i < this.containers[j].numChildren; i++)
            {
               this.containers[j].removeChild(this.containers[j].getChildAt(i));
            }
            removeChild(this.containers[j]);
            this.containers[j].dispose();
            this.containers[j] = null;
         }
         for(i = 0; i < this.images.length; i++)
         {
            this.images[i].dispose();
            this.images[i] = null;
         }
         this.containers = null;
         this.images = null;
         this.images = new Array();
         this.containers = new Array();
         this.advance_x = 0;
         if(this._textField != null)
         {
            removeChild(this._textField);
            this._textField.dispose();
            this._textField = null;
         }
         if(this._image != null)
         {
            removeChild(this._image);
            this._image.dispose();
            this._image = null;
         }
         if(Utils.EnableFontStrings)
         {
            this.generateFontText(new_string);
         }
         else
         {
            this.generateText(new_string);
            if(this.CENTERED)
            {
               this.centerText();
            }
         }
      }
      
      protected function generateFontText(_text:String) : void
      {
         this._textField = new TextField(this.AREA_WIDTH * 3,this.AREA_HEIGHT * 3,_text);
         if(this.type == GameText.TYPE_BIG)
         {
            this._textField.format.setTo("Verdana",20 * 3,16773608);
            this._textField.format.bold = true;
         }
         else if(this.type == GameText.TYPE_SMALL_WHITE)
         {
            if(Utils.Lang == "_ru")
            {
               this._textField.format.setTo("Verdana",8 * 3,16773608);
            }
            else
            {
               this._textField.format.setTo("Verdana",10 * 3,16773608);
            }
         }
         else if(Utils.Lang == "_ru")
         {
            this._textField.format.setTo("Verdana",8 * 3,8267091);
         }
         else
         {
            this._textField.format.setTo("Verdana",10 * 3,8267091);
         }
         if(this.CENTERED)
         {
            this._textField.format.horizontalAlign = Align.CENTER;
         }
         else
         {
            this._textField.format.horizontalAlign = Align.LEFT;
         }
         this._textField.format.verticalAlign = Align.TOP;
         this._textField.touchable = false;
         this._textField.pivotY = 1;
         this.WIDTH = this._textField.textBounds.width + 1;
         this.HEIGHT = this._textField.textBounds.height;
         this._textField = new TextField(this.WIDTH,this.HEIGHT,_text);
         if(this.type == GameText.TYPE_BIG)
         {
            this._textField.format.setTo("Verdana",20 * 3,16773608);
            this._textField.format.bold = true;
         }
         else if(this.type == GameText.TYPE_SMALL_WHITE)
         {
            if(Utils.Lang == "_ru")
            {
               this._textField.format.setTo("Verdana",8 * 3,16773608);
            }
            else
            {
               this._textField.format.setTo("Verdana",10 * 3,16773608);
            }
         }
         else if(Utils.Lang == "_ru")
         {
            this._textField.format.setTo("Verdana",8 * 3,8267091);
         }
         else
         {
            this._textField.format.setTo("Verdana",10 * 3,16773608);
         }
         if(this.CENTERED)
         {
            this._textField.format.horizontalAlign = Align.CENTER;
         }
         else
         {
            this._textField.format.horizontalAlign = Align.LEFT;
         }
         this._textField.format.verticalAlign = Align.TOP;
         this._textField.touchable = false;
         this._textField.pivotY = 1;
         this._textField.pixelSnapping = true;
         var _pivotX:Number = this._textField.pivotX;
         var _pivotY:Number = this._textField.pivotY;
         this._textField.pivotX = 0;
         this._textField.pivotY = 0;
         if(this._textField.bounds.width == 0 || this._textField.bounds.height == 0)
         {
            return;
         }
         var _renderTexture:RenderTexture = new RenderTexture(this._textField.bounds.width + 8,this._textField.bounds.height + 8);
         _renderTexture.draw(this._textField);
         this._image = new Image(_renderTexture);
         this._image.scaleX = this._image.scaleY = 0.3333;
         addChild(this._image);
         this._image.textureSmoothing = TextureSmoothing.BILINEAR;
         this.WIDTH = this._image.width;
         this.HEIGHT = this._image.height;
         this._image.touchable = false;
         this._image.pivotX = _pivotX;
         this._image.pivotY = _pivotY;
         this.images.push(this._image);
      }
      
      public function getLinesHeight() : int
      {
         return this.advance_y + this.line_height;
      }
      
      protected function generateText(_text:String) : void
      {
         var i:int = 0;
         var code:int = 0;
         var image:Image = null;
         var isCharMissing:Boolean = false;
         var texture:Texture = null;
         var temp_width:int = 0;
         this.containers.push(new Sprite());
         addChild(this.containers[this.containers.length - 1]);
         for(i = 0; i < _text.length; i++)
         {
            code = this.getCharCode(_text.charCodeAt(i));
            if(code == 32 || code == 160)
            {
               this.advance_x += this.spacing - this.pitch;
               if(this.isNextTokenOutsideWidth(_text,i + 1))
               {
                  if(this.LAST_WIDTH == -1 || this.advance_x - this.pitch > this.LAST_WIDTH)
                  {
                     this.WIDTH = this.LAST_WIDTH = this.advance_x - this.pitch;
                  }
                  temp_width = this.advance_x - this.pitch;
                  this.advance_x = 0;
                  this.advance_y += this.line_height;
                  ++this.LINES_AMOUNT;
                  this.LINES_WIDTH.push(temp_width - this.spacing);
                  temp_width = 0;
                  this.containers.push(new Sprite());
                  addChild(this.containers[this.containers.length - 1]);
               }
            }
            else
            {
               isCharMissing = false;
               try
               {
                  if(this.type == GameText.TYPE_BIG)
                  {
                     texture = TextureManager.hudTextureAtlas.getTexture("titleFont_" + code);
                  }
                  else if(this.type == GameText.TYPE_SMALL_WHITE || this.type == GameText.TYPE_SMALL_WHITE_SHORT_SPACING)
                  {
                     texture = TextureManager.hudTextureAtlas.getTexture("whiteSmallFontChar_" + code);
                  }
                  else
                  {
                     texture = TextureManager.hudTextureAtlas.getTexture("dialogChar_" + code);
                  }
                  if(texture == null)
                  {
                     trace("GameText::generateText - Missing char code " + code);
                  }
                  image = new Image(texture);
               }
               catch(err:Error)
               {
                  trace("GameText::generateText - Missing char code " + code);
                  isCharMissing = true;
               }
               finally
               {
                  if(!isCharMissing)
                  {
                     image.pivotX = this.pivot_x;
                     image.pivotY = this.pivot_y;
                     image.x = this.advance_x;
                     image.y = this.advance_y;
                     this.containers[this.containers.length - 1].addChild(image);
                     this.images.push(image);
                     this.advance_x += this.getCharWidth(code) + this.pitch;
                  }
               }
            }
         }
         this.LINES_WIDTH.push(this.advance_x - this.pitch);
         if(this.LAST_WIDTH == -1 || this.advance_x - this.pitch > this.LAST_WIDTH)
         {
            this.WIDTH = this.LAST_WIDTH = this.advance_x - this.pitch;
         }
      }
      
      protected function centerText() : void
      {
         var i:int = 0;
         var MAX_WIDTH:int = 0;
         for(i = 0; i < this.containers.length; i++)
         {
            this.containers[i].x = int((this.AREA_WIDTH - this.LINES_WIDTH[i]) * 0.5);
         }
      }
      
      protected function isNextTokenOutsideWidth(_text:String, index:int) : Boolean
      {
         var _code:int = 0;
         var hasEnded:Boolean = false;
         var token_width:int = 0;
         while(!hasEnded)
         {
            _code = this.getCharCode(_text.charCodeAt(index));
            if(_code == 32)
            {
               hasEnded = true;
            }
            else
            {
               token_width += this.getCharWidth(_code) + this.pitch;
               index++;
               if(index >= _text.length)
               {
                  hasEnded = true;
               }
            }
         }
         token_width -= this.pitch;
         if(this.advance_x + token_width >= this.AREA_WIDTH)
         {
            return true;
         }
         return false;
      }
      
      protected function getCharWidth(code:int) : int
      {
         return GameText.getCharWidth(code,this.type);
      }
      
      public function getCharCode(code:int) : int
      {
         if(this.type == GameText.TYPE_SMALL_WHITE || this.type == GameText.TYPE_SMALL_DARK || this.type == GameText.TYPE_SMALL_WHITE_SHORT_SPACING)
         {
            if(code == 73)
            {
               return code;
            }
            if(code >= 65 && code <= 90)
            {
               return code + 32;
            }
            return code;
         }
         if(code >= 97 && code <= 122)
         {
            return code - 32;
         }
         return code;
      }
   }
}
