package entities
{
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import sprites.*;
   import sprites.cats.SmallCatSprite;
   
   public class SmallCatHero extends Hero
   {
       
      
      protected var walk_hole_counter1:int;
      
      protected var in_hole_counter:int;
      
      public function SmallCatHero(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction);
         stateMachine.setRule("IS_HOPPING_STATE","INSIDE_HOLE_ACTION","IS_WALKING_HOLE_STATE");
         stateMachine.setRule("IS_WALKING_STATE","INSIDE_HOLE_ACTION","IS_WALKING_HOLE_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","INSIDE_HOLE_ACTION","IS_WALKING_HOLE_STATE");
         stateMachine.setRule("IS_WALKING_HOLE_STATE","ZERO_X_VEL_ACTION","IS_STANDING_HOLE_STATE");
         stateMachine.setRule("IS_STANDING_HOLE_STATE","INCREASE_VEL_ACTION","IS_WALKING_HOLE_STATE");
         stateMachine.setRule("IS_STANDING_HOLE_STATE","OPPOSITE_VEL_ACTION","IS_TURNING_HOLE_STATE");
         stateMachine.setRule("IS_WALKING_HOLE_STATE","OPPOSITE_VEL_ACTION","IS_TURNING_WALKING_HOLE_STATE");
         stateMachine.setRule("IS_TURNING_WALKING_HOLE_STATE","END_ACTION","IS_WALKING_HOLE_STATE");
         stateMachine.setRule("IS_TURNING_HOLE_STATE","END_ACTION","IS_STANDING_HOLE_STATE");
         stateMachine.setRule("IS_WALKING_HOLE_STATE","OUTSIDE_HOLE_ACTION","IS_WALKING_STATE");
         stateMachine.setFunctionToState("IS_WALKING_HOLE_STATE",this.walkingHoleAnimation);
         stateMachine.setFunctionToState("IS_STANDING_HOLE_STATE",this.standingHoleAnimation);
         stateMachine.setFunctionToState("IS_TURNING_HOLE_STATE",this.turningHoleAnimation);
         stateMachine.setFunctionToState("IS_TURNING_WALKING_HOLE_STATE",this.turningHoleAnimation);
         this.walk_hole_counter1 = 0;
         this.in_hole_counter = 0;
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_TURNING_HOLE_STATE" || stateMachine.currentState == "IS_TURNING_WALKING_HOLE_STATE")
         {
            xVel *= 0.9;
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_HOLE_STATE")
         {
            ++this.walk_hole_counter1;
            if(this.walk_hole_counter1 < 10)
            {
               xVel = 0;
            }
         }
         var x_t:int = getTileX(WIDTH * 0.5);
         var y_t:int = getTileY(HEIGHT * 0.5);
         if(stateMachine.currentState == "IS_HOPPING_STATE")
         {
            if(DIRECTION == Entity.RIGHT)
            {
               x_t = getTileX(WIDTH + 2);
            }
            else
            {
               x_t = getTileX(0 - 2);
            }
            y_t = getTileY(HEIGHT);
         }
         if(stateMachine.currentState == "IS_WALKING_HOLE_STATE" || stateMachine.currentState == "IS_STANDING_HOLE_STATE" || stateMachine.currentState == "IS_TURNING_HOLE_STATE" || stateMachine.currentState == "IS_TURNING_WALKING_HOLE_STATE")
         {
            ++this.in_hole_counter;
            if(level.levelData.getTileValueAt(x_t,y_t) != 14 && this.in_hole_counter >= 30)
            {
               stateMachine.performAction("OUTSIDE_HOLE_ACTION");
            }
         }
         else if(level.levelData.getTileValueAt(x_t,y_t) == 14)
         {
            this.walk_hole_counter1 = 0;
            stateMachine.performAction("INSIDE_HOLE_ACTION");
            this.in_hole_counter = 0;
         }
      }
      
      override protected function getHeroSprite() : GameSprite
      {
         return new SmallCatSprite();
      }
      
      protected function standingHoleAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(16);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function walkingHoleAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(17);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         x_friction = 0.8;
         MAX_X_VEL = 0.7;
         xVel = 0;
      }
      
      protected function turningHoleAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(18);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      override public function setInsideWater() : void
      {
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] == 85 && (stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || stateMachine.currentState == "IS_JUMPING_STATE") && (DIRECTION == RIGHT && level.rightPressed || DIRECTION == LEFT && level.leftPressed))
         {
            SoundSystem.PlaySound("water");
            stateMachine.setState("IS_JUMPING_STATE");
            yVel = -3.2;
         }
         else
         {
            super.setInsideWater();
         }
      }
      
      override public function levelStartAnimation() : void
      {
         super.levelStartAnimation();
         SoundSystem.PlaySound("cat_rose");
      }
      
      override public function levelCompleteAnimation() : void
      {
         super.levelCompleteAnimation();
      }
      
      override protected function updateAABB() : void
      {
         aabb.x = 2;
         aabb.y = -1;
         aabb.width = 12;
         aabb.height = 17;
         if(AABB_TYPE == 1)
         {
            aabb.x = 2;
            aabb.y = -3;
            aabb.width = 12;
            aabb.height = 15;
         }
         else if(AABB_TYPE == 2)
         {
            if(DIRECTION == RIGHT)
            {
               aabb.x = -3;
               aabb.y = 1;
               aabb.width = 14;
               aabb.height = 14;
            }
            else
            {
               aabb.x = 5;
               aabb.y = 1;
               aabb.width = 14;
               aabb.height = 14;
            }
         }
         if(BUBBLE_STATE > 0)
         {
            aabb.x = aabb.y = -4;
            aabb.width = aabb.height = 24;
         }
      }
   }
}
