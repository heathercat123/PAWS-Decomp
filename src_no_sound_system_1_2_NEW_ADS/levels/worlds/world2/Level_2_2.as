package levels.worlds.world2
{
   import entities.enemies.Enemy;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import levels.GenericScript;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.*;
   import levels.cutscenes.world1.*;
   
   public class Level_2_2 extends Level
   {
      
      public static const Map_2_2_1:Class = Level_2_2_Map_2_2_1;
      
      public static const Map_2_2_2:Class = Level_2_2_Map_2_2_2;
      
      public static const Map_2_2_3:Class = Level_2_2_Map_2_2_3;
      
      public static const Map_2_2_4:Class = Level_2_2_Map_2_2_4;
      
      public static const Map_2_2_5:Class = Level_2_2_Map_2_2_5;
       
      
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
      
      public function Level_2_2(_sub_level:int)
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
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_2_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_2_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_2_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_2_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_2_5.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_2_2_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_2_2_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_2_2_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_2_2_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_2_2_5());
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
         var top_y:int = 0;
         if(SUB_LEVEL == 1)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 2)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 3)
            {
               top_y = 144 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
               if(top_y < levelData.TOP_MARGIN)
               {
                  top_y = levelData.TOP_MARGIN;
               }
               camera.changeVerBehaviour(new StaticVerBehaviour(this,top_y));
            }
            else
            {
               camera.changeVerBehaviour(new StaticVerBehaviour(this,1024 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            }
            camera.changeHorBehaviour(new StaticHorBehaviour(this,256 - camera.HALF_WIDTH));
            camera.TOP_MARGIN = 48;
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,224 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 4)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,192 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 5)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            camera.changeHorBehaviour(new StaticHorBehaviour(this,256 - camera.HALF_WIDTH));
            camera.BOTTOM_MARGIN = 496 + camera.getVerticalOffsetFromGroundLevel();
            camera.LEFT_MARGIN = camera.x;
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
      }
      
      override public function update() : void
      {
         var tweenShift:VerTweenShiftBehaviour = null;
         var tweenShift2:HorTweenShiftBehaviour = null;
         var enemy:Enemy = null;
         var gScript:GenericScript = null;
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos <= 176)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  if(hero.xPos >= 1232)
                  {
                     tweenShift.y_end = 176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  }
                  else
                  {
                     tweenShift.y_end = 192 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  }
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
               else if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 2;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  if(hero.xPos <= 656)
                  {
                     tweenShift.y_end = 336 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  }
                  else
                  {
                     tweenShift.y_end = 368 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  }
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos >= 208)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
         }
         else if(SUB_LEVEL == 2)
         {
            if(this.CAMERA_AREA == 0)
            {
               this.CAMERA_AREA = 1;
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] != 3)
               {
                  camera.BOTTOM_MARGIN = camera.y + camera.HEIGHT;
               }
               camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,-16));
            }
            else if(this.CAMERA_AREA == 1)
            {
            }
         }
         else if(SUB_LEVEL == 4)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.xPos >= 312 && hero.yPos <= 128)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 112 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos >= 144 && hero.xPos <= 592)
               {
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 192 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  this.CAMERA_AREA = 0;
               }
               else if(hero.yPos >= 144 && hero.xPos >= 640)
               {
                  camera.changeHorBehaviour(new CenteredProgressiveHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 320 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  this.CAMERA_AREA = 2;
                  if(camera.x < 592)
                  {
                     camera.LEFT_MARGIN = camera.x;
                  }
                  else
                  {
                     camera.LEFT_MARGIN = 592;
                  }
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16)
               {
                  if(hero.xPos >= 976 || hero.xPos <= 624)
                  {
                     camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 224 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                     this.CAMERA_AREA = 3;
                  }
               }
               if(hero.xPos <= 624)
               {
                  camera.LEFT_MARGIN -= 2;
                  if(camera.LEFT_MARGIN <= 400)
                  {
                     camera.LEFT_MARGIN = 400;
                  }
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  camera.changeHorBehaviour(new CenteredProgressiveHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 320 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  this.CAMERA_AREA = 2;
               }
            }
         }
         else if(SUB_LEVEL == 5)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(this.camera_counter_1++ > 60)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = hero.getMidYPos() + 32 - camera.HALF_HEIGHT;
                  tweenShift.time = 2;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  this.camera_counter_1 = 0;
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(this.camera_counter_1++ > 120)
               {
                  this.CAMERA_AREA = 2;
                  camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,32));
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.xPos >= 304 && hero.yPos >= 400 && hero.xPos <= 1648)
               {
                  this.CAMERA_AREA = 3;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 432 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  camera.TOP_MARGIN = 208 + 16;
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               camera.LEFT_MARGIN *= 0.8;
               if(camera.LEFT_MARGIN <= levelData.LEFT_MARGIN)
               {
                  camera.LEFT_MARGIN = levelData.LEFT_MARGIN;
               }
               if(hero.xPos >= 640 && hero.xPos <= 1648 && hero.yPos <= 336)
               {
                  this.CAMERA_AREA = 4;
                  camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this));
               }
               else if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 5;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 496 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 4)
            {
               if(hero.yPos >= 352 && camera.y >= 432 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT))
               {
                  this.CAMERA_AREA = 3;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 496 - 64 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.25;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 5)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16)
               {
                  this.CAMERA_AREA = 3;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 496 - 64 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            if(hero.yPos > 240 && hero.yPos < 432 && hero.xPos <= 384)
            {
               if(this.fish_spawn_counter++ > 180)
               {
                  this.fish_spawn_counter = 0;
                  gScript = new GenericScript(34,240 + Math.random() * 32,8,int(Math.random() * 2),int(Math.random() * 3));
                  gScript.ai = 1;
                  enemy = enemiesManager.createEnemy(gScript);
                  enemy.updateScreenPosition(camera);
                  enemiesManager.enemies.push(enemy);
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 2 || SUB_LEVEL == 4 || SUB_LEVEL == 5)
         {
            array.push(new Point(0.2,0.2));
            array.push(new Point(0.5,0.5));
            array.push(new Point(1,1));
            array.push(new Point(0.8,0.8));
         }
         else
         {
            array.push(new Point(0.2,1));
            array.push(new Point(0.5,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         return new Point(1.2,1);
      }
      
      override public function getMusicName() : String
      {
         return "temple";
      }
      
      override public function playMusic() : void
      {
         SoundSystem.PlayMusic(this.getMusicName());
      }
      
      override public function getBackgroundId() : int
      {
         return BackgroundsManager.TEMPLE;
      }
   }
}
