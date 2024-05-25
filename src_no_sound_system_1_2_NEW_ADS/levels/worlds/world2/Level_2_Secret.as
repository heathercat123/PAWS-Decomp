package levels.worlds.world2
{
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.*;
   import levels.cutscenes.world1.*;
   import levels.cutscenes.world2.MonkeyMinigameCutscene;
   import levels.items.BellItem;
   
   public class Level_2_Secret extends Level
   {
      
      public static const Map_2_secret_1:Class = Level_2_Secret_Map_2_secret_1;
      
      public static const Map_2_secret_2:Class = Level_2_Secret_Map_2_secret_2;
      
      public static const Map_2_secret_3:Class = Level_2_Secret_Map_2_secret_3;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      protected var CREATE_BRICKS_FLAG:Boolean;
      
      protected var IS_DONE:Boolean;
      
      protected var bricks_counter_1:int;
      
      protected var bricks_counter_2:int;
      
      public var directions:Array;
      
      public var choices:Array;
      
      protected var TO_CHECK:Boolean;
      
      protected var FALL_AMOUNT:int;
      
      public function Level_2_Secret(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.CAMERA_AREA = 0;
         this.FALL_AMOUNT = 0;
         this.sfx_just_once = true;
         this.TO_CHECK = true;
         this.directions = new Array(0,0,0,0,0,0,0,0);
         this.choices = new Array(0,0,0,0,0,0,0,0);
         this.CREATE_BRICKS_FLAG = this.IS_DONE = false;
         this.bricks_counter_1 = this.bricks_counter_2 = 0;
         super();
         IS_SECRET_LEVEL = true;
         this.CUTSCENE_FLAG_1 = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_secret_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_secret_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_secret_3.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_2_secret_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_2_secret_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_2_secret_3());
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
            camera.BOTTOM_MARGIN = 720 + camera.getVerticalOffsetFromGroundLevel();
         }
         else if(SUB_LEVEL == 2)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            camera.BOTTOM_MARGIN = 720 + 192 + camera.getVerticalOffsetFromGroundLevel();
         }
         else if(SUB_LEVEL == 3)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            camera.BOTTOM_MARGIN = 720 + 192 + 192 + camera.getVerticalOffsetFromGroundLevel();
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
         var velShift:VelShiftHorScrollBehaviour = null;
         var tweenShift:VerTweenShiftBehaviour = null;
         var tweenShift2:HorTweenShiftBehaviour = null;
         var i:int = 0;
         var IS_WRONG:Boolean = false;
         var l_index:int = 0;
         var bell_item:BellItem = null;
         super.update();
         var AMOUNT:int = 0;
         if(SUB_LEVEL == 2)
         {
            AMOUNT = 1;
         }
         else if(SUB_LEVEL == 3)
         {
            AMOUNT = 2;
         }
         if(SUB_LEVEL == 1 || SUB_LEVEL == 2 || SUB_LEVEL == 3)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.xPos >= 360 - 16)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift2 = new HorTweenShiftBehaviour(this);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = 488 - camera.HALF_WIDTH;
                  tweenShift2.time = 0.75;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
                  if(this.CUTSCENE_FLAG_1 == false)
                  {
                     this.CUTSCENE_FLAG_1 = true;
                     startCutscene(new MonkeyMinigameCutscene(this));
                  }
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.xPos <= 368 - 32)
               {
                  this.CAMERA_AREA = 0;
                  velShift = new VelShiftHorScrollBehaviour(this);
                  camera.changeHorBehaviour(velShift);
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = int(160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT));
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0.75;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
         }
         if(hero.yPos >= 176 + 192 * this.FALL_AMOUNT)
         {
            if(hero.stateMachine.currentState == "IS_FALLING_STATE" && this.TO_CHECK == false)
            {
               if(hero.getMidXPos() <= 456)
               {
                  this.TO_CHECK = true;
                  this.choices[this.FALL_AMOUNT] = -1;
                  ++this.FALL_AMOUNT;
               }
               else if(hero.getMidXPos() >= 520)
               {
                  this.TO_CHECK = true;
                  this.choices[this.FALL_AMOUNT] = 1;
                  ++this.FALL_AMOUNT;
               }
            }
            else
            {
               this.TO_CHECK = false;
            }
         }
         if(hero.yPos >= 688 + AMOUNT * 192 && this.BONUS_FLAG == false)
         {
            this.BONUS_FLAG = true;
            IS_WRONG = false;
            for(i = 0; i < this.choices.length; i++)
            {
               if(this.choices[i] != this.directions[i])
               {
                  IS_WRONG = true;
               }
            }
            if(!IS_WRONG)
            {
               l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
               bell_item = new BellItem(this,392,704 + AMOUNT * 192,0 + AMOUNT);
               bell_item.level_index = l_index;
               bell_item.stateMachine.setState("IS_BONUS_STATE");
               bell_item.updateScreenPosition(this.camera);
               itemsManager.items.push(bell_item);
            }
            else
            {
               SoundSystem.PlaySound("error");
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         array.push(new Point(0.05,0));
         array.push(new Point(0.4,1));
         array.push(new Point(1,1));
         array.push(new Point(0.8,1));
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
