package levels.worlds.world2
{
   import entities.enemies.*;
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
   
   public class Level_2_4 extends Level
   {
      
      public static const Map_2_4_1:Class = Level_2_4_Map_2_4_1;
      
      public static const Map_2_4_2:Class = Level_2_4_Map_2_4_2;
      
      public static const Map_2_4_3:Class = Level_2_4_Map_2_4_3;
      
      public static const Map_2_4_4:Class = Level_2_4_Map_2_4_4;
      
      public static const Map_2_4_5:Class = Level_2_4_Map_2_4_5;
      
      public static const Map_2_4_6:Class = Level_2_4_Map_2_4_6;
      
      public static const Map_2_4_7:Class = Level_2_4_Map_2_4_7;
      
      public static const Map_2_4_8:Class = Level_2_4_Map_2_4_8;
      
      public static const Map_2_4_9:Class = Level_2_4_Map_2_4_9;
       
      
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
      
      public function Level_2_4(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.sfx_just_once = true;
         this.camera_reset_flag = true;
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
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_4_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_4_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_4_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_4_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_4_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_4_6.xml");
            }
            else if(SUB_LEVEL == 7)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_4_7.xml");
            }
            else if(SUB_LEVEL == 8)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_4_8.xml");
            }
            else if(SUB_LEVEL == 9)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_4_9.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_2_4_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_2_4_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_2_4_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_2_4_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_2_4_5());
            }
            else if(SUB_LEVEL == 6)
            {
               map = new XML(new Map_2_4_6());
            }
            else if(SUB_LEVEL == 7)
            {
               map = new XML(new Map_2_4_7());
            }
            else if(SUB_LEVEL == 8)
            {
               map = new XML(new Map_2_4_8());
            }
            else if(SUB_LEVEL == 9)
            {
               map = new XML(new Map_2_4_9());
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
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] <= 1)
            {
               camera.RIGHT_MARGIN = 496;
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 2)
            {
               camera.LEFT_MARGIN = 656;
            }
            camera.changeVerBehaviour(new StaticVerBehaviour(this,208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 2)
         {
            camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 3 && this.camera_reset_flag)
            {
               camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
               this.do_not_reset_right_margin = true;
               this.CAMERA_AREA = 1;
            }
            else
            {
               camera.changeVerBehaviour(new StaticVerBehaviour(this,272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
               if(!this.do_not_reset_right_margin)
               {
                  camera.RIGHT_MARGIN = 392 + camera.HALF_WIDTH;
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,264 - camera.HALF_WIDTH));
            camera.yPos = hero.yPos - camera.HALF_HEIGHT;
            camera.BOTTOM_MARGIN = int(1008 + camera.getVerticalOffsetFromGroundLevel());
            camera.TOP_MARGIN = 32;
         }
         else if(SUB_LEVEL == 4)
         {
            camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
            camera.changeVerBehaviour(new StaticVerBehaviour(this,272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 5)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 3)
            {
               camera.changeHorBehaviour(new StaticHorBehaviour(this,272 - camera.HALF_WIDTH));
               camera.changeVerBehaviour(new StaticVerBehaviour(this,272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
               this.CAMERA_AREA = 2;
            }
            else
            {
               camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
               camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            }
         }
         else if(SUB_LEVEL == 6)
         {
            camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
            camera.changeVerBehaviour(new StaticVerBehaviour(this,272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 7)
         {
            if(this.CAMERA_AREA > 0)
            {
               camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
            }
            else
            {
               camera.changeVerBehaviour(new StaticVerBehaviour(this,272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            }
         }
         else if(SUB_LEVEL == 8)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,264 - camera.HALF_WIDTH));
            camera.yPos = hero.yPos - camera.HALF_HEIGHT;
            camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,0));
            camera.BOTTOM_MARGIN = int(1008 + camera.getVerticalOffsetFromGroundLevel());
            camera.TOP_MARGIN = 32;
         }
         else if(SUB_LEVEL == 9)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,528 - camera.HALF_WIDTH));
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
         if(SUB_LEVEL == 5 || SUB_LEVEL == 6)
         {
            this.movingRock = new Vector.<BigIceBlockCollision>();
            for(i = 0; i < collisionsManager.collisions.length; i++)
            {
               if(collisionsManager.collisions[i] != null)
               {
                  if(collisionsManager.collisions[i] is BigIceBlockCollision)
                  {
                     this.movingRock.push(collisionsManager.collisions[i]);
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
         super.update();
         if(SUB_LEVEL != 1)
         {
            if(SUB_LEVEL == 2)
            {
               if(this.CAMERA_AREA == 0)
               {
                  if(hero.yPos <= 184 && hero.xPos >= 320)
                  {
                     this.do_not_reset_right_margin = true;
                     this.CAMERA_AREA = 1;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
               else if(this.CAMERA_AREA == 1)
               {
                  if(hero.yPos >= 200)
                  {
                     this.camera_reset_flag = false;
                     this.CAMERA_AREA = 0;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
                  camera.RIGHT_MARGIN *= 1.01;
                  if(camera.RIGHT_MARGIN >= levelData.RIGHT_MARGIN)
                  {
                     camera.RIGHT_MARGIN = levelData.RIGHT_MARGIN;
                  }
               }
               if(hero.xPos >= 960 && hero.xPos <= 1056 && (hero.yPos <= camera.yPos - 16 || hero.yPos <= 16))
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 3;
                  exit();
               }
               else if(hero.xPos >= 704 && hero.yPos >= 272 && hero.yPos >= camera.yPos + camera.HEIGHT)
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
            else if(SUB_LEVEL == 4)
            {
               if(this.CAMERA_AREA == 0)
               {
                  if(hero.stateMachine.currentState == "IS_CANNON_INSIDE_STATE")
                  {
                     this.CAMERA_AREA = 1;
                     tweenShift2 = new HorTweenShiftBehaviour(this);
                     tweenShift2.x_start = camera.x;
                     tweenShift2.x_end = 752 - int(camera.HALF_WIDTH);
                     tweenShift2.time = 0.5;
                     tweenShift2.tick = 0;
                     camera.changeHorBehaviour(tweenShift2);
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 192 - int(camera.HALF_HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
                  else if(hero.xPos <= 176 && hero.yPos <= 136)
                  {
                     this.CAMERA_AREA = 2;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
               else if(this.CAMERA_AREA == 1)
               {
                  if(hero.stateMachine.currentState == "IS_CANNON_SHOOT_STATE")
                  {
                     if(hero.xPos <= 648)
                     {
                        this.CAMERA_AREA = 2;
                        tweenShift = new VerTweenShiftBehaviour(this);
                        tweenShift.y_start = camera.y;
                        tweenShift.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                        tweenShift.time = 0.5;
                        tweenShift.tick = 0;
                        camera.changeVerBehaviour(tweenShift);
                        camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                     }
                  }
               }
               else if(this.CAMERA_AREA == 2)
               {
                  if(hero.stateMachine.currentState == "IS_CANNON_INSIDE_STATE")
                  {
                     this.CAMERA_AREA = 1;
                     tweenShift2 = new HorTweenShiftBehaviour(this);
                     tweenShift2.x_start = camera.x;
                     tweenShift2.x_end = 752 - int(camera.HALF_WIDTH);
                     tweenShift2.time = 0.5;
                     tweenShift2.tick = 0;
                     camera.changeHorBehaviour(tweenShift2);
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 192 - int(camera.HALF_HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
                  else if(hero.xPos <= 176 && hero.yPos >= 160)
                  {
                     this.CAMERA_AREA = 0;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                     camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  }
               }
            }
            else if(SUB_LEVEL == 5)
            {
               if(this.CAMERA_AREA == 0)
               {
                  if(hero.yPos >= 176)
                  {
                     this.CAMERA_AREA = 1;
                     for(i = 0; i < this.movingRock.length; i++)
                     {
                        this.movingRock[i].DO_NOT_MOVE = true;
                     }
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
                  if(hero.yPos <= 144)
                  {
                     for(i = 0; i < this.movingRock.length; i++)
                     {
                        this.movingRock[i].DO_NOT_MOVE = false;
                     }
                     this.CAMERA_AREA = 0;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
               if(hero.yPos >= camera.yPos + camera.HEIGHT)
               {
                  if(this.sfx_just_once)
                  {
                     if(hero.yPos >= camera.yPos + Utils.HEIGHT)
                     {
                        SoundSystem.PlaySound("flyingship_falldown");
                        this.sfx_just_once = false;
                     }
                  }
                  if(hero.xPos <= 400)
                  {
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 3;
                  }
                  else
                  {
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 5;
                  }
                  exit();
               }
            }
            else if(SUB_LEVEL == 6)
            {
               if(this.CAMERA_AREA == 0)
               {
                  if(camera.x >= 792 - camera.HALF_WIDTH || camera.x + camera.WIDTH >= camera.RIGHT_MARGIN)
                  {
                     camera.changeHorBehaviour(new StaticHorBehaviour(this,camera.x));
                     camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
                     camera.BOTTOM_MARGIN = camera.y + camera.HEIGHT;
                     this.CAMERA_AREA = 1;
                  }
                  else if(hero.yPos >= 304 && (hero.stateMachine.currentState == "IS_CANNON_INSIDE_STATE" || hero.stateMachine.currentState == "IS_CANNON_SHOOT_STATE"))
                  {
                     this.CAMERA_AREA = 5;
                     camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
                  }
               }
               else if(this.CAMERA_AREA == 1)
               {
                  if(hero.yPos <= 192 && hero.xPos <= camera.x + 64)
                  {
                     this.CAMERA_AREA = 0;
                     camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 272 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
                  else if(hero.xPos <= 712 && hero.yPos <= 96)
                  {
                     for(i = 0; i < this.movingRock.length; i++)
                     {
                        this.movingRock[i].DO_NOT_MOVE = true;
                     }
                     this.CAMERA_AREA = 2;
                     camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 96 - int(camera.HALF_HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
               else if(this.CAMERA_AREA == 2)
               {
                  if(hero.xPos >= 736)
                  {
                     if(camera.x >= 792 - camera.HALF_WIDTH || camera.x + camera.WIDTH >= camera.RIGHT_MARGIN)
                     {
                        for(i = 0; i < this.movingRock.length; i++)
                        {
                           this.movingRock[i].DO_NOT_MOVE = false;
                        }
                        this.CAMERA_AREA = 1;
                        camera.changeHorBehaviour(new StaticHorBehaviour(this,camera.x));
                        camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,-camera.getVerticalOffsetFromGroundLevel()));
                     }
                  }
                  else if(hero.stateMachine.currentState == "IS_CANNON_INSIDE_STATE")
                  {
                     this.CAMERA_AREA = 3;
                     camera.changeHorBehaviour(new CenteredProgressiveHorScrollBehaviour(this,-camera.WIDTH * 0.25));
                  }
               }
               else if(this.CAMERA_AREA == 3)
               {
                  if(hero.xPos <= 240)
                  {
                     this.CAMERA_AREA = 4;
                     camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 136 - int(camera.HALF_HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
               else if(this.CAMERA_AREA == 4)
               {
                  if(hero.yPos >= 208)
                  {
                     this.CAMERA_AREA = 0;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 272 - int(camera.HALF_HEIGHT);
                     tweenShift.time = 0.5;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                     for(i = 0; i < this.movingRock.length; i++)
                     {
                        this.movingRock[i].DO_NOT_MOVE = false;
                     }
                  }
               }
            }
            else if(SUB_LEVEL == 7)
            {
               if(this.CUTSCENE_FLAG_1 == false)
               {
                  if(hero.xPos >= 656 && Utils.LEVEL_LOCAL_PROGRESSION_1 == 0)
                  {
                     this.CUTSCENE_FLAG_1 = true;
                     Utils.LEVEL_LOCAL_PROGRESSION_1 = 1;
                     startCutscene(new MidBossCutscene(this));
                     for(i = 0; i < enemiesManager.enemies.length; i++)
                     {
                        if(enemiesManager.enemies[i] != null)
                        {
                           if(enemiesManager.enemies[i] is GiantCrabEnemy)
                           {
                              this.bossEnemy = enemiesManager.enemies[i] as GiantCrabEnemy;
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
               if(this.CAMERA_AREA == 0)
               {
                  if(hero.xPos >= 400)
                  {
                     camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this,0));
                     camera.BOTTOM_MARGIN = camera.y + camera.HEIGHT;
                     this.CAMERA_AREA = 1;
                  }
               }
               else if(this.CAMERA_AREA == 1)
               {
                  if(hero.xPos >= 624)
                  {
                  }
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
         array.push(new Point(0,0));
         array.push(new Point(0.05,1));
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
         if(SUB_LEVEL == 1 || SUB_LEVEL == 9)
         {
            return "outside_sea_night";
         }
         return "cave";
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
         return BackgroundsManager.SEASIDE_NIGHT;
      }
   }
}
