package levels.worlds.world2
{
   import entities.*;
   import entities.npcs.*;
   import flash.events.Event;
   import flash.geom.*;
   import flash.net.*;
   import game_utils.*;
   import interfaces.texts.GameText;
   import levels.*;
   import levels.backgrounds.*;
   import levels.cameras.behaviours.*;
   import levels.collisions.*;
   import levels.cutscenes.*;
   import levels.cutscenes.world2.*;
   import levels.items.BellItem;
   import starling.display.*;
   
   public class Level_2_5 extends Level
   {
      
      public static const Map_2_5_1:Class = Level_2_5_Map_2_5_1;
      
      public static const Map_2_5_2:Class = Level_2_5_Map_2_5_2;
      
      public static const Map_2_5_3:Class = Level_2_5_Map_2_5_3;
      
      public static const Map_2_5_4:Class = Level_2_5_Map_2_5_4;
      
      public static const Map_2_5_5:Class = Level_2_5_Map_2_5_5;
      
      public static const Map_2_5_6:Class = Level_2_5_Map_2_5_6;
      
      public static const Map_2_5_7:Class = Level_2_5_Map_2_5_7;
      
      public static const Map_2_5_8:Class = Level_2_5_Map_2_5_8;
      
      public static const Map_2_5_9:Class = Level_2_5_Map_2_5_9;
      
      public static const Map_2_5_10:Class = Level_2_5_Map_2_5_10;
      
      public static const Map_2_5_11:Class = Level_2_5_Map_2_5_11;
      
      public static const Map_2_5_12:Class = Level_2_5_Map_2_5_12;
      
      public static const Map_2_5_13:Class = Level_2_5_Map_2_5_13;
      
      public static const Map_2_5_14:Class = Level_2_5_Map_2_5_14;
      
      public static const Map_2_5_15:Class = Level_2_5_Map_2_5_15;
       
      
      public var CUTSCENE_FLAG_1:Boolean;
      
      public var CUTSCENE_FLAG_2:Boolean;
      
      public var BONUS_FLAG:Boolean;
      
      protected var CAMERA_AREA:int;
      
      protected var sfx_just_once:Boolean;
      
      public var minigame_counter:int;
      
      protected var CREATE_BRICKS_FLAG:Boolean;
      
      protected var IS_DONE:Boolean;
      
      protected var bricks_counter_1:int;
      
      protected var bricks_counter_2:int;
      
      protected var camera_flag_1:Boolean;
      
      protected var rod_image_1:Image;
      
      protected var wire_images:Vector.<Image>;
      
      protected var wire_positions:Vector.<Point>;
      
      protected var timer:GameText;
      
      protected var waves_sin_counter:Number;
      
      protected var tomoNPC:GenericNPC;
      
      protected var waterCollision:WaterCollision;
      
      public function Level_2_5(_sub_level:int)
      {
         var urlRequest:URLRequest = null;
         var urlLoader:URLLoader = null;
         SUB_LEVEL = _sub_level;
         Utils.CurrentSubLevel = SUB_LEVEL - 1;
         this.minigame_counter = -1;
         this.CAMERA_AREA = 0;
         this.sfx_just_once = true;
         this.camera_flag_1 = true;
         this.timer = null;
         this.waves_sin_counter = 0;
         this.CREATE_BRICKS_FLAG = this.IS_DONE = false;
         this.bricks_counter_1 = this.bricks_counter_2 = 0;
         super();
         this.CUTSCENE_FLAG_1 = this.CUTSCENE_FLAG_2 = false;
         this.BONUS_FLAG = false;
         if(Utils.LEVEL_RUNTIME)
         {
            if(SUB_LEVEL == 1)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_1.xml");
            }
            else if(SUB_LEVEL == 2)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_2.xml");
            }
            else if(SUB_LEVEL == 3)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_3.xml");
            }
            else if(SUB_LEVEL == 4)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_4.xml");
            }
            else if(SUB_LEVEL == 5)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_5.xml");
            }
            else if(SUB_LEVEL == 6)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_6.xml");
            }
            else if(SUB_LEVEL == 7)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_7.xml");
            }
            else if(SUB_LEVEL == 8)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_8.xml");
            }
            else if(SUB_LEVEL == 9)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_9.xml");
            }
            else if(SUB_LEVEL == 10)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_10.xml");
            }
            else if(SUB_LEVEL == 11)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_11.xml");
            }
            else if(SUB_LEVEL == 12)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_12.xml");
            }
            else if(SUB_LEVEL == 13)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_13.xml");
            }
            else if(SUB_LEVEL == 14)
            {
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_14.xml");
            }
            else if(SUB_LEVEL == 15)
            {
               Utils.IS_DARK = true;
               urlRequest = new URLRequest(Utils.ROOT_PATH + "/world_2/2_5_15.xml");
            }
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,urlLoaded);
            urlLoader.load(urlRequest);
         }
         else
         {
            if(SUB_LEVEL == 1)
            {
               map = new XML(new Map_2_5_1());
            }
            else if(SUB_LEVEL == 2)
            {
               map = new XML(new Map_2_5_2());
            }
            else if(SUB_LEVEL == 3)
            {
               map = new XML(new Map_2_5_3());
            }
            else if(SUB_LEVEL == 4)
            {
               map = new XML(new Map_2_5_4());
            }
            else if(SUB_LEVEL == 5)
            {
               map = new XML(new Map_2_5_5());
            }
            else if(SUB_LEVEL == 6)
            {
               map = new XML(new Map_2_5_6());
            }
            else if(SUB_LEVEL == 7)
            {
               map = new XML(new Map_2_5_7());
            }
            else if(SUB_LEVEL == 8)
            {
               map = new XML(new Map_2_5_8());
            }
            else if(SUB_LEVEL == 9)
            {
               map = new XML(new Map_2_5_9());
            }
            else if(SUB_LEVEL == 10)
            {
               map = new XML(new Map_2_5_10());
            }
            else if(SUB_LEVEL == 11)
            {
               map = new XML(new Map_2_5_11());
            }
            else if(SUB_LEVEL == 12)
            {
               map = new XML(new Map_2_5_12());
            }
            else if(SUB_LEVEL == 13)
            {
               map = new XML(new Map_2_5_13());
            }
            else if(SUB_LEVEL == 14)
            {
               map = new XML(new Map_2_5_14());
            }
            else if(SUB_LEVEL == 15)
            {
               Utils.IS_DARK = true;
               map = new XML(new Map_2_5_15());
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
            camera.changeVerBehaviour(new StaticVerBehaviour(this,168 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 2)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 9)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 2)
            {
               camera.changeHorBehaviour(new StaticHorBehaviour(this,int(456 - camera.HALF_WIDTH)));
               this.CAMERA_AREA = 3;
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 5 || Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 1)
            {
               camera.changeVerBehaviour(new StaticVerBehaviour(this,144 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
               this.CAMERA_AREA = 1;
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 3)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
            else
            {
               camera.changeVerBehaviour(new StaticVerBehaviour(this,208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            }
         }
         else if(SUB_LEVEL == 4)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,384 - camera.HALF_WIDTH));
            camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this),true);
         }
         else if(SUB_LEVEL == 5)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 1)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
            camera.changeVerBehaviour(new StaticVerBehaviour(this,208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 6)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 7 || SUB_LEVEL == 8 || SUB_LEVEL == 9 || SUB_LEVEL == 10)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] == 1)
            {
               camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
            }
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 11)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,int(528 - Utils.WIDTH * 0.5)));
            camera.changeVerBehaviour(new StaticVerBehaviour(this,256 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 12 || SUB_LEVEL == 14)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
            if(SUB_LEVEL == 14)
            {
               camera.changeHorBehaviour(new StaticHorBehaviour(this,int(752 - Utils.WIDTH * 0.5)));
            }
         }
         else if(SUB_LEVEL == 13)
         {
            camera.changeVerBehaviour(new StaticVerBehaviour(this,176 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
         else if(SUB_LEVEL == 15)
         {
            camera.changeHorBehaviour(new StaticHorBehaviour(this,int(280 - Utils.WIDTH * 0.5)));
            camera.changeVerBehaviour(new StaticVerBehaviour(this,160 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT)));
         }
      }
      
      override public function init() : void
      {
         var i:int = 0;
         var catNPC:CatNPC = null;
         var image:Image = null;
         var l_index:int = 0;
         var bell:BellItem = null;
         var item:BellItem = null;
         super.init();
         this.rod_image_1 = null;
         this.wire_images = null;
         this.wire_positions = null;
         if(SUB_LEVEL == 1)
         {
            if(Utils.Slot.gameProgression[12] == 0)
            {
               for(i = 0; i < npcsManager.npcs.length; i++)
               {
                  if(npcsManager.npcs[i] != null)
                  {
                     if(npcsManager.npcs[i].xPos >= 784 && npcsManager.npcs[i].xPos <= 1024)
                     {
                        npcsManager.npcs[i].dead = true;
                     }
                  }
               }
               catNPC = new CatNPC(this,928 + 32,144,Entity.RIGHT,0,CatNPC.MARA);
               catNPC.setTurnToHero(false);
               npcsManager.npcs.push(catNPC);
            }
         }
         else if(SUB_LEVEL == 2)
         {
            if(Utils.Slot.playerInventory[LevelItems.ITEM_WATER_CAT] == 0)
            {
               for(i = 0; i < npcsManager.npcs.length; i++)
               {
                  if(npcsManager.npcs[i] != null)
                  {
                     if(npcsManager.npcs[i] is GenericNPC)
                     {
                        if(GenericNPC(npcsManager.npcs[i]).NPC_TYPE == GenericNPC.NPC_GUY)
                        {
                           npcsManager.npcs[i].stringId = 12;
                        }
                     }
                  }
               }
            }
         }
         else if(SUB_LEVEL == 4)
         {
            camera.yPos = int(688 + camera.getVerticalOffsetFromGroundLevel() - camera.HEIGHT);
            camera.BOTTOM_MARGIN = 688 + camera.getVerticalOffsetFromGroundLevel();
            camera.TOP_MARGIN = 400 + camera.getVerticalOffsetFromGroundLevel() - camera.HEIGHT;
            this.rod_image_1 = new Image(TextureManager.GetBackgroundTexture().getTexture("fishing_rod_background_1"));
            this.rod_image_1.touchable = false;
            Utils.world.addChild(this.rod_image_1);
            Utils.world.setChildIndex(this.rod_image_1,0);
            this.wire_images = new Vector.<Image>();
            this.wire_positions = new Vector.<Point>();
            for(i = 0; i < 8; i++)
            {
               image = new Image(TextureManager.sTextureAtlas.getTexture("fishing_wire"));
               image.touchable = false;
               image.pivotX = image.pivotY = 3;
               Utils.world.addChild(image);
               this.wire_images.push(image);
               Utils.world.setChildIndex(image,0);
               this.wire_positions.push(new Point(140,384 + i * 24));
            }
            if(Utils.Slot.gameProgression[12] == 1)
            {
               catNPC = new CatNPC(this,192,384,Entity.LEFT,0,CatNPC.MARA);
               catNPC.setTurnToHero(false);
               npcsManager.npcs.push(catNPC);
            }
            else if(Utils.Slot.gameProgression[12] == 2)
            {
               if(Utils.Slot.gameProgression[15] >= 2)
               {
                  catNPC = new CatNPC(this,192,384,Entity.LEFT,0,CatNPC.MARA);
               }
               else
               {
                  catNPC = new CatNPC(this,192,384,Entity.LEFT,1,CatNPC.MARA);
               }
               npcsManager.npcs.push(catNPC);
            }
            for(i = 0; i < npcsManager.npcs.length; i++)
            {
               if(npcsManager.npcs[i] != null)
               {
                  if(npcsManager.npcs[i] is GenericNPC)
                  {
                     this.tomoNPC = npcsManager.npcs[i];
                  }
               }
            }
            l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
            if(Utils.LEVEL_LOCAL_PROGRESSION_2 == 1 && Utils.LEVEL_ITEMS[l_index] == false)
            {
               bell = new BellItem(this,344,480,0);
               itemsManager.items.push(bell);
            }
         }
         else if(SUB_LEVEL == 8)
         {
            ALLOW_CAT_BUTTON = false;
            if(Hero.GetCurrentCat() != Hero.CAT_RIGS)
            {
               catNPC = new CatNPC(this,467,128,Entity.LEFT,0,CatNPC.RIGS);
               catNPC.stateMachine.setState("IS_EYES_CLOSED_STATE");
               npcsManager.npcs.push(catNPC);
            }
            if(Hero.GetCurrentCat() != Hero.CAT_MARA && Utils.Slot.playerInventory[LevelItems.ITEM_WATER_CAT] > 0)
            {
               catNPC = new CatNPC(this,336,128,Entity.RIGHT,2,CatNPC.MARA);
               npcsManager.npcs.push(catNPC);
            }
            if(Hero.GetCurrentCat() != Hero.CAT_ROSE)
            {
               catNPC = new CatNPC(this,192,138,Entity.RIGHT,1,CatNPC.ROSE);
               catNPC.gravity_friction = 0;
               npcsManager.npcs.push(catNPC);
            }
            if(Hero.GetCurrentCat() != Hero.CAT_PASCAL)
            {
               catNPC = new CatNPC(this,282,144,Entity.LEFT,0,CatNPC.PASCAL);
               npcsManager.npcs.push(catNPC);
            }
            hero.onTop();
         }
         else if(SUB_LEVEL == 9)
         {
            if(Utils.Slot.gameProgression[16] >= 2)
            {
               l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
               if(Utils.LEVEL_ITEMS[l_index] == false)
               {
                  item = new BellItem(this,376,144,1);
                  item.level_index = l_index;
                  item.updateScreenPosition(camera);
                  itemsManager.items.push(item);
               }
            }
         }
         else if(SUB_LEVEL == 11)
         {
            for(i = 0; i < collisionsManager.collisions.length; i++)
            {
               if(collisionsManager.collisions[i] != null)
               {
                  if(collisionsManager.collisions[i] is WaterCollision)
                  {
                     this.waterCollision = WaterCollision(collisionsManager.collisions[i]);
                  }
               }
            }
            for(i = 0; i < npcsManager.npcs.length; i++)
            {
               if(npcsManager.npcs[i] != null)
               {
                  npcsManager.npcs[i].stringId = 3 + int(Math.random() * 3);
               }
            }
         }
         else if(SUB_LEVEL == 14)
         {
            this.timer = new GameText("00",GameText.TYPE_BIG);
            Utils.topWorld.addChild(this.timer);
            this.timer.x = int(Utils.WIDTH * 0.5 - this.timer.WIDTH * 0.5);
            this.timer.y = int(Math.floor(58 - camera.yPos));
         }
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var tweenShift:VerTweenShiftBehaviour = null;
         var tweenShift2:HorTweenShiftBehaviour = null;
         var condition:Boolean = false;
         super.update();
         if(SUB_LEVEL == 1)
         {
            if(Utils.Slot.gameProgression[12] == 0)
            {
               if(hero.xPos >= 864 && !this.CUTSCENE_FLAG_1)
               {
                  this.CUTSCENE_FLAG_1 = true;
                  startCutscene(new GenericWorld2Cutscene(this));
               }
            }
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 304 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 1 || this.CAMERA_AREA == 2)
            {
               condition = false;
               if(this.CAMERA_AREA == 1)
               {
                  if(hero.yPos <= Utils.SEA_LEVEL - 16)
                  {
                     condition = true;
                  }
               }
               else if(hero.yPos >= 144)
               {
                  condition = true;
               }
               if(condition)
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
            else if(this.CAMERA_AREA == 1 || this.CAMERA_AREA == 2)
            {
               condition = false;
               if(this.CAMERA_AREA == 1)
               {
                  if(hero.yPos <= Utils.SEA_LEVEL - 16)
                  {
                     condition = true;
                  }
               }
               else if(hero.yPos >= 144)
               {
                  condition = true;
               }
               if(condition)
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
            else if(this.CAMERA_AREA == 3)
            {
               if(level_tick > 10)
               {
                  this.CAMERA_AREA = 0;
                  camera.changeHorBehaviour(new VelShiftCenteredHorScrollBehaviour(this));
               }
            }
         }
         else if(SUB_LEVEL == 3)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos <= 144)
               {
                  if(hero.xPos >= 256 && hero.xPos <= 496)
                  {
                     this.CAMERA_AREA = 1;
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 144 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
               else if(hero.yPos >= camera.yPos + Utils.HEIGHT + 16)
               {
                  if(this.sfx_just_once)
                  {
                     SoundSystem.PlaySound("flyingship_falldown");
                     this.sfx_just_once = false;
                  }
                  Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 9;
                  exit();
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos >= 160)
               {
                  this.CAMERA_AREA = 0;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 208 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
         }
         else if(SUB_LEVEL == 4)
         {
            if(Utils.Slot.gameProgression[12] == 1)
            {
               if(hero.xPos <= 256 && !this.CUTSCENE_FLAG_1)
               {
                  this.CUTSCENE_FLAG_1 = true;
                  startCutscene(new GenericWorld2Cutscene(this));
               }
            }
            else if(Utils.Slot.gameProgression[12] == 2)
            {
               if(hero.xPos <= 256 && !this.CUTSCENE_FLAG_1 && Utils.Slot.gameProgression[15] >= 2)
               {
                  this.CUTSCENE_FLAG_1 = true;
                  startCutscene(new MaraJoinsTeamCutscene(this));
               }
            }
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos <= 400)
               {
                  if(hero.xPos <= 336 || hero.xPos >= 432)
                  {
                     this.CAMERA_AREA = 1;
                     camera.changeHorBehaviour(new CenteredProgressiveHorScrollBehaviour(this));
                     tweenShift = new VerTweenShiftBehaviour(this);
                     tweenShift.y_start = camera.y;
                     tweenShift.y_end = 400 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                     tweenShift.time = 0.75;
                     tweenShift.tick = 0;
                     camera.changeVerBehaviour(tweenShift);
                  }
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos >= 448 && (hero.xPos >= 336 && hero.xPos <= 432))
               {
                  this.CAMERA_AREA = 0;
                  tweenShift2 = new HorTweenShiftBehaviour(this,1);
                  tweenShift2.x_start = camera.x;
                  tweenShift2.x_end = int(384 - camera.WIDTH * 0.5);
                  tweenShift2.time = 0.75;
                  tweenShift2.tick = 0;
                  camera.changeHorBehaviour(tweenShift2);
                  camera.changeVerBehaviour(new TunnelVelShiftVerScrollBehaviour(this));
               }
               else if(hero.yPos >= camera.yPos + Utils.HEIGHT + 16)
               {
                  if(this.sfx_just_once)
                  {
                     SoundSystem.PlaySound("flyingship_falldown");
                     this.sfx_just_once = false;
                  }
                  if(hero.xPos <= 256)
                  {
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 5;
                  }
                  else
                  {
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 1;
                  }
                  exit();
               }
            }
            if(hero.xPos >= 605 && hero.yPos >= 392 && this.tomoNPC.flag_1 == false)
            {
               this.tomoNPC.flag_1 = true;
               this.tomoNPC.setEmotionParticle(Entity.EMOTION_WORRIED);
            }
            this.rod_image_1.x = int(Math.floor(135 - camera.xPos));
            this.rod_image_1.y = int(Math.floor(369 - camera.yPos));
            for(i = 0; i < this.wire_images.length; i++)
            {
               this.wire_images[i].x = int(Math.floor(this.wire_positions[i].x - camera.xPos));
               this.wire_images[i].y = int(Math.floor(this.wire_positions[i].y - camera.yPos));
            }
         }
         else if(SUB_LEVEL == 6)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
                  tweenShift.time = 0.75;
                  tweenShift.tick = 0;
                  camera.changeVerBehaviour(tweenShift);
               }
            }
            else if(this.CAMERA_AREA == 1)
            {
               if(hero.yPos <= Utils.SEA_LEVEL - 16 && (hero.xPos >= 1040 || hero.xPos <= 848))
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
         else if(SUB_LEVEL == 7)
         {
            if(Utils.LEVEL_LOCAL_PROGRESSION_1 == 0)
            {
               if(this.CUTSCENE_FLAG_1 == false)
               {
                  if(hero.xPos >= 544)
                  {
                     this.CUTSCENE_FLAG_1 = true;
                     startCutscene(new GenericWorld2Cutscene(this));
                  }
               }
            }
            if(hero.xPos <= 500)
            {
               this.CUTSCENE_FLAG_1 = false;
            }
         }
         else if(SUB_LEVEL == 8)
         {
            if(hero.xPos >= 424)
            {
            }
         }
         else if(SUB_LEVEL == 11)
         {
            --this.waterCollision.scrollValue;
            if(this.waterCollision.scrollValue < -9999999)
            {
               this.waterCollision.scrollValue = 0;
            }
            this.waves_sin_counter += 0.025;
            if(this.waves_sin_counter >= Math.PI * 2)
            {
               this.waves_sin_counter -= Math.PI * 2;
            }
            camera.wave_yShift = int(Math.sin(this.waves_sin_counter) * 8);
            if(counter1++ >= 900)
            {
               if(this.CUTSCENE_FLAG_1 == false)
               {
                  if(hud.dialogsManager.getDialogsAmount() == 0)
                  {
                     if(hero.getMidXPos() > 456 && hero.getMidXPos() < 616)
                     {
                        startCutscene(new GenericWorld2Cutscene(this));
                        this.CUTSCENE_FLAG_1 = true;
                     }
                  }
               }
            }
         }
         else if(SUB_LEVEL == 12)
         {
            if(this.CAMERA_AREA == 0)
            {
               if(hero.yPos >= Utils.SEA_LEVEL + 8)
               {
                  this.CAMERA_AREA = 1;
                  tweenShift = new VerTweenShiftBehaviour(this);
                  tweenShift.y_start = camera.y;
                  tweenShift.y_end = 240 + camera.getVerticalOffsetFromGroundLevel() - int(camera.HEIGHT);
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
         else if(SUB_LEVEL == 13)
         {
            if(!this.CUTSCENE_FLAG_1)
            {
               this.CUTSCENE_FLAG_1 = true;
               startCutscene(new TruckRideCutscene(this));
            }
         }
         else if(SUB_LEVEL == 14)
         {
            if(!this.CUTSCENE_FLAG_1)
            {
               this.CUTSCENE_FLAG_1 = true;
               startCutscene(new BeachMinigame(this));
            }
            if(this.minigame_counter >= 0)
            {
               ++this.minigame_counter;
               if(this.minigame_counter == 18 * 60)
               {
                  startCutscene(new BeachMinigame(this,true));
               }
            }
            if(Utils.BEACH_BALL_BOUNCES < 10)
            {
               this.timer.updateText("0" + Utils.BEACH_BALL_BOUNCES);
            }
            else
            {
               this.timer.updateText("" + Utils.BEACH_BALL_BOUNCES);
            }
            this.timer.x = int(Utils.WIDTH * 0.5 - this.timer.WIDTH * 0.5);
            this.timer.y = int(Math.floor(57 - camera.yPos));
         }
      }
      
      override public function customEvent(type:int = 0) : void
      {
         var l_index:int = 0;
         var item:BellItem = null;
         if(type == 1)
         {
            if(Utils.LEVEL_LOCAL_PROGRESSION_2 == 0)
            {
               Utils.LEVEL_LOCAL_PROGRESSION_2 = 1;
               l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
               if(Utils.LEVEL_ITEMS[l_index] == false)
               {
                  item = new BellItem(this,376,376 - 64,0);
                  item.level_index = l_index;
                  item.stateMachine.setState("IS_BONUS_STATE");
                  item.updateScreenPosition(camera);
                  itemsManager.items.push(item);
               }
            }
         }
      }
      
      override public function getBackgroundDistanceMultipliers() : Array
      {
         var array:Array = new Array();
         if(SUB_LEVEL == 3 || SUB_LEVEL == 5)
         {
            array.push(new Point(0.05,0.8));
            array.push(new Point(0.6,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         else if(SUB_LEVEL == 4)
         {
            array.push(new Point(0.05,0));
            array.push(new Point(0.6,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         else if(SUB_LEVEL == 13)
         {
            array.push(new Point(0,0));
            array.push(new Point(0.6,1));
            array.push(new Point(1,1));
            array.push(new Point(0.8,1));
         }
         else if(SUB_LEVEL == 15)
         {
            array.push(new Point(0.05,1));
            array.push(new Point(0.6,1));
            array.push(new Point(1,1));
            array.push(new Point(1,1));
         }
         else
         {
            array.push(new Point(0.05,1));
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
         if(SUB_LEVEL == 15)
         {
            return "tavern";
         }
         if(SUB_LEVEL == 14 || SUB_LEVEL == 11 || SUB_LEVEL == 12)
         {
            return "outside_sea";
         }
         return "portobello";
      }
      
      override public function playMusic() : void
      {
         SoundSystem.PlayMusic(this.getMusicName());
      }
      
      override public function exitLevel() : void
      {
         var i:int = 0;
         this.waterCollision = null;
         if(this.rod_image_1 != null)
         {
            Utils.world.removeChild(this.rod_image_1);
            this.rod_image_1.dispose();
            this.rod_image_1 = null;
            if(this.wire_images != null)
            {
               for(i = 0; i < this.wire_images.length; i++)
               {
                  Utils.world.removeChild(this.wire_images[i]);
                  this.wire_images[i].dispose();
                  this.wire_images[i] = null;
                  this.wire_positions[i] = null;
               }
               this.wire_images = null;
               this.wire_positions = null;
            }
         }
         super.exitLevel();
      }
      
      override public function getBackgroundId() : int
      {
         if(SUB_LEVEL == 13)
         {
            return BackgroundsManager.DESERT;
         }
         return BackgroundsManager.SEASIDE;
      }
   }
}
