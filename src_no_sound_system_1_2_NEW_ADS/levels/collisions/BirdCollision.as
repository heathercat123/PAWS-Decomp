package levels.collisions
{
   import entities.Easings;
   import entities.Entity;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   import states.LevelState;
   
   public class BirdCollision extends Collision
   {
       
      
      public var stateMachine:StateMachine;
      
      protected var xVel:Number;
      
      protected var yVel:Number;
      
      protected var friction_1:Number;
      
      protected var friction_2:Number;
      
      protected var tick_counter_1:Number;
      
      protected var tick_counter_2:Number;
      
      protected var landingXPos:Number;
      
      protected var takeOffXPos:Number;
      
      protected var takeOffYPos:Number;
      
      protected var isOnGround:Boolean;
      
      protected var fleeFromThis_xPos:Number;
      
      protected var isSomeEntityOnMySpot:Boolean;
      
      public var DIRECTION:int;
      
      public var MODE:int;
      
      protected var chirp_counter:int;
      
      public function BirdCollision(_level:Level, _xPos:Number, _yPos:Number, _radius:Number)
      {
         super(_level,_xPos,_yPos);
         this.initMode();
         RADIUS = _radius;
         this.fleeFromThis_xPos = 0;
         this.isSomeEntityOnMySpot = false;
         this.landingXPos = originalXPos;
         this.chirp_counter = int((Math.random() * 3 + 3) * 30);
         this.xVel = this.yVel = 0;
         sprite = new BirdCollisionSprite();
         Utils.world.addChild(sprite);
         if(Math.random() * 100 > 50)
         {
            this.DIRECTION = Entity.LEFT;
         }
         else
         {
            this.DIRECTION = Entity.RIGHT;
         }
         var x_t:int = int(originalXPos / Utils.TILE_WIDTH);
         var y_t:int = int((originalYPos + 8) / Utils.TILE_HEIGHT);
         var t_value:int = level.levelData.getTileValueAt(x_t,y_t + 1);
         if(level.levelData.isCollision(t_value))
         {
            this.isOnGround = true;
         }
         else
         {
            this.isOnGround = false;
         }
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         this.stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         this.stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         this.stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         this.stateMachine.setRule("IS_STANDING_STATE","JUMP_ACTION","IS_JUMPING_STATE");
         this.stateMachine.setRule("IS_JUMPING_STATE","END_ACTION","IS_STANDING_STATE");
         this.stateMachine.setRule("IS_STANDING_STATE","FLY_ACTION","IS_FLYING_STATE");
         this.stateMachine.setRule("IS_WALKING_STATE","FLY_ACTION","IS_FLYING_STATE");
         this.stateMachine.setRule("IS_TURNING_STATE","FLY_ACTION","IS_FLYING_STATE");
         this.stateMachine.setRule("IS_JUMPING_STATE","FLY_ACTION","IS_FLYING_STATE");
         this.stateMachine.setRule("IS_FLYING_STATE","END_ACTION","IS_OUTSIDE_SCREEN_STATE");
         this.stateMachine.setRule("IS_OUTSIDE_SCREEN_STATE","END_ACTION","IS_LANDING_STATE");
         this.stateMachine.setRule("IS_LANDING_STATE","SOMEONE_ON_LANDING_SPOT_ACTION","TAKE_OFF_STATE");
         this.stateMachine.setRule("TAKE_OFF_STATE","END_ACTION","IS_OUTSIDE_SCREEN_STATE");
         if(this.isOnGround)
         {
            this.stateMachine.setRule("IS_LANDING_STATE","END_ACTION","IS_JUMPING_STATE");
         }
         else
         {
            this.stateMachine.setRule("IS_LANDING_STATE","END_ACTION","IS_STANDING_STATE");
         }
         this.stateMachine.setRule("IS_OFF_STATE","END_ACTION","IS_STANDING_STATE");
         this.stateMachine.setRule("IS_STANDING_STATE","CHIRP_ACTION","IS_CHIRPING_STATE");
         this.stateMachine.setRule("IS_CHIRPING_STATE","END_ACTION","IS_STANDING_STATE");
         this.stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         this.stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         this.stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         this.stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         this.stateMachine.setFunctionToState("IS_FLYING_STATE",this.flyingAnimation);
         this.stateMachine.setFunctionToState("IS_OUTSIDE_SCREEN_STATE",this.outsideScreenAnimation);
         this.stateMachine.setFunctionToState("IS_LANDING_STATE",this.landingAnimation);
         this.stateMachine.setFunctionToState("IS_OFF_STATE",this.offAnimation);
         this.stateMachine.setFunctionToState("TAKE_OFF_STATE",this.takeOffAnimation);
         this.stateMachine.setFunctionToState("IS_CHIRPING_STATE",this.chirpingAnimation);
         this.stateMachine.setState("IS_STANDING_STATE");
         aabb.x = -48;
         aabb.y = -32;
         aabb.width = 96;
         aabb.height = 64;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         this.stateMachine.destroy();
         this.stateMachine = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,Math.random() * 2 + 1);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            if(Utils.Slot.gameProgression[0] != 0)
            {
               if(this.chirp_counter-- <= 0)
               {
                  this.chirp_counter = int((Math.random() * 3 + 3) * 30);
                  if(this.isInsideInnerScreen())
                  {
                     SoundSystem.PlaySound("chirp");
                  }
               }
            }
            --counter1;
            if(counter1 <= 0)
            {
               if(Math.random() * 100 > 50)
               {
                  if(this.DIRECTION == Entity.RIGHT && xPos < originalXPos + RADIUS - 16 || this.DIRECTION == Entity.LEFT && xPos > originalXPos - RADIUS + 16)
                  {
                     if(Math.random() * 100 > 50 || RADIUS == 0)
                     {
                        this.stateMachine.performAction("WALK_ACTION");
                     }
                     else
                     {
                        this.stateMachine.performAction("JUMP_ACTION");
                     }
                  }
                  else
                  {
                     this.stateMachine.performAction("WALK_ACTION");
                  }
               }
               else if(this.MODE != 2)
               {
                  if(Math.random() * 100 > 50 || this.MODE == 1)
                  {
                     this.stateMachine.performAction("TURN_ACTION");
                  }
                  else
                  {
                     this.stateMachine.performAction("FLY_ACTION");
                  }
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(this.MODE != 2)
            {
               if(sprite.visible)
               {
                  if(this.DIRECTION == Entity.RIGHT)
                  {
                     this.xVel = 0.25;
                  }
                  else
                  {
                     this.xVel = -0.25;
                  }
               }
            }
            xPos += this.xVel;
            if(xPos >= originalXPos + RADIUS || xPos <= originalXPos - RADIUS)
            {
               this.stateMachine.performAction("STOP_ACTION");
            }
            else if(counter1-- <= 0)
            {
               this.stateMachine.performAction("STOP_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_JUMPING_STATE")
         {
            if(this.DIRECTION == Entity.RIGHT)
            {
               this.xVel = 0.25;
            }
            else
            {
               this.xVel = -0.25;
            }
            xPos += this.xVel;
            yPos += this.yVel;
            this.yVel += 0.04;
            if(yPos >= originalYPos)
            {
               this.stateMachine.performAction("END_ACTION");
               this.xVel = 0;
               this.yVel = 0;
            }
         }
         else if(this.stateMachine.currentState == "IS_FLYING_STATE")
         {
            this.tick_counter_1 += 0.016;
            if(this.tick_counter_1 >= 1)
            {
               this.tick_counter_1 = 1;
            }
            this.tick_counter_2 += 0.016;
            if(this.tick_counter_2 >= 0.5)
            {
               this.tick_counter_2 = 0.5;
            }
            this.friction_1 = Easings.linear(this.tick_counter_1,0,1,1);
            this.friction_2 = Easings.easeInCubic(this.tick_counter_2,0,0.5,0.5) + 0.5;
            xPos += this.xVel * this.friction_1 * 1.5;
            yPos += this.yVel * this.friction_2 * 1.5;
            if(yPos <= level.camera.yPos - 32)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_OUTSIDE_SCREEN_STATE")
         {
            if(this.MODE != 2)
            {
               --counter1;
               if(counter1 <= 0)
               {
                  if(!this.isSomeoneOnLandingSpot())
                  {
                     this.stateMachine.performAction("END_ACTION");
                  }
                  else
                  {
                     counter1 = int(Math.random() * 10 + 8) * 60;
                  }
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_LANDING_STATE")
         {
            if(this.isSomeoneOnLandingSpot())
            {
               this.stateMachine.performAction("SOMEONE_ON_LANDING_SPOT_ACTION");
            }
            else
            {
               this.tick_counter_1 += 0.016;
               this.tick_counter_2 += 0.016;
               this.friction_1 = Easings.linear(this.tick_counter_1,0,1,2);
               this.friction_2 = Easings.easeOutSine(this.tick_counter_2,0,1,2);
               if(this.DIRECTION == Entity.RIGHT)
               {
                  xPos = this.landingXPos - 300 * (1 - this.friction_1);
               }
               else
               {
                  xPos = this.landingXPos + 300 * (1 - this.friction_1);
               }
               yPos = originalYPos - level.camera.HEIGHT * (1 - this.friction_2);
               if(this.tick_counter_1 >= 2)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "TAKE_OFF_STATE")
         {
            this.tick_counter_1 += 0.016;
            this.tick_counter_2 += 0.016;
            if(this.tick_counter_2 >= 1.5)
            {
               this.tick_counter_2 = 1.5;
            }
            this.friction_1 = Easings.linear(this.tick_counter_1,0,1,2);
            this.friction_2 = Easings.easeInCubic(this.tick_counter_2,0,1,1.5);
            if(this.DIRECTION == Entity.RIGHT)
            {
               xPos = this.takeOffXPos + 300 * this.friction_1;
            }
            else
            {
               xPos = this.takeOffXPos - 300 * this.friction_1;
            }
            yPos = this.takeOffYPos - level.camera.HEIGHT * this.friction_2;
            if(this.friction_1 >= 2)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_CHIRPING_STATE")
         {
            if(counter3 == 0)
            {
               if(sprite.gfxHandle().gfxHandleClip().currentFrame == 1)
               {
                  counter3 = 1;
                  SoundSystem.PlaySound("loud_chirp");
               }
            }
            else if(counter3 == 1)
            {
               if(sprite.gfxHandle().gfxHandleClip().currentFrame == 3)
               {
                  counter3 = 0;
                  SoundSystem.PlaySound("loud_chirp");
               }
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,1);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = level.hero.getAABB();
         var bird_aabb:Rectangle = getAABB();
         hero_aabb.x += level.hero.xVel;
         this.isSomeEntityOnMySpot = false;
         if(this.getLandingAABB().intersects(hero_aabb))
         {
            this.isSomeEntityOnMySpot = true;
         }
         if(this.stateMachine.currentState == "IS_FLYING_STATE")
         {
            return;
         }
         if(hero_aabb.intersects(bird_aabb))
         {
            this.fleeFromThis_xPos = level.hero.getMidXPos();
            this.stateMachine.performAction("FLY_ACTION");
            if(this.stateMachine.currentState == "IS_FLYING_STATE")
            {
               SoundSystem.PlaySound("bird_flying");
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.DIRECTION == Entity.LEFT)
         {
            sprite.gfxHandle().scaleX = 1;
         }
         else
         {
            sprite.gfxHandle().scaleX = -1;
         }
      }
      
      protected function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(!this.isOnGround)
         {
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(1,0);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(2,0);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(3,0);
         }
         counter1 = (Math.random() * 2 + 1) * 60;
         this.xVel = 0;
      }
      
      protected function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = (Math.random() * 1 + 1) * 60;
      }
      
      protected function turningAnimation() : void
      {
         if(this.DIRECTION == Entity.RIGHT)
         {
            this.DIRECTION = Entity.LEFT;
         }
         else
         {
            this.DIRECTION = Entity.RIGHT;
         }
         this.stateMachine.performAction("END_ACTION");
      }
      
      protected function jumpingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.yVel = -0.5;
      }
      
      protected function flyingAnimation() : void
      {
         if(this.MODE != 2)
         {
            if(this.fleeFromThis_xPos < xPos)
            {
               this.DIRECTION = Entity.RIGHT;
            }
            else
            {
               this.DIRECTION = Entity.LEFT;
            }
         }
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.MODE == 2)
         {
            this.yVel = -0.5;
            this.xVel = -2.5;
         }
         else
         {
            this.yVel = -(Math.random() * 1.5 + 1.5);
            if(this.DIRECTION == Entity.RIGHT)
            {
               this.xVel = Math.random() * 1 + 2;
            }
            else
            {
               this.xVel = -(Math.random() * 1 + 2);
            }
         }
         this.friction_1 = this.friction_2 = 0;
         this.tick_counter_1 = this.tick_counter_2 = 0;
      }
      
      protected function outsideScreenAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.visible = false;
         this.xVel = this.yVel = 0;
         counter1 = int(Math.random() * 20 + 5) * 60;
         this.landingXPos = originalXPos + Math.random() * (RADIUS * 0.8 * 2) - RADIUS * 0.8;
      }
      
      protected function landingAnimation() : void
      {
         sprite.visible = true;
         yPos = originalYPos - level.camera.HEIGHT;
         if(this.DIRECTION == Entity.RIGHT)
         {
            xPos = originalXPos - 300;
         }
         else
         {
            xPos = originalXPos + 300;
         }
         counter1 = counter2 = counter3 = 0;
         this.friction_1 = this.friction_2 = 0;
         this.tick_counter_1 = this.tick_counter_2 = 0;
      }
      
      protected function offAnimation() : void
      {
         sprite.visible = false;
      }
      
      protected function takeOffAnimation() : void
      {
         this.tick_counter_1 = this.tick_counter_2 = 0;
         this.takeOffXPos = xPos;
         this.takeOffYPos = yPos;
      }
      
      protected function chirpingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter3 = 0;
      }
      
      protected function isSomeoneOnLandingSpot() : Boolean
      {
         return this.isSomeEntityOnMySpot;
      }
      
      protected function getLandingAABB() : Rectangle
      {
         return new Rectangle(this.landingXPos + aabb.x,originalYPos + aabb.y,aabb.width,aabb.height);
      }
      
      protected function initMode() : void
      {
         this.MODE = 0;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_1)
         {
            this.MODE = 1;
         }
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var point:Point = new Point(xPos,yPos);
         var camera:Rectangle = new Rectangle(level.camera.xPos + 16,level.camera.yPos + 16,level.camera.WIDTH - 32,level.camera.HEIGHT - 32);
         if(camera.containsPoint(point))
         {
            return true;
         }
         return false;
      }
   }
}
