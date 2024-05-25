package levels.worlds.world1
{
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.*;
   import levels.cutscenes.world1.*;
   
   public class Level_1_6 extends Level
   {
      
      public static const Map_1_6_1:Class = Level_1_6_Map_1_6_1;
      
      public static const Map_1_6_2:Class = Level_1_6_Map_1_6_2;
      
      public static const Map_1_6_3:Class = Level_1_6_Map_1_6_3;
      
      public static const Map_1_6_4:Class = Level_1_6_Map_1_6_4;
      
      public static const Map_1_6_5:Class = Level_1_6_Map_1_6_5;
      
      public static const Map_1_6_6:Class = Level_1_6_Map_1_6_6;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      public function Level_1_6(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.CAMERA_AREA = 0;
         this.sfx_just_once = true;
         super();
         this.CUTSCENE_FLAG_1 = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_6_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_6_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_6_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               Utils.IS_DARK = true;
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_6_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_6_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               Utils.IS_DARK = true;
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_6_6.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_1_6_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_1_6_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_1_6_3());
            }
            else if(SUB_LEVEL == 4)
            {
               Utils.IS_DARK = true;
               map = new XML(new Map_1_6_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_1_6_5());
            }
            else if(SUB_LEVEL == 6)
            {
               Utils.IS_DARK = true;
               map = new XML(new Map_1_6_6());
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
         if(SUB_LEVEL == 4)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,288 - int(Utils.WIDTH * 0.5)),true);
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 1)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
         }
         else if(SUB_LEVEL == 6)
         {
            camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,-16),true);
            camera.TOP_MARGIN = 16;
         }
         else
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
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
         if(SUB_LEVEL == 5)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 4)
            {
               for(i = 0; i < enemiesManager.enemies.length; i++)
               {
                  if(enemiesManager.enemies[i] != null)
                  {
                     if(enemiesManager.enemies[i].xPos >= 912)
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
         var tweenShift:VerTweenShiftBehaviour = null;
         var tweenShift2:HorTweenShiftBehaviour = null;
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(!this.CUTSCENE_FLAG_1)
            {
               if(!Utils.Slot.doorUnlocked[0])
               {
                  if(!LevelItems.HasItem(LevelItems.ITEM_KEY))
                  {
                     if(hero.xPos >= 344)
                     {
                        this.CUTSCENE_FLAG_1 = true;
                        startCutscene(new GenericWorld1Cutscene(this));
                     }
                  }
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(hero.yPos >= camera.yPos + camera.HEIGHT + 16)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 4;
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
         else if(SUB_LEVEL != 5)
         {
            if(SUB_LEVEL == 6)
            {
               if(hero.xPos >= 944 && hero.yPos <= 32)
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 4;
                  exit();
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         array.push(new Point(0.05,1));
         array.push(new Point(0.4,1));
         array.push(new Point(1,1));
         array.push(new Point(0.8,1));
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         return new Point(1.2,1);
      }
      
      override public function getMusicName() : String
      {
         if(SUB_LEVEL == 1)
         {
            return "outside_desert";
         }
         if(SUB_LEVEL == 4 || SUB_LEVEL == 6)
         {
            return "inside_cave";
         }
         return "canyon";
      }
      
      override public function playMusic() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 0)
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
         if(SUB_LEVEL == 4 || SUB_LEVEL == 6)
         {
            return BackgroundsManager.CAVE;
         }
         return BackgroundsManager.CANYON;
      }
   }
}
