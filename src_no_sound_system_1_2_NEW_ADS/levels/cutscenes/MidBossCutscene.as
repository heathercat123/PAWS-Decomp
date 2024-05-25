package levels.cutscenes
{
   import entities.Entity;
   import entities.enemies.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.cameras.behaviours.VerTweenShiftBehaviour;
   import levels.collisions.*;
   import levels.items.BellItem;
   import levels.items.KeyItem;
   import states.LevelState;
   
   public class MidBossCutscene extends Cutscene
   {
       
      
      protected var cutscene_y_offset:Number;
      
      protected var pinkBlocks:Vector.<PinkBlockCollision>;
      
      protected var giantEnemy:GiantEnemy;
      
      protected var IS_ENDING:Boolean;
      
      public function MidBossCutscene(_level:Level, _isEnding:Boolean = false)
      {
         this.IS_ENDING = _isEnding;
         super(_level);
         this.cutscene_y_offset = 0;
         counter1 = counter2 = counter3 = 0;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var FORCE_REWARD:Boolean = false;
         var l_index:int = 0;
         var bell_item:BellItem = null;
         var key_item:KeyItem = null;
         ++counter1;
         level.hero.xVel = 0;
         if(this.IS_ENDING)
         {
            if(PROGRESSION == 0)
            {
               if(counter1 > 60)
               {
                  if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
                  {
                     if(this.giantEnemy.dead)
                     {
                        counter1 = counter2 = 0;
                        ++PROGRESSION;
                     }
                  }
                  else
                  {
                     counter1 = counter2 = 0;
                     ++PROGRESSION;
                  }
               }
            }
            else if(PROGRESSION == 1)
            {
               if(counter1 > 15)
               {
                  counter1 = 0;
                  this.pinkBlocks[counter2++].explode();
                  if(counter2 >= this.pinkBlocks.length)
                  {
                     counter1 = counter2 = 0;
                     ++PROGRESSION;
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               FORCE_REWARD = false;
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
               {
                  FORCE_REWARD = true;
               }
               if(Utils.PERFECT_ROOM || FORCE_REWARD)
               {
                  if(counter1 >= 30)
                  {
                     l_index = int((Utils.CurrentSubLevel + 1) * Utils.ITEMS_PER_LEVEL - 1);
                     if(Utils.LEVEL_ITEMS[l_index] == false)
                     {
                        bell_item = null;
                        key_item = null;
                        if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_4_4)
                        {
                           bell_item = new BellItem(level,392,80,2);
                        }
                        else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_4_7)
                        {
                           bell_item = new BellItem(level,744,144,2);
                        }
                        else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
                        {
                           if(LevelItems.HasItem(LevelItems.ITEM_KEY_CLUB) == false)
                           {
                              key_item = new KeyItem(level,level.hero.getMidXPos() > 872 ? 816 : 912,112,-1,2);
                           }
                           else
                           {
                              trace("key already acquired");
                           }
                        }
                        if(bell_item != null)
                        {
                           bell_item.level_index = l_index;
                           bell_item.stateMachine.setState("IS_BONUS_STATE");
                           bell_item.updateScreenPosition(level.camera);
                           level.itemsManager.items.push(bell_item);
                        }
                        else if(key_item != null)
                        {
                           key_item.level_index = l_index;
                           key_item.stateMachine.setState("IS_BONUS_STATE");
                           key_item.updateScreenPosition(level.camera);
                           level.itemsManager.items.push(key_item);
                        }
                     }
                     counter1 = 0;
                     ++PROGRESSION;
                  }
               }
               else
               {
                  counter1 = 0;
                  PROGRESSION = 4;
               }
            }
            else if(PROGRESSION == 3)
            {
               if(counter1 >= 30)
               {
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else if(PROGRESSION == 4)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 0)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
            {
               level.hero.xVel = 0;
               level.hero.xPos = 768;
            }
            if(counter1 > 15)
            {
               if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
               {
                  if(level.hero.stateMachine.currentState == "IS_STANDING_STATE")
                  {
                     counter1 = 0;
                     ++PROGRESSION;
                     this.giantEnemy.stateMachine.setState("IS_ENTERING_SCREEN_STATE");
                  }
               }
               else
               {
                  counter1 = 0;
                  ++PROGRESSION;
                  this.giantEnemy.stateMachine.setState("IS_WALKING_STATE");
               }
            }
         }
         else if(PROGRESSION == 1)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_4_4)
            {
               if(this.giantEnemy.xPos <= 464)
               {
                  this.giantEnemy.xPos = 464;
                  this.giantEnemy.xVel = 0;
                  this.giantEnemy.stateMachine.setState("IS_STANDING_STATE");
                  this.initBricks();
                  counter1 = counter2 = 0;
                  ++PROGRESSION;
               }
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_4_7)
            {
               if(this.giantEnemy.xPos <= 816)
               {
                  this.giantEnemy.xPos = 816;
                  this.giantEnemy.xVel = 0;
                  this.giantEnemy.stateMachine.setState("IS_STANDING_STATE");
                  this.initBricks();
                  counter1 = counter2 = 0;
                  PROGRESSION = 10;
               }
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
            {
               if(counter1 >= 150)
               {
                  this.initBricks();
                  counter1 = counter2 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 10)
         {
            if(counter1 == 30)
            {
               this.giantEnemy.speed = 0;
               this.giantEnemy.stateMachine.setRule("IS_SPIKES_OUT_STATE","END_ACTION","IS_STANDING_STATE");
               this.giantEnemy.stateMachine.setState("IS_SPIKES_OUT_STATE");
            }
            else if(counter1 >= 60)
            {
               counter1 = 0;
               PROGRESSION = 2;
            }
         }
         else if(PROGRESSION == 2)
         {
            if(counter1 > 15)
            {
               counter1 = 0;
               this.pinkBlocks[counter2++].appear();
               if(counter2 >= this.pinkBlocks.length)
               {
                  counter1 = counter2 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 3)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_4_7)
            {
               this.giantEnemy.stateMachine.setRule("IS_SPIKES_OUT_STATE","END_ACTION","IS_WALKING_STATE");
            }
            else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
            {
               this.giantEnemy.stateMachine.performAction("GO_UP_ACTION");
            }
            stateMachine.performAction("END_ACTION");
            ++PROGRESSION;
         }
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         counter1 = 0;
      }
      
      protected function initBricks() : void
      {
         var block:PinkBlockCollision = null;
         var i:int = 0;
         this.pinkBlocks = new Vector.<PinkBlockCollision>();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_4_4)
         {
            block = new PinkBlockCollision(level,256,112,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,256,112 + 16,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,256,112 + 32,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,528,112,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,528,112 + 16,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,528,112 + 32,0,1);
            this.pinkBlocks.push(block);
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_4_7)
         {
            block = new PinkBlockCollision(level,608,144 + 16,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,608,144 + 32,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,608,144 + 48,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,880,144 + 16,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,880,144 + 32,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,880,144 + 48,0,1);
            this.pinkBlocks.push(block);
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
         {
            block = new PinkBlockCollision(level,736,96 + 0,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,736,96 + 16,0,1);
            this.pinkBlocks.push(block);
            block = new PinkBlockCollision(level,736,96 + 32,0,1);
            this.pinkBlocks.push(block);
         }
         for(i = 0; i < this.pinkBlocks.length; i++)
         {
            this.pinkBlocks[i].updateScreenPosition(level.camera);
            level.collisionsManager.collisions.push(this.pinkBlocks[i]);
         }
      }
      
      protected function fetchPinkBlocks() : void
      {
         var i:int = 0;
         var _xPos:Number = 400;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_4_7)
         {
            _xPos = 688;
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
         {
            _xPos = 872;
         }
         this.pinkBlocks = new Vector.<PinkBlockCollision>();
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is PinkBlockCollision)
               {
                  if(level.collisionsManager.collisions[i].xPos >= _xPos)
                  {
                     this.pinkBlocks.push(level.collisionsManager.collisions[i] as PinkBlockCollision);
                  }
               }
            }
         }
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         var horTween:HorTweenShiftBehaviour = null;
         var verTween:VerTweenShiftBehaviour = null;
         super.initState();
         SoundSystem.StopMusic(false,false);
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_4_4)
         {
            if(this.IS_ENDING == false)
            {
               level.hero.xPos = 304;
               level.hero.xVel = 0;
               horTween = new HorTweenShiftBehaviour(level);
               horTween.x_start = level.camera.x;
               horTween.x_end = int(400 - Utils.WIDTH * 0.5);
               horTween.tick = 0;
               horTween.time = 1;
               level.camera.changeHorBehaviour(horTween,true);
               this.giantEnemy = new GiantLogEnemy(level,level.camera.xPos + Utils.WIDTH + 32,160 - 32,Entity.LEFT,0);
               this.giantEnemy.updateScreenPosition(level.camera);
               level.enemiesManager.enemies.push(this.giantEnemy);
            }
            else
            {
               this.fetchPinkBlocks();
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_5)
         {
            if(this.IS_ENDING == false)
            {
               level.hero.xPos = 768;
               level.hero.xVel = 0;
               horTween = new HorTweenShiftBehaviour(level);
               horTween.x_start = level.camera.x;
               horTween.x_end = int(872 - Utils.WIDTH * 0.5);
               horTween.tick = 0;
               horTween.time = 1;
               level.camera.changeHorBehaviour(horTween,true);
               this.giantEnemy = new BossSpiderEnemy(level,872,level.camera.yPos - 64,Entity.LEFT);
               this.giantEnemy.updateScreenPosition(level.camera);
               level.enemiesManager.enemies.push(this.giantEnemy);
            }
            else
            {
               this.fetchPinkBlocks();
               for(i = 0; i < level.enemiesManager.enemies.length; i++)
               {
                  if(level.enemiesManager.enemies[i] != null)
                  {
                     if(level.enemiesManager.enemies[i] is BossSpiderEnemy)
                     {
                        this.giantEnemy = level.enemiesManager.enemies[i];
                     }
                  }
               }
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_2_4_7)
         {
            if(this.IS_ENDING == false)
            {
               level.hero.xPos = 656;
               level.hero.xVel = 0;
               horTween = new HorTweenShiftBehaviour(level);
               horTween.x_start = level.camera.x;
               horTween.x_end = int(752 - Utils.WIDTH * 0.5);
               horTween.tick = 0;
               horTween.time = 1;
               verTween = new VerTweenShiftBehaviour(level);
               verTween.y_start = level.camera.y;
               verTween.y_end = int(240 - 8 + level.camera.getVerticalOffsetFromGroundLevel() - int(level.camera.HEIGHT));
               verTween.tick = 0;
               verTween.time = 1;
               level.camera.changeHorBehaviour(horTween,true);
               level.camera.changeVerBehaviour(verTween,true);
               this.giantEnemy = new GiantCrabEnemy(level,992,192,0,0,0,1);
               this.giantEnemy.updateScreenPosition(level.camera);
               level.enemiesManager.enemies.push(this.giantEnemy);
            }
            else
            {
               this.fetchPinkBlocks();
            }
         }
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         if(this.IS_ENDING)
         {
            level.camera.LEFT_MARGIN = level.camera.x;
            level.setCameraBehaviours();
            level.playMusic();
         }
         else
         {
            SoundSystem.PlayMusic("mid_boss");
         }
         super.overState();
      }
   }
}
