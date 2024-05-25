package states
{
   import game_utils.GameSlot;
   import game_utils.SaveManager;
   import starling.display.*;
   import starling.events.Event;
   
   public class DemoLevelSelectionState implements IState
   {
       
      
      public var GET_OUT_FLAG:Boolean;
      
      protected var background:Quad;
      
      protected var buttons:Vector.<Button>;
      
      public function DemoLevelSelectionState()
      {
         super();
      }
      
      public function enterState(game:Game) : void
      {
         this.GET_OUT_FLAG = false;
         Utils.world = new Sprite();
         Utils.rootMovie.addChild(Utils.world);
         Utils.world.x = Utils.world.y = 0;
         Utils.world.scaleX = Utils.world.scaleY = Utils.GFX_SCALE;
         this.background = new Quad(Utils.WIDTH,Utils.HEIGHT,2698291);
         Utils.world.addChild(this.background);
         this.background.x = this.background.y = 0;
         this.initButtons();
         Utils.SLEEPING_POLLEN_HIT = false;
         game.enterDemoLevelSelectionState();
      }
      
      public function updateState(game:Game) : void
      {
         game.updateDemoLevelSelectionState();
      }
      
      protected function initButtons() : void
      {
         var i:int = 0;
         var button:Button = null;
         var amount:int = 24;
         this.buttons = new Vector.<Button>();
         for(i = 0; i < amount; i++)
         {
            button = new Button(TextureManager.hudTextureAtlas.getTexture("mapLevelButton1"),"",TextureManager.hudTextureAtlas.getTexture("mapLevelButton2"));
            this.buttons.push(button);
            button.name = "" + (i + 1);
            Utils.world.addChild(button);
            button.x = 8 + int(i % 8) * 40;
            button.y = 8 + int(i / 8) * 40;
            button.addEventListener(Event.TRIGGERED,this.clickHandler);
         }
         button = new Button(TextureManager.hudTextureAtlas.getTexture("mapLevelButton1"),"",TextureManager.hudTextureAtlas.getTexture("mapLevelButton2"));
         this.buttons.push(button);
         button.name = "64";
         Utils.world.addChild(button);
         button.x = 8;
         button.y = 160;
         button.addEventListener(Event.TRIGGERED,this.clickHandler);
         button = new Button(TextureManager.hudTextureAtlas.getTexture("mapSaveLevelButton1"),"",TextureManager.hudTextureAtlas.getTexture("mapLevelButton2"));
         this.buttons.push(button);
         button.name = "65";
         Utils.world.addChild(button);
         button.x = 168;
         button.y = 160;
         button.addEventListener(Event.TRIGGERED,this.clickHandler);
         button = new Button(TextureManager.hudTextureAtlas.getTexture("mapLoadLevelButton1"),"",TextureManager.hudTextureAtlas.getTexture("mapLevelButton2"));
         this.buttons.push(button);
         button.name = "66";
         Utils.world.addChild(button);
         button.x = 208;
         button.y = 160;
         button.addEventListener(Event.TRIGGERED,this.clickHandler);
      }
      
      protected function clickHandler(event:Event) : void
      {
         var button:Button = Button(event.target);
         var index:int = int(button.name);
         if(index != 64 && index != 65 && index != 66)
         {
            this.GET_OUT_FLAG = true;
         }
         Utils.LEVEL_LOCAL_PROGRESSION_1 = Utils.LEVEL_LOCAL_PROGRESSION_2 = 0;
         Utils.RESET_LEVEL_STATS = true;
         if(index == 1)
         {
            Utils.CurrentLevel = 1;
            if(Utils.Slot.gameProgression[0] == 0)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_1_1;
               Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
            }
            else
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_1_5;
               Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 3;
            }
         }
         else if(index == 2)
         {
            Utils.CurrentLevel = 2;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_2_4;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 3;
         }
         else if(index == 3)
         {
            Utils.CurrentLevel = 3;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_3_1;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
         }
         else if(index == 4)
         {
            Utils.CurrentLevel = 4;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_4_4;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 3;
         }
         else if(index == 5)
         {
            Utils.CurrentLevel = 5;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_5_12;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 2;
         }
         else if(index == 6)
         {
            Utils.CurrentLevel = 6;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_6_1;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
         }
         else if(index == 7)
         {
            Utils.CurrentLevel = 7;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_7_4;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 1;
         }
         else if(index == 8)
         {
            Utils.CurrentLevel = 8;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_8_6;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 2;
         }
         else if(index == 9)
         {
            Utils.CurrentLevel = 9;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_1_3;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 2;
         }
         else if(index == 10)
         {
            Utils.CurrentLevel = 10;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_2_1;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
         }
         else if(index == 11)
         {
            Utils.CurrentLevel = 11;
            if(Utils.Slot.gameProgression[11] == 0)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_3_1;
               Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
            }
            else
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_3_5;
               Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 3;
            }
         }
         else if(index == 12)
         {
            Utils.CurrentLevel = 12;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_4_6;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 5;
         }
         else if(index == 13)
         {
            Utils.CurrentLevel = 13;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_5_2;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 9;
         }
         else if(index == 14)
         {
            Utils.CurrentLevel = 14;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_6_7;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 1;
         }
         else if(index == 15)
         {
            Utils.CurrentLevel = 15;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_7_3;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 2;
         }
         else if(index == 16)
         {
            Utils.CurrentLevel = 16;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_8_7;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 3;
         }
         else if(index == 17)
         {
            Utils.CurrentLevel = 251;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_SECRET_1;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
         }
         else if(index == 18)
         {
            Utils.CurrentLevel = 252;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_2_SECRET_1;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
         }
         else if(index == 64)
         {
            SaveManager.Reset();
         }
         else if(index == 65)
         {
            SaveManager.SaveBackupSlot();
         }
         else if(index == 66)
         {
            SaveManager.LoadBackupSlot();
         }
         else
         {
            Utils.CurrentLevel = LevelState.LEVEL_1_FISHING;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] = LevelState.LEVEL_1_FISHING;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] = 0;
         }
      }
      
      public function exitState(game:Game) : void
      {
         var i:int = 0;
         for(i = 0; i < this.buttons.length; i++)
         {
            Utils.world.removeChild(this.buttons[i]);
            this.buttons[i].addEventListener(Event.TRIGGERED,this.clickHandler);
            this.buttons[i].dispose();
            this.buttons[i] = null;
         }
         this.buttons = null;
         Utils.world.removeChild(this.background);
         this.background.dispose();
         this.background = null;
         Utils.rootMovie.removeChild(Utils.world);
         Utils.world.dispose();
         Utils.world = null;
         game.exitDemoLevelSelectionState();
      }
   }
}
