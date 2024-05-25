package interfaces
{
   import entities.Easings;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.StateMachine;
   import interfaces.panels.CatButtonPanel;
   import interfaces.panels.InventoryNotificationPanel;
   import interfaces.panels.ItemsInLevelPanel;
   import interfaces.panels.SoundHudPanel;
   import levels.Level;
   import sprites.hud.ArrowHudSprite;
   import starling.display.Sprite;
   import starling.events.Event;
   import states.LevelState;
   
   public class SoundHud
   {
       
      
      public var hudPanel:SoundHudPanel;
      
      public var catButtonPanel:CatButtonPanel;
      
      protected var canPause:Boolean;
      
      public var itemsContainer:Sprite;
      
      public var itemsInLevelPanel:ItemsInLevelPanel;
      
      public var inventoryNotificationPanel:InventoryNotificationPanel;
      
      public var ITEMS_OUT_POSITION:int;
      
      public var ITEMS_IN_POSITION:int;
      
      protected var delayCounter:*;
      
      protected var redBlinkCounter:*;
      
      protected var blinkAmount:int;
      
      protected var tick:Number;
      
      protected var time:Number;
      
      protected var start_y:Number;
      
      protected var diff_y:Number;
      
      protected var IS_CAT_BUTTON_MOVING:Boolean;
      
      protected var IS_HINT_SHOWED:Boolean;
      
      protected var hint_counter_1:int;
      
      protected var hint_counter_2:int;
      
      protected var hint_counter_3:int;
      
      protected var HINT_INDEX:int;
      
      protected var HINT_LEVEL:int;
      
      protected var sxArrow:ArrowHudSprite;
      
      protected var dxArrow:ArrowHudSprite;
      
      protected var counter1:int;
      
      protected var level:Level;
      
      public var HAS_CAT:Boolean;
      
      public var HAS_SLOT:Boolean;
      
      protected var oldPlayerItem1:int;
      
      protected var oldPlayerItem2:int;
      
      protected var oldPlayerItem3:int;
      
      protected var _start_y:Number;
      
      protected var _diff_y:Number;
      
      protected var _tick:Number;
      
      protected var _time:Number;
      
      protected var item_counter_1:int;
      
      protected var item_counter_2:int;
      
      protected var item_index:int;
      
      protected var stateMachine:StateMachine;
      
      public function SoundHud(_level:Level)
      {
         super();
         this.level = _level;
         this.hudPanel = new SoundHudPanel();
         this.catButtonPanel = new CatButtonPanel();
         this.hudPanel.x = this.hudPanel.y = this.catButtonPanel.x = this.catButtonPanel.y = 0;
         this.hudPanel.scaleX = this.hudPanel.scaleY = this.catButtonPanel.scaleX = this.catButtonPanel.scaleY = Utils.GFX_SCALE;
         this._start_y = this._diff_y = this._tick = this._time = 0;
         this.item_counter_1 = this.item_counter_2 = 0;
         this.item_index = 0;
         this.HINT_INDEX = this.HINT_LEVEL = 0;
         this.oldPlayerItem1 = Utils.PlayerItems & 1;
         this.oldPlayerItem2 = Utils.PlayerItems & 2;
         this.oldPlayerItem3 = Utils.PlayerItems & 4;
         Utils.rootMovie.addChild(this.hudPanel);
         Utils.rootMovie.addChild(this.catButtonPanel);
         this.itemsContainer = new Sprite();
         Utils.rootMovie.addChild(this.itemsContainer);
         this.itemsContainer.x = this.itemsContainer.y = 0;
         this.itemsContainer.scaleX = this.itemsContainer.scaleY = Utils.GFX_SCALE;
         this.inventoryNotificationPanel = new InventoryNotificationPanel();
         this.itemsInLevelPanel = new ItemsInLevelPanel(int(Utils.WIDTH * 0.9),64);
         this.itemsInLevelPanel.x = int(Utils.WIDTH * 0.5);
         this.ITEMS_OUT_POSITION = -int(this.itemsInLevelPanel.height * 0.5 + 4);
         this.ITEMS_IN_POSITION = int(this.itemsInLevelPanel.height * 0.5 + 4);
         this.itemsInLevelPanel.y = this.ITEMS_IN_POSITION;
         this.IS_HINT_SHOWED = false;
         this.hint_counter_1 = this.hint_counter_2 = this.hint_counter_3 = 0;
         this.itemsContainer.addChild(this.itemsInLevelPanel);
         this.itemsContainer.addChild(this.inventoryNotificationPanel);
         this.hudPanel.pauseButton.visible = false;
         this.hudPanel.helpButton.visible = false;
         this.canPause = false;
         Utils.CheckPause = false;
         Utils.PauseOn = false;
         Utils.HelpOn = false;
         Utils.CatOn = false;
         Utils.HelperOn = false;
         this.IS_CAT_BUTTON_MOVING = false;
         this.tick = 0;
         this.time = 0.2;
         this.start_y = 0;
         this.diff_y = 0;
         this.counter1 = -1;
         this.delayCounter = this.redBlinkCounter = this.blinkAmount = 0;
         if(Utils.Slot.levelUnlocked[4] == false && Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_2)
         {
            this.sxArrow = new ArrowHudSprite();
            this.hudPanel.addChild(this.sxArrow);
            this.sxArrow.x = 48;
            this.dxArrow = new ArrowHudSprite();
            this.dxArrow.scaleX = -1;
            this.hudPanel.addChild(this.dxArrow);
            this.dxArrow.x = Utils.WIDTH - 48;
            this.sxArrow.y = this.dxArrow.y = Utils.HEIGHT - 48;
            this.sxArrow.gfxHandleClip().gotoAndPlay(1);
            this.dxArrow.gfxHandleClip().gotoAndPlay(2);
            this.sxArrow.alpha = this.dxArrow.alpha = 0.5;
         }
         else
         {
            this.sxArrow = null;
            this.dxArrow = null;
         }
         if(Utils.Slot.gameProgression[2] == 1)
         {
            this.HAS_SLOT = true;
            this.catButtonPanel.showSlotButton();
         }
         else
         {
            this.HAS_SLOT = false;
         }
         if(LevelItems.HasItem(LevelItems.ITEM_BIG_CAT) || LevelItems.HasItem(LevelItems.ITEM_SMALL_CAT))
         {
            this.HAS_CAT = true;
         }
         else
         {
            this.HAS_CAT = false;
         }
         if(this.HAS_CAT)
         {
            this.showCatButton();
         }
         if(!this.HAS_CAT)
         {
            this.catButtonPanel.catButton.visible = false;
            this.catButtonPanel.catButton.touchable = false;
         }
         if(!this.HAS_SLOT)
         {
            this.catButtonPanel.slotButton.visible = false;
            this.catButtonPanel.slotButton.touchable = false;
         }
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_OUTSIDE_STATE","ITEM_COLLECTED_ACTION","IS_GETTING_IN_STATE");
         this.stateMachine.setRule("IS_GETTING_IN_STATE","END_ACTION","SHOW_ITEM_STATE");
         this.stateMachine.setRule("SHOW_ITEM_STATE","END_ACTION","IS_GETTING_OUT_STATE");
         this.stateMachine.setRule("IS_GETTING_OUT_STATE","END_ACTION","IS_OUTSIDE_STATE");
         this.stateMachine.setFunctionToState("IS_INSIDE_STATE",this.isInsideState);
         this.stateMachine.setFunctionToState("IS_GETTING_IN_STATE",this.isGettingInState);
         this.stateMachine.setFunctionToState("SHOW_ITEM_STATE",this.isShowingItemState);
         this.stateMachine.setFunctionToState("IS_GETTING_OUT_STATE",this.isGettingOutState);
         this.stateMachine.setFunctionToState("IS_OUTSIDE_STATE",this.isOutsideState);
         this.stateMachine.setState("IS_OUTSIDE_STATE");
      }
      
      protected function isInsideState() : void
      {
         this.itemsInLevelPanel.y = this.ITEMS_IN_POSITION;
      }
      
      protected function isGettingInState() : void
      {
         this.item_counter_1 = 0;
         this._start_y = this.ITEMS_OUT_POSITION;
         this._diff_y = this.ITEMS_IN_POSITION - this.ITEMS_OUT_POSITION;
         this._tick = 0;
         this._time = 0.25;
      }
      
      protected function isShowingItemState() : void
      {
         this.item_counter_1 = 0;
         this.item_counter_2 = 0;
      }
      
      protected function isGettingOutState() : void
      {
         this._start_y = this.ITEMS_IN_POSITION;
         this._diff_y = this.ITEMS_OUT_POSITION - this.ITEMS_IN_POSITION;
         this._tick = 0;
         this._time = 0.25;
      }
      
      protected function isOutsideState() : void
      {
         this.itemsInLevelPanel.y = this.ITEMS_OUT_POSITION;
      }
      
      protected function updateItems() : void
      {
         if(this.oldPlayerItem1 != (Utils.PlayerItems & 1))
         {
            if(!LevelItems.HasLevelItemBeenGot(0))
            {
               this.item_index = 0;
               this.oldPlayerItem1 = Utils.PlayerItems & 1;
               this.stateMachine.performAction("ITEM_COLLECTED_ACTION");
            }
         }
         if(this.oldPlayerItem2 != (Utils.PlayerItems & 2))
         {
            if(!LevelItems.HasLevelItemBeenGot(1))
            {
               this.item_index = 1;
               this.oldPlayerItem2 = Utils.PlayerItems & 2;
               this.stateMachine.performAction("ITEM_COLLECTED_ACTION");
            }
         }
         if(this.oldPlayerItem3 != (Utils.PlayerItems & 4))
         {
            if(!LevelItems.HasLevelItemBeenGot(2))
            {
               this.item_index = 2;
               this.oldPlayerItem3 = Utils.PlayerItems & 4;
               this.stateMachine.performAction("ITEM_COLLECTED_ACTION");
            }
         }
         if(this.stateMachine.currentState == "IS_GETTING_IN_STATE")
         {
            if(this.item_counter_1++ > 30)
            {
               this._tick += 1 / 60;
               if(this._tick >= this._time)
               {
                  this._tick = this._time;
               }
               this.itemsInLevelPanel.y = int(Easings.easeOutSine(this._tick,this._start_y,this._diff_y,this._time));
               if(this._tick >= this._time)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "SHOW_ITEM_STATE")
         {
            if(this.item_counter_2 == 0)
            {
               ++this.item_counter_2;
               this.item_counter_1 = 0;
               this.itemsInLevelPanel.gottenAnimation(this.item_index);
            }
            else if(this.item_counter_2 == 1)
            {
               if(this.item_counter_1++ > 90)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_GETTING_OUT_STATE")
         {
            this._tick += 1 / 60;
            if(this._tick >= this._time)
            {
               this._tick = this._time;
            }
            this.itemsInLevelPanel.y = int(Easings.easeOutSine(this._tick,this._start_y,this._diff_y,this._time));
            if(this._tick >= this._time)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         this.itemsInLevelPanel.update();
         this.inventoryNotificationPanel.update();
      }
      
      public function destroy() : void
      {
         if(this.sxArrow != null)
         {
            this.hudPanel.removeChild(this.sxArrow);
            this.sxArrow.destroy();
            this.sxArrow.dispose();
            this.sxArrow = null;
            this.hudPanel.removeChild(this.dxArrow);
            this.dxArrow.destroy();
            this.dxArrow.dispose();
            this.dxArrow = null;
         }
         if(this.hudPanel.pauseButton.visible)
         {
            this.hudPanel.pauseButton.removeEventListener(Event.TRIGGERED,this.pauseClickHandler);
         }
         this.catButtonPanel.catButton.removeEventListener(Event.TRIGGERED,this.catClickHandler);
         this.catButtonPanel.slotButton.removeEventListener(Event.TRIGGERED,this.slotClickHandler);
         this.catButtonPanel.hintButton.removeEventListener(Event.TRIGGERED,this.slotClickHandler);
         if(this.hudPanel.helpButton.visible)
         {
            this.hudPanel.helpButton.removeEventListener(Event.TRIGGERED,this.helpClickHandler);
         }
         this.itemsContainer.removeChild(this.itemsInLevelPanel);
         this.itemsInLevelPanel.destroy();
         this.itemsInLevelPanel.dispose();
         this.itemsInLevelPanel = null;
         this.itemsContainer.removeChild(this.inventoryNotificationPanel);
         this.inventoryNotificationPanel.destroy();
         this.inventoryNotificationPanel.dispose();
         this.inventoryNotificationPanel = null;
         Utils.rootMovie.removeChild(this.itemsContainer);
         this.itemsContainer.dispose();
         this.itemsContainer = null;
         Utils.rootMovie.removeChild(this.catButtonPanel);
         this.catButtonPanel.destroy();
         this.catButtonPanel.dispose();
         this.catButtonPanel = null;
         Utils.rootMovie.removeChild(this.hudPanel);
         this.hudPanel.destroy();
         this.hudPanel.dispose();
         this.hudPanel = null;
         this.level = null;
      }
      
      public function update() : void
      {
         this.updateItems();
         if(this.sxArrow != null)
         {
            if(this.level.stateMachine.currentState == "IS_PLAYING_STATE")
            {
               if(this.level.leftPressed || this.level.rightPressed)
               {
                  if(this.counter1 < 0)
                  {
                     this.counter1 = 1;
                  }
               }
               if(this.counter1 < 0)
               {
                  this.sxArrow.visible = this.dxArrow.visible = true;
               }
               if(this.sxArrow.visible)
               {
                  if(this.counter1 > -1)
                  {
                     ++this.counter1;
                     if(this.counter1 > 3)
                     {
                        this.counter1 = 0;
                        this.sxArrow.alpha -= 0.3;
                        this.dxArrow.alpha -= 0.3;
                        if(this.sxArrow.alpha <= 0)
                        {
                           this.sxArrow.visible = this.dxArrow.visible = false;
                        }
                     }
                  }
               }
            }
            else
            {
               this.sxArrow.visible = this.dxArrow.visible = false;
            }
         }
         if(this.IS_CAT_BUTTON_MOVING)
         {
            this.tick += 1 / 60;
            if(this.tick >= this.time)
            {
               this.tick = this.time;
               this.IS_CAT_BUTTON_MOVING = false;
            }
            this.catButtonPanel.catButton.y = Easings.linear(this.tick,this.start_y,this.diff_y,this.time);
            this.catButtonPanel.slotButton.y = this.catButtonPanel.catButton.y;
            this.catButtonPanel.catButton.touchable = false;
            this.catButtonPanel.slotButton.touchable = false;
            this.removeHint();
         }
         else if(this.level.hero.stateMachine.currentState == "IS_GAME_OVER_STATE")
         {
            this.catButtonPanel.catButton.touchable = false;
            this.catButtonPanel.slotButton.touchable = false;
         }
         else
         {
            this.catButtonPanel.catButton.touchable = true;
            this.catButtonPanel.slotButton.touchable = true;
         }
         this.catButtonPanel.itemSprite.x = this.catButtonPanel.slotButton.x + 7;
         this.catButtonPanel.itemSprite.y = this.catButtonPanel.slotButton.y + 14;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == 0 || !this.catButtonPanel.slotButton.visible)
         {
            this.catButtonPanel.itemSprite.visible = false;
         }
         else
         {
            this.catButtonPanel.itemSprite.visible = true;
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_HELPER_COCONUT)
            {
               this.catButtonPanel.itemSprite.gfxHandleClip().gotoAndStop(1);
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_HELPER_CLOUD)
            {
               this.catButtonPanel.itemSprite.gfxHandleClip().gotoAndStop(2);
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_HELPER_JELLYFISH)
            {
               this.catButtonPanel.itemSprite.gfxHandleClip().gotoAndStop(3);
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_HELPER_CUPID)
            {
               this.catButtonPanel.itemSprite.gfxHandleClip().gotoAndStop(4);
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_HELPER_BAT)
            {
               this.catButtonPanel.itemSprite.gfxHandleClip().gotoAndStop(5);
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] == LevelItems.ITEM_HELPER_ROCK)
            {
               this.catButtonPanel.itemSprite.gfxHandleClip().gotoAndStop(6);
            }
         }
         if(this.IS_HINT_SHOWED)
         {
            if(this.hint_counter_3 == 0)
            {
               ++this.hint_counter_1;
               if(this.hint_counter_1 > 10)
               {
                  this.hint_counter_1 = 0;
                  if(this.catButtonPanel.hintButton.alpha > 0.5)
                  {
                     this.catButtonPanel.hintButton.alpha = this.catButtonPanel.itemHintSprite.alpha = 0;
                  }
                  else
                  {
                     this.catButtonPanel.hintButton.alpha = this.catButtonPanel.itemHintSprite.alpha = 1;
                  }
                  if(this.catButtonPanel.hintButton.alpha > 0.5)
                  {
                     SoundSystem.PlaySound("blip");
                  }
                  ++this.hint_counter_2;
                  if(this.hint_counter_2 >= 8)
                  {
                     this.hint_counter_3 = 1;
                     this.hint_counter_1 = this.hint_counter_2 = 0;
                     this.catButtonPanel.hintButton.alpha = this.catButtonPanel.itemHintSprite.alpha = 1;
                  }
               }
            }
            else if(this.hint_counter_3 == 1)
            {
               ++this.hint_counter_1;
               if(this.hint_counter_1 >= 180)
               {
                  this.removeHint();
               }
            }
         }
         if(Hud.SET_HUD_INVISIBLE)
         {
            this.hudPanel.alpha = 0;
            this.catButtonPanel.alpha = 0;
         }
         if(this.level.ALLOW_CAT_BUTTON == false)
         {
            this.catButtonPanel.catButton.visible = false;
            this.catButtonPanel.catButton.touchable = false;
         }
      }
      
      public function removeHint() : void
      {
         this.IS_HINT_SHOWED = false;
         this.catButtonPanel.hintButton.visible = this.catButtonPanel.itemHintSprite.visible = false;
      }
      
      public function enablePause() : void
      {
         this.canPause = true;
         this.hudPanel.pauseButton.touchable = true;
         this.hudPanel.helpButton.touchable = true;
      }
      
      public function disablePause() : void
      {
         this.canPause = false;
         this.hudPanel.pauseButton.touchable = false;
         this.hudPanel.helpButton.touchable = false;
      }
      
      public function showHint(index:int) : void
      {
         if(!this.HAS_SLOT)
         {
            return;
         }
         if(this.IS_HINT_SHOWED || this.IS_CAT_BUTTON_MOVING)
         {
            return;
         }
         if(this.level.stateMachine.currentState != "IS_PLAYING_STATE")
         {
            return;
         }
         if(Utils.HintCounter > 0)
         {
            return;
         }
         if(index == Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED])
         {
            return;
         }
         Utils.HintCounter = 1800;
         this.HINT_INDEX = index;
         this.IS_HINT_SHOWED = true;
         this.hint_counter_1 = this.hint_counter_2 = this.hint_counter_3 = 0;
         this.catButtonPanel.hintButton.visible = true;
         this.catButtonPanel.itemHintSprite.visible = true;
         this.catButtonPanel.hintButton.alpha = 1;
         this.catButtonPanel.hintButton.x = this.catButtonPanel.slotButton.x;
         this.catButtonPanel.hintButton.y = this.catButtonPanel.slotButton.y + this.catButtonPanel.slotButton.height + 2;
         this.catButtonPanel.itemHintSprite.x = this.catButtonPanel.hintButton.x + 7;
         this.catButtonPanel.itemHintSprite.y = this.catButtonPanel.hintButton.y + 10;
         this.catButtonPanel.itemHintSprite.gfxHandleClip().gotoAndStop(this.getFrame(this.HINT_INDEX));
      }
      
      public function getFrame(_index:int) : int
      {
         if(_index == LevelItems.ITEM_HELPER_COCONUT)
         {
            return 1;
         }
         if(_index == LevelItems.ITEM_HELPER_CLOUD)
         {
            return 2;
         }
         if(_index == LevelItems.ITEM_HELPER_JELLYFISH)
         {
            return 3;
         }
         if(_index == LevelItems.ITEM_HELPER_CUPID)
         {
            return 4;
         }
         if(_index == LevelItems.ITEM_HELPER_GHOST)
         {
            return 5;
         }
         if(_index == LevelItems.ITEM_HELPER_ROCK)
         {
            return 6;
         }
         return 0;
      }
      
      public function showPause() : void
      {
         this.hudPanel.pauseButton.visible = true;
         this.hudPanel.pauseButton.addEventListener(Event.TRIGGERED,this.pauseClickHandler);
         if(this.HAS_CAT)
         {
            this.catButtonPanel.catButton.visible = true;
         }
         this.catButtonPanel.catButton.addEventListener(Event.TRIGGERED,this.catClickHandler);
         this.catButtonPanel.slotButton.addEventListener(Event.TRIGGERED,this.slotClickHandler);
         this.catButtonPanel.hintButton.addEventListener(Event.TRIGGERED,this.slotClickHandler);
         Utils.rootMovie.setChildIndex(this.hudPanel,Utils.rootMovie.numChildren - 1);
         Utils.rootMovie.setChildIndex(this.itemsContainer,Utils.rootMovie.numChildren - 1);
      }
      
      public function showHelp() : void
      {
         this.delayCounter = 0;
         this.hudPanel.helpButton.visible = true;
         this.hudPanel.helpButton.addEventListener(Event.TRIGGERED,this.helpClickHandler);
         this.hudPanel.helpButton.y = 0;
         this.hudPanel.helpButton.touchable = true;
      }
      
      protected function pauseClickHandler(event:Event) : void
      {
         if(this.canPause)
         {
            SoundSystem.PlaySound("select");
            Utils.PauseOn = true;
         }
      }
      
      protected function slotClickHandler(event:Event) : void
      {
         if(!this.HAS_SLOT)
         {
            return;
         }
         if(this.level.stateMachine.currentState != "IS_PLAYING_STATE")
         {
            return;
         }
         if(this.level.hero.stateMachine.currentState == "IS_GAME_OVER_STATE")
         {
            return;
         }
         if(!Utils.CatOn)
         {
            if(this.IS_HINT_SHOWED)
            {
               Utils.ShopIndex = this.HINT_INDEX;
               Utils.ShopHintLevel = this.HINT_LEVEL;
            }
            else
            {
               Utils.ShopIndex = -1;
               Utils.ShopHintLevel = -1;
            }
            this.removeHint();
            SoundSystem.PlaySound("select");
            Utils.ShopOn = true;
         }
      }
      
      protected function catClickHandler(event:Event) : void
      {
         if(this.level.stateMachine.currentState != "IS_PLAYING_STATE")
         {
            return;
         }
         if(!this.level.isCatChangeAllowed())
         {
            return;
         }
         if(this.level.hero.stateMachine.currentState == "IS_GAME_OVER_STATE" || this.level.hero.stateMachine.currentState == "IS_LEVEL_COMPLETE_STATE")
         {
            return;
         }
         if(this.level.hero.stateMachine.currentState == "IS_CANNON_INSIDE_STATE" || this.level.hero.stateMachine.currentState == "IS_CANNON_SHOOT_STATE")
         {
            return;
         }
         if(this.level.hero.stateMachine.currentState == "IS_CLIMBING_STATE" || this.level.hero.stateMachine.currentState == "IS_DRIFTING_STATE" || this.level.hero.stateMachine.currentState == "IS_SLIDING_STATE")
         {
            return;
         }
         if(this.level.hero.stateMachine.currentState == "IS_WALKING_HOLE_STATE" || this.level.hero.stateMachine.currentState == "IS_STANDING_HOLE_STATE" || this.level.hero.stateMachine.currentState == "IS_TURNING_HOLE_STATE" || this.level.hero.stateMachine.currentState == "IS_TURNING_WALKING_HOLE_STATE")
         {
            return;
         }
         if(!Utils.HelperOn)
         {
            SoundSystem.PlaySound("select");
            Utils.CatOn = true;
         }
      }
      
      protected function helpClickHandler(event:Event) : void
      {
         if(this.level.stateMachine.currentState != "IS_PLAYING_STATE")
         {
            return;
         }
         if(this.canPause)
         {
            SoundSystem.PlaySound("select");
            Utils.HelpOn = true;
         }
      }
      
      public function showCatButton() : void
      {
         if(!this.HAS_CAT)
         {
            return;
         }
         this.IS_CAT_BUTTON_MOVING = true;
         this.tick = 0;
         this.start_y = this.catButtonPanel.catButton.y;
         this.diff_y = 0 - this.start_y + this.catButtonPanel.additional_y_margin;
         this.catButtonPanel.catButton.visible = true;
         this.catButtonPanel.catButton.touchable = true;
      }
      
      public function hideCatButton() : void
      {
         if(!this.HAS_CAT)
         {
            return;
         }
         this.IS_CAT_BUTTON_MOVING = true;
         this.tick = 0;
         this.start_y = this.catButtonPanel.catButton.y;
         this.diff_y = -this.catButtonPanel.slotButton.height - this.start_y;
      }
   }
}
