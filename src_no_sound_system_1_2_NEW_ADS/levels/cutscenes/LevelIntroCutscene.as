package levels.cutscenes
{
   import entities.Entity;
   import entities.Hero;
   import game_utils.*;
   import levels.*;
   import levels.cameras.*;
   import levels.cameras.behaviours.*;
   import levels.collisions.ExitCollision;
   
   public class LevelIntroCutscene extends Cutscene
   {
      
      public static var FORCE_SHORT_INTRO:Boolean = false;
       
      
      protected var hero:Hero;
      
      protected var exitCollision:ExitCollision;
      
      protected var cameraOldBehaviour:CameraBehaviour;
      
      protected var TYPE:int;
      
      protected var IS_FROM_MAP:Boolean;
      
      protected var value_1:int;
      
      protected var value_2:int;
      
      protected var x_t_1:int;
      
      protected var y_t_1:int;
      
      protected var x_t_2:int;
      
      protected var y_t_2:int;
      
      public function LevelIntroCutscene(_level:Level, _type:int)
      {
         this.TYPE = _type;
         super(_level);
         IS_BLACK_BANDS = false;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_HERO_POSITION_ID] == 0 && FORCE_SHORT_INTRO == false && Utils.IsInstaGameOver == false)
         {
            this.IS_FROM_MAP = true;
         }
         else
         {
            this.IS_FROM_MAP = false;
         }
         if(Utils.LEVEL_REPEAT_FLAG)
         {
            this.IS_FROM_MAP = false;
         }
         FORCE_SHORT_INTRO = false;
         if(Utils.IS_SEASONAL)
         {
            this.IS_FROM_MAP = false;
         }
      }
      
      override public function destroy() : void
      {
         this.hero = null;
         this.exitCollision = null;
         this.cameraOldBehaviour = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var hero_x_t:int = 0;
         var hero_y_t:int = 0;
         ++counter1;
         if(Utils.SEA_LEVEL > 0 && level.hero.yPos >= Utils.SEA_LEVEL)
         {
            if(PROGRESSION == 0)
            {
               ++PROGRESSION;
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.TYPE == StartPosition.STATIC)
         {
            if(PROGRESSION == 0)
            {
               if(counter1 > (this.IS_FROM_MAP ? 90 : 1))
               {
                  ++PROGRESSION;
                  hero_x_t = int(level.hero.getMidXPos() / Utils.TILE_WIDTH);
                  hero_y_t = int((level.hero.getMidYPos() + 16) / Utils.TILE_HEIGHT);
                  if(level.levelData.getTileValueAt(hero_x_t,hero_y_t) == 0)
                  {
                     this.hero.stateMachine.setState("IS_FALLING_STATE");
                  }
                  else if(this.IS_FROM_MAP)
                  {
                     this.hero.stateMachine.setState("IS_LEVEL_START_STATE");
                  }
                  else
                  {
                     this.hero.stateMachine.setState("IS_STANDING_STATE");
                  }
               }
            }
            else if(PROGRESSION == 1)
            {
               if(this.hero.stateMachine.currentState != "IS_LEVEL_START_STATE")
               {
                  ++PROGRESSION;
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.TYPE == StartPosition.FENCE)
         {
            if(PROGRESSION == 0)
            {
               if(counter1 > (this.IS_FROM_MAP ? 60 : 0))
               {
                  ++PROGRESSION;
                  this.hero.stateMachine.setState("IS_RUNNING_STATE");
               }
            }
            else if(PROGRESSION == 1)
            {
               this.hero.MAX_X_VEL = 3;
               this.hero.speed = 1;
               if(this.exitCollision.IS_SX_EXIT)
               {
                  level.rightPressed = true;
                  if(this.hero.xPos >= this.hero.originalXPos - 16)
                  {
                     this.hero.stateMachine.setState("IS_BRAKING_STATE");
                     PROGRESSION = 3;
                  }
               }
               else
               {
                  level.leftPressed = true;
                  if(this.hero.xPos <= this.hero.originalXPos + 16)
                  {
                     this.hero.stateMachine.setState("IS_BRAKING_STATE");
                     PROGRESSION = 3;
                  }
               }
            }
            else if(PROGRESSION == 3)
            {
               if(this.exitCollision.IS_SX_EXIT)
               {
                  if(this.hero.xPos >= this.hero.originalXPos)
                  {
                     level.rightPressed = false;
                     this.hero.xPos = this.hero.originalXPos;
                     this.hero.xVel = 0;
                     PROGRESSION = 4;
                  }
               }
               else if(this.hero.xPos <= this.hero.originalXPos)
               {
                  level.leftPressed = false;
                  this.hero.xPos = this.hero.originalXPos;
                  this.hero.xVel = 0;
                  PROGRESSION = 4;
               }
            }
            else if(PROGRESSION == 4)
            {
               if(this.exitCollision.IS_SX_EXIT)
               {
                  this.hero.DIRECTION = Entity.RIGHT;
               }
               else
               {
                  this.hero.DIRECTION = Entity.LEFT;
               }
               if(this.IS_FROM_MAP)
               {
                  this.hero.stateMachine.setState("IS_LEVEL_START_STATE");
               }
               ++PROGRESSION;
            }
            else if(PROGRESSION == 5)
            {
               if(this.hero.stateMachine.currentState != "IS_LEVEL_START_STATE")
               {
                  level.levelData.setTileValueAt(this.x_t_1,this.y_t_1,this.value_1);
                  level.levelData.setTileValueAt(this.x_t_2,this.y_t_2,this.value_2);
                  ++PROGRESSION;
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         counter1 = 0;
      }
      
      override protected function isShowHideCatButtonCutscene() : Boolean
      {
         return false;
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         var index:int = 0;
         var focal_shift_x:Number = NaN;
         var xDiff:Number = NaN;
         var yDiff:Number = NaN;
         var distance:Number = NaN;
         var min_distance:Number = -1;
         super.initState();
         this.hero = level.hero;
         if(!(Utils.SEA_LEVEL > 0 && level.hero.yPos >= Utils.SEA_LEVEL))
         {
            if(this.TYPE == StartPosition.STATIC)
            {
               this.exitCollision = null;
            }
            else
            {
               focal_shift_x = level.camera.getMaxXFocal();
               for(i = 0; i < level.collisionsManager.collisions.length; i++)
               {
                  if(level.collisionsManager.collisions[i] != null)
                  {
                     if(level.collisionsManager.collisions[i] is ExitCollision)
                     {
                        if(ExitCollision(level.collisionsManager.collisions[i]).NOT_A_DOOR == false)
                        {
                           xDiff = this.hero.getMidXPos() - level.collisionsManager.collisions[i].getMidXPos();
                           yDiff = this.hero.getMidYPos() - level.collisionsManager.collisions[i].getMidYPos();
                           distance = Math.sqrt(xDiff * xDiff + yDiff * yDiff);
                           if(distance < min_distance || min_distance == -1)
                           {
                              min_distance = distance;
                              index = i;
                           }
                        }
                     }
                  }
               }
               this.exitCollision = level.collisionsManager.collisions[index];
               this.exitCollision.startIntroCutscene();
               if(this.exitCollision.IS_SX_EXIT)
               {
                  this.hero.xPos = this.exitCollision.xPos - 24;
               }
               else
               {
                  this.hero.xPos = this.exitCollision.xPos + this.exitCollision.WIDTH + 24;
               }
               this.x_t_1 = int((this.hero.xPos + this.hero.WIDTH * 0.5) / Utils.TILE_WIDTH);
               this.y_t_1 = int((this.hero.yPos + this.hero.HEIGHT * 0.5) / Utils.TILE_HEIGHT);
               this.x_t_2 = this.x_t_1 + 1;
               this.y_t_2 = this.y_t_1;
               this.value_1 = level.levelData.getTileValueAt(this.x_t_1,this.y_t_1);
               this.value_2 = level.levelData.getTileValueAt(this.x_t_2,this.y_t_2);
               level.levelData.setTileValueAt(this.x_t_1,this.y_t_1,0);
               level.levelData.setTileValueAt(this.x_t_2,this.y_t_2,0);
            }
         }
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         Utils.LEVEL_REPEAT_FLAG = false;
         if(this.exitCollision)
         {
            this.exitCollision.endIntroCutscene();
         }
         level.levelStart();
         super.overState();
      }
   }
}
