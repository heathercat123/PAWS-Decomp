package interfaces.panels
{
   import game_utils.GameSlot;
   import interfaces.texts.GameText;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class ChoiceSelectorPanel extends Sprite
   {
       
      
      public var TYPE:int;
      
      public var WIDTH:int;
      
      protected var sxButton:Button;
      
      protected var dxButton:Button;
      
      protected var titleText:GameText;
      
      protected var descriptionText:GameText;
      
      protected var IS_ENABLED:Boolean;
      
      public function ChoiceSelectorPanel(_TYPE:int, _WIDTH:int)
      {
         super();
         this.TYPE = _TYPE;
         this.WIDTH = _WIDTH;
         this.IS_ENABLED = true;
         this.sxButton = new Button(TextureManager.hudTextureAtlas.getTexture("sx_arrow_button1"),"",TextureManager.hudTextureAtlas.getTexture("sx_arrow_button2"));
         this.sxButton.name = "sx";
         Image(Sprite(this.sxButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         this.dxButton = new Button(TextureManager.hudTextureAtlas.getTexture("dx_arrow_button1"),"",TextureManager.hudTextureAtlas.getTexture("dx_arrow_button2"));
         this.dxButton.name = "dx";
         Image(Sprite(this.dxButton.getChildAt(0)).getChildAt(0)).textureSmoothing = Utils.getSmoothing();
         if(_TYPE == 1)
         {
            this.titleText = new GameText(StringsManager.GetString("panel_options_quick_start") + ":",GameText.TYPE_SMALL_WHITE);
            this.descriptionText = new GameText(StringsManager.GetString("yes"),GameText.TYPE_SMALL_WHITE);
         }
         else if(_TYPE == 2)
         {
            this.titleText = new GameText(StringsManager.GetString("panel_options_cloud_save") + ":",GameText.TYPE_SMALL_WHITE);
            this.descriptionText = new GameText(StringsManager.GetString("yes"),GameText.TYPE_SMALL_WHITE);
         }
         else
         {
            this.titleText = new GameText(StringsManager.GetString("panel_options_gfx") + ":",GameText.TYPE_SMALL_WHITE);
            this.descriptionText = new GameText(StringsManager.GetString("panel_options_normal"),GameText.TYPE_SMALL_WHITE);
         }
         this.refreshText();
         this.titleText.touchable = this.descriptionText.touchable = false;
         this.descriptionText.pivotX = int(this.descriptionText.WIDTH * 0.5);
         addChild(this.titleText);
         addChild(this.descriptionText);
         addChild(this.sxButton);
         addChild(this.dxButton);
         this.titleText.x = -int(this.titleText.WIDTH);
         this.sxButton.x = 8;
         this.dxButton.x = this.sxButton.x + 96;
         this.descriptionText.x = int((this.sxButton.x + this.dxButton.x) * 0.5) + 11;
         this.titleText.y = this.descriptionText.y = 5;
         this.sxButton.addEventListener(Event.TRIGGERED,this.onClick);
         this.dxButton.addEventListener(Event.TRIGGERED,this.onClick);
      }
      
      public function setEnabled(_value:Boolean) : void
      {
         this.IS_ENABLED = _value;
         if(this.IS_ENABLED == false)
         {
            this.sxButton.enabled = this.dxButton.enabled = false;
            this.sxButton.alphaWhenDisabled = this.dxButton.alphaWhenDisabled = 0.5;
            this.titleText.alpha = this.descriptionText.alpha = 0.5;
         }
         else
         {
            this.sxButton.enabled = this.dxButton.enabled = true;
            this.sxButton.alphaWhenDisabled = this.dxButton.alphaWhenDisabled = 0.5;
            this.titleText.alpha = this.descriptionText.alpha = 1;
         }
      }
      
      protected function switchOption(isSx:Boolean) : void
      {
         if(this.TYPE == 1)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_SKIP_INTRO] == 0)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_SKIP_INTRO] = 1;
            }
            else
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_SKIP_INTRO] = 0;
            }
         }
         else if(this.TYPE == 2)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_CLOUD_SAVE] == 0)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_CLOUD_SAVE] = 1;
            }
            else
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_CLOUD_SAVE] = 0;
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GFX] == 0)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_GFX] = 1;
         }
         else
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_GFX] = 0;
         }
         this.refreshText();
      }
      
      public function onClick(event:Event) : void
      {
         if(!this.visible)
         {
            return;
         }
         SoundSystem.PlaySound("select");
         var button:Button = event.target as Button;
         if(button.name == "sx")
         {
            this.switchOption(true);
         }
         else if(button.name == "dx")
         {
            this.switchOption(false);
         }
      }
      
      protected function refreshText() : void
      {
         if(this.TYPE == 1)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_SKIP_INTRO] == 0)
            {
               this.descriptionText.updateText(StringsManager.GetString("no"));
            }
            else
            {
               this.descriptionText.updateText(StringsManager.GetString("yes"));
            }
         }
         else if(this.TYPE == 2)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_CLOUD_SAVE] == 1)
            {
               this.descriptionText.updateText(StringsManager.GetString("no"));
            }
            else
            {
               this.descriptionText.updateText(StringsManager.GetString("yes"));
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GFX] == 0)
         {
            this.descriptionText.updateText(StringsManager.GetString("panel_options_normal"));
         }
         else
         {
            this.descriptionText.updateText(StringsManager.GetString("panel_options_low"));
         }
         this.descriptionText.pivotX = int(this.descriptionText.WIDTH * 0.5);
         this.descriptionText.x = int((this.sxButton.x + this.dxButton.x) * 0.5) + 11;
      }
      
      public function setButtonsEnabled(_value:Boolean) : void
      {
         if(this.IS_ENABLED)
         {
            this.sxButton.alphaWhenDisabled = 1;
            this.dxButton.alphaWhenDisabled = 1;
            this.sxButton.enabled = _value;
            this.dxButton.enabled = _value;
         }
      }
      
      public function exit() : void
      {
      }
      
      public function destroy() : void
      {
         this.sxButton.removeEventListener(Event.TRIGGERED,this.onClick);
         this.dxButton.removeEventListener(Event.TRIGGERED,this.onClick);
         removeChild(this.sxButton);
         removeChild(this.dxButton);
         this.sxButton.dispose();
         this.dxButton.dispose();
         this.sxButton = null;
         this.dxButton = null;
         removeChild(this.titleText);
         this.titleText.destroy();
         this.titleText.dispose();
         this.titleText = null;
         removeChild(this.descriptionText);
         this.descriptionText.destroy();
         this.descriptionText.dispose();
         this.descriptionText = null;
      }
   }
}
