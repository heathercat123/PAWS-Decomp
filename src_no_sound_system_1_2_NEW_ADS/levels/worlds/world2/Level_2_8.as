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
   import levels.cutscenes.world2.FishBossCutscene;
   import levels.cutscenes.world2.GenericWorld2Cutscene;
   
   public class Level_2_8 extends Level
   {
      
      public static const Map_2_8_1:Class = Level_2_8_Map_2_8_1;
      
      public static const Map_2_8_2:Class = Level_2_8_Map_2_8_2;
      
      public static const Map_2_8_3:Class = Level_2_8_Map_2_8_3;
      
      public static const Map_2_8_4:Class = Level_2_8_Map_2_8_4;
      
      public static const Map_2_8_5:Class = Level_2_8_Map_2_8_5;
      
      public static const Map_2_8_6:Class = Level_2_8_Map_2_8_6;
      
      public static const Map_2_8_7:Class = Level_2_8_Map_2_8_7;
      
      public static const Map_2_8_8:Class = Level_2_8_Map_2_8_8;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var IS_ON_TOP:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var do_not_reset_right_margin:Boolean;
      
      protected var movingRock:Vector.<BigIceBlockCollision>;
      
      protected var bossEnemy:GiantCrabEnemy;
      
      protected var hero_ref_x_for_camera:Number;
      
      protected var sfx_just_once:Boolean;
      
      protected var camera_reset_flag:Boolean;
      
      public var fishBoss:BossFishEnemy;
      
      public function Level_2_8(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.sfx_just_once = true;
         this.camera_reset_flag = true;
         this.hero_ref_x_for_camera = 0;
         this.fishBoss = null;
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
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_8_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_8_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_8_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_8_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_8_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_8_6.xml");
            }
            else if(SUB_LEVEL == 7)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_8_7.xml");
            }
            else if(SUB_LEVEL == 8)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_8_8.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_2_8_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_2_8_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_2_8_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_2_8_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_2_8_5());
            }
            else if(SUB_LEVEL == 6)
            {
               map = new XML(new Map_2_8_6());
            }
            else if(SUB_LEVEL == 7)
            {
               map = new XML(new Map_2_8_7());
            }
            else if(SUB_LEVEL == 8)
            {
               map = new XML(new Map_2_8_8());
            }
            this.levelLoaded();
         }
      }
      
      override public function levelLoaded() : void
      {
         this.init();
         this.setCameraBehaviours();
         LEVEL_LOADED = true;
         if(SUB_LEVEL == 8)
         {
            hud.showDarkFade(0);
         }
      }
      
      override public function setCameraBehaviours() : void
      {
         if(SUB_LEVEL == 1)
         {
            camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
         }
         else if(SUB_LEVEL == 2 || SUB_LEVEL == 4 || SUB_LEVEL == 5 || SUB_LEVEL == 7)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,336 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            camera.RIGHT_MARGIN = 1584;
         }
         else if(SUB_LEVEL == 6)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,264 - camera.HALF_WIDTH));
            camera.yPos = hero.yPos - camera.HALF_HEIGHT;
            camera.TOP_MARGIN = 32;
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 2)
            {
               camera.BOTTOM_MARGIN = 864 + camera.getVerticalOffsetFromGroundLevel();
            }
            else
            {
               camera.BOTTOM_MARGIN = 944 + camera.getVerticalOffsetFromGroundLevel();
            }
         }
         else if(SUB_LEVEL == 8)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,320 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
      }
      
      override public function exitLevel() : void
      {
         super.exitLevel();
      }
      
      override public function init() : void
      {
         var fishNPC:CutsceneNPC = null;
         var lace:CutsceneNPC = null;
         var fox:CutsceneNPC = null;
         super.init();
         if(SUB_LEVEL == 7)
         {
            fishNPC = new CutsceneNPC(this,800,304,Entity.LEFT,0,2);
            npcsManager.npcs.push(fishNPC);
         }
         else if(SUB_LEVEL == 8)
         {
            lace = new CutsceneNPC(this,400,304,Entity.LEFT,0,CutsceneNPC.BOSS_LACE);
            lace.sprite.gfxHandle().gotoAndStop(3);
            npcsManager.npcs.push(lace);
            fox = new CutsceneNPC(this,480 - 8,304,Entity.LEFT,0,CutsceneNPC.BOSS_FOX);
            npcsManager.npcs.push(fox);
         }
      }
      
      override public function setQuestionMarkCutscene(index:int = 0) : void
      {
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var tweenShift:VerTweenShiftBehaviour = null;
         var tweenShift2:HorTweenShiftBehaviour = null;
         super.update();
         if(SUB_LEVEL == 8)
         {
            if(!this.CUTSCENE_FLAG_1)
            {
               this.CUTSCENE_FLAG_1 = true;
               startCutscene(new GenericWorld2Cutscene(this));
            }
         }
         else if(SUB_LEVEL == 1)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(this.hero_ref_x_for_camera < 1)
               {
                  if(camera.yPos <= 288 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT) && level_tick > 60)
                  {
                     this.CAMERA_AREA = 1;
                     camera.changeVerBehaviour(new StaticVerBehaviour(this,288 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
                     this.hero_ref_x_for_camera = hero.xPos;
                  }
               }
               else if(camera.yPos <= 288 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT) && hero.xPos > this.hero_ref_x_for_camera)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeVerBehaviour(new StaticVerBehaviour(this,288 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
                  this.hero_ref_x_for_camera = hero.xPos;
               }
            }
            else if(hero.xPos <= this.hero_ref_x_for_camera - 24)
            {
               camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
               this.CAMERA_AREA = 0;
            }
         }
         else if(SUB_LEVEL == 2 || SUB_LEVEL == 4)
         {
            if(hero.yPos >= camera.yPos + camera.HEIGHT)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 1;
               if(this.sfx_just_once)
               {
                  SoundSystem.PlaySound("flyingship_falldown");
                  this.sfx_just_once = false;
               }
               exit();
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(this.CAMERA_AREA == 0)
            {
               camera.LEFT_MARGIN *= 0.8;
               if(camera.LEFT_MARGIN <= levelData.LEFT_MARGIN)
               {
                  camera.LEFT_MARGIN = levelData.LEFT_MARGIN;
               }
               if(hero.getMidXPos() >= 496)
               {
                  this.CAMERA_AREA = 1;
                  camera.BOTTOM_MARGIN = camera.y + Utils.HEIGHT;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = 528 - int(camera.HALF_WIDTH);
                  tweenShift2.time = 1;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               camera.LEFT_MARGIN *= 1.2;
               if(camera.LEFT_MARGIN >= 224)
               {
                  camera.LEFT_MARGIN = 224;
               }
               if(hero.getMidXPos() <= 464 && hero.getMidYPos() >= 215)
               {
                  this.CAMERA_AREA = 0;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 336 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.25;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
               else if((hero.getMidXPos() >= 592 || hero.getMidXPos() <= 464) && hero.getMidYPos() <= 215)
               {
                  this.CAMERA_AREA = 2;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 144 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.25;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.getMidXPos() >= 1152)
               {
                  camera.RIGHT_MARGIN *= 1.2;
                  if(camera.RIGHT_MARGIN >= levelData.RIGHT_MARGIN)
                  {
                     camera.RIGHT_MARGIN = levelData.RIGHT_MARGIN;
                  }
               }
               if(hero.getMidXPos() >= 848)
               {
                  if(hero.getMidYPos() >= 176)
                  {
                     this.CAMERA_AREA = 3;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 272 + 32 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
               else if(hero.getMidXPos() <= 624)
               {
                  if(hero.getMidYPos() >= 192)
                  {
                     this.CAMERA_AREA = 1;
                     tweenShift2 = new HorTweenShiftBehaviour(this);
                     tweenShift2.x_start = camera.x;
                     tweenShift2.x_end = 528 - int(camera.HALF_WIDTH);
                     tweenShift2.time = 1;
                     tweenShift2.tick = 0;
                     camera.changeHorBehaviour(tweenShift2);
                     camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
                  }
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               camera.RIGHT_MARGIN *= 0.8;
               if(camera.RIGHT_MARGIN <= 1584)
               {
                  camera.RIGHT_MARGIN = 1584;
               }
               if(hero.getMidXPos() <= 984 && hero.getMidXPos() >= 848)
               {
                  if(hero.getMidYPos() <= 160)
                  {
                     this.CAMERA_AREA = 2;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 144 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
            }
            if(hero.yPos >= camera.yPos + camera.HEIGHT && hero.yPos >= 288)
            {
               Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 2;
               if(this.sfx_just_once)
               {
                  SoundSystem.PlaySound("flyingship_falldown");
                  this.sfx_just_once = false;
               }
               exit();
            }
         }
         else if(SUB_LEVEL == 5)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  if(hero.xPos <= 528 || hero.xPos >= 1520)
                  {
                     this.CAMERA_AREA = 1;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
                  else
                  {
                     this.CAMERA_AREA = 2;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 304 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
               else if(hero.getMidXPos() >= 800 && hero.getMidXPos() <= 1024)
               {
                  this.CAMERA_AREA = 3;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = int(912 - Utils.WIDTH * 0.5);
                  tweenShift2.time = 0.75;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
               }
            }
            else if(this.CAMERA_AREA == 1 || this.CAMERA_AREA == 2)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16 || hero.yPos <= camera.yPos + 8)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               if(hero.getMidXPos() <= 776 || hero.getMidXPos() >= 1048)
               {
                  this.CAMERA_AREA = 0;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
               }
            }
         }
         else if(SUB_LEVEL == 7)
         {
            if(this.CUTSCENE_FLAG_1 == false)
            {
               if(hero.xPos >= 608)
               {
                  this.CUTSCENE_FLAG_1 = true;
                  startCutscene(new FishBossCutscene(this));
               }
            }
            if(this.CUTSCENE_FLAG_2 == false)
            {
               if(this.fishBoss != null)
               {
                  if(this.fishBoss.stateMachine.currentState == "IS_DEAD_STATE")
                  {
                     this.CUTSCENE_FLAG_2 = true;
                     startCutscene(new FishBossCutscene(this,true));
                  }
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 2 || SUB_LEVEL == 4)
         {
            array.push(new Point(0.5,1));
            array.push(new Point(0.75,1));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else if(SUB_LEVEL == 3 || SUB_LEVEL == 5)
         {
            array.push(new Point(0.5,0.5));
            array.push(new Point(0.75,0.75));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else if(SUB_LEVEL == 6)
         {
            array.push(new Point(1,0.5));
            array.push(new Point(1,0.75));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else if(SUB_LEVEL == 7)
         {
            array.push(new Point(0,0.1));
            array.push(new Point(0.025,0.1));
            array.push(new Point(0,0.1375));
            array.push(new Point(1,1));
         }
         else if(SUB_LEVEL == 8)
         {
            array.push(new Point(0.05,1));
            array.push(new Point(0.4,1));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else
         {
            array.push(new Point(0,0));
            array.push(new Point(0.025,0));
            array.push(new Point(0,0.1375));
            array.push(new Point(1,1));
         }
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         if(SUB_LEVEL == 6)
         {
            return new Point(1,1.2);
         }
         return new Point(1.2,1);
      }
      
      override public function getMusicName() : String
      {
         if(SUB_LEVEL == 1 || SUB_LEVEL == 7)
         {
            return "outside_iceberg";
         }
         if(SUB_LEVEL == 8)
         {
            return "outside_desert";
         }
         return "fortress";
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
         if(SUB_LEVEL == 2 || SUB_LEVEL == 3 || SUB_LEVEL == 4 || SUB_LEVEL == 5 || SUB_LEVEL == 6)
         {
            return BackgroundsManager.ICEBERG_NIGHT_CASTLE;
         }
         if(SUB_LEVEL == 8)
         {
            return BackgroundsManager.CANYON_AFTERNOON;
         }
         return BackgroundsManager.ICEBERG_NIGHT;
      }
   }
}
