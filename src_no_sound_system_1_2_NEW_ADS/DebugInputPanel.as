package
{
   import flash.display.*;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class DebugInputPanel extends Sprite
   {
      
      private static var _instance:DebugInputPanel = null;
      
      private static var _tf1:TextField;
      
      private static var _tf2:TextField;
      
      private static var _tf3:TextField;
      
      private static var _tf4:TextField;
      
      private static var _mf1:TextField;
      
      private static var _mf2:TextField;
      
      private static var _mf3:TextField;
      
      private static var _mf4:TextField;
      
      private static var _lf1:TextField;
      
      private static var _lf2:TextField;
      
      private static var _lf3:TextField;
      
      private static var _lf4:TextField;
      
      private static var _df1:TextField;
      
      private static var _df2:TextField;
      
      private static var _df3:TextField;
      
      private static var _df4:TextField;
      
      private static var cursor_selector:int = 0;
      
      private static var cursor1:Sprite;
      
      private static var cursor2:Sprite;
      
      private static var cursor3:Sprite;
      
      private static var cursor4:Sprite;
      
      private static var cXPos1:Number;
      
      private static var cXPos2:Number;
      
      private static var cXPos3:Number;
      
      private static var cXPos4:Number;
      
      private static var cursor1Value:Number = 0;
      
      private static var cursor2Value:Number = 0;
      
      private static var cursor3Value:Number = 0;
      
      private static var cursor4Value:Number = 0;
      
      private static var normValue1:Number = 0;
      
      private static var normValue2:Number = 0;
      
      private static var normValue3:Number = 0;
      
      private static var normValue4:Number = 0;
      
      private static var multValue1:Number = 1;
      
      private static var multValue2:Number = 2;
      
      private static var multValue3:Number = 3;
      
      private static var multValue4:Number = 4;
       
      
      private var bitmap:Bitmap;
      
      private var bitmapData:BitmapData;
      
      public function DebugInputPanel()
      {
         super();
         this.bitmapData = new BitmapData(320,208,true,1711276032);
         this.bitmap = new Bitmap(this.bitmapData);
         addChild(this.bitmap);
         this.initText();
         this.initCursors();
         this.initMultiplierText();
         this.initTextDisplayers();
         addEventListener(Event.ENTER_FRAME,this.update);
      }
      
      public static function getInstance() : DebugInputPanel
      {
         if(_instance == null)
         {
            _instance = new DebugInputPanel();
         }
         return _instance;
      }
      
      private function initCursors() : void
      {
         var labelText:TextField = null;
         var textFormat:TextFormat = new TextFormat();
         textFormat.font = "Arial";
         textFormat.size = 12;
         textFormat.color = 16777215;
         labelText = new TextField();
         labelText.x = 12;
         labelText.y = 80;
         labelText.width = 16;
         labelText.height = 16;
         labelText.text = "s1";
         labelText.mouseEnabled = false;
         labelText.textColor = 1048575;
         labelText.defaultTextFormat = textFormat;
         addChild(labelText);
         labelText = new TextField();
         labelText.x = 12;
         labelText.y = 96;
         labelText.width = 16;
         labelText.height = 16;
         labelText.text = "s2";
         labelText.mouseEnabled = false;
         labelText.textColor = 1048575;
         labelText.defaultTextFormat = textFormat;
         addChild(labelText);
         labelText = new TextField();
         labelText.x = 12;
         labelText.y = 112;
         labelText.width = 16;
         labelText.height = 16;
         labelText.text = "s3";
         labelText.mouseEnabled = false;
         labelText.textColor = 1048575;
         labelText.defaultTextFormat = textFormat;
         addChild(labelText);
         labelText = new TextField();
         labelText.x = 12;
         labelText.y = 128;
         labelText.width = 16;
         labelText.height = 16;
         labelText.text = "s4";
         labelText.mouseEnabled = false;
         labelText.textColor = 1048575;
         labelText.defaultTextFormat = textFormat;
         addChild(labelText);
         Main.rootStage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpFunction);
         this.bitmapData.fillRect(new Rectangle(32,89,160,2),4294967295);
         cursor1 = new Sprite();
         cursor1.graphics.beginFill(16740607,1);
         cursor1.graphics.drawRect(0,0,8,8);
         cursor1.graphics.endFill();
         cursor1.y = 86;
         cursor1.x = cXPos1 = 32 + 80 - 4;
         cursor1.buttonMode = true;
         cursor1.name = "cursor_1";
         addChild(cursor1);
         cursor1.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownFunction);
         this.bitmapData.fillRect(new Rectangle(32,105,160,2),4294967295);
         cursor2 = new Sprite();
         cursor2.graphics.beginFill(16740607,1);
         cursor2.graphics.drawRect(0,0,8,8);
         cursor2.graphics.endFill();
         cursor2.y = 102;
         cursor2.x = cXPos2 = 32 + 80 - 4;
         cursor2.buttonMode = true;
         cursor2.name = "cursor_2";
         addChild(cursor2);
         cursor2.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownFunction);
         this.bitmapData.fillRect(new Rectangle(32,121,160,2),4294967295);
         cursor3 = new Sprite();
         cursor3.graphics.beginFill(16740607,1);
         cursor3.graphics.drawRect(0,0,8,8);
         cursor3.graphics.endFill();
         cursor3.y = 118;
         cursor3.x = cXPos3 = 32 + 80 - 4;
         cursor3.buttonMode = true;
         cursor3.name = "cursor_3";
         addChild(cursor3);
         cursor3.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownFunction);
         this.bitmapData.fillRect(new Rectangle(32,137,160,2),4294967295);
         cursor4 = new Sprite();
         cursor4.graphics.beginFill(16740607,1);
         cursor4.graphics.drawRect(0,0,8,8);
         cursor4.graphics.endFill();
         cursor4.y = 134;
         cursor4.x = cXPos4 = 32 + 80 - 4;
         cursor4.buttonMode = true;
         cursor4.name = "cursor_4";
         addChild(cursor4);
         cursor4.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownFunction);
      }
      
      private function update(e:Event) : void
      {
         var start_value:Number = NaN;
         multValue1 = Number(_mf1.text);
         multValue2 = Number(_mf2.text);
         multValue3 = Number(_mf3.text);
         multValue4 = Number(_mf4.text);
         cursor1.y = 86;
         if(cursor1.x <= 28)
         {
            cursor1.x = 28;
         }
         else if(cursor1.x >= 188)
         {
            cursor1.x = 188;
         }
         start_value = cursor1.x;
         start_value -= 28;
         start_value /= 160;
         normValue1 = (start_value - 0.5) * 2 * multValue1;
         cursor2.y = 102;
         if(cursor2.x <= 28)
         {
            cursor2.x = 28;
         }
         else if(cursor2.x >= 188)
         {
            cursor2.x = 188;
         }
         start_value = cursor2.x;
         start_value -= 28;
         start_value /= 160;
         normValue2 = (start_value - 0.5) * 2 * multValue2;
         cursor3.y = 118;
         if(cursor3.x <= 28)
         {
            cursor3.x = 28;
         }
         else if(cursor3.x >= 188)
         {
            cursor3.x = 188;
         }
         start_value = cursor3.x;
         start_value -= 28;
         start_value /= 160;
         normValue3 = (start_value - 0.5) * 2 * multValue3;
         cursor4.y = 134;
         if(cursor4.x <= 28)
         {
            cursor4.x = 28;
         }
         else if(cursor4.x >= 188)
         {
            cursor4.x = 188;
         }
         start_value = cursor4.x;
         start_value -= 28;
         start_value /= 160;
         normValue4 = (start_value - 0.5) * 2 * multValue4;
         _lf1.text = "" + normValue1;
         _lf2.text = "" + normValue2;
         _lf3.text = "" + normValue3;
         _lf4.text = "" + normValue4;
      }
      
      private function mouseDownFunction(e:MouseEvent) : void
      {
         if(e.target.name == "cursor_1")
         {
            cursor_selector = 1;
         }
         else if(e.target.name == "cursor_1")
         {
            cursor_selector = 2;
         }
         else if(e.target.name == "cursor_1")
         {
            cursor_selector = 3;
         }
         else
         {
            cursor_selector = 4;
         }
         e.target.startDrag();
      }
      
      private function mouseUpFunction(e:MouseEvent) : void
      {
         if(cursor_selector == 1)
         {
            cursor1.stopDrag();
         }
         else if(cursor_selector == 2)
         {
            cursor2.stopDrag();
         }
         else if(cursor_selector == 3)
         {
            cursor3.stopDrag();
         }
         else
         {
            cursor4.stopDrag();
         }
      }
      
      private function initText() : void
      {
         var labelText:TextField = null;
         var textFormat:TextFormat = new TextFormat();
         textFormat.font = "Arial";
         textFormat.size = 12;
         textFormat.color = 16777215;
         this.bitmapData.fillRect(new Rectangle(32,16,112,16),1728053247);
         _tf1 = new TextField();
         _tf1.x = 32;
         _tf1.y = 16;
         _tf1.width = 112;
         _tf1.height = 16;
         _tf1.type = TextFieldType.INPUT;
         _tf1.border = true;
         _tf1.borderColor = 16777215;
         _tf1.defaultTextFormat = textFormat;
         addChild(_tf1);
         labelText = new TextField();
         labelText.x = _tf1.x - 16;
         labelText.y = _tf1.y;
         labelText.width = 16;
         labelText.height = 16;
         labelText.text = "c1";
         labelText.textColor = 1048575;
         labelText.mouseEnabled = false;
         labelText.defaultTextFormat.font = "Arial";
         addChild(labelText);
         this.bitmapData.fillRect(new Rectangle(176,16,112,16),1728053247);
         _tf2 = new TextField();
         _tf2.x = 176;
         _tf2.y = 16;
         _tf2.width = 112;
         _tf2.height = 16;
         _tf2.background;
         _tf2.type = TextFieldType.INPUT;
         _tf2.border = true;
         _tf2.borderColor = 16777215;
         _tf2.defaultTextFormat = textFormat;
         addChild(_tf2);
         labelText = new TextField();
         labelText.x = _tf2.x - 16;
         labelText.y = _tf2.y;
         labelText.width = 16;
         labelText.height = 16;
         labelText.text = "c2";
         labelText.mouseEnabled = false;
         labelText.textColor = 1048575;
         labelText.defaultTextFormat = textFormat;
         addChild(labelText);
         this.bitmapData.fillRect(new Rectangle(32,48,112,16),1728053247);
         _tf3 = new TextField();
         _tf3.x = 32;
         _tf3.y = 48;
         _tf3.width = 112;
         _tf3.height = 16;
         _tf3.background;
         _tf3.type = TextFieldType.INPUT;
         _tf3.border = true;
         _tf3.borderColor = 16777215;
         _tf3.defaultTextFormat = textFormat;
         addChild(_tf3);
         labelText = new TextField();
         labelText.x = _tf3.x - 16;
         labelText.y = _tf3.y;
         labelText.width = 16;
         labelText.height = 16;
         labelText.text = "c3";
         labelText.mouseEnabled = false;
         labelText.textColor = 1048575;
         labelText.defaultTextFormat = textFormat;
         addChild(labelText);
         this.bitmapData.fillRect(new Rectangle(176,48,112,16),1728053247);
         _tf4 = new TextField();
         _tf4.x = 176;
         _tf4.y = 48;
         _tf4.width = 112;
         _tf4.height = 16;
         _tf4.background;
         _tf4.type = TextFieldType.INPUT;
         _tf4.border = true;
         _tf4.borderColor = 16777215;
         _tf4.defaultTextFormat = textFormat;
         addChild(_tf4);
         labelText = new TextField();
         labelText.x = _tf4.x - 16;
         labelText.y = _tf4.y;
         labelText.width = 16;
         labelText.height = 16;
         labelText.text = "c4";
         labelText.mouseEnabled = false;
         labelText.textColor = 1048575;
         labelText.defaultTextFormat = textFormat;
         addChild(labelText);
      }
      
      private function initMultiplierText() : void
      {
         var labelText:TextField = null;
         var textFormat:TextFormat = new TextFormat();
         textFormat.font = "Arial";
         textFormat.size = 12;
         textFormat.color = 16777215;
         this.bitmapData.fillRect(new Rectangle(208,80,48,16),1728053247);
         _mf1 = new TextField();
         _mf1.x = 208;
         _mf1.y = 80;
         _mf1.width = 48;
         _mf1.height = 16;
         _mf1.type = TextFieldType.INPUT;
         _mf1.border = true;
         _mf1.borderColor = 16777215;
         _mf1.text = "1";
         _mf1.defaultTextFormat = textFormat;
         addChild(_mf1);
         _lf1 = new TextField();
         _lf1.x = _mf1.x + _mf1.width + 8;
         _lf1.y = _mf1.y;
         _lf1.width = 48;
         _lf1.height = 16;
         _lf1.text = "0";
         _lf1.textColor = 1048575;
         _lf1.defaultTextFormat = textFormat;
         addChild(_lf1);
         this.bitmapData.fillRect(new Rectangle(208,96,48,16),1728053247);
         _mf2 = new TextField();
         _mf2.x = 208;
         _mf2.y = 96;
         _mf2.width = 48;
         _mf2.height = 16;
         _mf2.type = TextFieldType.INPUT;
         _mf2.border = true;
         _mf2.borderColor = 16777215;
         _mf2.text = "1";
         _mf2.defaultTextFormat = textFormat;
         addChild(_mf2);
         _lf2 = new TextField();
         _lf2.x = _mf2.x + _mf2.width + 8;
         _lf2.y = _mf2.y;
         _lf2.width = 48;
         _lf2.height = 16;
         _lf2.text = "0";
         _lf2.textColor = 1048575;
         _lf2.defaultTextFormat = textFormat;
         addChild(_lf2);
         this.bitmapData.fillRect(new Rectangle(208,112,48,16),1728053247);
         _mf3 = new TextField();
         _mf3.x = 208;
         _mf3.y = 112;
         _mf3.width = 48;
         _mf3.height = 16;
         _mf3.type = TextFieldType.INPUT;
         _mf3.border = true;
         _mf3.borderColor = 16777215;
         _mf3.text = "1";
         _mf3.defaultTextFormat = textFormat;
         addChild(_mf3);
         _lf3 = new TextField();
         _lf3.x = _mf3.x + _mf3.width + 8;
         _lf3.y = _mf3.y;
         _lf3.width = 48;
         _lf3.height = 16;
         _lf3.text = "0";
         _lf3.textColor = 1048575;
         _lf3.defaultTextFormat = textFormat;
         addChild(_lf3);
         this.bitmapData.fillRect(new Rectangle(208,128,48,16),1728053247);
         _mf4 = new TextField();
         _mf4.x = 208;
         _mf4.y = 128;
         _mf4.width = 48;
         _mf4.height = 16;
         _mf4.type = TextFieldType.INPUT;
         _mf4.border = true;
         _mf4.borderColor = 16777215;
         _mf4.text = "1";
         _mf4.defaultTextFormat = textFormat;
         addChild(_mf4);
         _lf4 = new TextField();
         _lf4.x = _mf4.x + _mf4.width + 8;
         _lf4.y = _mf4.y;
         _lf4.width = 48;
         _lf4.height = 16;
         _lf4.text = "0";
         _lf4.textColor = 1048575;
         _lf4.defaultTextFormat = textFormat;
         addChild(_lf4);
      }
      
      protected function initTextDisplayers() : void
      {
         var labelText:TextField = null;
         var textFormat:TextFormat = new TextFormat();
         textFormat.font = "Arial";
         textFormat.size = 10;
         textFormat.color = 16777215;
         this.bitmapData.fillRect(new Rectangle(32,156,112,16),1728053247);
         this.bitmapData.fillRect(new Rectangle(32,180,112,16),1728053247);
         this.bitmapData.fillRect(new Rectangle(176,156,112,16),1728053247);
         this.bitmapData.fillRect(new Rectangle(176,180,112,16),1728053247);
         _df1 = new TextField();
         _df1.x = 32;
         _df1.y = 156;
         _df1.width = 112;
         _df1.height = 16;
         _df1.mouseEnabled = false;
         _df1.text = "";
         _df1.defaultTextFormat = textFormat;
         addChild(_df1);
         _df2 = new TextField();
         _df2.x = 32;
         _df2.y = 180;
         _df2.width = 112;
         _df2.height = 16;
         _df2.mouseEnabled = false;
         _df2.text = "";
         _df2.defaultTextFormat = textFormat;
         addChild(_df2);
         _df3 = new TextField();
         _df3.x = 176;
         _df3.y = 156;
         _df3.width = 112;
         _df3.height = 16;
         _df3.mouseEnabled = false;
         _df3.text = "";
         _df3.defaultTextFormat = textFormat;
         addChild(_df3);
         _df4 = new TextField();
         _df4.x = 176;
         _df4.y = 180;
         _df4.width = 112;
         _df4.height = 16;
         _df4.mouseEnabled = false;
         _df4.text = "";
         _df4.defaultTextFormat = textFormat;
         addChild(_df4);
      }
      
      public function get c1() : Number
      {
         return Number(_tf1.text);
      }
      
      public function get c2() : Number
      {
         return Number(_tf2.text);
      }
      
      public function get c3() : Number
      {
         return Number(_tf3.text);
      }
      
      public function get c4() : Number
      {
         return Number(_tf4.text);
      }
      
      public function get s1() : Number
      {
         return Number(normValue1);
      }
      
      public function get s2() : Number
      {
         return Number(normValue2);
      }
      
      public function get s3() : Number
      {
         return Number(normValue3);
      }
      
      public function get s4() : Number
      {
         return Number(normValue4);
      }
      
      public function get text1() : TextField
      {
         return _df1;
      }
      
      public function get text2() : TextField
      {
         return _df2;
      }
      
      public function get text3() : TextField
      {
         return _df3;
      }
      
      public function get text4() : TextField
      {
         return _df4;
      }
   }
}
