package interfaces.texts
{
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.textures.RenderTexture;
   import starling.textures.Texture;
   import starling.textures.TextureSmoothing;
   import starling.utils.Align;
   
   public class GameText extends Sprite
   {
      
      public static const TYPE_BIG:int = 0;
      
      public static const TYPE_SMALL_WHITE:int = 1;
      
      public static const TYPE_SMALL_DARK:int = 2;
      
      public static const TYPE_BIG_BLUE:int = 3;
      
      public static const TYPE_SMALL_WHITE_SHORT_SPACING:int = 4;
       
      
      protected var images:Array;
      
      protected var advance_x:int;
      
      protected var base_advance_x:int;
      
      protected var spacing:int;
      
      protected var pitch:int;
      
      protected var pivot_x:int;
      
      protected var pivot_y:int;
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var type:int;
      
      public var coinIcon:Image;
      
      public var coinEndIcon:Image;
      
      public var _textField:TextField;
      
      public var _image:Image;
      
      protected var FORCE_FONTS:Boolean;
      
      public function GameText(_text:String, _type:int = 0, _coin_icon:Boolean = false, _money_symbol:Boolean = false, _bell_icon:Boolean = false, _key_icon:Boolean = false, _force_fonts:Boolean = false, _question_mark_icon:Boolean = false, _star_icon:Boolean = false)
      {
         var i:int = 0;
         super();
         this.type = _type;
         this.advance_x = 0;
         this.base_advance_x = 0;
         this._textField = null;
         this._image = null;
         this.FORCE_FONTS = _force_fonts;
         this.coinEndIcon = null;
         if(this.type == TYPE_BIG || this.type == TYPE_BIG_BLUE)
         {
            this.spacing = 8;
            this.pitch = -1;
            this.pivot_x = 0;
            this.pivot_y = 10;
            this.WIDTH = 0;
            this.HEIGHT = 14;
         }
         else
         {
            this.spacing = 6;
            this.pitch = 2;
            this.pivot_x = 0;
            this.pivot_y = 8;
            this.WIDTH = 0;
            this.HEIGHT = 8;
            if(this.type == GameText.TYPE_SMALL_WHITE_SHORT_SPACING || this.type == GameText.TYPE_SMALL_WHITE)
            {
               this.spacing = 9;
            }
         }
         this.images = new Array();
         if(_coin_icon)
         {
            this.addCoinIcon();
         }
         else if(_key_icon)
         {
            this.addKeyIcon();
         }
         else if(_bell_icon)
         {
            this.addBellIcon();
         }
         else if(_question_mark_icon)
         {
            this.addQuestionMarkIcon();
         }
         else if(_star_icon)
         {
            this.addStarIcon();
         }
         else
         {
            this.coinIcon = null;
         }
         this.generateText(_text);
         if(_key_icon)
         {
            this.addEndKeyIcon();
         }
         else if(_question_mark_icon)
         {
            this.addEndQuestionMarkIcon();
         }
         else if(_star_icon)
         {
            this.addEndStarIcon();
         }
      }
      
      public static function getCharWidth(code:int, _type:int) : int
      {
         var codeLenght:int = 0;
         if(_type == TYPE_BIG || _type == TYPE_BIG_BLUE)
         {
            if(code == 73 || code == 84 || code == 90 || code == 237 || code == 238)
            {
               codeLenght = 14;
            }
            else if(code == 89 || code == 42 || code == 45 || code == 94)
            {
               codeLenght = 16;
            }
            else if(code == 77 || code == 87)
            {
               codeLenght = 17;
            }
            else if(code == 49)
            {
               codeLenght = 12;
            }
            else if(code == 33 || code == 39 || code == 161)
            {
               codeLenght = 8;
            }
            else if(code == 46 || code == 44)
            {
               codeLenght = 7;
            }
            else
            {
               if(code == 123)
               {
                  return 20;
               }
               codeLenght = 15;
            }
            if(Utils.Lang != "_en")
            {
               codeLenght--;
            }
            if(code >= 1040 && code <= 1071)
            {
               if(code == 1062)
               {
                  codeLenght = 15;
               }
               else if(code == 1066)
               {
                  codeLenght = 16;
               }
               else if(code == 1044)
               {
                  codeLenght = 17;
               }
               else if(code == 1046 || code == 1052 || code == 1058 || code == 1060 || code == 1064 || code == 1067 || code == 1070)
               {
                  codeLenght = 19;
               }
               else if(code == 1065)
               {
                  codeLenght = 21;
               }
               else
               {
                  codeLenght = 13;
               }
            }
            return codeLenght;
         }
         if(code == 105 || code == 33 || code == 39 || code == 58 || code == 73 || code == 161)
         {
            codeLenght = 1;
         }
         else if(code == 46 || code == 237)
         {
            codeLenght = 2;
         }
         else if(code == 108 || code == 44 || code == 49 || code == 40 || code == 41 || code == 238)
         {
            codeLenght = 3;
         }
         else if(code == 106 || code == 107 || code == 115 || code == 63 || code == 48 || code >= 50 && code <= 53 || code >= 55 && code <= 56 || code == 45 || code == 191 || code == 8211 || code == 8212)
         {
            codeLenght = 4;
         }
         else if(code == 97 || code == 101 || code == 102 || code == 223 || code == 224 || code == 232 || code == 228 || code == 223 || code == 225 || code == 233 || code == 227 || code == 234 || code == 226 || code == 245)
         {
            codeLenght = 6;
         }
         else if(code == 109 || code == 119 || code == 169)
         {
            codeLenght = 7;
         }
         else if(code == 38 || code == 94)
         {
            codeLenght = 16;
         }
         else if(code == 64 || code == 36)
         {
            codeLenght = 8;
         }
         else
         {
            codeLenght = 5;
         }
         if(code >= 1072 && code <= 1103)
         {
            if(code == 1078 || code == 1090 || code == 1092 || code == 1094 || code == 1096 || code == 1098)
            {
               codeLenght = 5;
            }
            else if(code == 1083 || code == 1097 || code == 1102 || code == 1076)
            {
               codeLenght = 6;
            }
            else if(code == 1084 || code == 1099)
            {
               codeLenght = 7;
            }
            else
            {
               codeLenght = 4;
            }
         }
         return codeLenght;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
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
         for(i = 0; i < this.images.length; i++)
         {
            removeChild(this.images[i]);
            this.images[i].dispose();
            this.images[i] = null;
         }
         this.images = null;
         if(this.coinIcon != null)
         {
            removeChild(this.coinIcon);
            this.coinIcon.dispose();
            this.coinIcon = null;
         }
         if(this.coinEndIcon != null)
         {
            removeChild(this.coinEndIcon);
            this.coinEndIcon.dispose();
            this.coinEndIcon = null;
         }
      }
      
      public function updateText(new_string:String) : void
      {
         var i:int = 0;
         for(i = 0; i < this.images.length; i++)
         {
            removeChild(this.images[i]);
            this.images[i].dispose();
            this.images[i] = null;
         }
         this.images = null;
         this.images = new Array();
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
         this.generateText(new_string);
      }
      
      public function setColor(color:uint) : void
      {
         var i:int = 0;
         for(i = 0; i < this.images.length; i++)
         {
            this.images[i].color = color;
         }
      }
      
      protected function addCoinIcon() : void
      {
         this.coinIcon = new Image(TextureManager.hudTextureAtlas.getTexture("coin_text_symbol"));
         addChild(this.coinIcon);
         this.coinIcon.x = this.coinIcon.y = 0;
         this.coinIcon.pivotY = 1;
         if(Utils.EnableFontStrings || this.FORCE_FONTS)
         {
            this.base_advance_x = 29;
         }
         else
         {
            this.base_advance_x = 9;
         }
      }
      
      protected function addBellIcon() : void
      {
         this.coinIcon = new Image(TextureManager.hudTextureAtlas.getTexture("bell_text_symbol"));
         addChild(this.coinIcon);
         this.coinIcon.x = this.coinIcon.y = 0;
         this.coinIcon.pivotY = 1;
         if(Utils.EnableFontStrings || this.FORCE_FONTS)
         {
            this.base_advance_x = 32;
         }
         else
         {
            this.base_advance_x = 12;
         }
      }
      
      protected function addKeyIcon() : void
      {
         this.coinIcon = new Image(TextureManager.hudTextureAtlas.getTexture("key_text_symbol"));
         addChild(this.coinIcon);
         this.coinIcon.x = this.coinIcon.y = 0;
         this.coinIcon.pivotY = 0;
         if(Utils.EnableFontStrings || this.FORCE_FONTS)
         {
            this.base_advance_x = 33;
         }
         else
         {
            this.base_advance_x = 13;
         }
      }
      
      protected function addQuestionMarkIcon() : void
      {
         this.coinIcon = new Image(TextureManager.hudTextureAtlas.getTexture("secret_text_symbol"));
         addChild(this.coinIcon);
         this.coinIcon.x = this.coinIcon.y = 0;
         this.coinIcon.pivotY = 0;
         if(Utils.EnableFontStrings || this.FORCE_FONTS)
         {
            this.base_advance_x = 33;
         }
         else
         {
            this.base_advance_x = 13;
         }
      }
      
      protected function addStarIcon() : void
      {
         this.coinIcon = new Image(TextureManager.hudTextureAtlas.getTexture("star_symbol"));
         addChild(this.coinIcon);
         this.coinIcon.x = this.coinIcon.y = 0;
         this.coinIcon.pivotY = 0;
         if(Utils.EnableFontStrings || this.FORCE_FONTS)
         {
            this.base_advance_x = 33;
         }
         else
         {
            this.base_advance_x = 13;
         }
      }
      
      protected function addEndKeyIcon() : void
      {
         this.coinEndIcon = new Image(TextureManager.hudTextureAtlas.getTexture("key_text_symbol"));
         addChild(this.coinEndIcon);
         this.coinEndIcon.x = this.advance_x + 1;
         this.coinEndIcon.y = 0;
         this.coinEndIcon.pivotY = 0;
         this.WIDTH += 14;
      }
      
      protected function addEndQuestionMarkIcon() : void
      {
         this.coinEndIcon = new Image(TextureManager.hudTextureAtlas.getTexture("secret_text_symbol"));
         addChild(this.coinEndIcon);
         this.coinEndIcon.x = this.advance_x + 1;
         this.coinEndIcon.y = 0;
         this.coinEndIcon.pivotY = 0;
         this.WIDTH += 14;
      }
      
      protected function addEndStarIcon() : void
      {
         this.coinEndIcon = new Image(TextureManager.hudTextureAtlas.getTexture("star_symbol"));
         addChild(this.coinEndIcon);
         this.coinEndIcon.x = this.advance_x + 1;
         this.coinEndIcon.y = 0;
         this.coinEndIcon.pivotY = 0;
         this.WIDTH += 14;
      }
      
      protected function generateFontText(_text:String) : void
      {
         this._textField = new TextField(Utils.SCREEN_WIDTH * 2,72,_text);
         if(this.type == TYPE_BIG || this.type == TYPE_BIG_BLUE)
         {
            this._textField.format.setTo("Verdana",20 * 3,16773608);
            this._textField.format.bold = true;
         }
         else if(this.type == TYPE_SMALL_WHITE)
         {
            this._textField.format.setTo("Verdana",10 * 3,16773608);
         }
         else
         {
            this._textField.format.setTo("Verdana",10 * 3,8267091);
         }
         this._textField.format.horizontalAlign = Align.LEFT;
         this._textField.format.verticalAlign = Align.TOP;
         this._textField.touchable = false;
         this._textField.border = false;
         this.WIDTH = this._textField.textBounds.width + 1;
         this.HEIGHT = this._textField.textBounds.height;
         this._textField = new TextField(this.WIDTH,this.HEIGHT,_text);
         if(this.type == TYPE_BIG || this.type == TYPE_BIG_BLUE)
         {
            this._textField.format.setTo("Verdana",20 * 3,16773608);
            this._textField.format.bold = true;
         }
         else if(this.type == TYPE_SMALL_WHITE)
         {
            this._textField.format.setTo("Verdana",10 * 3,16773608);
         }
         else
         {
            this._textField.format.setTo("Verdana",10 * 3,8267091);
         }
         this._textField.format.horizontalAlign = Align.LEFT;
         this._textField.format.verticalAlign = Align.TOP;
         this._textField.touchable = false;
         this._textField.border = false;
         this._textField.pixelSnapping = true;
         if(this.base_advance_x != 0)
         {
            this._textField.x = this.base_advance_x - 2;
            this._textField.pivotY = 6;
         }
         else
         {
            this._textField.pivotY = 1;
         }
         if(this.type == TYPE_BIG || this.type == TYPE_BIG_BLUE)
         {
            this._textField.pivotY = 3;
         }
         var _pivotX:Number = this._textField.pivotX;
         var _pivotY:Number = this._textField.pivotY;
         this._textField.pivotX = 0;
         this._textField.pivotY = 0;
         if(this._textField.bounds.width == 0 || this._textField.bounds.height == 0)
         {
            return;
         }
         var _renderTexture:RenderTexture = new RenderTexture(this._textField.bounds.width + 8 + this.base_advance_x,this._textField.bounds.height + 8);
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
         this.advance_x += this._image.width;
      }
      
      protected function generateText(_text:String) : void
      {
         var i:int = 0;
         var code:int = 0;
         var image:Image = null;
         var isCharMissing:Boolean = false;
         var texture:Texture = null;
         if(Utils.EnableFontStrings || this.FORCE_FONTS)
         {
            this.generateFontText(_text);
            return;
         }
         this.advance_x += this.base_advance_x;
         for(i = 0; i < _text.length; i++)
         {
            code = this.getCharCode(_text.charCodeAt(i));
            if(code == 32 || code == 160)
            {
               this.advance_x += this.spacing - this.pitch;
            }
            else
            {
               isCharMissing = false;
               try
               {
                  if(this.type == TYPE_BIG)
                  {
                     texture = TextureManager.hudTextureAtlas.getTexture("titleFont_" + code);
                  }
                  else if(this.type == TYPE_BIG_BLUE)
                  {
                     texture = TextureManager.hudTextureAtlas.getTexture("titleBlueFont_" + code);
                  }
                  else if(this.type == TYPE_SMALL_WHITE || this.type == TYPE_SMALL_WHITE_SHORT_SPACING)
                  {
                     texture = TextureManager.hudTextureAtlas.getTexture("whiteSmallFontChar_" + code);
                  }
                  else
                  {
                     texture = TextureManager.hudTextureAtlas.getTexture("dialogChar_" + code);
                  }
                  if(texture == null)
                  {
                     trace("GameText::generateText - Missing char code " + code + ", symbol = " + String.fromCharCode(code));
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
                     image.y = 0;
                     image.name = "" + code;
                     addChild(image);
                     this.images.push(image);
                     this.advance_x += getCharWidth(code,this.type) + this.pitch;
                  }
               }
            }
         }
         this.WIDTH = this.advance_x - this.pitch;
      }
      
      public function setColonsInvisible() : void
      {
         var i:int = 0;
         for(i = 0; i < this.images.length; i++)
         {
            if(this.images[i] != null)
            {
               if(this.images[i].name == "58")
               {
                  this.images[i].visible = false;
               }
            }
         }
      }
      
      public function getCharCode(code:int) : int
      {
         if(this.type == TYPE_SMALL_WHITE || this.type == TYPE_SMALL_DARK || this.type == TYPE_SMALL_WHITE_SHORT_SPACING)
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
         if(code >= 1072 && code <= 1103)
         {
            return code - 32;
         }
         return code;
      }
   }
}
