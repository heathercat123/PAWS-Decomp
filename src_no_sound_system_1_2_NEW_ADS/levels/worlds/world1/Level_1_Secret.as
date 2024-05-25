package levels.worlds.world1
{
   import entities.*;
   import entities.enemies.*;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.*;
   import levels.items.*;
   
   public class Level_1_Secret extends Level
   {
      
      public static const Map_1_secret_1:Class = Level_1_Secret_Map_1_secret_1;
      
      public static const Map_1_secret_2:Class = Level_1_Secret_Map_1_secret_2;
      
      public static const Map_1_secret_3:Class = Level_1_Secret_Map_1_secret_3;
       
      
      public var CUTSCENE_FLAG:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      public function Level_1_Secret(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.sfx_just_once = true;
         super();
         IS_SECRET_LEVEL = true;
         this.CUTSCENE_FLAG = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         this.CAMERA_AREA = 0;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_secret_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_secret_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_secret_3.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_1_secret_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_1_secret_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_1_secret_3());
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
         if(SUB_LEVEL == 2 || SUB_LEVEL == 3)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else
         {
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
      }
      
      override public function update() : void
      {
         var tweenShift:VerTweenShiftBehaviour = null;
         var l_index:int = 0;
         var bell_item:BellItem = null;
         super.update();
         if(SUB_LEVEL != 1)
         {
            if(SUB_LEVEL == 2)
            {
               if(this.CAMERA_AREA == 0)
               {
                  if(hero.yPos <= 88)
                  {
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.yPos;
                     tweenShift.y_end = 96 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     camera.changeVerBehaviour(tweenShift,false);
                     this.CAMERA_AREA = 1;
                  }
               }
               else if(this.CAMERA_AREA == 1)
               {
                  if(hero.yPos >= 112)
                  {
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.yPos;
                     tweenShift.y_end = 208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     camera.changeVerBehaviour(tweenShift,false);
                     this.CAMERA_AREA = 0;
                  }
               }
            }
            else if(SUB_LEVEL == 3)
            {
               if(this.CAMERA_AREA == 0)
               {
                  if(hero.yPos <= 88 + 16)
                  {
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.yPos;
                     tweenShift.y_end = 96 + 16 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     camera.changeVerBehaviour(tweenShift,false);
                     this.CAMERA_AREA = 1;
                  }
               }
               else if(this.CAMERA_AREA == 1)
               {
                  if(hero.xPos < 640 || hero.xPos > 1056)
                  {
                     if(hero.yPos >= 112 + 16)
                     {
                        tweenShift = new VerTweenShiftBehaviour(this);
                        tweenShift.y_start = camera.yPos;
                        tweenShift.y_end = 208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                        tweenShift.time = 0.75;
                        camera.changeVerBehaviour(tweenShift,false);
                        this.CAMERA_AREA = 0;
                     }
                  }
               }
               if(this.sfx_just_once)
               {
                  if(hero.yPos >= 176)
                  {
                     if(hero.xPos >= 640 && hero.xPos <= 1056 && Boolean(hero.yPos))
                     {
                        if(hero.yPos >= camera.yPos + Utils.HEIGHT)
                        {
                           SoundSystem.PlaySound("flyingship_falldown");
                           this.sfx_just_once = false;
                        }
                        Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 4;
                        exit();
                     }
                  }
               }
               if(hero.xPos >= 1408)
               {
                  if(this.BONUS_FLAG == false)
                  {
                     if(Utils.SLEEPING_POLLEN_HIT == false)
                     {
                        this.BONUS_FLAG = true;
                        l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
                        bell_item = new BellItem(this,1552,80,2);
                        bell_item.level_index = l_index;
                        bell_item.stateMachine.setState("IS_BONUS_STATE");
                        bell_item.updateScreenPosition(this.camera);
                        itemsManager.items.push(bell_item);
                     }
                     else
                     {
                        this.BONUS_FLAG = true;
                        SoundSystem.PlaySound("error");
                     }
                  }
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         array.push(new Point(0.15,1));
         array.push(new Point(0.3,1));
         array.push(new Point(1,1));
         array.push(new Point(0.6,1));
         return array;
      }
      
      override public function getMusicName() : String
      {
         if(Utils.Slot.gameProgression[3] == 0)
         {
            return "outside_trees";
         }
         return "woods";
      }
      
      override public function playMusic() : void
      {
         if(Utils.Slot.gameProgression[3] == 0)
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
         return BackgroundsManager.TURNIP_GARDEN_WITH_CLOUDS_POLLEN;
      }
   }
}
