package levels.worlds.world1
{
   import entities.Entity;
   import entities.enemies.BossSpiderEnemy;
   import entities.enemies.GiantPollenEnemy;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.backgrounds.RainWoodsBackground;
   import levels.cameras.behaviours.StaticVerBehaviour;
   import levels.cameras.behaviours.VelShiftCenteredHorScrollBehaviour;
   import levels.cameras.behaviours.VelShiftHorScrollBehaviour;
   import levels.cutscenes.MidBossCutscene;
   import levels.cutscenes.world1.*;
   import levels.items.BellItem;
   
   public class Level_1_1 extends Level
   {
      
      public static const Map_1_1_1:Class = Level_1_1_Map_1_1_1;
      
      public static const Map_1_1_2:Class = Level_1_1_Map_1_1_2;
      
      public static const Map_1_1_3:Class = Level_1_1_Map_1_1_3;
      
      public static const Map_1_1_4:Class = Level_1_1_Map_1_1_4;
      
      public static const Map_1_1_5:Class = Level_1_1_Map_1_1_5;
       
      
      public var CUTSCENE_FLAG:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var enemy:GiantPollenEnemy;
      
      protected var bossEnemy:BossSpiderEnemy;
      
      protected var just_once:Boolean = true;
      
      public function Level_1_1(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.bossEnemy = null;
         super();
         this.CUTSCENE_FLAG = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         this.enemy = null;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_1_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_1_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_1_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_1_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_1_5.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_1_1_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_1_1_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_1_1_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_1_1_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_1_1_5());
            }
            this.levelLoaded();
         }
      }
      
      override public function levelLoaded() : void
      {
         this.init();
         if(SUB_LEVEL == 1)
         {
            RainWoodsBackground(backgroundsManager.background).setStrongRain();
         }
         camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         if(SUB_LEVEL == 3)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 3)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
         }
         else if(SUB_LEVEL == 4)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 5)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
         }
         LEVEL_LOADED = true;
      }
      
      override public function exitLevel() : void
      {
         this.enemy = null;
         super.exitLevel();
      }
      
      override public function init() : void
      {
         var i:int = 0;
         super.init();
         if(SUB_LEVEL == 4)
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
         else if(SUB_LEVEL == 3)
         {
            if(Utils.Slot.levelUnlocked[1] == true)
            {
               for(i = 0; i < enemiesManager.enemies.length; i++)
               {
                  if(enemiesManager.enemies[i] != null)
                  {
                     if(enemiesManager.enemies[i].xPos <= 320)
                     {
                        enemiesManager.enemies[i].path_end_x = 2300;
                        enemiesManager.enemies[i].DIRECTION = Entity.RIGHT;
                     }
                  }
               }
            }
         }
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var l_index:int = 0;
         var item:BellItem = null;
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(this.just_once)
            {
               if(!this.CUTSCENE_FLAG)
               {
                  this.CUTSCENE_FLAG = true;
                  startCutscene(new Intro1Cutscene(this));
               }
            }
         }
         else if(SUB_LEVEL == 4)
         {
            if(!this.BONUS_FLAG)
            {
               if(this.enemy.stateMachine.currentState == "IS_HIT_STATE")
               {
                  this.BONUS_FLAG = true;
                  l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
                  if(Utils.LEVEL_ITEMS[l_index] == false)
                  {
                     item = new BellItem(this,this.enemy.xPos + this.enemy.WIDTH * 0.5,this.enemy.yPos - 16,2);
                     item.level_index = l_index;
                     item.entity = this.enemy;
                     item.stateMachine.setState("IS_BONUS_STATE");
                     item.updateScreenPosition(camera);
                     itemsManager.items.push(item);
                  }
               }
            }
         }
         else if(SUB_LEVEL == 5)
         {
            if(this.CUTSCENE_FLAG == false)
            {
               if(hero.xPos >= 768 && Utils.LEVEL_LOCAL_PROGRESSION_1 == 0)
               {
                  this.CUTSCENE_FLAG = true;
                  startCutscene(new MidBossCutscene(this));
                  Utils.LEVEL_LOCAL_PROGRESSION_1 = 1;
                  for(i = 0; i < enemiesManager.enemies.length; i++)
                  {
                     if(enemiesManager.enemies[i] != null)
                     {
                        if(enemiesManager.enemies[i] is BossSpiderEnemy)
                        {
                           this.bossEnemy = enemiesManager.enemies[i] as BossSpiderEnemy;
                        }
                     }
                  }
               }
            }
            if(this.CUTSCENE_FLAG_2 == false)
            {
               if(this.bossEnemy != null)
               {
                  if(this.bossEnemy.stateMachine.currentState == "IS_DEAD_STATE")
                  {
                     if(hero.stateMachine.currentState != "IS_GAME_OVER_STATE")
                     {
                        this.CUTSCENE_FLAG_2 = true;
                        startCutscene(new MidBossCutscene(this,true));
                     }
                  }
               }
            }
         }
      }
      
      override public function setCameraBehaviours() : void
      {
         if(SUB_LEVEL == 5)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            camera.changeHorBehaviour(new VelShiftHorScrollBehaviour(this));
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 5)
         {
            array.push(new Point(0.4,1));
            array.push(new Point(0.6,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         else
         {
            array.push(new Point(0.4,1));
            array.push(new Point(0.5,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         return array;
      }
      
      override public function getMusicName() : String
      {
         if(SUB_LEVEL == 1)
         {
            return "outside_rain";
         }
         return "rain";
      }
      
      override public function playMusic() : void
      {
         if(SUB_LEVEL == 1)
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
         return BackgroundsManager.RAIN_WOODS;
      }
   }
}
