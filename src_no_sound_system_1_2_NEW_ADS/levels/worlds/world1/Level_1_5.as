package levels.worlds.world1
{
   import entities.Entity;
   import entities.npcs.CatNPC;
   import entities.npcs.GenericNPC;
   import entities.npcs.HelperNPC;
   import entities.npcs.TwelveNPC;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.backgrounds.BackgroundsManager;
   import levels.cameras.behaviours.StaticHorBehaviour;
   import levels.cameras.behaviours.StaticVerBehaviour;
   import levels.cameras.behaviours.VelShiftCenteredHorScrollBehaviour;
   import levels.collisions.ClodCollision;
   import levels.cutscenes.ElevatorCutscene;
   import levels.cutscenes.world1.*;
   import levels.items.BellItem;
   import levels.items.KeyItem;
   
   public class Level_1_5 extends Level
   {
      
      public static const Map_1_5_1:Class = Level_1_5_Map_1_5_1;
      
      public static const Map_1_5_2:Class = Level_1_5_Map_1_5_2;
      
      public static const Map_1_5_3:Class = Level_1_5_Map_1_5_3;
      
      public static const Map_1_5_4:Class = Level_1_5_Map_1_5_4;
      
      public static const Map_1_5_5:Class = Level_1_5_Map_1_5_5;
      
      public static const Map_1_5_6:Class = Level_1_5_Map_1_5_6;
      
      public static const Map_1_5_7:Class = Level_1_5_Map_1_5_7;
      
      public static const Map_1_5_8:Class = Level_1_5_Map_1_5_8;
      
      public static const Map_1_5_9:Class = Level_1_5_Map_1_5_9;
      
      public static const Map_1_5_10:Class = Level_1_5_Map_1_5_10;
      
      public static const Map_1_5_11:Class = Level_1_5_Map_1_5_11;
      
      public static const Map_1_5_12:Class = Level_1_5_Map_1_5_12;
      
      public static const Map_1_5_13:Class = Level_1_5_Map_1_5_13;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var CUTSCENE_FLAG_3:Boolean;
      
      public var CUTSCENE_FLAG_4:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      public var CUTSCENE_CONDITION_1:Boolean;
      
      protected var sub_counter_1:int;
      
      protected var sub_counter_2:int;
      
      protected var cutscene_counter_1:int;
      
      public function Level_1_5(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.cutscene_counter_1 = 0;
         this.sub_counter_1 = this.sub_counter_2 = 0;
         super();
         this.CUTSCENE_FLAG_1 = this.CUTSCENE_FLAG_2 = this.CUTSCENE_FLAG_3 = this.CUTSCENE_FLAG_4 = false;
         this.CUTSCENE_CONDITION_1 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_6.xml");
            }
            else if(SUB_LEVEL == 7)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_7.xml");
            }
            else if(SUB_LEVEL == 8)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_8.xml");
            }
            else if(SUB_LEVEL == 9)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_9.xml");
            }
            else if(SUB_LEVEL == 10)
            {
               Utils.IS_DARK = true;
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_10.xml");
            }
            else if(SUB_LEVEL == 11)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_11.xml");
            }
            else if(SUB_LEVEL == 12)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_12.xml");
            }
            else if(SUB_LEVEL == 13)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_1/1_5_13.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_1_5_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_1_5_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_1_5_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_1_5_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_1_5_5());
            }
            else if(SUB_LEVEL == 6)
            {
               map = new XML(new Map_1_5_6());
            }
            else if(SUB_LEVEL == 7)
            {
               map = new XML(new Map_1_5_7());
            }
            else if(SUB_LEVEL == 8)
            {
               map = new XML(new Map_1_5_8());
            }
            else if(SUB_LEVEL == 9)
            {
               map = new XML(new Map_1_5_9());
            }
            else if(SUB_LEVEL == 10)
            {
               Utils.IS_DARK = true;
               map = new XML(new Map_1_5_10());
            }
            else if(SUB_LEVEL == 11)
            {
               map = new XML(new Map_1_5_11());
            }
            else if(SUB_LEVEL == 12)
            {
               map = new XML(new Map_1_5_12());
            }
            else if(SUB_LEVEL == 13)
            {
               map = new XML(new Map_1_5_13());
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
         if(SUB_LEVEL == 1 || SUB_LEVEL == 3 || SUB_LEVEL == 4)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
            if(SUB_LEVEL == 3 || SUB_LEVEL == 4)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 1)
               {
                  camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
               }
            }
         }
         else if(SUB_LEVEL == 5 || SUB_LEVEL == 6 || SUB_LEVEL == 11 || SUB_LEVEL == 13)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
         }
         else if(SUB_LEVEL == 12)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,272 - int(Utils.WIDTH * 0.5)));
            camera.changeVerBehaviour(new StaticVerBehaviour(this,176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
         }
         else if(SUB_LEVEL == 2 || SUB_LEVEL == 8)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,288 - int(Utils.WIDTH * 0.5)),true);
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
         }
         else if(SUB_LEVEL == 7)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] != 4)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
         }
         else if(SUB_LEVEL == 9)
         {
            camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)),true);
         }
         else if(SUB_LEVEL == 10)
         {
         }
      }
      
      override public function exitLevel() : void
      {
         super.exitLevel();
      }
      
      override public function init() : void
      {
         var i:int = 0;
         var l_index:int = 0;
         var bell_item:BellItem = null;
         var rigsNPC:CatNPC = null;
         var item:KeyItem = null;
         super.init();
         if(SUB_LEVEL == 1)
         {
            if(Utils.Slot.gameProgression[2] == 0)
            {
               for(i = 0; i < npcsManager.npcs.length; i++)
               {
                  if(npcsManager.npcs[i] is GenericNPC)
                  {
                     if(GenericNPC(npcsManager.npcs[i]).NPC_TYPE == GenericNPC.NPC_ACORN_SMALL)
                     {
                        npcsManager.npcs[i].dead = true;
                     }
                  }
                  else if(npcsManager.npcs[i] is HelperNPC)
                  {
                     npcsManager.npcs[i].dead = true;
                  }
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(Utils.Slot.gameProgression[6] == 0)
            {
               for(i = 0; i < npcsManager.npcs.length; i++)
               {
                  if(npcsManager.npcs[i] is GenericNPC)
                  {
                     if(GenericNPC(npcsManager.npcs[i]).xPos <= 325)
                     {
                        npcsManager.npcs[i].dead = true;
                     }
                  }
               }
               rigsNPC = new CatNPC(this,264,144,Entity.RIGHT,0,CatNPC.RIGS);
               rigsNPC.updateScreenPosition(camera);
               npcsManager.npcs.push(rigsNPC);
               rigsNPC.stateMachine.setState("IS_STANDING_STATE");
            }
         }
         else if(SUB_LEVEL != 5)
         {
            if(SUB_LEVEL == 6)
            {
               if(Utils.Slot.gameProgression[6] >= 2)
               {
                  for(i = 0; i < npcsManager.npcs.length; i++)
                  {
                     if(npcsManager.npcs[i] is TwelveNPC)
                     {
                        npcsManager.npcs[i].dead = true;
                     }
                     else if(npcsManager.npcs[i] is GenericNPC)
                     {
                        npcsManager.npcs[i].stringId = 1;
                        if(Utils.Slot.levelUnlocked[8])
                        {
                           npcsManager.npcs[i].stringId = 2;
                        }
                     }
                  }
                  if(Utils.Slot.gameProgression[6] == 2)
                  {
                     l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
                     if(Utils.LEVEL_ITEMS[l_index] == false)
                     {
                        item = new KeyItem(this,272,160,1);
                        item.level_index = l_index;
                        item.updateScreenPosition(camera);
                        itemsManager.items.push(item);
                        item.onTop();
                     }
                  }
               }
            }
            else if(SUB_LEVEL != 7)
            {
               if(SUB_LEVEL == 8)
               {
                  if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
                  {
                     if(Utils.Slot.gameProgression[21] == 1)
                     {
                        for(i = 0; i < npcsManager.npcs.length; i++)
                        {
                           if(npcsManager.npcs[i] != null)
                           {
                              npcsManager.npcs[i].stringId = 1;
                           }
                        }
                     }
                  }
               }
               else if(SUB_LEVEL == 10)
               {
                  if(Utils.Slot.gameProgression[19] == 1 || Utils.Slot.playerInventory[LevelItems.ITEM_ICE_CREAM_1] > 0)
                  {
                     for(i = 0; i < npcsManager.npcs.length; i++)
                     {
                        if(npcsManager.npcs[i] != null)
                        {
                           npcsManager.npcs[i].stringId = 0;
                        }
                     }
                  }
                  if(Utils.Slot.gameProgression[19] == 1)
                  {
                     l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
                     if(Utils.LEVEL_ITEMS[l_index] == false)
                     {
                        bell_item = new BellItem(this,544,96,2);
                        bell_item.level_index = l_index;
                        bell_item.updateScreenPosition(camera);
                        itemsManager.items.push(bell_item);
                     }
                  }
               }
               else if(SUB_LEVEL == 13)
               {
                  if(Utils.Slot.gameProgression[18] == 1)
                  {
                     for(i = 0; i < npcsManager.npcs.length; i++)
                     {
                        if(npcsManager.npcs[i] != null)
                        {
                           if(npcsManager.npcs[i].xPos < 416)
                           {
                              npcsManager.npcs[i].stringId = 7;
                           }
                        }
                     }
                     l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
                     if(Utils.LEVEL_ITEMS[l_index] == false)
                     {
                        bell_item = new BellItem(this,240,112,1);
                        bell_item.level_index = l_index;
                        bell_item.updateScreenPosition(camera);
                        itemsManager.items.push(bell_item);
                     }
                  }
               }
            }
         }
      }
      
      override public function update() : void
      {
         var mid_x:Number = NaN;
         var i:int = 0;
         var amount:int = 0;
         var flowers_amount:int = 0;
         var cD:ClodCollision = null;
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(Utils.Slot.gameProgression[2] == 0)
            {
               if(!this.CUTSCENE_FLAG_1)
               {
                  if(hero.xPos >= 792)
                  {
                     this.CUTSCENE_FLAG_1 = true;
                     startCutscene(new ShopIntroCutscene(this));
                  }
               }
            }
         }
         else if(SUB_LEVEL == 3 || SUB_LEVEL == 4)
         {
            if(stateMachine.currentState == "IS_PLAYING_STATE")
            {
               if(Utils.Slot.gameProgression[6] == 0)
               {
                  if(!this.CUTSCENE_FLAG_2)
                  {
                     this.CUTSCENE_FLAG_2 = true;
                     startCutscene(new GenericWorld1Cutscene(this));
                  }
               }
            }
            if(SUB_LEVEL != 3)
            {
               if(SUB_LEVEL == 4)
               {
               }
            }
            if(this.CUTSCENE_CONDITION_1)
            {
               if(!this.CUTSCENE_FLAG_1)
               {
                  mid_x = hero.getMidXPos();
                  if(mid_x >= 448 - 32 && mid_x <= 512 - 32)
                  {
                     if(hero.stateMachine.currentState == "IS_STANDING_STATE")
                     {
                        this.CUTSCENE_FLAG_1 = true;
                        startCutscene(new ElevatorCutscene(this));
                     }
                  }
               }
            }
            else if(hero.xPos <= 448 - 32 || hero.xPos >= 512 - 32)
            {
               this.CUTSCENE_CONDITION_1 = true;
            }
         }
         else if(SUB_LEVEL != 5)
         {
            if(SUB_LEVEL == 6)
            {
               if(stateMachine.currentState == "IS_PLAYING_STATE")
               {
                  if(Utils.Slot.gameProgression[6] == 1)
                  {
                     if(!this.CUTSCENE_FLAG_1)
                     {
                        this.CUTSCENE_FLAG_1 = true;
                        startCutscene(new GenericWorld1Cutscene(this));
                     }
                  }
               }
            }
            else if(SUB_LEVEL == 8)
            {
               if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
               {
                  if(hero.xPos >= 304 && Utils.Slot.gameProgression[21] == 0 && !this.CUTSCENE_FLAG_1)
                  {
                     amount = 0;
                     for(i = 0; i < 10; i++)
                     {
                        if((Utils.Slot.gameProgression[20] >> i & 1) == 1)
                        {
                           amount++;
                        }
                     }
                     if(amount >= 10)
                     {
                        this.CUTSCENE_FLAG_1 = true;
                        startCutscene(new GenericWorld1Cutscene(this));
                     }
                  }
               }
            }
            else if(SUB_LEVEL == 10)
            {
               if(Utils.Slot.gameProgression[19] == 0 && Utils.Slot.playerInventory[LevelItems.ITEM_ICE_CREAM_1] > 0)
               {
                  if(hero.xPos <= 464)
                  {
                     if(!this.CUTSCENE_FLAG_1)
                     {
                        this.CUTSCENE_FLAG_1 = true;
                        startCutscene(new GenericWorld1Cutscene(this));
                     }
                  }
               }
            }
            else if(SUB_LEVEL == 12)
            {
               ++this.sub_counter_1;
               if(this.sub_counter_1 > 120)
               {
                  this.sub_counter_1 = 0;
                  camera.verShake(1.5,0.98,0.2);
               }
               if(counter3++ > 90)
               {
                  counter3 = 0;
               }
               SoundSystem.PlaySound("crank");
               if(this.sub_counter_2++ >= 600)
               {
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 1;
                  exit();
                  Utils.EXIT_DIRECTION = 4;
               }
            }
            else if(SUB_LEVEL == 13)
            {
               if(Utils.Slot.gameProgression[18] == 0)
               {
                  flowers_amount = 0;
                  for(i = 0; i < collisionsManager.collisions.length; i++)
                  {
                     if(collisionsManager.collisions[i] != null)
                     {
                        if(collisionsManager.collisions[i] is ClodCollision)
                        {
                           cD = collisionsManager.collisions[i] as ClodCollision;
                           if(cD.stateMachine.currentState == "IS_FLOWER_STATE")
                           {
                              flowers_amount++;
                           }
                        }
                     }
                  }
                  if(flowers_amount >= 4 && hero.getMidXPos() >= 272 && hero.getMidXPos() <= 320)
                  {
                     if(!this.CUTSCENE_FLAG_1)
                     {
                        this.CUTSCENE_FLAG_1 = true;
                        startCutscene(new GenericWorld1Cutscene(this));
                     }
                  }
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 1 || SUB_LEVEL == 2 || SUB_LEVEL == 7 || SUB_LEVEL == 8 || SUB_LEVEL == 13)
         {
            array.push(new Point(0.05,1));
            array.push(new Point(0.4,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
            return array;
         }
         if(SUB_LEVEL == 3 || SUB_LEVEL == 9 || SUB_LEVEL == 10)
         {
            array.push(new Point(0.05,1));
            array.push(new Point(0.8,1));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else if(SUB_LEVEL == 4 || SUB_LEVEL == 5 || SUB_LEVEL == 6 || SUB_LEVEL == 11 || SUB_LEVEL == 12)
         {
            array.push(new Point(0.05,1));
            array.push(new Point(0.4,1));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         return array;
      }
      
      override public function getForegroundMultipliers() : Point
      {
         if(SUB_LEVEL == 2 || SUB_LEVEL == 5 || SUB_LEVEL == 8)
         {
            return new Point(1,1.2);
         }
         return new Point(1.2,1);
      }
      
      override public function getMusicName() : String
      {
         if(SUB_LEVEL == 3 && Utils.Slot.gameProgression[6] == 0)
         {
            return "cutscene_cats";
         }
         if(SUB_LEVEL == 6 && Utils.Slot.gameProgression[6] == 1)
         {
            return "cutscene_danger";
         }
         if(SUB_LEVEL == 9)
         {
            return "arcade";
         }
         if(SUB_LEVEL == 12)
         {
            return "outside_mountain";
         }
         if(SUB_LEVEL == 10)
         {
            return "inside_cave";
         }
         return "paws_base";
      }
      
      override public function playMusic() : void
      {
         SoundSystem.PlayMusic(this.getMusicName());
      }
      
      override public function getBackgroundId() : int
      {
         if(SUB_LEVEL == 10)
         {
            return BackgroundsManager.CAVE;
         }
         if(SUB_LEVEL >= 2 && SUB_LEVEL <= 6 || SUB_LEVEL >= 8 && SUB_LEVEL <= 9)
         {
            return BackgroundsManager.CANYON_NO_CLOUDS;
         }
         if(SUB_LEVEL == 12)
         {
            return BackgroundsManager.CANYON_SCROLLING;
         }
         return BackgroundsManager.CANYON;
      }
   }
}
