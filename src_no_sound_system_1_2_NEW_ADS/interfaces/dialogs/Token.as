package interfaces.dialogs
{
   import levels.cameras.*;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.textures.RenderTexture;
   import starling.textures.TextureSmoothing;
   import starling.utils.Align;
   
   public class Token extends Sprite
   {
       
      
      public var dialog:Dialog;
      
      public var text:String;
      
      protected var images:Array;
      
      public var WIDTH:int;
      
      public var counter:int;
      
      public var char_index:int;
      
      public var isNewParagraph:Boolean;
      
      public var isNewLine:Boolean;
      
      public var isBackspace:Boolean;
      
      public var isPause:Boolean;
      
      public var action:int;
      
      public var color:uint;
      
      public var animation:int;
      
      public var isButton:Boolean;
      
      protected var sinCounter:Number;
      
      protected var wait_time:int;
      
      public var IS_WAITING:Boolean;
      
      public var IS_RENDERING:Boolean;
      
      public var HAS_FINISHED:Boolean;
      
      public var original_x:Number;
      
      public var original_y:Number;
      
      public function Token(_dialog:Dialog, _text:String, _action:int = 0, _color:int = 16777215, _animation:int = 0, _isButton:Boolean = false)
      {
         super();
         this.dialog = _dialog;
         this.text = _text;
         this.isNewParagraph = this.isNewLine = this.isBackspace = this.isPause = false;
         this.IS_WAITING = true;
         this.IS_RENDERING = false;
         this.HAS_FINISHED = false;
         this.WIDTH = 0;
         this.counter = this.char_index = 0;
         this.sinCounter = 0;
         this.wait_time = 0;
         this.action = _action;
         this.color = _color;
         this.animation = _animation;
         this.isButton = _isButton;
         this.images = null;
         this.addChars();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         if(this.images != null)
         {
            for(i = 0; i < this.images.length; i++)
            {
               if(this.images[i] != null)
               {
                  removeChild(this.images[i]);
                  this.images[i].dispose();
                  this.images[i] = null;
               }
            }
         }
         this.images = null;
         this.text = null;
         this.dialog = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var image:Image = null;
         var shift:Number = NaN;
         if(this.IS_WAITING)
         {
            if(this.isPause)
            {
               this.wait_time = 30;
            }
            else
            {
               this.wait_time = 0;
            }
         }
         else if(this.IS_RENDERING)
         {
            ++this.counter;
            if(this.counter > this.dialog.getCharRenderTime() + this.wait_time)
            {
               this.wait_time = 0;
               this.counter = 0;
               getChildAt(this.char_index).visible = true;
               if(Utils.LAST_DIALOG == Dialog.SOUND_NORMAL)
               {
                  SoundSystem.PlaySound("hud_font");
               }
               else if(Utils.LAST_DIALOG != Dialog.NO_SOUND)
               {
                  SoundSystem.PlaySound("hud_font");
               }
               ++this.char_index;
               if(this.char_index >= numChildren)
               {
                  this.IS_RENDERING = false;
                  this.HAS_FINISHED = true;
               }
            }
         }
         else if(this.HAS_FINISHED)
         {
         }
         if(!this.IS_WAITING)
         {
            if(this.animation == Dialog.SHAKE)
            {
               x = this.original_x + this.dialog.anim_x;
               y = this.original_y + this.dialog.anim_y;
            }
            else if(this.animation == Dialog.WAVE)
            {
               for(i = 0; i < numChildren; i++)
               {
                  image = getChildAt(i) as Image;
                  shift = Number(image.name) * 0.75;
                  image.y = int(this.original_y + int(Math.sin(this.dialog.wave_sin_counter + shift) * 2));
               }
            }
            else if(this.animation == Dialog.HOR_WAVE || this.animation == Dialog.RADIO)
            {
               x = int(this.original_x + int(Math.sin(this.dialog.wave_sin_counter * 4) * 2));
               if(this.dialog.tick_since_complete > 30 && Math.abs(x - this.original_x) < 1)
               {
                  x = int(this.original_x);
                  this.animation = Dialog.NONE;
               }
            }
         }
      }
      
      public function startRendering() : void
      {
         this.IS_WAITING = false;
         this.IS_RENDERING = true;
         this.original_x = x;
         this.original_y = y;
         if(this.action != 0)
         {
            if(this.dialog.entity != null)
            {
            }
         }
      }
      
      public function renderAll() : void
      {
         var i:int = 0;
         for(i = 0; i < numChildren; i++)
         {
            getChildAt(i).visible = true;
         }
         this.original_x = x;
         this.original_y = y;
         this.IS_WAITING = false;
         this.IS_RENDERING = false;
         this.HAS_FINISHED = true;
      }
      
      public function addChars() : void
      {
         var i:int = 0;
         var image:Image = null;
         var _textField:TextField = null;
         var _image:Image = null;
         var _w:int = 0;
         var _h:int = 0;
         var advance_x:int = 0;
         var isCharMissing:Boolean = false;
         var char_code:int = 0;
         var __width:int = 0;
         var __height:int = 0;
         var _renderTexture:RenderTexture = null;
         advance_x = 0;
         this.images = new Array();
         if(Utils.EnableFontStrings)
         {
            image = null;
            _textField = new TextField(140 * 3,100 * 3,this.text);
            _textField.format.setTo("Verdana",10 * 3,8267091);
            _w = _textField.textBounds.width + 1;
            _h = _textField.textBounds.height + 1;
            _textField = new TextField(_w,_h,this.text);
            _textField.format.setTo("Verdana",10 * 3,8267091);
            _textField.format.horizontalAlign = Align.LEFT;
            _textField.format.verticalAlign = Align.TOP;
            _textField.touchable = false;
            _textField.border = false;
            _textField.pixelSnapping = true;
            __width = _textField.bounds.width;
            __height = _textField.bounds.height;
            _renderTexture = new RenderTexture(__width + 8,__height + 8);
            _renderTexture.draw(_textField);
            _image = new Image(_renderTexture);
            _image.scaleX = _image.scaleY = 0.3333;
            _image.pivotX = 2;
            _image.pivotY = 4;
            _image.x = advance_x;
            _image.y = 0;
            _image.visible = false;
            _image.name = "" + this.dialog.char_index++;
            _image.textureSmoothing = TextureSmoothing.BILINEAR;
            addChild(_image);
            this.images.push(_image);
            advance_x += int(_image.width);
            this.WIDTH += int(_image.width);
            if(i != this.text.length - 1)
            {
               this.WIDTH += this.dialog.char_spacing;
            }
            return;
         }
         if(!this.isButton)
         {
            for(i = 0; i < this.text.length; i++)
            {
               isCharMissing = false;
               try
               {
                  if(Utils.EnableFontStrings)
                  {
                     image = null;
                     _textField = new TextField(16,16,this.text.charAt(i));
                     _textField.format.setTo("Verdana",10 * 3,8267091);
                     _w = _textField.textBounds.width + 1;
                     _h = _textField.textBounds.height + 1;
                     _textField = new TextField(_w,_h,this.text.charAt(i));
                     _textField.format.setTo("Verdana",10 * 3,8267091);
                     _textField.format.horizontalAlign = Align.LEFT;
                     _textField.format.verticalAlign = Align.TOP;
                     _textField.touchable = false;
                     _textField.border = false;
                     _textField.pixelSnapping = true;
                     __width = _textField.bounds.width;
                     __height = _textField.bounds.height;
                     _renderTexture = new RenderTexture(__width + 8,__height + 8);
                     _renderTexture.draw(_textField);
                     _image = new Image(_renderTexture);
                     _image.scaleX = _image.scaleY = 0.3333;
                  }
                  else
                  {
                     _textField = null;
                     char_code = this.text.charCodeAt(i);
                     if(char_code != 32 && char_code != 160)
                     {
                        image = new Image(TextureManager.hudTextureAtlas.getTexture(this.dialog.getCharName(this.color) + this.dialog.getCharCode(char_code)));
                     }
                     else
                     {
                        isCharMissing = true;
                     }
                  }
               }
               catch(err:Error)
               {
                  trace("Token::addChars - Missing char code " + dialog.getCharCode(text.charCodeAt(i)));
                  isCharMissing = true;
               }
               finally
               {
                  if(!isCharMissing)
                  {
                     if(image != null)
                     {
                        image.pivotX = this.dialog.font_pivot_x;
                        image.pivotY = this.dialog.font_pivot_y;
                        image.x = advance_x;
                        image.y = 0;
                        image.visible = false;
                        image.name = "" + this.dialog.char_index++;
                        addChild(image);
                        this.images.push(image);
                        advance_x += this.dialog.getCharWidth(this.dialog.getCharCode(this.text.charCodeAt(i))) + this.dialog.char_spacing;
                        this.WIDTH += this.dialog.getCharWidth(this.dialog.getCharCode(this.text.charCodeAt(i)));
                        if(i != this.text.length - 1)
                        {
                           this.WIDTH += this.dialog.char_spacing;
                        }
                     }
                     else if(_textField != null)
                     {
                        _image.pivotX = 2;
                        _image.pivotY = 4;
                        _image.x = advance_x;
                        _image.y = 0;
                        _image.visible = false;
                        _image.name = "" + this.dialog.char_index++;
                        _image.textureSmoothing = TextureSmoothing.BILINEAR;
                        addChild(_image);
                        this.images.push(_image);
                        advance_x += int(_image.width * 0.6);
                        this.WIDTH += int(_image.width * 0.55);
                        if(i != this.text.length - 1)
                        {
                           this.WIDTH += this.dialog.char_spacing;
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
