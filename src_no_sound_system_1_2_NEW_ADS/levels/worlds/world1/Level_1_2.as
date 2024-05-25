package levels.worlds.world1
{
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.*;
   import levels.cameras.behaviours.CenteredProgressiveHorScrollBehaviour;
   import levels.cameras.behaviours.CenteredProgressiveVerScrollBehaviour;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.cameras.behaviours.StaticHorBehaviour;
   import levels.cameras.behaviours.StaticVerBehaviour;
   import levels.cameras.behaviours.TunnelVelShiftVerScrollBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   import levels.cameras.behaviours.VerTweenShiftBehaviour;
   import levels.cameras.*;
   import levels.collisions.CheckeredSpotCollision;
   import levels.cutscenes.world1.*;
   
   public class Level_1_2 extends Level
   {
      
      public static const Map_1_2_1:Class = Level_1_2_Map_1_2_1;
      
      public static const Map_1_2_2:Class = Level_1_2_Map_1_2_2;
      
      public static const Map_1_2_3:Class = Level_1_2_Map_1_2_3;
      
      public static const Map_1_2_4:Class = Level_1_2_Map_1_2_4;
       
      
      public var CUTSCENE_FLAG:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var IS_ON_TOP:Boolean;
      
      protected var CAMERA_AREA:int;
      
      public function Level_1_2(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         super();
         this.CUTSCENE_FLAG = false;
         this.BONUS_FLAG = false;
         this.IS_ON_TOP = false;
         this.CAMERA_AREA = 0;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_2_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_2_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_2_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_2_4.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_1_2_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_1_2_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_1_2_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_1_2_4());
            }
            this.levelLoaded();
         }
      }
      
      override public function levelLoaded() : void
      {
         this.init();
         if(SUB_LEVEL == 1)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 1)
            {
               this.CAMERA_AREA = 2;
               camera.changeVerBehaviour(new StaticVerBehaviour(this,112 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            }
            else
            {
               this.CAMERA_AREA = 0;
               camera.changeVerBehaviour(new StaticVerBehaviour(this,216 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            }
         }
         else if(SUB_LEVEL == 2 || SUB_LEVEL == 3)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,216 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 4)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         LEVEL_LOADED = true;
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
            if(Utils.Slot.gameProgression[1] == 0)
            {
               for(i = 0; i < collisionsManager.collisions.length; i++)
               {
                  if(collisionsManager.collisions[i] != null)
                  {
                     if(collisionsManager.collisions[i] is CheckeredSpotCollision)
                     {
                        collisionsManager.collisions[i].dead = true;
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
         DebugInputPanel.getInstance().text1.text = "" + this.CAMERA_AREA;
         if(SUB_LEVEL == 1)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(camera.xPos >= 1008 - camera.WIDTH * 0.5)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeHorBehaviour(new StaticHorBehaviour(this,1008 - camera.WIDTH * 0.5));
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.xPos <= camera.xPos + camera.WIDTH * 0.2 || hero.xPos <= 832)
               {
                  this.CAMERA_AREA = 0;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.yPos;
                  tweenShift.y_end = 216 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  camera.changeVerBehaviour(tweenShift,false);
               }
               else if(hero.xPos >= 1104)
               {
                  this.CAMERA_AREA = 2;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.xPos <= 1104 - 32)
               {
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
                  this.CAMERA_AREA = 1;
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(this.IS_ON_TOP == false)
            {
               if(hero.xPos >= 848 && hero.xPos <= 1184)
               {
                  if(hero.yPos <= 144)
                  {
                     camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,0));
                     this.IS_ON_TOP = true;
                  }
               }
            }
            else if(hero.yPos >= 160)
            {
               tweenShift = new VerTweenShiftBehaviour(this);
               tweenShift.y_start = camera.y;
               tweenShift.y_end = 216 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
               tweenShift.time = 0.25;
               tweenShift.tick = 0;
               camera.changeVerBehaviour(tweenShift);
               this.IS_ON_TOP = false;
            }
         }
         else if(SUB_LEVEL == 4)
         {
            camera.TOP_MARGIN = 32;
            if(this.CAMERA_AREA == 0)
            {
               if(hero.getMidXPos() >= 304)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = 336 - int(camera.HALF_WIDTH);
                  tweenShift2.time = 1;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.getMidXPos() <= 272)
               {
                  this.CAMERA_AREA = 0;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.25;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
               else if(hero.getMidXPos() >= 400)
               {
                  this.CAMERA_AREA = 2;
                  this.setCamera2();
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.getMidXPos() >= 624 && hero.getMidYPos() >= 176)
               {
                  this.CAMERA_AREA = 3;
                  this.setCamera3();
               }
               else if(hero.getMidXPos() <= 368)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = 336 - int(camera.HALF_WIDTH);
                  tweenShift2.time = 1;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               if(hero.getMidXPos() >= 672 && hero.getMidXPos() <= 768 && hero.getMidYPos() <= 144)
               {
                  this.setCamera2();
                  this.CAMERA_AREA = 2;
               }
               else if(hero.getMidXPos() >= 888)
               {
                  this.setCamera4();
                  this.CAMERA_AREA = 4;
               }
            }
            else if(this.CAMERA_AREA == 4)
            {
               if(hero.getMidXPos() <= 800)
               {
                  this.setCamera3();
                  this.CAMERA_AREA = 3;
               }
            }
         }
         if(SUB_LEVEL == 4)
         {
            if(Utils.Slot.gameProgression[1] == 0)
            {
               if(!this.CUTSCENE_FLAG)
               {
                  if(hero.xPos >= 1520)
                  {
                     this.CUTSCENE_FLAG = true;
                     startCutscene(new LizardIntroCutscene(this));
                  }
               }
            }
         }
      }
      
      protected function setCamera2() : void
      {
         camera.changeHorBehaviour(new CenteredProgressiveHorScrollBehaviour(this));
         var tweenShift:VerTweenShiftBehaviour = new VerTweenShiftBehaviour(this);
         tweenShift.y_start = camera.y;
         tweenShift.y_end = 128 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
         if(this.CAMERA_AREA == 3)
         {
            tweenShift.time = 0.75;
         }
         else
         {
            tweenShift.time = 0.25;
         }
         tweenShift.tick = 0;
         camera.changeVerBehaviour(tweenShift);
         camera.LEFT_MARGIN = 80;
      }
      
      protected function setCamera3() : void
      {
         camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
         var tweenShift:VerTweenShiftBehaviour = new VerTweenShiftBehaviour(this);
         tweenShift.y_start = camera.y;
         tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
         tweenShift.time = 0.25;
         tweenShift.tick = 0;
         camera.changeVerBehaviour(tweenShift);
         camera.LEFT_MARGIN = int(656 - camera.HALF_WIDTH);
      }
      
      protected function setCamera4() : void
      {
         camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         array.push(new Point(0.05,0.25));
         array.push(new Point(0.5,0.5));
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
         return "radio_station";
      }
      
      override public function getBackgroundId() : int
      {
         return BackgroundsManager.STARRY_NIGHT;
      }
   }
}
