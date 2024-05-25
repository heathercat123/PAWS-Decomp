package levels.cutscenes
{
   import entities.*;
   import entities.npcs.*;
   import game_utils.*;
   import levels.*;
   import levels.cameras.*;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.collisions.*;
   import states.LevelState;
   
   public class ElevatorCutscene extends Cutscene
   {
       
      
      protected var yellowPlatform:CutsceneYellowPlatformCollision;
      
      protected var GO_LEFT:Boolean;
      
      public function ElevatorCutscene(_level:Level)
      {
         super(_level);
         IS_BLACK_BANDS = false;
         this.GO_LEFT = false;
      }
      
      override public function destroy() : void
      {
         this.yellowPlatform = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var mid_x:Number = NaN;
         ++counter1;
         ++counter1;
         if(PROGRESSION == 0)
         {
            ++PROGRESSION;
         }
         else if(PROGRESSION == 1)
         {
            mid_x = level.hero.getMidXPos();
            if(mid_x < this.yellowPlatform.getMidXPos())
            {
               if(level.hero.DIRECTION == Entity.LEFT)
               {
                  PROGRESSION = 2;
                  level.hero.stateMachine.setState("IS_TURNING_STATE");
               }
               else
               {
                  PROGRESSION = 3;
               }
            }
            else if(level.hero.DIRECTION == Entity.RIGHT)
            {
               PROGRESSION = 2;
               level.hero.stateMachine.setState("IS_TURNING_STATE");
            }
            else
            {
               PROGRESSION = 3;
            }
         }
         else if(PROGRESSION == 2)
         {
            if(level.hero.stateMachine.currentState == "IS_STANDING_STATE")
            {
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 3)
         {
            mid_x = level.hero.getMidXPos();
            this.GO_LEFT = true;
            if(mid_x < this.yellowPlatform.getMidXPos())
            {
               this.GO_LEFT = false;
            }
            ++PROGRESSION;
         }
         else if(PROGRESSION == 4)
         {
            mid_x = level.hero.getMidXPos();
            if(this.GO_LEFT)
            {
               level.leftPressed = true;
               level.rightPressed = false;
               if(mid_x <= this.yellowPlatform.getMidXPos())
               {
                  level.leftPressed = false;
                  level.hero.stateMachine.setState("IS_STANDING_STATE");
                  level.hero.xVel = 0;
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            else
            {
               level.rightPressed = true;
               level.leftPressed = false;
               if(mid_x >= this.yellowPlatform.getMidXPos())
               {
                  level.rightPressed = false;
                  level.hero.stateMachine.setState("IS_STANDING_STATE");
                  level.hero.xVel = 0;
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 5)
         {
            if(level.hero.yPos <= level.camera.yPos - 24 || level.hero.yPos >= level.camera.yPos + Utils.HEIGHT)
            {
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 6)
         {
            ++PROGRESSION;
            stateMachine.performAction("END_ACTION");
         }
         if(PROGRESSION >= 5)
         {
            SoundSystem.PlaySound("red_platform");
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_3)
            {
               this.yellowPlatform.yPos -= 2;
            }
            else
            {
               this.yellowPlatform.yPos += 2;
            }
         }
      }
      
      override protected function isShowHideCatButtonCutscene() : Boolean
      {
         return false;
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         counter1 = 0;
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         super.initState();
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] is CutsceneYellowPlatformCollision)
            {
               this.yellowPlatform = level.collisionsManager.collisions[i] as CutsceneYellowPlatformCollision;
            }
         }
         var hor_tween:HorTweenShiftBehaviour = new HorTweenShiftBehaviour(level);
         hor_tween.x_start = level.camera.xPos;
         hor_tween.x_end = this.yellowPlatform.getMidXPos() - Utils.WIDTH * 0.5;
         hor_tween.tick = 0;
         hor_tween.time = 1;
         level.camera.changeHorBehaviour(hor_tween,true);
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_3 || Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_4)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 1;
         }
         level.CHANGE_ROOM_FLAG = true;
      }
   }
}
