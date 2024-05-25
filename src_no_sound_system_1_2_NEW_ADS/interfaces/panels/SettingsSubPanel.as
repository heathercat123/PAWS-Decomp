package interfaces.panels
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game_utils.SaveManager;
   import interfaces.buttons.TextButton;
   import interfaces.texts.GameText;
   import interfaces.texts.GameTextArea;
   import starling.display.*;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class SettingsSubPanel extends Sprite
   {
       
      
      public var TYPE:int;
      
      public var settingsPanel:SettingsPanel;
      
      protected var bluePanel:BluePanel;
      
      protected var container:Sprite;
      
      protected var sub_container:Sprite;
      
      public var WIDTH:int;
      
      public var HEIGHT:int;
      
      protected var text1:GameTextArea;
      
      protected var text2:GameText;
      
      protected var yesButton:TextButton;
      
      protected var noButton:TextButton;
      
      protected var choice1Panel:ChoiceSelectorPanel;
      
      protected var choice2Panel:ChoiceSelectorPanel;
      
      protected var choice3Panel:ChoiceSelectorPanel;
      
      protected var quadMask:Quad;
      
      public var IS_DONE:Boolean;
      
      protected var y_diff:Number;
      
      protected var y_new:Number;
      
      protected var y_key:Number;
      
      protected var y_freeze:Number;
      
      protected var yPos:Number;
      
      protected var yPosWhenTouched:Number;
      
      protected var TOP_MARGIN:Number;
      
      protected var BOTTOM_MARGIN:Number;
      
      protected var ITEMS_HEIGHT:Number;
      
      protected var IS_PRESSED:Boolean;
      
      protected var IS_MOVING_BOTTOM:Boolean;
      
      protected var IS_MOVING_ALLOWED:Boolean;
      
      protected var touch_area:Rectangle;
      
      public function SettingsSubPanel(_settingsPanel:SettingsPanel, _width:int, _height:int, _TYPE:int)
      {
         super();
         this.settingsPanel = _settingsPanel;
         this.TYPE = _TYPE;
         this.WIDTH = _width;
         this.HEIGHT = _height;
         this.IS_DONE = false;
         this.IS_MOVING_ALLOWED = true;
         this.IS_PRESSED = this.IS_MOVING_BOTTOM = false;
         this.yPos = this.y_key = this.y_new = this.y_diff = this.yPosWhenTouched = 0;
         this.y_freeze = 1;
         this.touch_area = new Rectangle();
         this.TOP_MARGIN = 0;
         this.BOTTOM_MARGIN = this.HEIGHT;
         this.bluePanel = new BluePanel(this.WIDTH,this.HEIGHT);
         addChild(this.bluePanel);
         this.container = new Sprite();
         addChild(this.container);
         this.container.x = this.container.y = 0;
         this.sub_container = new Sprite();
         this.container.addChild(this.sub_container);
         this.sub_container.x = this.sub_container.y = 0;
         this.text1 = null;
         this.text2 = null;
         this.yesButton = null;
         this.noButton = null;
         this.choice1Panel = null;
         this.choice2Panel = null;
         this.choice3Panel = null;
         if(this.TYPE == 0)
         {
            this.initResetPanel();
         }
         else
         {
            this.initOptionsPanel();
         }
         if(this.ITEMS_HEIGHT <= this.HEIGHT)
         {
            this.IS_MOVING_ALLOWED = false;
         }
         this.quadMask = new Quad(this.WIDTH - 4,this.HEIGHT - 4);
         this.quadMask.x = this.quadMask.y = 2;
         this.container.mask = this.quadMask;
         Utils.rootStage.addEventListener(TouchEvent.TOUCH,this.onSubPanelTouch);
      }
      
      public function onClick(event:Event) : void
      {
         if(!this.visible)
         {
            return;
         }
         var button:Button = event.target as Button;
         if(button.name == "yesButton")
         {
            SaveManager.Reset();
            SoundSystem.PlaySound("confirmShort");
         }
         else if(button.name == "resetButton")
         {
            SoundSystem.PlaySound("select");
            this.settingsPanel.showReset();
         }
         else if(button.name == "creditsButton")
         {
            SoundSystem.PlaySound("select");
            this.settingsPanel.showCredits();
         }
         else if(button.name == "noButton")
         {
            SoundSystem.PlaySound("select");
         }
         this.IS_DONE = true;
      }
      
      public function update() : void
      {
         if(this.IS_PRESSED)
         {
            this.y_diff = (this.y_new - this.y_key) * this.y_freeze;
            this.y_key += this.y_diff * 0.5;
            this.yPos += this.y_diff * 0.5;
            if(Math.abs(this.yPos - this.yPosWhenTouched) > 8)
            {
               this.setButtonsEnabled(false);
            }
            if(this.yPos > this.TOP_MARGIN + 16)
            {
               this.yPos = this.TOP_MARGIN + 16;
            }
            else if(this.yPos + this.ITEMS_HEIGHT < this.BOTTOM_MARGIN - 16)
            {
               this.yPos = this.BOTTOM_MARGIN - 16 - this.ITEMS_HEIGHT;
            }
         }
         else
         {
            this.yPos += this.y_diff;
            this.y_diff *= 0.9;
            if(this.yPos > this.TOP_MARGIN)
            {
               this.yPos -= (this.yPos - this.TOP_MARGIN) * 0.25;
            }
            else if(this.yPos + this.ITEMS_HEIGHT < this.BOTTOM_MARGIN)
            {
               this.yPos += (this.BOTTOM_MARGIN - (this.yPos + this.ITEMS_HEIGHT)) * 0.25;
            }
         }
         this.sub_container.y = int(Math.floor(this.yPos));
         if(this.y_freeze < 0)
         {
            this.y_freeze = 0;
         }
         else if(this.y_freeze > 1)
         {
            this.y_freeze = 1;
         }
      }
      
      public function reset() : void
      {
         this.IS_DONE = false;
      }
      
      protected function initOptionsPanel() : void
      {
         var last_y_position:Number = 0;
         this.choice1Panel = new ChoiceSelectorPanel(0,this.WIDTH);
         this.choice2Panel = new ChoiceSelectorPanel(1,this.WIDTH);
         this.sub_container.addChild(this.choice1Panel);
         this.sub_container.addChild(this.choice2Panel);
         this.choice1Panel.x = int(this.WIDTH * 0.4);
         this.choice2Panel.x = int(this.WIDTH * 0.4);
         this.choice1Panel.y = 8;
         this.choice2Panel.y = this.choice1Panel.y + 24;
         last_y_position = this.choice2Panel.y;
         var __width:int = int(this.WIDTH - 16);
         var __height:int = this.HEIGHT - (last_y_position + 32);
         __height = 32;
         this.noButton = new TextButton(StringsManager.GetString("panel_settings"),__width,__height);
         this.sub_container.addChild(this.noButton);
         this.noButton.x = 8;
         this.noButton.y = last_y_position + 26;
         this.noButton.name = "creditsButton";
         this.yesButton = new TextButton(StringsManager.GetString("panel_reset"),__width,__height);
         this.sub_container.addChild(this.yesButton);
         this.yesButton.x = 8;
         this.yesButton.y = this.noButton.y + this.noButton.HEIGHT + 6;
         this.yesButton.name = "resetButton";
         this.ITEMS_HEIGHT = this.yesButton.y + this.yesButton.HEIGHT + 6;
         this.noButton.addEventListener(Event.TRIGGERED,this.onClick);
         this.yesButton.addEventListener(Event.TRIGGERED,this.onClick);
      }
      
      protected function initResetPanel() : void
      {
         this.text1 = new GameTextArea(StringsManager.GetString("reset_line_1"),GameText.TYPE_SMALL_WHITE,this.WIDTH - 32,32,true);
         this.text1.x = int((this.WIDTH - (this.WIDTH - 32)) * 0.5);
         this.text1.pivotY = int(this.text1.HEIGHT * 0.5);
         if(Utils.EnableFontStrings)
         {
            this.text1.y = int(this.HEIGHT * 0.15);
         }
         else
         {
            this.text1.y = int(this.HEIGHT * 0.1);
         }
         this.sub_container.addChild(this.text1);
         this.text2 = new GameText(StringsManager.GetString("reset_line_0"),GameText.TYPE_BIG);
         this.text2.pivotX = int(this.text2.WIDTH * 0.5);
         this.text2.pivotY = int(this.text2.HEIGHT * 0.5);
         this.text2.x = int(this.WIDTH * 0.5);
         this.text2.y = int(this.HEIGHT * 0.4);
         this.sub_container.addChild(this.text2);
         var button_width:int = int((this.WIDTH - 22) * 0.5);
         var button_height:int = int(this.HEIGHT * 0.35);
         this.yesButton = new TextButton(StringsManager.GetString("yes"),button_width,button_height);
         this.yesButton.name = "yesButton";
         this.noButton = new TextButton(StringsManager.GetString("no"),button_width,button_height);
         this.noButton.name = "noButton";
         this.sub_container.addChild(this.yesButton);
         this.yesButton.x = 8;
         this.yesButton.y = this.HEIGHT - button_height - 8;
         this.sub_container.addChild(this.noButton);
         this.noButton.x = this.WIDTH - (button_width + 8);
         this.noButton.y = this.yesButton.y;
         this.yesButton.addEventListener(Event.TRIGGERED,this.onClick);
         this.noButton.addEventListener(Event.TRIGGERED,this.onClick);
      }
      
      public function onSubPanelTouch(event:TouchEvent) : void
      {
         var touches:Vector.<Touch> = null;
         var previousPosition:Point = null;
         var position:Point = null;
         var scaled_position:Point = null;
         if(!this.visible || this.TYPE == 0 || !this.IS_MOVING_ALLOWED)
         {
            return;
         }
         var touch:Touch = event.getTouch(Utils.rootStage);
         if(touch != null)
         {
            touches = event.getTouches(Utils.rootStage);
            previousPosition = touches[touches.length - 1].getPreviousLocation(Utils.rootStage);
            position = touches[touches.length - 1].getLocation(Utils.rootStage);
            scaled_position = new Point(position.x * Utils.GFX_INV_SCALE,position.y * Utils.GFX_INV_SCALE);
            if(touches[touches.length - 1].phase == "began")
            {
               if(this.touch_area.containsPoint(scaled_position))
               {
                  this.y_key = this.y_new = position.y * Utils.GFX_INV_SCALE;
                  this.IS_PRESSED = true;
                  this.yPosWhenTouched = this.yPos;
               }
            }
            else if(touches[touches.length - 1].phase == "moved")
            {
               if(position.y * Utils.GFX_INV_SCALE < this.y_new)
               {
                  this.IS_MOVING_BOTTOM = false;
               }
               else
               {
                  this.IS_MOVING_BOTTOM = true;
               }
               this.y_new = position.y * Utils.GFX_INV_SCALE;
            }
            else if(touches[touches.length - 1].phase == "ended")
            {
               this.IS_PRESSED = false;
               this.y_diff *= 0.75;
               this.setButtonsEnabled(true);
            }
         }
      }
      
      protected function setButtonsEnabled(_value:Boolean) : void
      {
         if(this.TYPE == 1)
         {
            this.yesButton.alphaWhenDisabled = 1;
            this.yesButton.enabled = _value;
            this.noButton.alphaWhenDisabled = 1;
            this.noButton.enabled = _value;
            this.choice1Panel.setButtonsEnabled(_value);
            this.choice2Panel.setButtonsEnabled(_value);
         }
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
         Utils.rootStage.removeEventListener(TouchEvent.TOUCH,this.onSubPanelTouch);
         this.quadMask.dispose();
         this.quadMask = null;
         if(this.choice1Panel != null)
         {
            this.sub_container.removeChild(this.choice1Panel);
            this.choice1Panel.destroy();
            this.choice1Panel.dispose();
            this.choice1Panel = null;
         }
         if(this.choice2Panel != null)
         {
            this.sub_container.removeChild(this.choice2Panel);
            this.choice2Panel.destroy();
            this.choice2Panel.dispose();
            this.choice2Panel = null;
         }
         if(this.choice3Panel != null)
         {
            this.sub_container.removeChild(this.choice3Panel);
            this.choice3Panel.destroy();
            this.choice3Panel.dispose();
            this.choice3Panel = null;
         }
         if(this.noButton != null)
         {
            this.noButton.removeEventListener(Event.TRIGGERED,this.onClick);
            this.sub_container.removeChild(this.noButton);
            this.noButton.destroy();
            this.noButton.dispose();
            this.noButton = null;
         }
         if(this.yesButton != null)
         {
            this.yesButton.removeEventListener(Event.TRIGGERED,this.onClick);
            this.sub_container.removeChild(this.yesButton);
            this.yesButton.destroy();
            this.yesButton.dispose();
            this.yesButton = null;
         }
         removeChild(this.bluePanel);
         this.bluePanel.destroy();
         this.bluePanel.dispose();
         this.bluePanel = null;
         if(this.text1 != null)
         {
            this.sub_container.removeChild(this.text1);
            this.text1.destroy();
            this.text1.dispose();
            this.text1 = null;
         }
         if(this.text2 != null)
         {
            this.sub_container.removeChild(this.text2);
            this.text2.destroy();
            this.text2.dispose();
            this.text2 = null;
         }
         this.container.removeChild(this.sub_container);
         this.sub_container.dispose();
         this.sub_container = null;
         removeChild(this.container);
         this.container.dispose();
         this.container = null;
         this.settingsPanel = null;
      }
   }
}
