package entities.fishing
{
   import entities.Entity;
   import levels.Level;
   import levels.worlds.fishing.LevelFishing;
   
   public class Fish extends BaseFish
   {
      
      public static var GREEN_CARP:int = 0;
      
      public static var SNAIL:int = 1;
      
      public static var CAT_FISH:int = 2;
      
      public static var GOLDFISH:int = 3;
      
      public static var TADPOLE:int = 4;
      
      public static var SALAMANDER:int = 5;
      
      public static var TURTLE:int = 6;
      
      public static var FROG:int = 7;
      
      public static var SQUID:int = 8;
      
      public static var CRAB:int = 9;
      
      public static var RED_JUMPER:int = 10;
      
      public static var BLOWFISH:int = 11;
      
      public static var SHARK:int = 12;
      
      public static var STINGRAY:int = 13;
      
      public static var OCTOPUS:int = 14;
      
      public static var JELLYFISH:int = 15;
      
      public static var RANK_1:int = 0;
      
      public static var RANK_1_2:int = 1;
      
      public static var RANK_2:int = 2;
      
      public static var RANK_2_3:int = 3;
      
      public static var RANK_3:int = 4;
      
      public static var RANK_3_4:int = 5;
      
      public static var RANK_4:int = 6;
      
      public static var RANK_4_5:int = 7;
      
      public static var RANK_5:int = 8;
      
      public static var RANK_5_6:int = 9;
      
      public static var RANK_6:int = 10;
       
      
      public function Fish(_level:Level, _type:int, _rank:int, _xPos:Number, _yPos:Number, _direction:int, _size:Number)
      {
         super(_level,_type,_rank,_xPos,_yPos,_direction,_size);
         counter1 = counter2 = 0;
         if(TYPE == Fish.SNAIL || TYPE == Fish.CRAB)
         {
            aabbPhysics.x = aabbPhysics.y = -6;
            aabbPhysics.width = aabbPhysics.height = 12;
            aabb.y = -5;
            aabb.height = 10;
            MAX_X_VEL = 0.02;
         }
         else if(TYPE == Fish.TADPOLE || TYPE == Fish.FROG)
         {
            aabb.y = -4;
            aabb.height = 8;
         }
         else if(TYPE == Fish.SALAMANDER)
         {
            aabb.x = -12;
            aabb.y = -6;
            aabb.width = 24;
            aabb.height = 12;
            aabbPhysics.x = -10;
            aabbPhysics.y = -8;
            aabbPhysics.width = 20;
            aabbPhysics.height = 16;
            MAX_X_VEL = 0.02;
         }
         else if(TYPE == Fish.OCTOPUS)
         {
            aabb.x = -12;
            aabb.y = -10;
            aabb.width = 24;
            aabb.height = 20;
            aabbPhysics.x = -10;
            aabbPhysics.y = -8;
            aabbPhysics.width = 20;
            aabbPhysics.height = 16;
            MAX_X_VEL = 0.02;
         }
         else if(TYPE == Fish.CAT_FISH)
         {
            aabb.x = aabb.y = -10;
            aabb.width = aabb.height = 20;
            aabbPhysics.x = aabbPhysics.y = -9;
            aabbPhysics.width = aabbPhysics.height = 18;
         }
         else if(TYPE == Fish.TURTLE || TYPE == Fish.STINGRAY)
         {
            aabb.x = -12;
            aabb.y = -8;
            aabb.width = 24;
            aabb.height = 16;
            aabbPhysics.x = aabbPhysics.y = -9;
            aabbPhysics.width = aabbPhysics.height = 18;
            MAX_X_VEL = 0.125;
         }
         else if(TYPE == Fish.SHARK)
         {
            aabb.x = -12;
            aabb.y = -7;
            aabb.width = 23;
            aabb.height = 16;
            aabbPhysics.x = -12;
            aabbPhysics.y = -7;
            aabbPhysics.width = 23;
            aabbPhysics.height = 16;
         }
         else if(TYPE == Fish.SQUID || TYPE == Fish.JELLYFISH)
         {
            counter1 = Math.random() * 150;
         }
      }
      
      override protected function updateBrain() : void
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         var fLevel:LevelFishing = level as LevelFishing;
         if(BRAIN_STATE == 0)
         {
            if(xPos >= originalXPos)
            {
               destX = originalXPos - (Math.random() * 16 + 16);
            }
            else
            {
               destX = originalXPos + (Math.random() * 16 + 16);
            }
            if(TYPE == Fish.SNAIL || TYPE == Fish.CRAB || TYPE == Fish.SALAMANDER || TYPE == Fish.OCTOPUS)
            {
               destY = yPos;
            }
            else if(TYPE == Fish.SQUID || TYPE == Fish.JELLYFISH)
            {
               destX = originalXPos;
               if(yPos >= originalYPos)
               {
                  destY = originalYPos - 16;
               }
               else
               {
                  destY = originalYPos + 16;
               }
               if(destY <= Utils.SEA_LEVEL + 8)
               {
                  destY = Utils.SEA_LEVEL + 8;
               }
               counter1 = Math.random() * 150;
            }
            else
            {
               if(Math.random() * 100 > 20)
               {
                  destY = originalYPos;
               }
               else
               {
                  destY = originalYPos - 16 + Math.random() * 32;
               }
               if(destY <= Utils.SEA_LEVEL + HEIGHT)
               {
                  destY = Utils.SEA_LEVEL + HEIGHT;
               }
            }
            counter1 = counter2 = 0;
            BRAIN_STATE = 1;
         }
         else if(BRAIN_STATE == 1)
         {
            if(TYPE == Fish.SNAIL || TYPE == Fish.CRAB || TYPE == Fish.SALAMANDER || TYPE == Fish.OCTOPUS)
            {
               diff_x = destX - xPos;
               diff_y = 0;
               distance = Math.abs(destX - xPos);
            }
            else if(!(TYPE == Fish.SQUID || TYPE == Fish.JELLYFISH))
            {
               diff_x = destX - xPos;
               diff_y = destY - yPos;
               distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
            }
            if(TYPE == Fish.SQUID || TYPE == Fish.JELLYFISH)
            {
               if(destY <= yPos)
               {
                  if(counter1++ > 150)
                  {
                     counter1 = 0;
                     yVel = -0.5;
                     sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
                  }
                  if(yPos - 1 <= destY)
                  {
                     BRAIN_STATE = 0;
                  }
               }
               else
               {
                  yVel = 0.5;
                  if(yPos + 1 >= destY)
                  {
                     BRAIN_STATE = 0;
                  }
               }
            }
            else if(distance < 2)
            {
               distance = 0.1;
               BRAIN_STATE = 0;
            }
            else
            {
               diff_x /= distance;
               diff_y /= distance;
               xVel += diff_x * 0.02 * ground_friction;
               yVel += diff_y * 0.02 * ground_friction;
            }
         }
         else if(BRAIN_STATE == 3)
         {
            xVel = yVel = 0;
            if(!WRONG_INPUT)
            {
               if(direction_change_counter-- <= 0)
               {
                  direction_change_counter = getNewInterval();
                  if(FIGHT_DIRECTION == Entity.RIGHT)
                  {
                     FIGHT_DIRECTION = Entity.LEFT;
                  }
                  else
                  {
                     FIGHT_DIRECTION = Entity.RIGHT;
                  }
               }
            }
            if(yPos >= yPosWhenCaught + 16)
            {
               yPos = yPosWhenCaught + 16;
               yForce = 0;
               yVel = -0.1;
            }
            if(jump_counter_1 >= 0)
            {
               if(Math.abs(yPos - Utils.SEA_LEVEL) <= HEIGHT && xPos >= 368)
               {
                  --jump_counter_1;
                  if(jump_counter_1 <= 0)
                  {
                     jump_counter_1 = -1;
                     BRAIN_STATE = 4;
                     stateMachine.setState("IS_JUMPING_STATE");
                  }
               }
            }
         }
         else if(BRAIN_STATE == 6)
         {
            xVel += 1;
            if(yPos >= Utils.SEA_LEVEL + 32)
            {
               yVel -= 0.1;
            }
            else
            {
               yVel = 0;
            }
            x_friction = y_friction = 0.98;
            gravity_friction = 0;
            MAX_X_VEL = MAX_Y_VEL = 6;
         }
         super.updateBrain();
      }
      
      override public function groundCollision() : void
      {
         if(TYPE == Fish.SQUID || TYPE == Fish.JELLYFISH)
         {
            if(BRAIN_STATE == 1)
            {
               BRAIN_STATE = 0;
            }
            yPos -= 2;
         }
      }
      
      override protected function getFloatRadius() : Number
      {
         if(TYPE == Fish.SNAIL || TYPE == Fish.CRAB || TYPE == Fish.SALAMANDER || TYPE == Fish.OCTOPUS)
         {
            if(BRAIN_STATE <= 1)
            {
               return 0;
            }
         }
         return 1.5;
      }
   }
}
