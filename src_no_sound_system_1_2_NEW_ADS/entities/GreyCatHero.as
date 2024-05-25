package entities
{
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   import sprites.*;
   import sprites.cats.HeroSprite;
   
   public class GreyCatHero extends Hero
   {
       
      
      protected var victory_counter_1:int;
      
      protected var victory_counter_2:int;
      
      public function GreyCatHero(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction);
         this.victory_counter_1 = this.victory_counter_2 = 0;
         climb_max_value = 6;
      }
      
      override protected function getHeroSprite() : GameSprite
      {
         return new HeroSprite();
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_LEVEL_COMPLETE_STATE")
         {
            if(this.victory_counter_1++ == 35)
            {
               SoundSystem.PlaySound("cat_grey");
            }
         }
      }
      
      override protected function getClimbMaxValue() : int
      {
         if(IS_ON_ICE && Utils.Slot.gameVariables[GameSlot.VARIABLE_HELPER_EQUIPPED] != LevelItems.ITEM_ICE_POP)
         {
            return 2;
         }
         return 6;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
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
            SoundSystem.PlaySound("cat_grey");
         }
      }
      
      override public function levelCompleteAnimation() : void
      {
         super.levelCompleteAnimation();
      }
   }
}
