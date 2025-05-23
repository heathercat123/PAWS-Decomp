package interfaces.panels
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import interfaces.texts.GameText;
   import starling.display.Button;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   
   public class SettingsCreditsPanel extends Sprite
   {
      
      public var settingsPanel:SettingsPanel;
      
      protected var bluePanel:BluePanel;
      
      protected var maskContainer:Sprite;
      
      protected var textContainer:Sprite;
      
      protected var texts:Array;
      
      protected var quadMask:Quad;
      
      protected var end_y:int;
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      public var counter_1:int;
      
      public var counter_2:int;
      
      public var yVel:Number;
      
      public var yPos:Number;
      
      protected var IS_TOUCHING:Boolean;
      
      protected var touch_area:Rectangle;
      
      protected var last_y:Number;
      
      protected var new_y:Number;
      
      public function SettingsCreditsPanel(_settingsPanel:SettingsPanel, _width:int, _height:int)
      {
         super();
         this.settingsPanel = _settingsPanel;
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.IS_TOUCHING = false;
         this.end_y = 0;
         this.counter_1 = this.counter_2 = 0;
         this.yVel = this.last_y = this.new_y = 0;
         this.touch_area = new Rectangle();
         this.quadMask = new Quad(_width,_height - 4);
         this.quadMask.y += 2;
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT);
         addChild(this.bluePanel);
         this.maskContainer = new Sprite();
         addChild(this.maskContainer);
         this.maskContainer.mask = this.quadMask;
         this.textContainer = new Sprite();
         this.maskContainer.addChild(this.textContainer);
         this.yPos = 32;
         this.initStrings();
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onClick);
      }
      
      public function onClick(event:TouchEvent) : void
      {
         var point:Point = null;
         if(!this.visible)
         {
            return;
         }
         var touch:Touch = event.getTouch(Utils.rootStage);
         if(event.target is Button)
         {
            return;
         }
         if(touch != null)
         {
            this.last_y = touch.previousGlobalY * Utils.GFX_INV_SCALE;
            this.new_y = touch.globalY * Utils.GFX_INV_SCALE;
            if(touch.phase == TouchPhase.BEGAN)
            {
               point = new Point(touch.globalX * Utils.GFX_INV_SCALE,touch.globalY * Utils.GFX_INV_SCALE);
               if(this.touch_area.containsPoint(point))
               {
                  this.IS_TOUCHING = true;
               }
            }
            else if(touch.phase != TouchPhase.MOVED)
            {
               if(touch.phase == TouchPhase.ENDED)
               {
                  this.IS_TOUCHING = false;
               }
            }
         }
      }
      
      public function update() : void
      {
         var desidered_y_vel:Number = NaN;
         var y_vel_diff:Number = NaN;
         if(this.IS_TOUCHING)
         {
            this.yVel = this.new_y - this.last_y;
            if(Math.abs(this.yVel) < 0.5)
            {
               this.yVel = 0;
            }
            this.yPos += this.yVel;
            this.counter_1 = 91;
         }
         else
         {
            if(this.counter_1++ > 90)
            {
               this.counter_1 = 91;
               desidered_y_vel = -0.5;
               y_vel_diff = desidered_y_vel - this.yVel;
               this.yVel += y_vel_diff * 0.1;
            }
            this.yPos += this.yVel;
         }
         if(this.yPos < -(this.end_y + 32))
         {
            this.yPos = this.HEIGHT + 4;
         }
         else if(this.yPos > this.HEIGHT + 32)
         {
            this.yPos = -(this.end_y + 32);
         }
         this.textContainer.y = int(Math.floor(this.yPos));
      }
      
      public function reset() : void
      {
         this.textContainer.y = 32;
         this.counter_1 = this.counter_2 = 0;
         this.yVel = 0;
         this.yPos = 32;
         this.last_y = this.new_y = 0;
         this.IS_TOUCHING = false;
      }
      
      protected function initStrings() : void
      {
         var gText:GameText = null;
         var advance_y:int = 0;
         this.texts = new Array();
         advance_y = 0;
         gText = new GameText("SUPER CAT TALES",GameText.TYPE_BIG);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         gText = new GameText("PAWS",GameText.TYPE_BIG);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         gText = new GameText("©neutronized 2016-2023",GameText.TYPE_SMALL_WHITE);
         gText.setColor(16756684);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         advance_y += 48;
         gText = new GameText(StringsManager.GetString("credits_line_0"),GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         gText.setColor(16756684);
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         if(Utils.IS_ANDROID)
         {
            gText = new GameText(Utils.ANDROID_VERSION_STRING,GameText.TYPE_SMALL_WHITE);
         }
         else
         {
            gText = new GameText(Utils.VERSION_STRING,GameText.TYPE_SMALL_WHITE);
         }
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         advance_y += 48;
         gText = new GameText(StringsManager.GetString("credits_line_2"),GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         gText.setColor(16756684);
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         gText = new GameText("neutronized",GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         gText = new GameText("www.neutronized.com",GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         gText.setColor(16756684);
         this.texts.push(gText);
         advance_y += 48;
         gText = new GameText(StringsManager.GetString("credits_line_3"),GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         gText.setColor(16756684);
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         gText = new GameText("gionathan",GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         advance_y += 32;
         gText = new GameText(StringsManager.GetString("credits_line_4"),GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         gText.setColor(16756684);
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         gText = new GameText("emi monserrate",GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         gText = new GameText("cocefi",GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         advance_y += 32;
         gText = new GameText(StringsManager.GetString("credits_line_5"),GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         gText.setColor(16756684);
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         gText = new GameText("raku",GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         advance_y += 48;
         gText = new GameText(StringsManager.GetString("credits_line_14"),GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         gText.setColor(16756684);
         this.texts.push(gText);
         advance_y += gText.HEIGHT + 3;
         gText = new GameText("laura, nora",GameText.TYPE_SMALL_WHITE);
         gText.pivotX = gText.WIDTH * 0.5;
         this.textContainer.addChild(gText);
         gText.x = int(this.WIDTH * 0.5);
         gText.y = advance_y;
         this.texts.push(gText);
         this.end_y = advance_y;
      }
      
      public function setArea(__x:Number, __y:Number, __width:Number, __height:Number) : void
      {
         this.touch_area.x = __x;
         this.touch_area.y = __y;
         this.touch_area.width = __width;
         this.touch_area.height = __height;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onClick);
         for(i = 0; i < this.texts.length; i++)
         {
            this.textContainer.removeChild(this.texts[i]);
            this.texts[i].destroy();
            this.texts[i].dispose();
            this.texts[i] = null;
         }
         this.texts = null;
         this.maskContainer.removeChild(this.textContainer);
         this.textContainer.dispose();
         this.textContainer = null;
         removeChild(this.maskContainer);
         this.maskContainer.mask = null;
         this.maskContainer.dispose();
         this.maskContainer = null;
         this.quadMask.dispose();
         this.quadMask = null;
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
         this.settingsPanel = null;
      }
   }
}

