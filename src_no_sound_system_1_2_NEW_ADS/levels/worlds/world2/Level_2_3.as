package levels.worlds.world2
{
   import entities.*;
   import entities.enemies.*;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.*;
   import levels.*;
   import levels.backgrounds.*;
   import levels.cameras.behaviours.*;
   import levels.cutscenes.world2.*;
   import levels.items.*;
   
   public class Level_2_3 extends Level
   {
      
      public static const Map_2_3_1:Class = Level_2_3_Map_2_3_1;
      
      public static const Map_2_3_2:Class = Level_2_3_Map_2_3_2;
      
      public static const Map_2_3_3:Class = Level_2_3_Map_2_3_3;
      
      public static const Map_2_3_4:Class = Level_2_3_Map_2_3_4;
      
      public static const Map_2_3_5:Class = Level_2_3_Map_2_3_5;
      
      public static const Map_2_3_6:Class = Level_2_3_Map_2_3_6;
      
      public static const Map_2_3_7:Class = Level_2_3_Map_2_3_7;
      
      public static const Map_2_3_8:Class = Level_2_3_Map_2_3_8;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      protected var camera_counter_1:int;
      
      protected var CREATE_BRICKS_FLAG:Boolean;
      
      protected var IS_DONE:Boolean;
      
      protected var bricks_counter_1:int;
      
      protected var bricks_counter_2:int;
      
      protected var fish_spawn_counter:int;
      
      protected var just_once:Boolean = true;
      
      public function Level_2_3(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.CAMERA_AREA = this.camera_counter_1 = 0;
         this.fish_spawn_counter = 180;
         this.sfx_just_once = true;
         this.CREATE_BRICKS_FLAG = this.IS_DONE = false;
         this.bricks_counter_1 = this.bricks_counter_2 = 0;
         super();
         this.CUTSCENE_FLAG_1 = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_3_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_3_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_3_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_3_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_3_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               Utils.IS_DARK = true;
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_3_6.xml");
            }
            else if(SUB_LEVEL == 7)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_3_7.xml");
            }
            else if(SUB_LEVEL == 8)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_3_8.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_2_3_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_2_3_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_2_3_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_2_3_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_2_3_5());
            }
            else if(SUB_LEVEL == 6)
            {
               Utils.IS_DARK = true;
               map = new XML(new Map_2_3_6());
            }
            else if(SUB_LEVEL == 7)
            {
               map = new XML(new Map_2_3_7());
            }
            else if(SUB_LEVEL == 8)
            {
               map = new XML(new Map_2_3_8());
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
            camera.changeVerBehaviour(new StaticVerBehaviour(this,176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 2)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 4 || SUB_LEVEL == 5)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            if(SUB_LEVEL == 5 && Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] != 2)
            {
               camera.RIGHT_MARGIN = 1792;
            }
            else if(SUB_LEVEL == 5)
            {
               camera.RIGHT_MARGIN = 2048;
            }
            if(SUB_LEVEL == 5 && Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 9)
            {
               this.CAMERA_AREA = 1;
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
               camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this));
               camera.yPos = hero.yPos - camera.HALF_HEIGHT;
            }
         }
         else if(SUB_LEVEL == 6)
         {
            camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            camera.yPos = hero.getMidYPos() - camera.HALF_HEIGHT;
         }
         else if(SUB_LEVEL == 7)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,408 - camera.HALF_WIDTH));
            camera.changeVerBehaviour(new StaticVerBehaviour(this,176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 8)
         {
            camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            camera.yPos = hero.getMidYPos() - camera.HALF_HEIGHT;
            camera.changeVerBehaviour(new StaticVerBehaviour(this,192 + DebugInputPanel.getInstance().s1 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
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
         if(SUB_LEVEL == 4)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] != 2)
            {
               for(i = 0; i < enemiesManager.enemies.length; i++)
               {
                  if(enemiesManager.enemies[i] != null)
                  {
                     if(enemiesManager.enemies[i].xPos >= 1392)
                     {
                        enemiesManager.enemies[i].dead = true;
                     }
                  }
               }
            }
         }
         else if(SUB_LEVEL == 5)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 8)
            {
               for(i = 0; i < enemiesManager.enemies.length; i++)
               {
                  if(enemiesManager.enemies[i] != null)
                  {
                     if(enemiesManager.enemies[i].xPos <= 480)
                     {
                        enemiesManager.enemies[i].dead = true;
                     }
                  }
               }
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] != 3)
            {
               for(i = 0; i < enemiesManager.enemies.length; i++)
               {
                  if(enemiesManager.enemies[i] != null)
                  {
                     if(enemiesManager.enemies[i].xPos <= 272)
                     {
                        enemiesManager.enemies[i].dead = true;
                     }
                     else if(enemiesManager.enemies[i].xPos >= 672 && enemiesManager.enemies[i].xPos <= 931)
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
         var centeredVerProgressive:CenteredProgressiveVerScrollBehaviour = null;
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(this.just_once)
            {
               if(!this.CUTSCENE_FLAG_1)
               {
                  this.CUTSCENE_FLAG_1 = true;
                  startCutscene(new RigsJoinsTeamCutscene(this));
               }
            }
         }
         else if(SUB_LEVEL == 2)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 224 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  if(hero.xPos <= 1040)
                  {
                     tweenShift.y_end = 224 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  }
                  else
                  {
                     tweenShift.y_end = 256 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  }
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
         }
         else if(SUB_LEVEL == 4)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 288 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
               else if(hero.xPos >= 496)
               {
                  if(hero.yPos <= 144 - 8)
                  {
                     this.CAMERA_AREA = 2;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.yPos >= 176)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
         }
         else if(SUB_LEVEL == 5)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.xPos >= 592)
               {
                  this.CAMERA_AREA = 1;
                  centeredVerProgressive = new CenteredProgressiveVerScrollBehaviour(this);
                  camera.changeVerBehaviour(centeredVerProgressive);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               camera.LEFT_MARGIN *= 0.9;
               if(camera.LEFT_MARGIN <= levelData.LEFT_MARGIN)
               {
                  camera.LEFT_MARGIN = levelData.LEFT_MARGIN;
               }
               if(hero.xPos <= 568)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
               else if(hero.xPos >= 944)
               {
                  this.CAMERA_AREA = 2;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  camera.LEFT_MARGIN = 792 - camera.HALF_WIDTH;
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.xPos <= 896 && hero.yPos <= 176)
               {
                  this.CAMERA_AREA = 1;
                  centeredVerProgressive = new CenteredProgressiveVerScrollBehaviour(this);
                  camera.changeVerBehaviour(centeredVerProgressive);
               }
               else if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 3;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 304 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16)
               {
                  this.CAMERA_AREA = 2;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  camera.LEFT_MARGIN = 792 - camera.HALF_WIDTH;
               }
            }
            if(hero.xPos >= 2016)
            {
               camera.RIGHT_MARGIN *= 1.2;
               if(camera.RIGHT_MARGIN >= levelData.RIGHT_MARGIN)
               {
                  camera.RIGHT_MARGIN = levelData.RIGHT_MARGIN;
               }
            }
         }
         else if(SUB_LEVEL == 6)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(camera.xPos >= 744 - camera.HALF_WIDTH)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeHorBehaviour(new StaticHorBehaviour(this,744 - camera.HALF_WIDTH));
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.xPos <= 624 + 16)
               {
                  this.CAMERA_AREA = 0;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
               }
               else if(hero.xPos >= 864 - 16)
               {
                  this.CAMERA_AREA = 2;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(camera.xPos <= 744 - camera.HALF_WIDTH)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeHorBehaviour(new StaticHorBehaviour(this,744 - camera.HALF_WIDTH));
               }
            }
         }
         else if(SUB_LEVEL == 8)
         {
            if(hero.yPos >= camera.yPos + camera.HEIGHT + 16)
            {
               if(hero.xPos <= 512)
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 7;
               }
               else if(hero.xPos >= 1072)
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 9;
               }
               else
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 8;
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
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 7)
         {
            array.push(new Point(0,1));
            array.push(new Point(0.4,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         else if(SUB_LEVEL == 5)
         {
            array.push(new Point(0,0));
            array.push(new Point(0.4,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         else
         {
            array.push(new Point(0,1));
            array.push(new Point(0.4,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         if(SUB_LEVEL == 4 || SUB_LEVEL == 5)
         {
            return new Point(1.2,0.2);
         }
         if(SUB_LEVEL == 7)
         {
            return new Point(1,1);
         }
         return new Point(1.2,1);
      }
      
      override public function getMusicName() : String
      {
         if(SUB_LEVEL == 1)
         {
            return "outside_sea";
         }
         if(SUB_LEVEL == 6)
         {
            return "inside_cave";
         }
         return "beach";
      }
      
      override public function playMusic() : void
      {
         if(SUB_LEVEL == 1)
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
         if(SUB_LEVEL == 6)
         {
            return BackgroundsManager.CAVE;
         }
         return BackgroundsManager.DESERT;
      }
   }
}
