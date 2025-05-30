package entities
{
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import sprites.*;
   import sprites.cats.*;
   
   public class EvilCatHero extends Hero
   {
      
      protected var victory_counter_1:int;
      
      public function EvilCatHero(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction);
         this.victory_counter_1 = 0;
      }
      
      override protected function getHeroSprite() : GameSprite
      {
         return new EvilCatSprite();
      }
      
      override protected function updateAABB() : void
      {
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 17;
         if(AABB_TYPE == 1)
         {
            aabb.x = 1;
            aabb.y = -3;
            aabb.width = 14;
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
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_LEVEL_COMPLETE_STATE")
         {
         }
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
         if(!level.hud.IS_DARK_FADE_ON)
         {
            SoundSystem.PlaySound("rigs");
         }
      }
      
      override public function ropeClimbingAnimation() : void
      {
         super.ropeClimbingAnimation();
         sprite.gfxHandle().gotoAndStop(20);
      }
      
      override public function ropeTurningAnimation() : void
      {
         super.ropeTurningAnimation();
         sprite.gfxHandle().gotoAndStop(21);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
   }
}

