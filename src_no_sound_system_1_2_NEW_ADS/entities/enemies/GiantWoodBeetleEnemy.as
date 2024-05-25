package entities.enemies
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.*;
   
   public class GiantWoodBeetleEnemy extends GiantEnemy
   {
       
      
      protected var SIDE:int;
      
      protected var mid_point:Point;
      
      protected var front_point:Point;
      
      protected var friction:Number;
      
      protected var aabb2:Rectangle;
      
      protected var viewArea:Rectangle;
      
      protected var viewSight:int;
      
      protected var eyeSprite:GiantWoodBeetleEnemyEyesSprite;
      
      protected var EYE_SPRITE_VISIBLE:Boolean;
      
      protected var unhidingCounter:Array;
      
      protected var blinkSoundJustOnce:Boolean;
      
      protected var firstTime:Boolean;
      
      public function GiantWoodBeetleEnemy(_level:Level, _xPos:Number, _yPos:Number, _flipped_hor:int, _flipped_ver:int, __rotation:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,0,_ai_index);
         WIDTH = 32;
         HEIGHT = 32;
         this.friction = 1;
         this.firstTime = true;
         this.blinkSoundJustOnce = false;
         this.viewSight = 8;
         speed = 0.5;
         this.front_point = new Point();
         this.mid_point = new Point();
         this.viewArea = new Rectangle();
         this.unhidingCounter = null;
         sprite = new GiantWoodBeetleEnemySprite();
         Utils.world.addChild(sprite);
         this.eyeSprite = new GiantWoodBeetleEnemyEyesSprite();
         sprite.gfxHandle().addChild(this.eyeSprite);
         this.eyeSprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         this.eyeSprite.x = 13;
         this.eyeSprite.y = 34;
         aabb.x = aabbPhysics.x = 0;
         aabb.y = aabbPhysics.y = 0;
         aabb.height = aabbPhysics.height = 32;
         aabb.width = aabbPhysics.width = 32;
         frame_counter = frame_speed = 0;
         this.EYE_SPRITE_VISIBLE = true;
         this.aabb2 = new Rectangle(0,0,0,0);
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","RUN_ACTION","IS_SURPRISED_STATE");
         stateMachine.setRule("IS_SURPRISED_STATE","END_ACTION","IS_RUNNING_STATE");
         stateMachine.setRule("IS_RUNNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SHAKE_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","FALL_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","SHAKE_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_HIDING_STATE","END_ACTION","IS_UNHIDING_STATE");
         stateMachine.setRule("IS_UNHIDING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_SLEEPING_STATE","END_ACTION","IS_UNHIDING_STATE");
         stateMachine.setRule("IS_HURT_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_HURT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_SURPRISED_STATE",this.surprisedAnimation);
         stateMachine.setFunctionToState("IS_RUNNING_STATE",this.runningAnimation);
         stateMachine.setFunctionToState("IS_HIDING_STATE",this.hidingAnimation);
         stateMachine.setFunctionToState("IS_UNHIDING_STATE",this.unhidingAnimation);
         stateMachine.setFunctionToState("IS_SLEEPING_STATE",this.sleepingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_HURT_STATE",this.hurtAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(_ai_index == 1)
         {
            stateMachine.setState("IS_SLEEPING_STATE");
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         this.setDirectionAndSide(__rotation);
         if(_flipped_hor <= 0)
         {
            DIRECTION = LEFT;
         }
         else
         {
            DIRECTION = RIGHT;
         }
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState == "IS_SLEEPING_STATE")
         {
            return false;
         }
         if(dead)
         {
            return false;
         }
         if(!isInsideInnerScreen())
         {
            return false;
         }
         return true;
      }
      
      override public function destroy() : void
      {
         this.mid_point = null;
         this.front_point = null;
         this.aabb2 = null;
         this.viewArea = null;
         sprite.gfxHandle().removeChild(this.eyeSprite);
         this.eyeSprite.destroy();
         this.eyeSprite.dispose();
         this.eyeSprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var RUN_ASAP:Boolean = false;
         super.update();
         if(stateMachine.currentState != "IS_SLEEPING_STATE")
         {
            if(stateMachine.currentState == "IS_SURPRISED_STATE")
            {
               if(counter2 == 0)
               {
                  ++counter1;
                  if(counter1 > 3)
                  {
                     xVel = yVel = 0;
                     if(this.SIDE == 0)
                     {
                        yVel = -3.5;
                     }
                     else if(this.SIDE == 1)
                     {
                        xVel = -3.5;
                     }
                     else if(this.SIDE == 2)
                     {
                        yVel = 3.5;
                     }
                     else
                     {
                        xVel = 3.5;
                     }
                     speed = 3;
                     counter2 = 1;
                  }
               }
               else
               {
                  if(this.SIDE == 0)
                  {
                     yVel += 0.4;
                     if(yPos > originalYPos)
                     {
                        SoundSystem.PlaySound("ground_stomp");
                        yPos = originalYPos;
                        stateMachine.performAction("END_ACTION");
                     }
                  }
                  else if(this.SIDE == 1)
                  {
                     xVel += 0.4;
                     if(xPos > originalXPos)
                     {
                        xPos = originalXPos;
                        stateMachine.performAction("END_ACTION");
                     }
                  }
                  else if(this.SIDE == 2)
                  {
                     yVel -= 0.4;
                     if(yPos < originalYPos)
                     {
                        yPos = originalYPos;
                        stateMachine.performAction("END_ACTION");
                     }
                  }
                  else
                  {
                     xVel -= 0.4;
                     if(xPos < originalXPos)
                     {
                        xPos = originalXPos;
                        stateMachine.performAction("END_ACTION");
                     }
                  }
                  this.integratePosition();
               }
            }
            else if(stateMachine.currentState == "IS_WALKING_STATE")
            {
               RUN_ASAP = false;
               if(this.isOnHeroPlatform())
               {
                  RUN_ASAP = true;
               }
               if(this.SIDE == 0)
               {
                  this.updateTop();
               }
               else if(this.SIDE == 1)
               {
                  this.updateLeft();
               }
               else if(this.SIDE == 2)
               {
                  this.updateBottom();
               }
               else if(this.SIDE == 3)
               {
                  this.updateRight();
               }
               if(RUN_ASAP)
               {
                  SoundSystem.PlaySound("eye_blink");
                  stateMachine.performAction("RUN_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_RUNNING_STATE")
            {
               if(counter2++ > 20)
               {
                  this.friction += 0.1;
                  if(this.friction >= 1)
                  {
                     this.friction = 1;
                  }
               }
               if(this.SIDE == 0)
               {
                  this.updateTop();
               }
               else if(this.SIDE == 1)
               {
                  this.updateLeft();
               }
               else if(this.SIDE == 2)
               {
                  this.updateBottom();
               }
               else if(this.SIDE == 3)
               {
                  this.updateRight();
               }
               if(counter1++ > 90)
               {
                  speed *= 0.95;
                  if(speed <= 0.5)
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
               else
               {
                  SoundSystem.PlaySound("ground_stomp");
                  if(counter3++ > 0)
                  {
                     counter3 = -int(Math.random() * 5);
                     level.particlesManager.groundSmokeParticles(this,WIDTH,this.SIDE);
                  }
               }
            }
            else if(stateMachine.currentState == "IS_TURNING_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_HIDING_STATE")
            {
               ++counter1;
               if(counter1 >= 240)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_FALLING_STATE")
            {
               yPos += 4;
               if(yPos >= 528 - 32)
               {
                  SoundSystem.PlaySound("big_enemy_impact");
                  stateMachine.setState("IS_HIT_STATE");
               }
            }
            else if(stateMachine.currentState == "IS_UNHIDING_STATE")
            {
               if(counter2 % 2 == 0)
               {
                  this.blinkSoundJustOnce = true;
                  this.EYE_SPRITE_VISIBLE = true;
               }
               else
               {
                  if(this.blinkSoundJustOnce)
                  {
                     this.blinkSoundJustOnce = false;
                  }
                  this.EYE_SPRITE_VISIBLE = false;
               }
               ++counter1;
               if(counter1 > this.unhidingCounter[counter2])
               {
                  counter1 = 0;
                  ++counter2;
                  if(counter2 >= 5)
                  {
                     if(this.firstTime)
                     {
                        Utils.NoMusicBeingPlayed = false;
                        SoundSystem.PlayMusic("boss");
                        this.firstTime = false;
                     }
                     stateMachine.performAction("END_ACTION");
                  }
                  else if(counter2 % 2 != 0)
                  {
                     SoundSystem.PlaySound("eye_blink");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_HIT_STATE")
            {
               this.EYE_SPRITE_VISIBLE = false;
            }
         }
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(this.SIDE == 0)
            {
               aabb.x = 0;
               aabb.y = 10;
               aabb.width = 32;
               aabb.height = 22;
               this.aabb2.x = 11;
               this.aabb2.y = -1;
               this.aabb2.width = 10;
               this.aabb2.height = 11;
            }
            else if(this.SIDE == 1)
            {
               aabb.x = 10;
               aabb.y = 0;
               aabb.width = 22;
               aabb.height = 32;
               this.aabb2.x = -1;
               this.aabb2.y = 11;
               this.aabb2.width = 11;
               this.aabb2.height = 10;
            }
            else if(this.SIDE == 2)
            {
               aabb.x = 0;
               aabb.y = 0;
               aabb.width = 32;
               aabb.height = 22;
               this.aabb2.x = 11;
               this.aabb2.y = 22;
               this.aabb2.width = 10;
               this.aabb2.height = 11;
            }
            else
            {
               aabb.x = 0;
               aabb.y = 0;
               aabb.width = 22;
               aabb.height = 32;
               this.aabb2.x = 22;
               this.aabb2.y = 11;
               this.aabb2.width = 11;
               this.aabb2.height = 10;
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(this.SIDE == 1)
            {
               aabb.x = 10;
               aabb.y = -7;
            }
            else if(this.SIDE == 2)
            {
               aabb.x = -7;
               aabb.y = -10;
            }
            else if(this.SIDE == 3)
            {
               aabb.x = -10;
               aabb.y = 7;
            }
            else
            {
               aabb.x = 7;
               aabb.y = 10;
            }
            aabb.width = aabb.height = 32;
            this.aabb2.width = this.aabb2.height = 0;
         }
         if(this.SIDE == 0 || this.SIDE == 2)
         {
            this.viewArea.width = Utils.TILE_WIDTH * this.viewSight;
            if(this.SIDE == 2)
            {
               this.viewArea.width = Utils.TILE_WIDTH * 2;
            }
            this.viewArea.height = Utils.TILE_HEIGHT;
            if(this.SIDE == 0)
            {
               if(DIRECTION == LEFT)
               {
                  this.viewArea.x = xPos - this.viewArea.width;
               }
               else
               {
                  this.viewArea.x = xPos + WIDTH;
               }
               this.viewArea.y = yPos + HEIGHT - this.viewArea.height;
            }
            else
            {
               if(DIRECTION == LEFT)
               {
                  this.viewArea.x = xPos + WIDTH;
               }
               else
               {
                  this.viewArea.x = xPos - this.viewArea.width;
               }
               this.viewArea.y = yPos;
            }
         }
         else
         {
            this.viewArea.width = Utils.TILE_WIDTH;
            this.viewArea.height = Utils.TILE_HEIGHT * 2;
            if(this.SIDE == 1)
            {
               if(DIRECTION == LEFT)
               {
                  this.viewArea.y = yPos + HEIGHT;
               }
               else
               {
                  this.viewArea.y = yPos - this.viewArea.height;
               }
               this.viewArea.x = xPos + WIDTH - this.viewArea.width;
            }
            else
            {
               if(DIRECTION == LEFT)
               {
                  this.viewArea.y = yPos - this.viewArea.height;
               }
               else
               {
                  this.viewArea.y = yPos + HEIGHT;
               }
               this.viewArea.x = xPos;
            }
         }
         if(sprite.gfxHandle().frame == 1)
         {
            if(speed > 1)
            {
               frame_speed = speed * 0.1666;
            }
            else
            {
               frame_speed = speed * 0.333;
            }
            frame_counter += frame_speed;
            if(frame_counter >= 4)
            {
               frame_counter -= 4;
            }
         }
      }
      
      protected function updateTop() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         this.mid_point.x = WIDTH * 0.5;
         this.mid_point.y = HEIGHT;
         if(DIRECTION == LEFT)
         {
            this.front_point.x = 0;
            this.front_point.y = HEIGHT * 0.5;
            xVel = -speed;
            yVel += 4;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = (x_t + 1) * Utils.TILE_WIDTH - WIDTH;
               yPos = y_t * Utils.TILE_HEIGHT - WIDTH * 0.5;
               xVel = yVel = 0;
               this.SIDE = 1;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
            {
               if(stateMachine.currentState == "IS_RUNNING_STATE")
               {
                  stateMachine.performAction("TURN_FRONT_ACTION");
               }
               else
               {
                  xPos = (x_t + 1) * Utils.TILE_WIDTH;
                  yPos = (y_t + 1) * Utils.TILE_HEIGHT - HEIGHT;
                  xVel = yVel = 0;
                  this.SIDE = 3;
               }
            }
         }
         else
         {
            this.front_point.x = WIDTH - 0;
            this.front_point.y = HEIGHT * 0.5;
            xVel = speed;
            yVel += 4;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH;
               yPos = y_t * Utils.TILE_HEIGHT - HEIGHT * 0.5;
               xVel = yVel = 0;
               this.SIDE = 3;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
            {
               if(stateMachine.currentState == "IS_RUNNING_STATE")
               {
                  stateMachine.performAction("TURN_FRONT_ACTION");
               }
               else
               {
                  xPos = x_t * Utils.TILE_WIDTH - WIDTH;
                  yPos = (y_t + 1) * Utils.TILE_HEIGHT - HEIGHT;
                  xVel = yVel = 0;
                  this.SIDE = 1;
               }
            }
         }
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      protected function updateLeft() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         this.mid_point.x = WIDTH;
         this.mid_point.y = HEIGHT * 0.5;
         if(DIRECTION == LEFT)
         {
            this.front_point.x = WIDTH * 0.5;
            this.front_point.y = HEIGHT - 2;
            yVel = speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH - WIDTH * 0.5;
               yPos = y_t * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 2;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
            {
               if(stateMachine.currentState == "IS_RUNNING_STATE")
               {
                  stateMachine.performAction("TURN_FRONT_ACTION");
               }
               else
               {
                  xPos = (x_t + 1) * Utils.TILE_WIDTH - WIDTH;
                  yPos = y_t * Utils.TILE_HEIGHT - HEIGHT;
                  xVel = yVel = 0;
                  this.SIDE = 0;
               }
            }
         }
         else
         {
            this.front_point.x = WIDTH * 0.5;
            this.front_point.y = 2;
            yVel = -speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH - WIDTH * 0.5;
               yPos = (y_t + 1) * Utils.TILE_HEIGHT - HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 0;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
            {
               if(stateMachine.currentState == "IS_RUNNING_STATE")
               {
                  stateMachine.performAction("TURN_FRONT_ACTION");
               }
               else
               {
                  stateMachine.performAction("TURN_FRONT_ACTION");
                  xPos = (x_t + 1) * Utils.TILE_WIDTH - WIDTH;
                  yPos = (y_t + 1) * Utils.TILE_HEIGHT;
                  xVel = yVel = 0;
                  this.SIDE = 2;
               }
            }
         }
      }
      
      protected function updateBottom() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         this.mid_point.x = WIDTH * 0.5;
         this.mid_point.y = 0;
         if(DIRECTION == LEFT)
         {
            this.front_point.x = WIDTH - 2;
            this.front_point.y = HEIGHT * 0.5;
            xVel = speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y - 1) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = x_t * Utils.TILE_WIDTH;
               yPos = (y_t - 1) * Utils.TILE_HEIGHT + HEIGHT * 0.5;
               xVel = yVel = 0;
               this.SIDE = 3;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
            {
               if(stateMachine.currentState == "IS_RUNNING_STATE")
               {
                  stateMachine.performAction("TURN_FRONT_ACTION");
               }
               else
               {
                  xPos = x_t * Utils.TILE_WIDTH - WIDTH;
                  yPos = (y_t - 1) * Utils.TILE_HEIGHT;
                  xVel = yVel = 0;
                  this.SIDE = 1;
               }
            }
         }
         else
         {
            this.front_point.x = 2;
            this.front_point.y = HEIGHT * 0.5;
            xVel = -speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y - 1) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = (x_t + 1) * Utils.TILE_WIDTH - WIDTH;
               yPos = (y_t + 1) * Utils.TILE_HEIGHT - HEIGHT * 0.5;
               xVel = yVel = 0;
               this.SIDE = 1;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
            {
               if(stateMachine.currentState == "IS_RUNNING_STATE")
               {
                  stateMachine.performAction("TURN_FRONT_ACTION");
               }
               else
               {
                  xPos = (x_t + 1) * Utils.TILE_WIDTH;
                  yPos = (y_t - 1) * Utils.TILE_HEIGHT;
                  xVel = yVel = 0;
                  this.SIDE = 3;
               }
            }
         }
      }
      
      protected function updateRight() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         this.mid_point.x = 0;
         this.mid_point.y = HEIGHT * 0.5;
         if(DIRECTION == LEFT)
         {
            this.front_point.x = WIDTH * 0.5;
            this.front_point.y = 2;
            yVel = -speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x - 1) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = (x_t + 1) * Utils.TILE_WIDTH - WIDTH * 0.5;
               yPos = (y_t + 1) * Utils.TILE_HEIGHT - HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 0;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
            {
               if(stateMachine.currentState == "IS_RUNNING_STATE")
               {
                  stateMachine.performAction("TURN_FRONT_ACTION");
               }
               else
               {
                  xPos = (x_t - 1) * Utils.TILE_WIDTH;
                  yPos = (y_t + 1) * Utils.TILE_HEIGHT;
                  xVel = yVel = 0;
                  this.SIDE = 2;
               }
            }
         }
         else
         {
            this.front_point.x = WIDTH * 0.5;
            this.front_point.y = HEIGHT - 2;
            yVel = speed;
            this.integratePosition();
            x_t = int((xPos + this.mid_point.x - 1) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.mid_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               stateMachine.performAction("TURN_ACTION");
               xPos = (x_t + 1) * Utils.TILE_WIDTH - WIDTH * 0.5;
               yPos = y_t * Utils.TILE_HEIGHT;
               xVel = yVel = 0;
               this.SIDE = 2;
            }
            x_t = int((xPos + this.front_point.x) / Utils.TILE_WIDTH);
            y_t = int((yPos + this.front_point.y) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 1)
            {
               if(stateMachine.currentState == "IS_RUNNING_STATE")
               {
                  stateMachine.performAction("TURN_FRONT_ACTION");
               }
               else
               {
                  xPos = (x_t - 1) * Utils.TILE_WIDTH;
                  yPos = y_t * Utils.TILE_HEIGHT - HEIGHT;
                  xVel = yVel = 0;
                  this.SIDE = 0;
               }
            }
         }
      }
      
      protected function integratePosition() : void
      {
         var x_friction:Number = 1;
         var y_friction:Number = 1;
         if(this.SIDE == 0 || this.SIDE == 2)
         {
            x_friction = this.friction;
         }
         else
         {
            y_friction = this.friction;
         }
         xPos += xVel * x_friction;
         yPos += yVel * y_friction;
      }
      
      override public function shake() : void
      {
         if(stateMachine.currentState == "IS_HIT_STATE" || stateMachine.currentState == "IS_GAME_OVER_STATE")
         {
            return;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.SIDE == 1)
         {
            sprite.gfxHandle().rotation = -Math.PI * 0.5;
         }
         else if(this.SIDE == 2)
         {
            sprite.gfxHandle().rotation = Math.PI;
         }
         else if(this.SIDE == 3)
         {
            sprite.gfxHandle().rotation = Math.PI * 0.5;
         }
         else
         {
            sprite.gfxHandle().rotation = 0;
         }
         if(sprite.gfxHandle().frame == 1)
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(int(frame_counter + 1));
            if(sprite.gfxHandle().gfxHandleClip().currentFrame == 1 || sprite.gfxHandle().gfxHandleClip().currentFrame == 3)
            {
               this.eyeSprite.y = 33;
            }
            else
            {
               this.eyeSprite.y = 34;
            }
         }
         else if(sprite.gfxHandle().frame == 4)
         {
            this.eyeSprite.y = 36;
         }
         sprite.gfxHandle().setChildIndex(this.eyeSprite,sprite.gfxHandle().numChildren - 1);
         this.eyeSprite.visible = this.EYE_SPRITE_VISIBLE;
         if(stateMachine.currentState == "IS_HURT_STATE")
         {
            if(this.SIDE == 0)
            {
               stunHandler.stun_x_offset = 0;
               stunHandler.stun_y_offset = -9;
            }
            else if(this.SIDE == 1)
            {
               stunHandler.stun_x_offset = -16;
               stunHandler.stun_y_offset = 14;
               stunHandler.sprite.rotation = 1.5 * Math.PI;
            }
            else if(this.SIDE == 2)
            {
               stunHandler.stun_x_offset = 0;
               stunHandler.stun_y_offset = 32;
               stunHandler.sprite.rotation = Math.PI * 1;
            }
            else if(this.SIDE == 3)
            {
               stunHandler.stun_x_offset = 16;
               stunHandler.stun_y_offset = 14;
               stunHandler.sprite.rotation = 0.5 * Math.PI;
            }
         }
      }
      
      public function walkingAnimation() : void
      {
         speed = 0.5;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.EYE_SPRITE_VISIBLE = true;
         this.eyeSprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
      }
      
      public function runningAnimation() : void
      {
         this.friction = 0;
         speed = 3;
         sprite.gfxHandle().gotoAndStop(1);
         counter1 = counter2 = counter3 = 0;
         xVel = yVel = 0;
         this.EYE_SPRITE_VISIBLE = true;
         this.eyeSprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
      }
      
      public function surprisedAnimation() : void
      {
         SoundSystem.PlaySound("beetle_attack");
         speed = 0;
         sprite.gfxHandle().gotoAndStop(1);
         originalXPos = xPos;
         originalYPos = yPos;
         xVel = 0;
         yVel = 0;
         counter1 = counter2 = 0;
         this.EYE_SPRITE_VISIBLE = true;
         this.eyeSprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
      }
      
      public function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         this.EYE_SPRITE_VISIBLE = false;
      }
      
      override public function hurtAnimation() : void
      {
         super.hurtAnimation();
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.EYE_SPRITE_VISIBLE = false;
         xVel = yVel = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         level.topParticlesManager.hurtImpactParticle(this,xPos + this.front_point.x,yPos + this.front_point.y);
         level.camera.shake(8);
         if(KILLED_BY_CAT)
         {
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_WOOD_BEETLE_DEFEATED_BY_ANY_CAT);
         }
         var hor_vel:Number = 1;
         var ver_vel:Number = 2.5;
         setHitVariables();
         counter1 = counter2 = 0;
         this.EYE_SPRITE_VISIBLE = false;
      }
      
      public function hidingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
         this.EYE_SPRITE_VISIBLE = false;
      }
      
      public function unhidingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(4);
         this.randomizeUnhiding();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
         this.EYE_SPRITE_VISIBLE = true;
      }
      
      public function sleepingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(4);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
         this.EYE_SPRITE_VISIBLE = false;
      }
      
      public function fallingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
         this.EYE_SPRITE_VISIBLE = false;
      }
      
      protected function setDirectionAndSide(__rotation:int) : void
      {
         if(__rotation == 0)
         {
            this.SIDE = 0;
         }
         else if(__rotation == -90)
         {
            this.SIDE = 1;
         }
         else if(__rotation == 180)
         {
            this.SIDE = 2;
         }
         else if(__rotation == 90)
         {
            this.SIDE = 3;
         }
      }
      
      protected function randomizeUnhiding() : void
      {
         var i:int = 0;
         var time_left:Number = NaN;
         var amount:Number = 0;
         var total:Number = 0;
         if(this.unhidingCounter == null)
         {
            this.unhidingCounter = new Array();
            for(i = 0; i < 5; i++)
            {
               this.unhidingCounter.push(0);
            }
         }
         for(i = 0; i < 4; i++)
         {
            amount = int(Math.random() * 2 + 1) * 6;
            this.unhidingCounter[i] = amount;
            total += amount;
         }
         time_left = 60 - total;
         this.unhidingCounter[4] = time_left;
      }
      
      override protected function isOnHeroPlatform() : Boolean
      {
         var inBetweenArea:Rectangle = null;
         var heroAABB:Rectangle = level.hero.getAABB();
         if(this.viewArea.intersects(heroAABB))
         {
            inBetweenArea = new Rectangle();
            if(this.SIDE == 0 || this.SIDE == 2)
            {
               inBetweenArea.y = this.viewArea.y;
               inBetweenArea.height = this.viewArea.height;
               if(this.SIDE == 0)
               {
                  if(DIRECTION == LEFT)
                  {
                     inBetweenArea.x = heroAABB.x + heroAABB.width;
                     inBetweenArea.width = this.viewArea.x + this.viewArea.width - (heroAABB.x + heroAABB.width);
                  }
                  else
                  {
                     inBetweenArea.x = this.viewArea.x;
                     inBetweenArea.width = heroAABB.x - this.viewArea.x;
                  }
               }
               else if(DIRECTION == LEFT)
               {
                  inBetweenArea.x = this.viewArea.x;
                  inBetweenArea.width = heroAABB.x - this.viewArea.x;
               }
               else
               {
                  inBetweenArea.x = heroAABB.x + heroAABB.width;
                  inBetweenArea.width = this.viewArea.x + this.viewArea.width - (heroAABB.x + heroAABB.width);
               }
            }
            else
            {
               inBetweenArea.x = this.viewArea.x;
               inBetweenArea.width = this.viewArea.width;
               if(this.SIDE == 1)
               {
                  if(DIRECTION == LEFT)
                  {
                     inBetweenArea.y = this.viewArea.y;
                     inBetweenArea.height = heroAABB.y - this.viewArea.y;
                  }
                  else
                  {
                     inBetweenArea.y = heroAABB.y + heroAABB.height;
                     inBetweenArea.height = this.viewArea.y + this.viewArea.height - (heroAABB.y + heroAABB.height);
                  }
               }
               else if(DIRECTION == LEFT)
               {
                  inBetweenArea.y = heroAABB.y + heroAABB.height;
                  inBetweenArea.height = this.viewArea.y + this.viewArea.height - (heroAABB.y + heroAABB.height);
               }
               else
               {
                  inBetweenArea.y = this.viewArea.y;
                  inBetweenArea.height = heroAABB.y - this.viewArea.y;
               }
            }
            if(level.levelData.isAreaContainingCollisionTiles(inBetweenArea,8))
            {
               return false;
            }
            return true;
         }
         return false;
      }
   }
}
