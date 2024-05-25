package levels.cutscenes
{
   import entities.Hero;
   import levels.Level;
   import levels.cameras.behaviours.StaticHorBehaviour;
   import levels.collisions.DoorExitCollision;
   import levels.collisions.ExitCollision;
   
   public class LevelOutroCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var exitCollision:ExitCollision;
      
      protected var hero_original_xPos:Number;
      
      protected var value_1:int;
      
      protected var x_t_1:int;
      
      protected var y_t_1:int;
      
      protected var value_2:int;
      
      protected var x_t_2:int;
      
      protected var y_t_2:int;
      
      protected var hero_xPos:Number;
      
      protected var IS_DOOR_COLLISION:Boolean;
      
      protected var mid_x:Number;
      
      protected var GO_RIGHT:Boolean;
      
      protected var IS_CASTLE_DOOR:Boolean;
      
      protected var DOOR_SOUND_JUST_ONCE:Boolean;
      
      public function LevelOutroCutscene(_level:Level)
      {
         this.IS_DOOR_COLLISION = false;
         this.IS_CASTLE_DOOR = false;
         this.mid_x = 0;
         this.hero_xPos = 0;
         this.GO_RIGHT = false;
         this.DOOR_SOUND_JUST_ONCE = true;
         super(_level);
         IS_BLACK_BANDS = false;
      }
      
      override public function destroy() : void
      {
         this.hero = null;
         this.exitCollision = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         ++counter1;
         if(this.IS_DOOR_COLLISION)
         {
            if(level.hero.IS_IN_WATER)
            {
               if(this.GO_RIGHT)
               {
                  ++level.hero.xPos;
                  if(level.hero.getMidXPos() >= this.mid_x)
                  {
                     if(this.DOOR_SOUND_JUST_ONCE)
                     {
                        SoundSystem.PlaySound("door_exit");
                        this.DOOR_SOUND_JUST_ONCE = false;
                     }
                     level.hero.xPos = this.mid_x - level.hero.WIDTH * 0.5;
                     level.hero.setBackAnimation();
                  }
               }
               else
               {
                  --level.hero.xPos;
                  if(level.hero.getMidXPos() <= this.mid_x)
                  {
                     if(this.DOOR_SOUND_JUST_ONCE)
                     {
                        SoundSystem.PlaySound("door_exit");
                        this.DOOR_SOUND_JUST_ONCE = false;
                     }
                     level.hero.xPos = this.mid_x - level.hero.WIDTH * 0.5;
                     level.hero.setBackAnimation();
                  }
               }
            }
            else if(this.GO_RIGHT)
            {
               level.rightPressed = true;
               if(level.hero.getMidXPos() >= this.mid_x)
               {
                  level.rightPressed = level.leftPressed = false;
                  level.hero.xVel = 0;
                  level.hero.xPos = this.mid_x - level.hero.WIDTH * 0.5;
                  if(this.DOOR_SOUND_JUST_ONCE)
                  {
                     SoundSystem.PlaySound("door_exit");
                     this.DOOR_SOUND_JUST_ONCE = false;
                  }
                  level.hero.stateMachine.setState("IS_STANDING_STATE");
                  level.hero.setBackAnimation();
               }
            }
            else
            {
               level.leftPressed = true;
               if(level.hero.getMidXPos() <= this.mid_x)
               {
                  level.rightPressed = level.leftPressed = false;
                  level.hero.xVel = 0;
                  level.hero.xPos = this.mid_x - level.hero.WIDTH * 0.5;
                  if(this.DOOR_SOUND_JUST_ONCE)
                  {
                     SoundSystem.PlaySound("door_exit");
                     this.DOOR_SOUND_JUST_ONCE = false;
                  }
                  level.hero.stateMachine.setState("IS_STANDING_STATE");
                  level.hero.setBackAnimation();
               }
            }
         }
         else if(this.IS_CASTLE_DOOR)
         {
            if(PROGRESSION == 0)
            {
               level.hero.xVel = 0;
               level.hero.xPos = this.hero_xPos;
               if(counter1 >= 15 && level.hero.stateMachine.currentState == "IS_STANDING_STATE")
               {
                  this.exitCollision.startOutroCutscene();
                  ++PROGRESSION;
                  counter1 = 0;
               }
            }
            else if(PROGRESSION == 1)
            {
               if(counter1 >= 30)
               {
                  if(this.exitCollision.IS_SX_EXIT)
                  {
                     level.leftPressed = true;
                  }
                  else
                  {
                     level.rightPressed = true;
                  }
                  if(counter1 >= 90)
                  {
                     ++PROGRESSION;
                     counter1 = 0;
                     this.exitCollision.endIntroCutscene();
                  }
               }
            }
            else if(PROGRESSION == 2)
            {
               if(counter1 == 60)
               {
                  if(this.exitCollision.DOOR_ID == 0)
                  {
                     level.EXIT_FLAG = true;
                  }
                  else
                  {
                     level.CHANGE_ROOM_FLAG = true;
                  }
               }
            }
         }
         else if(Utils.EXIT_DIRECTION > -1)
         {
            this.hero.xVel = this.hero.yVel = 0;
            if(Utils.EXIT_DIRECTION == 0)
            {
               this.hero.xPos += 1.5;
            }
            else if(Utils.EXIT_DIRECTION == 1)
            {
               this.hero.xPos -= 1.5;
            }
            else if(Utils.EXIT_DIRECTION == 2)
            {
               this.hero.yPos += 1.5;
            }
            else if(Utils.EXIT_DIRECTION == 3)
            {
               this.hero.yPos -= 1.5;
            }
         }
         else if(this.exitCollision.IS_SX_EXIT)
         {
            level.leftPressed = true;
            if(this.hero.xPos < this.hero_original_xPos - 96)
            {
               this.hero.xPos = this.hero_original_xPos - 96;
            }
         }
         else
         {
            level.rightPressed = true;
            if(this.hero.xPos > this.hero_original_xPos + 96)
            {
               this.hero.xPos = this.hero_original_xPos + 96;
            }
         }
         if(counter1 == 30 && !this.IS_CASTLE_DOOR)
         {
            if(this.exitCollision.DOOR_ID == 0)
            {
               level.EXIT_FLAG = true;
            }
            else
            {
               level.CHANGE_ROOM_FLAG = true;
            }
         }
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
         var index:int = 0;
         var xDiff:Number = NaN;
         var yDiff:Number = NaN;
         var distance:Number = NaN;
         var min_distance:Number = -1;
         super.initState();
         this.hero = level.hero;
         this.hero_original_xPos = this.hero.xPos;
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is ExitCollision)
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
         var camera_x:Number = level.camera.xPos;
         level.camera.changeHorBehaviour(new StaticHorBehaviour(level,camera_x),true);
         this.exitCollision = level.collisionsManager.collisions[index];
         if(this.exitCollision is DoorExitCollision)
         {
            if(DoorExitCollision(this.exitCollision).TYPE == 1)
            {
               this.IS_CASTLE_DOOR = true;
               this.hero_xPos = level.hero.xPos;
            }
         }
         if(!this.IS_CASTLE_DOOR)
         {
            this.exitCollision.startOutroCutscene();
         }
         if(this.exitCollision.EXIT_TYPE == 1)
         {
            this.IS_DOOR_COLLISION = true;
            this.mid_x = this.exitCollision.getMidXPos();
            if(level.hero.getMidXPos() < this.mid_x)
            {
               this.GO_RIGHT = true;
            }
            else
            {
               this.GO_RIGHT = false;
            }
         }
         else
         {
            this.IS_DOOR_COLLISION = false;
         }
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function isShowHideCatButtonCutscene() : Boolean
      {
         return false;
      }
      
      override protected function overState() : void
      {
         this.exitCollision.endOutroCutscene();
         super.overState();
      }
   }
}
