package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.GenieEnemySprite;
   import sprites.particles.GenieParticleSprite;
   
   public class GenieEnemy extends Enemy
   {
       
      
      protected var TYPE:int;
      
      protected var sin_counter:Number;
      
      protected var last_particle_x_pos:Number;
      
      protected var last_particle_y_pos:Number;
      
      protected var particle_counter:int;
      
      protected var LIMIT_X_POS:Boolean;
      
      protected var IS_GOING_UP:Boolean;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var direction_update_counter:int;
      
      protected var ATTACK_DISTANCE:int;
      
      public function GenieEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _type:int = 0, _attack_distance:int = 128)
      {
         super(_level,_xPos,_yPos,_direction,0);
         this.TYPE = _type;
         WIDTH = 16;
         HEIGHT = 16;
         this.ATTACK_DISTANCE = _attack_distance;
         this.IS_GOING_UP = false;
         speed = 0.8;
         this.particle_counter = 0;
         this.direction_update_counter = 0;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         this.last_particle_x_pos = getMidXPos();
         this.last_particle_y_pos = getMidYPos();
         MAX_X_VEL = 2;
         MAX_Y_VEL = 4;
         sprite = new GenieEnemySprite(_type);
         Utils.world.addChild(sprite);
         this.sin_counter = Math.random() * Math.PI * 2;
         aabb.x = 1 + 1 - 1;
         aabb.y = -1 + 1 - 5;
         aabb.width = 14 - 2 + 2;
         aabb.height = 13 - 2 + 5;
         aabbPhysics.x = 0;
         aabbPhysics.y = -5;
         aabbPhysics.width = 16;
         aabbPhysics.height = 18;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         if(this.TYPE == 0)
         {
            stateMachine.setRule("IS_HIDDEN_STATE","END_ACTION","IS_WALKING_STATE");
         }
         else
         {
            stateMachine.setRule("IS_HIDDEN_STATE","END_ACTION","IS_ENTERING_SCREEN_STATE");
            stateMachine.setRule("IS_ENTERING_SCREEN_STATE","END_ACTION","IS_WALKING_STATE");
            stateMachine.setRule("IS_ENTERING_SCREEN_STATE","HIT_ACTION","IS_HIT_STATE");
         }
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         stateMachine.setFunctionToState("IS_ENTERING_SCREEN_STATE",this.enteringScreenAnimation);
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_HIDDEN_STATE");
         energy = 1;
         this.LIMIT_X_POS = false;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         if(stateMachine != null)
         {
            stateMachine.destroy();
            stateMachine = null;
         }
         if(stunHandler != null)
         {
            stunHandler.destroy();
            stunHandler = null;
         }
         aabb = aabbPhysics = null;
         level = null;
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_HIDDEN_STATE");
      }
      
      override public function update() : void
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         super.update();
         if(stateMachine.currentState == "IS_HIDDEN_STATE")
         {
            if(Math.abs(getMidXPos() - level.hero.getMidXPos()) < this.ATTACK_DISTANCE)
            {
               yPos = level.camera.yPos - 16;
               this.sin_counter = Math.random() * Math.PI * 2;
               sprite.visible = true;
               if(level.hero.getMidXPos() > xPos)
               {
                  DIRECTION = Entity.RIGHT;
               }
               else
               {
                  DIRECTION = Entity.LEFT;
               }
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_ENTERING_SCREEN_STATE")
         {
            if(isInsideScreen())
            {
               SoundSystem.PlaySound("wind_enemy");
            }
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               stateMachine.performAction("END_ACTION");
            }
            else if(this.particle_counter++ > 5)
            {
               this.particle_counter = 0;
               level.particlesManager.airParticles(xPos,yPos - 4,WIDTH);
            }
            yPos = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         else if(stateMachine.currentState != "IS_STANDING_STATE")
         {
            if(stateMachine.currentState == "IS_TURNING_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  changeDirection();
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_WALKING_STATE")
            {
               if(DIRECTION == Entity.RIGHT)
               {
                  xVel = 0.5;
               }
               else
               {
                  xVel = -0.5;
               }
               if(this.TYPE == 1)
               {
                  if(ai_index == 1)
                  {
                     xVel = 0;
                  }
                  if(this.particle_counter++ > 5)
                  {
                     this.particle_counter = 0;
                     level.particlesManager.airParticles(xPos,yPos - 4,WIDTH);
                  }
                  if(this.IS_GOING_UP)
                  {
                     yVel = -0.5;
                  }
                  else
                  {
                     yVel = 0.5;
                  }
                  if(ai_index == 1)
                  {
                     yVel = 0.5;
                     if(yPos >= 232)
                     {
                        yPos = 232;
                     }
                  }
               }
               else
               {
                  yVel = 0.2;
               }
               if(counter1-- < 0)
               {
                  counter1 = 60;
                  if(DIRECTION == Entity.LEFT)
                  {
                     if(level.hero.getMidXPos() > getMidXPos() + 32 || xPos < originalXPos - 160)
                     {
                        stateMachine.performAction("TURN_ACTION");
                     }
                  }
                  else if(level.hero.getMidXPos() < getMidXPos() - 32 || xPos > originalXPos + 160)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
               }
               if(this.direction_update_counter-- < 0)
               {
                  this.direction_update_counter = 120;
                  if(this.TYPE == 1)
                  {
                     if(level.hero.yPos < getMidYPos())
                     {
                        this.IS_GOING_UP = true;
                     }
                     else
                     {
                        this.IS_GOING_UP = false;
                     }
                  }
               }
               if(this.TYPE == 0)
               {
                  diff_x = getMidXPos() - this.last_particle_x_pos;
                  diff_y = getMidYPos() - this.last_particle_y_pos;
                  distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                  if(distance >= 12)
                  {
                     level.particlesManager.pushBackParticle(new GenieParticleSprite(),this.last_particle_x_pos,this.last_particle_y_pos,0,0,0);
                     this.last_particle_x_pos = getMidXPos();
                     this.last_particle_y_pos = getMidYPos();
                  }
               }
            }
         }
         yVel *= x_friction;
         gravity_friction = 0;
         this.sin_counter += 0.1;
         if(this.sin_counter >= Math.PI * 2)
         {
            this.sin_counter -= Math.PI * 2;
         }
         integratePositionAndCollisionDetection();
         if(this.LIMIT_X_POS)
         {
            if(xPos >= 656 && DIRECTION == Entity.RIGHT && stateMachine.currentState != "IS_TURNING_STATE")
            {
               stateMachine.performAction("TURN_ACTION");
            }
         }
      }
      
      protected function boundariesCheck() : void
      {
         if(path_start_x != 0)
         {
            if(DIRECTION == LEFT)
            {
               if(xPos <= path_start_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else if(xPos + WIDTH >= path_end_x)
            {
               stateMachine.performAction("TURN_ACTION");
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         if(this.TYPE == 0)
         {
            sprite.y = int(Math.floor(yPos + Math.sin(this.sin_counter) * 2 - camera.yPos));
         }
         else if(this.TYPE == 1)
         {
            if(ai_index == 1)
            {
               sprite.y = int(Math.floor(yPos + Math.sin(this.sin_counter) * 2 - camera.yPos));
            }
            else
            {
               sprite.y = int(Math.floor(yPos - camera.yPos));
            }
         }
         if(sprite.gfxHandle() != null)
         {
            if(DIRECTION == LEFT)
            {
               sprite.gfxHandle().scaleX = 1;
            }
            else
            {
               sprite.gfxHandle().scaleX = -1;
            }
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
      }
      
      override public function groundCollision() : void
      {
         if(this.TYPE == 1)
         {
            if(level.hero.getMidYPos() < getMidYPos())
            {
               this.IS_GOING_UP = true;
            }
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         var x_t:int = int((xPos + WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         if(DIRECTION == RIGHT)
         {
            stateMachine.performAction("TURN_ACTION");
         }
         else
         {
            stateMachine.performAction("TURN_ACTION");
         }
         if(this.TYPE == 1)
         {
            if(level.hero.getMidYPos() < getMidYPos())
            {
               this.IS_GOING_UP = true;
            }
            else
            {
               this.IS_GOING_UP = false;
            }
         }
      }
      
      public function hiddenAnimation() : void
      {
         sprite.visible = false;
         xVel = yVel = gravity_friction = 0;
         counter1 = counter2 = 0;
      }
      
      public function enteringScreenAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.t_start = yPos;
         this.t_diff = level.hero.getMidYPos() - 64 - this.t_start;
         if(this.t_diff < 64)
         {
            this.t_diff = 64;
         }
         this.t_time = 1;
         this.t_tick = 0;
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         gravity_friction = 0;
         xVel = yVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 120;
         xVel = yVel = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
   }
}
