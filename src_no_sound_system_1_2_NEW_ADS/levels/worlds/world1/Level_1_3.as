package levels.worlds.world1
{
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.StaticVerBehaviour;
   import levels.cameras.behaviours.VelShiftCenteredHorScrollBehaviour;
   import levels.cutscenes.world1.*;
   
   public class Level_1_3 extends Level
   {
      
      public static const Map_1_3_1:Class = Level_1_3_Map_1_3_1;
      
      public static const Map_1_3_2:Class = Level_1_3_Map_1_3_2;
      
      public static const Map_1_3_3:Class = Level_1_3_Map_1_3_3;
      
      public static const Map_1_3_4:Class = Level_1_3_Map_1_3_4;
      
      public static const Map_1_3_5:Class = Level_1_3_Map_1_3_5;
      
      public static const Map_1_3_6:Class = Level_1_3_Map_1_3_6;
       
      
      public var CUTSCENE_FLAG:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var sfx_just_once:Boolean;
      
      public function Level_1_3(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.sfx_just_once = true;
         super();
         this.CUTSCENE_FLAG = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_3_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_3_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_3_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_3_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_3_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_3_6.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_1_3_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_1_3_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_1_3_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_1_3_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_1_3_5());
            }
            else if(SUB_LEVEL == 6)
            {
               map = new XML(new Map_1_3_6());
            }
            this.levelLoaded();
         }
      }
      
      override public function levelLoaded() : void
      {
         this.init();
         this.setCameraBehaviours();
         LEVEL_LOADED = true;
      }
      
      override public function setCameraBehaviours() : void
      {
         camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         if(SUB_LEVEL == 1)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 2)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
         }
         else if(SUB_LEVEL == 4)
         {
            camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
         }
         else if(SUB_LEVEL == 3)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 4)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
         }
         else if(SUB_LEVEL == 5)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 3 || Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 5)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
         }
         else if(SUB_LEVEL == 6)
         {
            camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
         }
      }
      
      override public function exitLevel() : void
      {
         super.exitLevel();
      }
      
      override public function init() : void
      {
         var i:int = 0;
         super.init();
         if(SUB_LEVEL == 1)
         {
            if(Utils.Slot.gameProgression[3] == 0)
            {
               for(i = 0; i < enemiesManager.enemies.length; i++)
               {
                  if(enemiesManager.enemies[i] != null)
                  {
                     if(enemiesManager.enemies[i].xPos <= 422)
                     {
                        enemiesManager.enemies[i].dead = true;
                     }
                  }
               }
            }
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(Utils.Slot.gameProgression[3] == 0)
            {
               if(!this.CUTSCENE_FLAG)
               {
                  this.CUTSCENE_FLAG = true;
                  startCutscene(new RoseJoinsTeamCutscene(this));
               }
            }
            else if(Utils.Slot.gameProgression[4] == 0)
            {
               if(!this.CUTSCENE_FLAG_2)
               {
                  this.CUTSCENE_FLAG_2 = true;
                  startCutscene(new CatButtonCutscene(this));
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(hero.yPos <= 32)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 4;
               exit();
            }
         }
         else if(SUB_LEVEL == 4)
         {
            if(hero.yPos >= camera.yPos + camera.HEIGHT + 16)
            {
               if(hero.xPos <= 240)
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 4;
               }
               else if(hero.xPos >= 760)
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 5;
               }
               else
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 3;
               }
               if(this.sfx_just_once)
               {
                  if(hero.yPos >= camera.yPos + Utils.HEIGHT)
                  {
                     SoundSystem.PlaySound("flyingship_falldown");
                     this.sfx_just_once = false;
                  }
               }
               exit();
            }
         }
         else if(SUB_LEVEL == 5)
         {
            if(hero.yPos <= 32)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 5;
               exit();
            }
         }
         else if(SUB_LEVEL == 6)
         {
            if(hero.yPos >= camera.yPos + camera.HEIGHT + 16)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 2;
               if(this.sfx_just_once)
               {
                  if(hero.yPos >= camera.yPos + Utils.HEIGHT)
                  {
                     SoundSystem.PlaySound("flyingship_falldown");
                     this.sfx_just_once = false;
                  }
               }
               exit();
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         array.push(new Point(0.4,1));
         array.push(new Point(0.5,1));
         array.push(new Point(1,1));
         array.push(new Point(0.8,1));
         return array;
      }
      
      override public function getMusicName() : String
      {
         if(Utils.Slot.gameProgression[3] == 0)
         {
            return "outside_trees";
         }
         return "woods";
      }
      
      override public function playMusic() : void
      {
         if(Utils.Slot.gameProgression[3] == 0)
         {
            SoundSystem.PlayMusic(this.getMusicName(),-1,false,true);
         }
         else
         {
            SoundSystem.PlayMusic(this.getMusicName());
         }
      }
      
      override public function getBackgroundId() : int
      {
         return BackgroundsManager.DAWN_WOODS;
      }
   }
}
