package levels.worlds.world1
{
   import entities.bullets.Bullet;
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
   import sprites.bullets.BoulderBulletSprite;
   
   public class Level_1_7 extends Level
   {
      
      public static const Map_1_7_1:Class = Level_1_7_Map_1_7_1;
      
      public static const Map_1_7_2:Class = Level_1_7_Map_1_7_2;
      
      public static const Map_1_7_3:Class = Level_1_7_Map_1_7_3;
      
      public static const Map_1_7_4:Class = Level_1_7_Map_1_7_4;
      
      public static const Map_1_7_5:Class = Level_1_7_Map_1_7_5;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      protected var gate:GateCollision;
      
      protected var set_margin:Boolean;
      
      protected var boulder:Bullet;
      
      public function Level_1_7(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.CAMERA_AREA = 0;
         this.sfx_just_once = true;
         this.set_margin = false;
         super();
         this.CUTSCENE_FLAG_1 = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_7_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_7_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_7_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_7_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_7_5.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_1_7_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_1_7_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_1_7_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_1_7_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_1_7_5());
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
            camera.changeVerBehaviour(new StaticVerBehaviour(this,640 + 128 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
            camera.RIGHT_MARGIN = 576 + int(camera.HALF_WIDTH);
         }
         else if(SUB_LEVEL == 2)
         {
            camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this),true);
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
            camera.RIGHT_MARGIN = 1728;
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,levelData.LEFT_MARGIN));
            camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,-32),true);
         }
         else if(SUB_LEVEL == 4)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 2)
            {
               this.CAMERA_AREA = 1;
               camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
               camera.y = int(256 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT));
               camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
               camera.TOP_MARGIN = int(304 + camera.getVerticalOffsetFromGroundLevel() - Utils.HEIGHT);
               camera.LEFT_MARGIN = camera.x;
            }
            else
            {
               camera.changeHorBehaviour(new StaticHorBehaviour(this,int(224 - Utils.WIDTH * 0.5)));
               camera.y = int(432 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT));
               camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
            }
         }
         else if(SUB_LEVEL == 5)
         {
            camera.BOTTOM_MARGIN = 480 + camera.getVerticalOffsetFromGroundLevel();
            camera.y = int(480 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT));
         }
      }
      
      override public function setQuestionMarkCutscene(index:int = 0) : void
      {
         if(index == 0)
         {
            startCutscene(new QuestionMarkCutscene(this));
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
         if(SUB_LEVEL == 1 || SUB_LEVEL == 4)
         {
            for(i = 0; i < collisionsManager.collisions.length; i++)
            {
               if(collisionsManager.collisions[i] != null)
               {
                  if(collisionsManager.collisions[i] is GateCollision)
                  {
                     if(collisionsManager.collisions[i].yPos < 160)
                     {
                        this.gate = collisionsManager.collisions[i] as GateCollision;
                     }
                  }
               }
            }
         }
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var tweenShift:VerTweenShiftBehaviour = null;
         var tweenShift2:HorTweenShiftBehaviour = null;
         var offset_x:Number = NaN;
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.xPos >= 576)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = 576 - int(camera.HALF_WIDTH);
                  tweenShift2.time = 0.25;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this),true);
               }
               camera.LEFT_MARGIN *= 0.8;
               if(camera.LEFT_MARGIN <= levelData.LEFT_MARGIN)
               {
                  camera.LEFT_MARGIN = levelData.LEFT_MARGIN;
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos <= 128)
               {
                  this.CAMERA_AREA = 2;
                  camera.LEFT_MARGIN = 352;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 144 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 1;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this),true);
               }
               else if(hero.yPos >= 672 && hero.xPos < 448)
               {
                  this.CAMERA_AREA = 0;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this),true);
               }
               else if(hero.yPos >= 400 && hero.yPos <= 528 && hero.xPos <= 432)
               {
                  this.CAMERA_AREA = 0;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this),true);
               }
               if(!this.set_margin)
               {
                  if(hero.yPos <= 608)
                  {
                     this.set_margin = true;
                     if(camera.x <= 352)
                     {
                        camera.LEFT_MARGIN = camera.x;
                     }
                     else
                     {
                        camera.LEFT_MARGIN = 352;
                     }
                  }
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(this.gate.stateMachine.currentState != "IS_CLOSED_STATE")
               {
                  if(this.set_margin)
                  {
                     this.set_margin = false;
                  }
               }
               if(!this.set_margin)
               {
                  camera.LEFT_MARGIN *= 0.5;
                  if(camera.LEFT_MARGIN <= levelData.LEFT_MARGIN)
                  {
                     camera.LEFT_MARGIN = levelData.LEFT_MARGIN;
                  }
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               if(hero.yPos >= 656)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 640 + 128 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 1;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            if(hero.yPos <= 480 && hero.yPos >= 368)
            {
               camera.LEFT_MARGIN = 272 - camera.HALF_WIDTH;
            }
         }
         else if(SUB_LEVEL == 2)
         {
            if(hero.xPos >= 1680)
            {
               camera.RIGHT_MARGIN *= 1.1;
               if(camera.RIGHT_MARGIN >= levelData.RIGHT_MARGIN)
               {
                  camera.RIGHT_MARGIN = levelData.RIGHT_MARGIN;
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(this.CAMERA_AREA == 0)
            {
               for(i = 0; i < bulletsManager.bullets.length; i++)
               {
                  if(bulletsManager.bullets[i].sprite != null)
                  {
                     if(bulletsManager.bullets[i].sprite is BoulderBulletSprite)
                     {
                        this.boulder = bulletsManager.bullets[i];
                        this.CAMERA_AREA = 1;
                        offset_x = Number(bulletsManager.bullets[i].sprite.x);
                        camera.changeHorBehaviour(new CenteredHorScrollBehaviour(this,bulletsManager.bullets[i],offset_x));
                     }
                  }
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               camera.RIGHT_MARGIN = camera.x + Utils.WIDTH + 2;
               camera.LEFT_MARGIN = camera.x;
               if(this.boulder.xPos >= 1000)
               {
                  this.CAMERA_AREA = 2;
                  camera.RIGHT_MARGIN = levelData.RIGHT_MARGIN;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 416 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 1;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this),true);
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
            }
         }
         else if(SUB_LEVEL == 4)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos <= 304)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  camera.TOP_MARGIN = int(304 + camera.getVerticalOffsetFromGroundLevel() - Utils.HEIGHT);
                  camera.LEFT_MARGIN = camera.x;
               }
               camera.BOTTOM_MARGIN = 432 + camera.getVerticalOffsetFromGroundLevel();
               camera.LEFT_MARGIN *= 0.95;
               if(camera.LEFT_MARGIN <= levelData.LEFT_MARGIN)
               {
                  camera.LEFT_MARGIN = levelData.LEFT_MARGIN;
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.xPos < 368)
               {
                  if(camera.TOP_MARGIN < int(304 + camera.getVerticalOffsetFromGroundLevel() - Utils.HEIGHT))
                  {
                     camera.TOP_MARGIN *= 1.01;
                  }
                  if(hero.yPos >= 336)
                  {
                     this.CAMERA_AREA = 0;
                     tweenShift2 = new HorTweenShiftBehaviour(this);
                     tweenShift2.x_start = camera.x;
                     tweenShift2.x_end = 224 - int(camera.HALF_WIDTH);
                     tweenShift2.time = 0.5;
                     tweenShift2.tick = 0;
                     camera.changeHorBehaviour(tweenShift2);
                     camera.BOTTOM_MARGIN = 432 + camera.getVerticalOffsetFromGroundLevel();
                     camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
                  }
               }
               else if(camera.TOP_MARGIN > int(272 + camera.getVerticalOffsetFromGroundLevel() - Utils.HEIGHT))
               {
                  camera.TOP_MARGIN *= 0.99;
               }
               camera.BOTTOM_MARGIN *= 1.1;
               if(camera.BOTTOM_MARGIN >= levelData.BOTTOM_MARGIN)
               {
                  camera.BOTTOM_MARGIN = levelData.BOTTOM_MARGIN;
               }
               if(hero.xPos >= 944)
               {
                  this.CAMERA_AREA = 2;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = 1016 - int(camera.HALF_WIDTH);
                  tweenShift2.time = 0.25;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this),true);
                  camera.TOP_MARGIN = levelData.TOP_MARGIN;
                  camera.BOTTOM_MARGIN = camera.y + Utils.HEIGHT;
               }
               camera.LEFT_MARGIN *= 0.95;
               if(camera.LEFT_MARGIN <= levelData.LEFT_MARGIN)
               {
                  camera.LEFT_MARGIN = levelData.LEFT_MARGIN;
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.yPos >= 176)
               {
                  if(hero.xPos <= 944 - 32)
                  {
                     this.CAMERA_AREA = 1;
                     camera.TOP_MARGIN = camera.y;
                     camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
                     camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  }
               }
               else if(hero.xPos <= 944 - 32 && this.gate.stateMachine.currentState == "IS_OPEN_STATE")
               {
                  this.CAMERA_AREA = 3;
                  camera.LEFT_MARGIN = 272;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               if(hero.xPos >= 944)
               {
                  this.CAMERA_AREA = 2;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = 1016 - int(camera.HALF_WIDTH);
                  tweenShift2.time = 0.25;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this),true);
               }
               else if(hero.yPos >= 160)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 1 || SUB_LEVEL == 3 || SUB_LEVEL == 4 || SUB_LEVEL == 5)
         {
            array.push(new Point(0.2,1));
            array.push(new Point(0.6,0.6));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         else
         {
            array.push(new Point(0.2,1));
            array.push(new Point(0.6,1));
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
         return "canyon";
      }
      
      override public function playMusic() : void
      {
         SoundSystem.PlayMusic(this.getMusicName());
      }
      
      override public function getBackgroundId() : int
      {
         return BackgroundsManager.CANYON_YELLOW;
      }
   }
}
