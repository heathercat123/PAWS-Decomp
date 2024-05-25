package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.collisions.*;
   import sprites.particles.SnowSmallParticleSprite;
   import sprites.tutorials.*;
   import starling.display.Image;
   import states.LevelState;
   
   public class DoorExitCollision extends ExitCollision
   {
       
      
      public var LOCK_ID:int;
      
      public var stateMachine:StateMachine;
      
      protected var lockImage:Image;
      
      protected var lockYOffset:int;
      
      protected var IS_ENABLED:Boolean;
      
      protected var IS_TOP_WORLD:Boolean;
      
      public var TYPE:int;
      
      protected var close_cutscene_flag:Boolean;
      
      protected var snow_counter_1:int;
      
      protected var unlock_delay_counter:int;
      
      protected var hero_x_pos:int;
      
      public function DoorExitCollision(_level:Level, _xPos:Number, _yPos:Number, _dir:int, _disabled:int, _type:int)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         sprite = new DoorCollisionSprite(this.TYPE);
         this.close_cutscene_flag = false;
         this.snow_counter_1 = this.unlock_delay_counter = 0;
         this.IS_ENABLED = true;
         if(_disabled > 0)
         {
            this.IS_ENABLED = false;
         }
         this.lockImage = null;
         this.lockYOffset = 0;
         if(_dir > 0)
         {
            IS_SX_EXIT = true;
            sprite.scaleX = -1;
            aabb.x = aabb.y = 0;
            aabb.width = 48;
            aabb.height = 48;
            if(this.TYPE == 1)
            {
               aabb.width = 52;
            }
         }
         else
         {
            IS_SX_EXIT = false;
            aabb.x = -48;
            aabb.y = 0;
            aabb.width = 48;
            aabb.height = 32;
            if(this.TYPE == 1)
            {
               aabb.x = -52;
               aabb.width = 52;
            }
         }
         this.IS_TOP_WORLD = false;
         initDoorId();
         initWeatherId();
         this.LOCK_ID = this.getLockId();
         if(this.isBackDoor())
         {
            Utils.world.addChild(sprite);
         }
         else
         {
            Utils.topWorld.addChild(sprite);
            this.IS_TOP_WORLD = true;
         }
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_CLOSED_STATE","OPEN_ACTION","IS_OPENING_STATE");
         this.stateMachine.setRule("IS_OPENING_STATE","END_ACTION","IS_OPEN_STATE");
         this.stateMachine.setRule("IS_OPEN_STATE","CLOSE_ACTION","IS_CLOSING_STATE");
         this.stateMachine.setRule("IS_CLOSING_STATE","END_ACTION","IS_CLOSED_STATE");
         this.stateMachine.setRule("IS_LOCKED_STATE","UNLOCK_ACTION","IS_UNLOCKING_STATE");
         this.stateMachine.setRule("IS_UNLOCKING_STATE","END_ACTION","IS_CLOSED_STATE");
         this.stateMachine.setFunctionToState("IS_OPENING_STATE",this.openingAnimation);
         this.stateMachine.setFunctionToState("IS_OPEN_STATE",this.openAnimation);
         this.stateMachine.setFunctionToState("IS_CLOSING_STATE",this.closingAnimation);
         this.stateMachine.setFunctionToState("IS_CLOSED_STATE",this.closedAnimation);
         this.stateMachine.setFunctionToState("IS_LOCKED_STATE",this.lockedAnimation);
         this.stateMachine.setFunctionToState("IS_UNLOCKING_STATE",this.unlockingAnimation);
         this.stateMachine.setState("IS_CLOSED_STATE");
         if(this.LOCK_ID < 0)
         {
            this.stateMachine.setState("IS_CLOSED_STATE");
         }
         else if(Utils.Slot.doorUnlocked[this.LOCK_ID])
         {
            this.stateMachine.setState("IS_CLOSED_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_LOCKED_STATE");
         }
      }
      
      override public function destroy() : void
      {
         if(this.lockImage != null)
         {
            Utils.topWorld.removeChild(this.lockImage);
            this.lockImage.dispose();
            this.lockImage = null;
         }
         if(!this.IS_TOP_WORLD)
         {
            Utils.world.removeChild(sprite);
         }
         else
         {
            Utils.topWorld.removeChild(sprite);
         }
         this.stateMachine.destroy();
         this.stateMachine = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         if(this.stateMachine.currentState != "IS_CLOSED_STATE")
         {
            if(this.stateMachine.currentState == "IS_OPENING_STATE")
            {
               if(sprite.gfxHandleClip().isComplete)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
               if(IS_SNOW)
               {
                  this.createSnowParticles();
               }
            }
            else if(this.stateMachine.currentState == "IS_OPEN_STATE")
            {
               if(IS_SNOW)
               {
                  this.createSnowParticles();
               }
            }
            else if(this.stateMachine.currentState == "IS_CLOSING_STATE")
            {
               ++counter1;
               if(this.TYPE == 1 && this.close_cutscene_flag)
               {
                  if(counter1 == 15)
                  {
                     this.close_cutscene_flag = false;
                     level.camera.shake(1.5,false,15);
                  }
               }
               if(sprite.gfxHandleClip().isComplete)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState == "IS_LOCKED_STATE")
            {
               ++counter1;
               if(counter1 > 30)
               {
                  counter1 = 0;
                  if(this.lockYOffset == 0)
                  {
                     this.lockYOffset = -1;
                  }
                  else
                  {
                     this.lockYOffset = 0;
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_UNLOCKING_STATE")
            {
               if(this.unlock_delay_counter++ >= 50)
               {
                  ++counter1;
                  if(counter1 >= 3)
                  {
                     counter1 = 0;
                     this.lockImage.visible = !this.lockImage.visible;
                     ++counter2;
                     if(counter2 >= 15)
                     {
                        LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_KEY,-1,false);
                        Utils.Slot.doorUnlocked[this.LOCK_ID] = true;
                        SaveManager.SaveItemsAndDoors();
                        this.lockImage.visible = false;
                        this.stateMachine.performAction("END_ACTION");
                        if(IS_SX_EXIT)
                        {
                           x_t = int((xPos + 8) / Utils.TILE_WIDTH);
                           y_t = int((yPos + 8) / Utils.TILE_HEIGHT);
                        }
                        else
                        {
                           x_t = int((xPos - 8) / Utils.TILE_WIDTH);
                           y_t = int((yPos + 8) / Utils.TILE_HEIGHT);
                        }
                        level.levelData.setTileValueAt(x_t,y_t,0);
                        level.levelData.setTileValueAt(x_t,y_t + 1,0);
                     }
                  }
               }
            }
         }
      }
      
      override public function checkPostUpdateEntitiesCollision() : void
      {
         if(this.stateMachine.currentState == "IS_UNLOCKING_STATE")
         {
            level.hero.xVel = 0;
            level.hero.stateMachine.setState("IS_STANDING_STATE");
            level.leftPressed = level.rightPressed = false;
            if(IS_SX_EXIT == false)
            {
               level.hero.DIRECTION = Entity.RIGHT;
               level.hero.xPos = this.hero_x_pos + 1;
            }
            else
            {
               level.hero.DIRECTION = Entity.LEFT;
               level.hero.xPos = this.hero_x_pos - 1;
            }
         }
      }
      
      protected function createSnowParticles() : void
      {
         var pSprite:GameSprite = null;
         if(this.snow_counter_1-- < 0)
         {
            this.snow_counter_1 = 0;
            pSprite = new SnowSmallParticleSprite();
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            if(IS_SX_EXIT)
            {
               level.particlesManager.pushParticle(pSprite,xPos,yPos + 8 + Math.random() * 32,3 + Math.random() * 2,0,Math.random() * 0.05 + 0.95,Math.random() * Math.PI,Math.random() * 16 + 4);
            }
            else
            {
               level.particlesManager.pushParticle(pSprite,xPos + 32,yPos + 8 + Math.random() * 32,-(3 + Math.random() * 2),0,Math.random() * 0.05 + 0.95,Math.random() * Math.PI,Math.random() * 16 + 4);
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var offset_x:int = IS_SX_EXIT ? 31 : -31;
         var offset_y:int = -8;
         sprite.x = int(Math.floor(xPos + offset_x - camera.xPos));
         sprite.y = int(Math.floor(yPos + offset_y - camera.yPos));
         sprite.updateScreenPosition();
         if(!this.IS_TOP_WORLD)
         {
            Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
         }
         if(this.lockImage != null)
         {
            if(IS_SX_EXIT)
            {
               this.lockImage.x = sprite.x - 7;
               this.lockImage.y = sprite.y + 17 + this.lockYOffset;
            }
            else
            {
               this.lockImage.x = sprite.x + 7;
               this.lockImage.y = sprite.y + 17 + this.lockYOffset;
            }
         }
      }
      
      protected function isBackDoor() : Boolean
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_5_2)
         {
            if(DOOR_ID == 3)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function startOutroCutscene() : void
      {
         this.stateMachine.setState("IS_OPENING_STATE");
      }
      
      override public function startIntroCutscene() : void
      {
         this.stateMachine.setState("IS_OPEN_STATE");
      }
      
      override public function endIntroCutscene() : void
      {
         this.close_cutscene_flag = true;
         this.stateMachine.setState("IS_CLOSING_STATE");
      }
      
      protected function closedAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function closingAnimation() : void
      {
         sprite.gotoAndStop(4);
         sprite.gfxHandleClip().gotoAndPlay(1);
         if(this.TYPE == 1)
         {
            SoundSystem.PlaySound("giant_door_close");
         }
         else
         {
            SoundSystem.PlaySound("door_close");
         }
      }
      
      protected function openingAnimation() : void
      {
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
         if(IS_SNOW)
         {
            SoundSystem.PlaySound("wind_breeze");
         }
         if(this.TYPE == 1)
         {
            SoundSystem.PlaySound("giant_door_open");
         }
         else
         {
            SoundSystem.PlaySound("door_open");
         }
      }
      
      protected function openAnimation() : void
      {
         sprite.gotoAndStop(3);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function lockedAnimation() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
         if(IS_SX_EXIT)
         {
            x_t = int((xPos + 8) / Utils.TILE_WIDTH);
            y_t = int((yPos + 8) / Utils.TILE_HEIGHT);
         }
         else
         {
            x_t = int((xPos - 8) / Utils.TILE_WIDTH);
            y_t = int((yPos + 8) / Utils.TILE_HEIGHT);
         }
         level.levelData.setTileValueAt(x_t,y_t,11);
         level.levelData.setTileValueAt(x_t,y_t + 1,11);
         this.lockImage = new Image(TextureManager.sTextureAtlas.getTexture("door_lock_image_1"));
         this.lockImage.touchable = false;
         Utils.topWorld.addChild(this.lockImage);
         if(IS_SX_EXIT)
         {
            this.lockImage.scaleX = -1;
         }
         counter1 = 0;
      }
      
      protected function unlockingAnimation() : void
      {
         counter1 = counter2 = 0;
         this.unlock_delay_counter = 0;
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(EXIT_FLAG || !this.IS_ENABLED)
         {
            return;
         }
         if(level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            return;
         }
         var aabb_1:Rectangle = level.hero.getAABB();
         var aabb_2:Rectangle = getAABB();
         if(aabb_1.intersects(aabb_2))
         {
            if(this.stateMachine.currentState == "IS_LOCKED_STATE")
            {
               if(LevelItems.HasItem(LevelItems.ITEM_KEY))
               {
                  Utils.INVENTORY_NOTIFICATION_ID = LevelItems.ITEM_KEY;
                  Utils.INVENTORY_NOTIFICATION_ACTION = -1;
                  this.openDoor();
               }
            }
            else if(this.stateMachine.currentState != "IS_UNLOCKING_STATE")
            {
               if(level.hero.stateMachine.currentState != "IS_HEAD_POUND_STATE")
               {
                  if(!(this.TYPE == 1 && DOOR_ID == 0))
                  {
                     EXIT_FLAG = true;
                     Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = DOOR_ID;
                     level.exit();
                  }
               }
            }
         }
      }
      
      public function openDoor() : void
      {
         this.stateMachine.performAction("UNLOCK_ACTION");
         this.hero_x_pos = level.hero.xPos;
         SoundSystem.PlaySound("item_appear");
         level.topParticlesManager.createUseItemParticles(LevelItems.ITEM_KEY);
      }
      
      protected function getLockId() : int
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_6_1 && DOOR_ID == 1)
         {
            return 0;
         }
         return -1;
      }
   }
}
