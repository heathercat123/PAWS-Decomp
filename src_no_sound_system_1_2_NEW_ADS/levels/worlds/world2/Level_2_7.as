package levels.worlds.world2
{
   import entities.Entity;
   import entities.enemies.*;
   import entities.npcs.CutsceneNPC;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.*;
   import levels.cameras.behaviours.*;
   import levels.cameras.*;
   import levels.collisions.*;
   import levels.cutscenes.*;
   import levels.cutscenes.world1.*;
   import levels.cutscenes.world2.GenericWorld2Cutscene;
   
   public class Level_2_7 extends Level
   {
      
      public static const Map_2_7_1:Class = Level_2_7_Map_2_7_1;
      
      public static const Map_2_7_2:Class = Level_2_7_Map_2_7_2;
      
      public static const Map_2_7_3:Class = Level_2_7_Map_2_7_3;
      
      public static const Map_2_7_4:Class = Level_2_7_Map_2_7_4;
      
      public static const Map_2_7_5:Class = Level_2_7_Map_2_7_5;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var IS_ON_TOP:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var do_not_reset_right_margin:Boolean;
      
      protected var movingRock:Vector.<BigIceBlockCollision>;
      
      protected var bossEnemy:GiantCrabEnemy;
      
      protected var sfx_just_once:Boolean;
      
      protected var camera_reset_flag:Boolean;
      
      protected var foxNPC:CutsceneNPC;
      
      public function Level_2_7(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.sfx_just_once = true;
         this.camera_reset_flag = true;
         this.foxNPC = null;
         super();
         this.CUTSCENE_FLAG_1 = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         this.IS_ON_TOP = false;
         this.CAMERA_AREA = 0;
         this.do_not_reset_right_margin = false;
         this.movingRock = null;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_7_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_7_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_7_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_7_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_7_5.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_2_7_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_2_7_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_2_7_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_2_7_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_2_7_5());
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
         if(SUB_LEVEL == 1 || SUB_LEVEL == 2 || SUB_LEVEL == 4 || SUB_LEVEL == 5)
         {
            camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
            camera.changeVerBehaviour(new StaticVerBehaviour(this,208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            if(SUB_LEVEL == 4)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 4)
               {
                  camera.LEFT_MARGIN = 768;
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeHorBehaviour(new CenteredHorScrollBehaviour(this));
            camera.TOP_MARGIN = 128;
         }
      }
      
      override public function exitLevel() : void
      {
         super.exitLevel();
      }
      
      override public function init() : void
      {
         super.init();
         if(SUB_LEVEL == 2)
         {
            if(Utils.Slot.gameProgression[13] == 0)
            {
               this.foxNPC = new CutsceneNPC(this,1696,176,Entity.LEFT,0,CutsceneNPC.BOSS_FOX);
               npcsManager.npcs.push(this.foxNPC);
               camera.RIGHT_MARGIN = 1712 + 48;
            }
            else
            {
               camera.RIGHT_MARGIN = 1712;
            }
         }
         else if(SUB_LEVEL == 4)
         {
         }
      }
      
      override public function setQuestionMarkCutscene(index:int = 0) : void
      {
         if(index == 0)
         {
            startCutscene(new QuestionMarkCutscene(this));
         }
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var tweenShift:VerTweenShiftBehaviour = null;
         var tweenShift2:HorTweenShiftBehaviour = null;
         super.update();
         if(SUB_LEVEL == 1 || SUB_LEVEL == 4)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
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
                  tweenShift.y_end = 208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
         }
         else if(SUB_LEVEL == 2)
         {
            if(!this.CUTSCENE_FLAG_1)
            {
               if(hero.xPos >= 1536 && Utils.Slot.gameProgression[13] == 0)
               {
                  this.CUTSCENE_FLAG_1 = true;
                  startCutscene(new GenericWorld2Cutscene(this));
               }
            }
            if(this.CAMERA_AREA == 0)
            {
               if(hero.xPos >= 1680)
               {
                  camera.RIGHT_MARGIN *= 1.2;
                  if(camera.RIGHT_MARGIN >= levelData.RIGHT_MARGIN)
                  {
                     camera.RIGHT_MARGIN = levelData.RIGHT_MARGIN;
                  }
               }
               if(hero.yPos <= 112 && (hero.xPos <= 1280 && hero.xPos >= 256))
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
               else if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 2;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.xPos >= 864 + 16 && hero.xPos <= 1088 - 16)
               {
                  this.CAMERA_AREA = 3;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = int(976 - Utils.WIDTH * 0.5);
                  tweenShift2.time = 0.75;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
               else if(hero.yPos >= 160)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
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
                  tweenShift.y_end = 208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               if((hero.xPos <= 864 || hero.xPos >= 1088) && hero.yPos <= 144)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(hero.xPos >= 272)
            {
               camera.TOP_MARGIN *= 0.8;
               if(camera.TOP_MARGIN <= 32)
               {
                  camera.TOP_MARGIN = 32;
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         array.push(new Point(0,0));
         array.push(new Point(0.025,0));
         array.push(new Point(0,0.1375));
         array.push(new Point(0.8,1));
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         return new Point(1.2,1);
      }
      
      override public function getMusicName() : String
      {
         return "ocean";
      }
      
      override public function playMusic() : void
      {
         SoundSystem.PlayMusic(this.getMusicName());
      }
      
      override public function getBackgroundId() : int
      {
         if(SUB_LEVEL == 3)
         {
            return BackgroundsManager.UNDERWATER;
         }
         return BackgroundsManager.ICEBERG_NIGHT;
      }
   }
}
