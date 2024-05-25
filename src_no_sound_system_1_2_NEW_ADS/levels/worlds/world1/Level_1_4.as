package levels.worlds.world1
{
   import entities.enemies.GiantLogEnemy;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.CenteredProgressiveVerScrollBehaviour;
   import levels.cameras.behaviours.StaticHorBehaviour;
   import levels.cameras.behaviours.StaticVerBehaviour;
   import levels.cameras.behaviours.TunnelVelShiftVerScrollBehaviour;
   import levels.cameras.behaviours.VelShiftCenteredHorScrollBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   import levels.cutscenes.MidBossCutscene;
   import levels.cutscenes.QuestionMarkCutscene;
   import levels.cutscenes.world1.*;
   
   public class Level_1_4 extends Level
   {
      
      public static const Map_1_4_1:Class = Level_1_4_Map_1_4_1;
      
      public static const Map_1_4_2:Class = Level_1_4_Map_1_4_2;
      
      public static const Map_1_4_3:Class = Level_1_4_Map_1_4_3;
      
      public static const Map_1_4_4:Class = Level_1_4_Map_1_4_4;
      
      public static const Map_1_4_5:Class = Level_1_4_Map_1_4_5;
      
      public static const Map_1_4_6:Class = Level_1_4_Map_1_4_6;
      
      public static const Map_1_4_7:Class = Level_1_4_Map_1_4_7;
      
      public static const Map_1_4_8:Class = Level_1_4_Map_1_4_8;
      
      public static const Map_1_4_9:Class = Level_1_4_Map_1_4_9;
       
      
      public var CUTSCENE_FLAG:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      protected var bossEnemy:GiantLogEnemy;
      
      public function Level_1_4(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.sfx_just_once = true;
         this.CAMERA_AREA = 0;
         this.bossEnemy = null;
         super();
         this.CUTSCENE_FLAG = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_4_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_4_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_4_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_4_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_4_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_4_6.xml");
            }
            else if(SUB_LEVEL == 7)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_4_7.xml");
            }
            else if(SUB_LEVEL == 8)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_4_8.xml");
            }
            else if(SUB_LEVEL == 9)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_4_9.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_1_4_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_1_4_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_1_4_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_1_4_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_1_4_5());
            }
            else if(SUB_LEVEL == 6)
            {
               map = new XML(new Map_1_4_6());
            }
            else if(SUB_LEVEL == 7)
            {
               map = new XML(new Map_1_4_7());
            }
            else if(SUB_LEVEL == 8)
            {
               map = new XML(new Map_1_4_8());
            }
            else if(SUB_LEVEL == 9)
            {
               map = new XML(new Map_1_4_9());
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
         if(SUB_LEVEL == 1)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
            if(hero.xPos < 776)
            {
               camera.RIGHT_MARGIN = 776 + 16;
            }
            else
            {
               camera.LEFT_MARGIN = 770;
            }
         }
         else if(SUB_LEVEL == 3 || SUB_LEVEL == 4 || SUB_LEVEL == 6)
         {
            camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this),true);
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 - 8 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
         }
         else if(SUB_LEVEL == 5)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,256 - Utils.WIDTH * 0.5),true);
            camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,Utils.HEIGHT * 0.25,30,0.00125),true);
            camera.BOTTOM_MARGIN = 752 + camera.getVerticalOffsetFromGroundLevel();
            camera.y = hero.yPos + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
         }
         else if(SUB_LEVEL == 7)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,256 - Utils.WIDTH * 0.5),true);
            camera.changeVerBehaviour(new StaticVerBehaviour(this,248 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
            camera.BOTTOM_MARGIN = 752 + camera.getVerticalOffsetFromGroundLevel();
            camera.y = hero.yPos + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
            camera.TOP_MARGIN = camera.y;
         }
         else if(SUB_LEVEL == 8)
         {
            camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this),true);
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 - 8 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
         }
         else if(SUB_LEVEL == 9)
         {
            camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this),true);
            camera.changeVerBehaviour(new StaticVerBehaviour(this,184 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
         }
         else
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,256 - Utils.WIDTH * 0.5),true);
            camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this),true);
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 2)
            {
               camera.yPos = int(224 + camera.getVerticalOffsetFromGroundLevel() - camera.HEIGHT);
            }
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
         if(SUB_LEVEL == 2)
         {
            camera.yPos = int(864 + camera.getVerticalOffsetFromGroundLevel() - camera.HEIGHT);
         }
      }
      
      override public function update() : void
      {
         var i:int = 0;
         super.update();
         if(SUB_LEVEL == 4)
         {
            if(this.CUTSCENE_FLAG == false)
            {
               if(hero.xPos >= 304 && Utils.LEVEL_LOCAL_PROGRESSION_1 == 0)
               {
                  this.CUTSCENE_FLAG = true;
                  startCutscene(new MidBossCutscene(this));
                  Utils.LEVEL_LOCAL_PROGRESSION_1 = 1;
                  for(i = 0; i < enemiesManager.enemies.length; i++)
                  {
                     if(enemiesManager.enemies[i] != null)
                     {
                        if(enemiesManager.enemies[i] is GiantLogEnemy)
                        {
                           this.bossEnemy = enemiesManager.enemies[i] as GiantLogEnemy;
                        }
                     }
                  }
               }
            }
            if(this.CUTSCENE_FLAG_2 == false)
            {
               if(this.bossEnemy != null)
               {
                  if(this.bossEnemy.stateMachine.currentState == "IS_HIT_STATE")
                  {
                     if(hero.stateMachine.currentState != "IS_GAME_OVER_STATE")
                     {
                        this.CUTSCENE_FLAG_2 = true;
                        startCutscene(new MidBossCutscene(this,true));
                     }
                  }
               }
            }
         }
         else if(SUB_LEVEL == 6)
         {
            if(hero.xPos <= 176)
            {
               camera.LEFT_MARGIN *= 0.8;
               if(camera.LEFT_MARGIN <= 48)
               {
                  camera.LEFT_MARGIN = 48;
               }
            }
         }
         else if(SUB_LEVEL == 7)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.getMidYPos() >= 224 || hero.getMidXPos() <= 224)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,Utils.HEIGHT * 0.25,0,0.00125),true);
               }
            }
         }
      }
      
      override public function setQuestionMarkCutscene(index:int = 0) : void
      {
         if(index == 0)
         {
            startCutscene(new QuestionMarkCutscene(this));
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 2 || SUB_LEVEL == 5 || SUB_LEVEL == 7)
         {
            array.push(new Point(0.4,1));
            array.push(new Point(1,0.5));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else if(SUB_LEVEL == 3 || SUB_LEVEL == 4 || SUB_LEVEL == 6)
         {
            array.push(new Point(1,0.4));
            array.push(new Point(0.5,1));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else if(SUB_LEVEL == 9)
         {
            array.push(new Point(0.05,1));
            array.push(new Point(0.5,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         else
         {
            array.push(new Point(0.4,1));
            array.push(new Point(0.5,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         if(SUB_LEVEL == 2 || SUB_LEVEL == 5 || SUB_LEVEL == 7)
         {
            return new Point(1,1.2);
         }
         return new Point(1.2,1);
      }
      
      override public function getMusicName() : String
      {
         if(SUB_LEVEL == 1 || SUB_LEVEL == 9)
         {
            return "outside_background";
         }
         return "hive";
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
         if(SUB_LEVEL == 9)
         {
            return BackgroundsManager.TURNIP_GARDEN_WITH_CLOUDS;
         }
         return BackgroundsManager.TURNIP_GARDEN;
      }
   }
}
