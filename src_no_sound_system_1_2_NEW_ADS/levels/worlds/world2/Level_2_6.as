package levels.worlds.world2
{
   import entities.Hero;
   import entities.enemies.GiantPollenEnemy;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.*;
   import levels.cutscenes.world1.*;
   import levels.items.BellItem;
   
   public class Level_2_6 extends Level
   {
      
      public static const Map_2_6_1:Class = Level_2_6_Map_2_6_1;
      
      public static const Map_2_6_2:Class = Level_2_6_Map_2_6_2;
      
      public static const Map_2_6_3:Class = Level_2_6_Map_2_6_3;
      
      public static const Map_2_6_4:Class = Level_2_6_Map_2_6_4;
      
      public static const Map_2_6_5:Class = Level_2_6_Map_2_6_5;
      
      public static const Map_2_6_6:Class = Level_2_6_Map_2_6_6;
      
      public static const Map_2_6_7:Class = Level_2_6_Map_2_6_7;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      protected var enemy:GiantPollenEnemy;
      
      protected var CREATE_BRICKS_FLAG:Boolean;
      
      protected var IS_DONE:Boolean;
      
      protected var bricks_counter_1:int;
      
      protected var bricks_counter_2:int;
      
      public function Level_2_6(_sub_level:int)
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
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_6_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_6_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_6_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_6_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_6_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_6_6xml");
            }
            else if(SUB_LEVEL == 7)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_6_7xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_2_6_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_2_6_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_2_6_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_2_6_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_2_6_5());
            }
            else if(SUB_LEVEL == 6)
            {
               map = new XML(new Map_2_6_6());
            }
            else if(SUB_LEVEL == 7)
            {
               map = new XML(new Map_2_6_7());
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
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 0)
            {
               camera.RIGHT_MARGIN = 544;
            }
            else
            {
               camera.LEFT_MARGIN = 544;
            }
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 2 || SUB_LEVEL == 5)
         {
            if(SUB_LEVEL == 2)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 3)
               {
                  camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
               }
               camera.changeVerBehaviour(new StaticVerBehaviour(this,200 - int(camera.HALF_HEIGHT)));
            }
            else
            {
               camera.changeVerBehaviour(new StaticVerBehaviour(this,200 - int(camera.HALF_HEIGHT)));
            }
            camera.TOP_MARGIN = 32;
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,104 - int(camera.HALF_HEIGHT)));
            camera.TOP_MARGIN = 32;
         }
         else if(SUB_LEVEL == 4 || SUB_LEVEL == 7)
         {
            camera.changeVerBehaviour(new CenteredVerScrollBehaviour(this));
            camera.TOP_MARGIN = 32;
         }
         else if(SUB_LEVEL == 6)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,int(288 - camera.HALF_WIDTH)));
            camera.BOTTOM_MARGIN = 336 + camera.getVerticalOffsetFromGroundLevel();
            camera.TOP_MARGIN = 32;
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
         if(SUB_LEVEL == 7)
         {
            for(i = 0; i < enemiesManager.enemies.length; i++)
            {
               if(enemiesManager.enemies[i] != null)
               {
                  if(enemiesManager.enemies[i] is GiantPollenEnemy)
                  {
                     this.enemy = enemiesManager.enemies[i];
                  }
               }
            }
         }
      }
      
      override public function update() : void
      {
         var tweenShift:VerTweenShiftBehaviour = null;
         var tweenShift2:HorTweenShiftBehaviour = null;
         var level_condition:Boolean = false;
         var x_t:int = 0;
         var y_t:int = 0;
         var tile_value:int = 0;
         var l_index:int = 0;
         var item:BellItem = null;
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8 && (Hero.GetCurrentCat() == Hero.CAT_MARA || hero.xPos >= 570.5))
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
         else if(SUB_LEVEL == 2 || SUB_LEVEL == 5)
         {
            if(this.CAMERA_AREA == 0)
            {
               level_condition = true;
               if(SUB_LEVEL == 5 && hero.getMidXPos() > 1240)
               {
                  level_condition = false;
               }
               if(hero.getMidXPos() >= 400 && hero.getMidYPos() <= 144 && level_condition)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = int(80 - camera.HALF_HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.getMidXPos() >= 400 && hero.getMidYPos() >= 168)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = int(200 - camera.HALF_HEIGHT);
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
               if(hero.getMidXPos() >= 400 && hero.getMidYPos() >= 168)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = int(200 - camera.HALF_HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.getMidYPos() <= 144)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = int(80 - camera.HALF_HEIGHT);
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
               if(hero.getMidXPos() >= 464 && hero.getMidYPos() >= 160)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift2 = new HorTweenShiftBehaviour(this,1);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = int(1400 - camera.WIDTH * 0.5);
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
         else if(SUB_LEVEL == 7)
         {
            if(!this.BONUS_FLAG)
            {
               if(this.enemy.stateMachine.currentState == "IS_HIT_STATE")
               {
                  this.BONUS_FLAG = true;
                  l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
                  if(Utils.LEVEL_ITEMS[l_index] == false)
                  {
                     item = new BellItem(this,this.enemy.xPos + this.enemy.WIDTH * 0.5,176,2);
                     item.level_index = l_index;
                     item.stateMachine.setState("IS_BONUS_STATE");
                     item.updateScreenPosition(camera);
                     itemsManager.items.push(item);
                  }
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         array.push(new Point(0.6,0.6));
         array.push(new Point(0.8,0.8));
         array.push(new Point(1,1));
         array.push(new Point(0.95,0.95));
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         return new Point(1.2,1);
      }
      
      override public function getMusicName() : String
      {
         if(SUB_LEVEL == 1)
         {
            return "outside_sea";
         }
         return "ocean";
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
         if(SUB_LEVEL == 1)
         {
            return BackgroundsManager.SEASIDE;
         }
         return BackgroundsManager.UNDERWATER;
      }
   }
}
