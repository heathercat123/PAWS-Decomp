package levels.worlds.world2
{
   import flash.events.Event;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.CenteredProgressiveVerScrollBehaviour;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.cameras.behaviours.StaticHorBehaviour;
   import levels.cameras.behaviours.StaticVerBehaviour;
   import levels.cameras.behaviours.TunnelVelShiftVerScrollBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   import levels.cameras.behaviours.VerTweenShiftBehaviour;
   import levels.collisions.SmallBrickCollision;
   
   public class Level_2_1 extends Level
   {
      
      public static const Map_2_1_1:Class = Level_2_1_Map_2_1_1;
      
      public static const Map_2_1_2:Class = Level_2_1_Map_2_1_2;
      
      public static const Map_2_1_3:Class = Level_2_1_Map_2_1_3;
      
      public static const Map_2_1_4:Class = Level_2_1_Map_2_1_4;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      protected var CREATE_BRICKS_FLAG:Boolean;
      
      protected var IS_DONE:Boolean;
      
      protected var bricks_counter_1:int;
      
      protected var bricks_counter_2:int;
      
      public function Level_2_1(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.CAMERA_AREA = 0;
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
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_1_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_1_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_1_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_1_4.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_2_1_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_2_1_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_2_1_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_2_1_4());
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
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 2)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,320 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 4)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,192 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            camera.LEFT_MARGIN = 176;
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
         var x_t:int = 0;
         var y_t:int = 0;
         var tile_value:int = 0;
         var brick:SmallBrickCollision = null;
         super.update();
         if(SUB_LEVEL == 1)
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
                  tweenShift.y_end = 160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
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
               if(hero.getMidXPos() >= 448)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift2 = new HorTweenShiftBehaviour(this,1);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = int(1600 - camera.WIDTH * 0.5);
                  if(tweenShift2.x_end + camera.WIDTH >= levelData.RIGHT_MARGIN)
                  {
                     tweenShift2.x_end = levelData.RIGHT_MARGIN - camera.WIDTH;
                  }
                  tweenShift2.time = (tweenShift2.x_end - tweenShift2.x_start) / 24;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               camera.RIGHT_MARGIN = camera.x + Utils.WIDTH + 2;
               camera.LEFT_MARGIN = camera.x;
               x_t = hero.getMidXPos() / Utils.TILE_WIDTH;
               y_t = hero.getMidYPos() / Utils.TILE_HEIGHT;
               tile_value = levelData.getTileValueAt(x_t + 1,y_t);
               if(tile_value != 0 && hero.xPos <= camera.x + 4)
               {
                  hero.gameOver(camera.x,hero.getMidYPos(),true);
                  camera.changeHorBehaviour(new StaticHorBehaviour(this,camera.x));
                  this.CAMERA_AREA = 100;
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(hero.xPos >= 896 && !this.CREATE_BRICKS_FLAG)
            {
               this.CREATE_BRICKS_FLAG = true;
               this.bricks_counter_1 = this.bricks_counter_2 = 0;
            }
            if(this.CAMERA_AREA == 0)
            {
               if(camera.x >= 416 - camera.WIDTH * 0.5)
               {
                  this.CAMERA_AREA = 1;
                  camera.changeHorBehaviour(new StaticHorBehaviour(this,416 - camera.WIDTH * 0.5));
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
                  camera.BOTTOM_MARGIN = camera.y + camera.HEIGHT;
                  camera.LEFT_MARGIN = camera.x;
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.xPos <= camera.x + 16)
               {
                  camera.LEFT_MARGIN = levelData.LEFT_MARGIN;
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  this.CAMERA_AREA = 0;
               }
               else if(hero.xPos >= 464)
               {
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  camera.changeVerBehaviour(new CenteredProgressiveVerScrollBehaviour(this));
                  this.CAMERA_AREA = 2;
               }
            }
            else if(this.CAMERA_AREA == 2)
            {
               if(hero.xPos <= 464 && hero.yPos >= 208)
               {
                  this.CAMERA_AREA = 1;
               }
               else if(camera.x >= 952 - camera.WIDTH * 0.5)
               {
                  this.CAMERA_AREA = 3;
                  camera.changeHorBehaviour(new StaticHorBehaviour(this,952 - camera.WIDTH * 0.5));
                  camera.LEFT_MARGIN = camera.x;
               }
            }
            else if(this.CAMERA_AREA == 3)
            {
               if(hero.xPos >= 1056)
               {
                  camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 336 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
                  this.CAMERA_AREA = 4;
               }
            }
            else if(this.CAMERA_AREA == 4)
            {
               ++camera.BOTTOM_MARGIN;
               if(camera.BOTTOM_MARGIN >= levelData.BOTTOM_MARGIN)
               {
                  camera.BOTTOM_MARGIN = levelData.BOTTOM_MARGIN;
               }
            }
         }
         if(this.CREATE_BRICKS_FLAG && !this.IS_DONE)
         {
            if(this.bricks_counter_1-- <= 0)
            {
               this.bricks_counter_1 = 15;
               if(this.bricks_counter_2 == 0)
               {
                  brick = new SmallBrickCollision(this,832,256);
                  brick.updateScreenPosition(camera);
                  collisionsManager.collisions.push(brick);
                  brick = new SmallBrickCollision(this,832 + 16,256);
                  brick.updateScreenPosition(camera);
                  collisionsManager.collisions.push(brick);
               }
               else if(this.bricks_counter_2 == 1)
               {
                  brick = new SmallBrickCollision(this,832,256 + 16);
                  brick.updateScreenPosition(camera);
                  collisionsManager.collisions.push(brick);
                  brick = new SmallBrickCollision(this,832 + 16,256 + 16);
                  brick.updateScreenPosition(camera);
                  collisionsManager.collisions.push(brick);
                  this.IS_DONE = true;
               }
               ++this.bricks_counter_2;
            }
         }
         else if(SUB_LEVEL == 4)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.xPos <= 192)
               {
                  this.CUTSCENE_FLAG_1 = true;
               }
            }
            if(this.CUTSCENE_FLAG_1)
            {
               camera.LEFT_MARGIN *= 0.8;
               if(camera.LEFT_MARGIN <= levelData.LEFT_MARGIN)
               {
                  camera.LEFT_MARGIN = levelData.LEFT_MARGIN;
               }
            }
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
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 192 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 3)
         {
            array.push(new Point(0.05,0.05));
            array.push(new Point(0.4,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         else
         {
            array.push(new Point(0.05,1));
            array.push(new Point(0.4,1));
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
         return "beach";
      }
      
      override public function playMusic() : void
      {
         SoundSystem.PlayMusic(this.getMusicName());
      }
      
      override public function getBackgroundId() : int
      {
         return BackgroundsManager.SEASIDE;
      }
   }
}
