package entities.enemies
{
   import entities.Easings;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.FlameJumperEnemySprite;
   import sprites.particles.SplashLavaParticleSprite;
   
   public class FlameJumperEnemy extends Enemy
   {
       
      
      protected var speed_multiplier:Number;
      
      protected var jump_anchor_x:Number;
      
      protected var jump_sin_counter:Number;
      
      protected var jump_radius:Number;
      
      protected var ease_tick:Number;
      
      public function FlameJumperEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         sprite = new FlameJumperEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.x = 0;
         aabbPhysics.y = -3;
         aabbPhysics.width = 16;
         aabbPhysics.height = 10;
         aabb.x = 0;
         aabb.y = -3;
         aabb.width = 16;
         aabb.height = 14;
         this.jump_anchor_x = 0;
         this.jump_sin_counter = 0;
         if(Utils.CurrentLevel == 33)
         {
            this.jump_radius = Utils.TILE_WIDTH * 1;
         }
         else
         {
            this.jump_radius = Utils.TILE_WIDTH * 1.5;
         }
         this.ease_tick = 0;
         ground_friction_time = 0.5;
         this.speed_multiplier = 1;
         ground_friction = 1;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","JUMP_ACTION","IS_DIVING_STATE");
         stateMachine.setRule("IS_DIVING_STATE","END_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","END_ACTION","IS_SUB_DIVING_STATE");
         stateMachine.setRule("IS_SUB_DIVING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_DIVING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SUB_DIVING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_DIVING_STATE",this.divingAnimation);
         stateMachine.setFunctionToState("IS_SUB_DIVING_STATE",this.subDivingAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_WALKING_STATE");
         energy = 1;
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_WALKING_STATE");
         energy = 1;
      }
      
      override public function update() : void
      {
         var hero_mid_x:Number = NaN;
         var mid_x:Number = NaN;
         var wait_time:int = 0;
         super.update();
         x_friction = 1;
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(DIRECTION == LEFT)
            {
               xVel -= 0.03;
               if(xPos <= path_start_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else
            {
               xVel += 0.03;
               if(xPos + WIDTH >= path_end_x)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            hero_mid_x = level.hero.xPos + level.hero.WIDTH * 0.5;
            mid_x = xPos + WIDTH * 0.5;
            if(Math.abs(hero_mid_x - mid_x) < 72 && level.hero.yPos <= yPos - Utils.TILE_HEIGHT && level.hero.yPos >= yPos - Utils.TILE_HEIGHT * 4)
            {
               if(mid_x > hero_mid_x && DIRECTION == LEFT || mid_x < hero_mid_x && DIRECTION == RIGHT)
               {
                  if(xPos + WIDTH <= path_end_x || xPos >= path_start_x)
                  {
                     stateMachine.performAction("JUMP_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_DIVING_STATE")
         {
            yVel -= 0.05;
            yPos += yVel;
            if(yPos <= originalYPos)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_SUB_DIVING_STATE")
         {
            if(counter1 == 0)
            {
               yVel -= 0.05;
            }
            else
            {
               yVel += 0.025;
            }
            yPos += yVel;
            if(counter1 == 0)
            {
               if(yPos <= originalYPos)
               {
                  counter1 = 1;
               }
            }
            else if(yPos >= originalYPos)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            this.ease_tick += 1 / 60;
            if(this.ease_tick >= 1.5)
            {
               this.ease_tick = 1.5;
            }
            this.jump_sin_counter = Easings.linear(this.ease_tick,0,Math.PI,1.5);
            if(DIRECTION == LEFT)
            {
               xPos = this.jump_anchor_x + Math.cos(this.jump_sin_counter) * this.jump_radius - WIDTH * 0.5;
            }
            else
            {
               xPos = this.jump_anchor_x - Math.cos(this.jump_sin_counter) * this.jump_radius - WIDTH * 0.5;
            }
            yPos = originalYPos - Math.sin(this.jump_sin_counter) * this.jump_radius * 4;
            if(this.ease_tick >= 1.5)
            {
               if(isInsideScreen())
               {
                  SoundSystem.PlaySound("water_splash");
               }
               level.particlesManager.pushParticle(new SplashLavaParticleSprite(),xPos + WIDTH * 0.5,Utils.SEA_LEVEL,0,0,0);
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            ++counter1;
            wait_time = 3;
            if(sprite.visible)
            {
               wait_time = 5;
            }
            if(counter1 >= wait_time)
            {
               counter1 = 0;
               ++counter2;
               sprite.visible = !sprite.visible;
               if(sprite.visible)
               {
                  if(DIRECTION == LEFT)
                  {
                     level.particlesManager.createBubble(xPos,yPos);
                  }
                  else
                  {
                     level.particlesManager.createBubble(xPos + WIDTH,yPos);
                  }
               }
               if(counter2 > 12)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         if(xVel <= 0 && DIRECTION == LEFT || xVel >= 0 && DIRECTION == RIGHT)
         {
            this.removeGroundFriction();
            this.speed_multiplier += 0.01;
         }
         else
         {
            this.addGroundFriction();
            this.speed_multiplier -= 0.02;
         }
         if(this.speed_multiplier <= 0.25)
         {
            this.speed_multiplier = 0.25;
         }
         else if(this.speed_multiplier >= 0.5)
         {
            this.speed_multiplier = 0.5;
         }
         MAX_X_VEL = 1;
         xVel *= x_friction;
         if(xVel > MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel < -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         xPos += xVel;
         yPos += yVel;
         if(stateMachine.currentState != "IS_HIT_STATE")
         {
            sinCounter1 += 0.1;
            if(sinCounter1 >= Math.PI * 2)
            {
               sinCounter1 -= Math.PI * 2;
            }
         }
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_STATE")
         {
            yPos = originalYPos + Math.sin(sinCounter1) * 1.5;
         }
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(sprite.gfxHandle().frame == 1)
         {
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,0.1 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(1,0.2 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(2,0.2 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(3,0.1 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(4,0.2 * this.speed_multiplier);
            sprite.gfxHandle().gfxHandleClip().setFrameDuration(5,0.2 * this.speed_multiplier);
         }
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         counter1 = counter2 = counter3 = 0;
         x_friction = 0.8;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function divingAnimation() : void
      {
         xVel = yVel = 0;
         yVel = 1;
      }
      
      public function subDivingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         xVel = yVel = 0;
         yVel = 0.5;
         counter1 = 0;
      }
      
      public function jumpAnimation() : void
      {
         xVel = 0;
         yVel = 0;
         if(DIRECTION == RIGHT)
         {
            this.jump_anchor_x = xPos + WIDTH * 0.5 + this.jump_radius;
         }
         else
         {
            this.jump_anchor_x = xPos + WIDTH * 0.5 - this.jump_radius;
         }
         this.jump_sin_counter = 0;
         this.ease_tick = 0;
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("water_splash");
         }
         level.particlesManager.pushParticle(new SplashLavaParticleSprite(),xPos + WIDTH * 0.5,Utils.SEA_LEVEL,0,0,0);
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
         counter1 = counter2 = 0;
      }
      
      override protected function removeGroundFriction() : void
      {
         ground_friction = 1;
         ground_friction_tick = ground_friction_time;
      }
      
      override protected function addGroundFriction() : void
      {
         ground_friction_tick -= 1 / 60;
         if(ground_friction_tick <= 0)
         {
            ground_friction_tick = 0;
         }
         ground_friction = Easings.easeOutExpo(ground_friction_tick,1,-1,ground_friction_time);
      }
   }
}
