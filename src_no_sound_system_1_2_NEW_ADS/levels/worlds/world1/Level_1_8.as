package levels.worlds.world1
{
   import entities.Entity;
   import entities.bullets.Bullet;
   import entities.enemies.BossLizardEnemy;
   import entities.npcs.CutsceneNPC;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.*;
   import levels.*;
   import levels.backgrounds.*;
   import levels.cameras.*;
   import levels.cameras.behaviours.*;
   import levels.collisions.GateCollision;
   import levels.cutscenes.*;
   import levels.cutscenes.world1.*;
   
   public class Level_1_8 extends Level
   {
      
      public static const Map_1_8_1:Class = Level_1_8_Map_1_8_1;
      
      public static const Map_1_8_2:Class = Level_1_8_Map_1_8_2;
      
      public static const Map_1_8_3:Class = Level_1_8_Map_1_8_3;
      
      public static const Map_1_8_4:Class = Level_1_8_Map_1_8_4;
      
      public static const Map_1_8_5:Class = Level_1_8_Map_1_8_5;
      
      public static const Map_1_8_6:Class = Level_1_8_Map_1_8_6;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      protected var gate:GateCollision;
      
      protected var set_margin:Boolean;
      
      protected var boulder:Bullet;
      
      protected var hero_ref_x_for_camera:Number;
      
      public var lizardBoss:BossLizardEnemy;
      
      public function Level_1_8(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.CAMERA_AREA = 0;
         this.sfx_just_once = true;
         this.set_margin = false;
         this.hero_ref_x_for_camera = 0;
         this.lizardBoss = null;
         super();
         this.CUTSCENE_FLAG_1 = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_8_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_8_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_8_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_8_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_8_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_8_6.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_1_8_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_1_8_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_1_8_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_1_8_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_1_8_5());
            }
            else if(SUB_LEVEL == 6)
            {
               map = new XML(new Map_1_8_6());
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
         var tweenShift:VerTweenShiftBehaviour = null;
         if(SUB_LEVEL == 1)
         {
            camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
         }
         else if(SUB_LEVEL == 2)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 3)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 4)
            {
               tweenShift = new VerTweenShiftBehaviour(this);
               tweenShift.y_start = camera.y;
               tweenShift.y_end = 176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
               tweenShift.time = 0.01;
               tweenShift.tick = 0;
               camera.changeVerBehaviour(tweenShift);
               this.CAMERA_AREA = 2;
            }
            else
            {
               camera.changeVerBehaviour(new StaticVerBehaviour(this,672 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            }
         }
         else if(SUB_LEVEL == 4)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,256 - Utils.WIDTH * 0.5));
            camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
            camera.y = levelData.BOTTOM_MARGIN - Utils.HEIGHT;
            camera.RIGHT_MARGIN = 1552;
         }
         else if(SUB_LEVEL == 5)
         {
            camera.BOTTOM_MARGIN = 352 + camera.getVerticalOffsetFromGroundLevel();
         }
         else if(SUB_LEVEL == 6)
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
         var lizardNPC:CutsceneNPC = null;
         super.init();
         if(SUB_LEVEL == 4)
         {
            camera.y = levelData.BOTTOM_MARGIN - Utils.HEIGHT;
         }
         else if(SUB_LEVEL == 6)
         {
            if(Utils.Slot.gameProgression[8] == 0)
            {
               lizardNPC = new CutsceneNPC(this,904,80 + 64,Entity.LEFT,0,0);
               npcsManager.npcs.push(lizardNPC);
            }
         }
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var tweenShift:VerTweenShiftBehaviour = null;
         var tweenShift2:HorTweenShiftBehaviour = null;
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(stateMachine.currentState == "IS_PLAYING_STATE")
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
               if(!this.CUTSCENE_FLAG_1)
               {
                  if(Utils.Slot.gameProgression[7] == 0)
                  {
                     if(hero.xPos >= 472)
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
            if(this.CAMERA_AREA == 0)
            {
               if(camera.xPos >= 1120 - Utils.WIDTH * 0.5 && hero.xPos >= 1008)
               {
                  camera.changeHorBehaviour(new StaticHorBehaviour(this,1120 - Utils.WIDTH * 0.5));
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
                  camera.BOTTOM_MARGIN = camera.yPos + Utils.HEIGHT;
                  camera.TOP_MARGIN = 176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  camera.RIGHT_MARGIN = 1488;
                  this.CAMERA_AREA = 1;
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos >= 608 && hero.xPos <= 976)
               {
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 672 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.25;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  this.CAMERA_AREA = 0;
               }
               else if(hero.yPos <= 192 && hero.xPos >= 1216)
               {
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.25;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  this.CAMERA_AREA = 2;
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(camera.xPos <= 1120 - Utils.WIDTH * 0.5 && hero.xPos <= 1184)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeHorBehaviour(new StaticHorBehaviour(this,1120 - Utils.WIDTH * 0.5));
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
               }
               if(hero.xPos >= 1456)
               {
                  this.CUTSCENE_FLAG_1 = true;
               }
            }
            if(this.CUTSCENE_FLAG_1)
            {
               camera.RIGHT_MARGIN *= 1.2;
               if(camera.RIGHT_MARGIN >= levelData.RIGHT_MARGIN)
               {
                  camera.RIGHT_MARGIN = levelData.RIGHT_MARGIN;
               }
            }
         }
         else if(SUB_LEVEL == 4)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.xPos >= 304 && hero.yPos <= 160)
               {
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.25;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  this.CAMERA_AREA = 1;
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.xPos <= 304 - 24 || hero.xPos <= 304 && hero.yPos <= 176)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = 256 - int(camera.HALF_WIDTH);
                  tweenShift2.time = 0.25;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
               }
            }
            if(hero.yPos <= 48 && hero.xPos >= 1312 || hero.xPos >= 1520)
            {
               camera.RIGHT_MARGIN *= 1.05;
               if(camera.RIGHT_MARGIN >= levelData.RIGHT_MARGIN)
               {
                  camera.RIGHT_MARGIN = levelData.RIGHT_MARGIN;
               }
            }
         }
         else if(SUB_LEVEL == 6)
         {
            if(this.CUTSCENE_FLAG_1 == false)
            {
               if(hero.xPos >= 608)
               {
                  this.CUTSCENE_FLAG_1 = true;
                  startCutscene(new LizardBossCutscene(this));
               }
            }
            if(this.CUTSCENE_FLAG_2 == false)
            {
               if(this.lizardBoss != null)
               {
                  if(this.lizardBoss.stateMachine.currentState == "IS_DEAD_STATE")
                  {
                     this.CUTSCENE_FLAG_2 = true;
                     startCutscene(new LizardBossCutscene(this,true));
                  }
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 1)
         {
            array.push(new Point(0.05,0.05));
            array.push(new Point(0.4,0.4));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else if(SUB_LEVEL == 3 || SUB_LEVEL == 4 || SUB_LEVEL == 5)
         {
            array.push(new Point(0.5,0.5));
            array.push(new Point(0.75,0.75));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else if(SUB_LEVEL == 6)
         {
            array.push(new Point(0.05,1));
            array.push(new Point(0.4,1));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else
         {
            array.push(new Point(0.5,1));
            array.push(new Point(0.75,1));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         return new Point(1.2,1);
      }
      
      override public function getMusicName() : String
      {
         if(SUB_LEVEL == 1 || SUB_LEVEL == 6)
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
         if(SUB_LEVEL == 1 || SUB_LEVEL == 6)
         {
            return BackgroundsManager.CANYON_AFTERNOON;
         }
         return BackgroundsManager.WOOD_CASTLE_INSIDE;
      }
   }
}
