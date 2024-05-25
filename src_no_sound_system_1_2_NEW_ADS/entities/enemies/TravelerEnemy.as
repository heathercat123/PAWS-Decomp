package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.GenericBulletSprite;
   import sprites.bullets.SnowballBulletSprite;
   import sprites.collisions.DarkSmallSpotCollisionSprite;
   import sprites.enemies.TravelerEnemySprite;
   import sprites.particles.ZSleepParticleSprite;
   import starling.display.Image;
   import states.LevelState;
   
   public class TravelerEnemy extends Enemy
   {
       
      
      protected var param_2:Number;
      
      protected var z_counter:int;
      
      protected var fishString:Image;
      
      protected var drift_friction:Number;
      
      protected var drift_tick:Number;
      
      protected var ice_jump_counter:int;
      
      protected var HAS_SNOW:Boolean;
      
      protected var pogo_x_pos:Number;
      
      protected var pogo_sin_counter:Number;
      
      protected var start_y:Number;
      
      protected var diff__y:Number;
      
      protected var tick:Number;
      
      protected var time:Number;
      
      protected var light:DarkSmallSpotCollisionSprite;
      
      public function TravelerEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int, _param_2:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         ai_index = _ai;
         this.param_2 = _param_2;
         this.z_counter = 0;
         this.ice_jump_counter = this.pogo_x_pos = this.pogo_sin_counter = 0;
         this.start_y = this.diff__y = this.tick = this.time = 0;
         MAX_X_VEL = 2;
         MAX_Y_VEL = 4;
         this.drift_friction = this.drift_tick = 0;
         sprite = new TravelerEnemySprite(ai_index);
         Utils.world.addChild(sprite);
         this.fishString = new Image(TextureManager.sTextureAtlas.getTexture("travelerEnemyFishString"));
         this.fishString.touchable = false;
         Utils.world.addChild(this.fishString);
         this.fishString.visible = false;
         this.fishString.alpha = 0;
         aabb.x = 1 + 1;
         aabb.y = -1 + 1;
         aabb.width = 14 - 2;
         aabb.height = 13 - 2;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 14;
         aabbPhysics.height = 13;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","MAKE_SNOW_ACTION","IS_MAKING_SNOW_STATE");
         stateMachine.setRule("IS_MAKING_SNOW_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","AIM_ACTION","IS_AIMING_STATE");
         stateMachine.setRule("IS_AIMING_STATE","END_ACTION","IS_TOSSING_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SLIDE_ACTION","IS_SLIDING_STATE");
         stateMachine.setRule("IS_SLIDING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","JUMP_ACTION","IS_READY_TO_JUMP_STATE");
         stateMachine.setRule("IS_READY_TO_JUMP_STATE","END_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","GROUND_COLLISION_ACTION","IS_GROUND_IMPACT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_ICE_WALKING_STATE","TURN_ACTION","IS_ICE_TURNING_STATE");
         stateMachine.setRule("IS_ICE_TURNING_STATE","END_ACTION","IS_ICE_WALKING_STATE");
         stateMachine.setRule("IS_ICE_WALKING_STATE","JUMP_ACTION","IS_ICE_JUMPING_STATE");
         stateMachine.setRule("IS_ICE_JUMPING_STATE","GROUND_COLLISION_ACTION","IS_ICE_WALKING_STATE");
         stateMachine.setRule("IS_POGO_STANDING_STATE","JUMP_ACTION","IS_POGO_JUMPING_STATE");
         stateMachine.setRule("IS_POGO_JUMPING_STATE","GROUND_COLLISION_ACTION","IS_POGO_STANDING_STATE");
         stateMachine.setRule("IS_POGO_STANDING_STATE","TURN_ACTION","IS_POGO_TURNING_STATE");
         stateMachine.setRule("IS_POGO_TURNING_STATE","END_ACTION","IS_POGO_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SLIDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_READY_TO_JUMP_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FISHING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ICE_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ICE_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ICE_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_AIMING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_MAKING_SNOW_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_POGO_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_POGO_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_POGO_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_POGO_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_SLIDING_STATE",this.slidingAnimation);
         stateMachine.setFunctionToState("IS_READY_TO_JUMP_STATE",this.readyToJumpAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_GROUND_IMPACT_STATE",this.groundImpactAnimation);
         stateMachine.setFunctionToState("IS_FISHING_STATE",this.fishingAnimation);
         stateMachine.setFunctionToState("IS_ICE_WALKING_STATE",this.iceWalkingAnimation);
         stateMachine.setFunctionToState("IS_ICE_TURNING_STATE",this.iceTurningAnimation);
         stateMachine.setFunctionToState("IS_ICE_JUMPING_STATE",this.iceJumpingAnimation);
         stateMachine.setFunctionToState("IS_AIMING_STATE",this.aimingAnimation);
         stateMachine.setFunctionToState("IS_TOSSING_STATE",this.tossingAnimation);
         stateMachine.setFunctionToState("IS_MAKING_SNOW_STATE",this.makingSnowAnimation);
         stateMachine.setFunctionToState("IS_POGO_STANDING_STATE",this.pogoStandingAnimation);
         stateMachine.setFunctionToState("IS_POGO_JUMPING_STATE",this.pogoJumpingAnimation);
         stateMachine.setFunctionToState("IS_POGO_TURNING_STATE",this.pogoTurningAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 4)
         {
            this.HAS_SNOW = true;
         }
         if(ai_index == 0 || ai_index == 4 || ai_index == 5)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else if(ai_index == 2 || ai_index == 7)
         {
            stateMachine.setState("IS_FISHING_STATE");
         }
         else if(ai_index == 3)
         {
            stateMachine.setState("IS_ICE_WALKING_STATE");
         }
         else if(ai_index == 6)
         {
            stateMachine.setState("IS_POGO_STANDING_STATE");
            aabb.y = -1 + 1 - 12;
            aabb.height = 13 - 2 + 12;
            aabbPhysics.y = 0 - 12;
            aabbPhysics.height = 13 + 12;
         }
         else
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
         if(ai_index == 5)
         {
            this.light = new DarkSmallSpotCollisionSprite();
            this.light.gotoAndStop(1);
            level.darkManager.maskContainer.addChild(this.light);
         }
         else
         {
            this.light = null;
         }
         energy = 1;
      }
      
      override public function destroy() : void
      {
         if(this.light != null)
         {
            level.darkManager.maskContainer.removeChild(this.light);
            this.light.destroy();
            this.light.dispose();
            this.light = null;
         }
         Utils.world.removeChild(this.fishString);
         this.fishString.dispose();
         this.fishString = null;
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
         if(ai_index == 0 || ai_index == 5)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else if(ai_index == 2)
         {
            stateMachine.setState("IS_FISHING_STATE");
         }
         else if(ai_index == 3)
         {
            stateMachine.setState("IS_ICE_WALKING_STATE");
         }
         else if(ai_index == 6)
         {
            stateMachine.setState("IS_POGO_STANDING_STATE");
         }
         else
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
      }
      
      override public function update() : void
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         var hero_mid_x:int = 0;
         var this_mid_x:int = 0;
         var min_distance:Number = NaN;
         var t_value:int = 0;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(ai_index == 0 || ai_index == 5)
            {
               stateMachine.performAction("WALK_ACTION");
            }
            else if(ai_index == 1)
            {
               ++counter2;
               if(counter2 >= 0 && counter2 < 30)
               {
                  sprite.gfxHandle().gotoAndStop(5);
                  sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  sprite.gfxHandle().gotoAndStop(1);
                  sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
                  if(counter2 >= 60)
                  {
                     counter2 = 0;
                  }
               }
               diff_x = level.hero.getMidXPos() - getMidXPos();
               diff_y = level.hero.getMidYPos() - this.getMidYPos();
               distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
               if(distance <= this.param_2)
               {
                  stateMachine.performAction("WALK_ACTION");
                  ai_index = 0;
               }
            }
            else if(ai_index == 4)
            {
               if(counter3-- < 0)
               {
                  if(this.HAS_SNOW)
                  {
                     if(Math.abs(path_start_x - path_end_x) > 16)
                     {
                        stateMachine.performAction("TURN_ACTION");
                     }
                     else
                     {
                        counter3 = 60;
                     }
                  }
                  else
                  {
                     stateMachine.performAction("MAKE_SNOW_ACTION");
                  }
               }
               else
               {
                  hero_mid_x = level.hero.getMidXPos();
                  this_mid_x = getMidXPos();
                  min_distance = 112;
                  if(LevelState.LEVEL_3_7_3)
                  {
                     min_distance = 128;
                  }
                  if(this.HAS_SNOW)
                  {
                     if(DIRECTION == LEFT && hero_mid_x < this_mid_x || DIRECTION == RIGHT && hero_mid_x > this_mid_x)
                     {
                        if(Math.abs(hero_mid_x - this_mid_x) <= min_distance && Math.abs(hero_mid_x - this_mid_x) > 24)
                        {
                           stateMachine.performAction("AIM_ACTION");
                        }
                     }
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_ICE_TURNING_STATE" || stateMachine.currentState == "IS_POGO_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_AIMING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TOSSING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_MAKING_SNOW_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(DIRECTION == RIGHT)
            {
               xVel = speed;
            }
            else
            {
               xVel = -speed;
            }
            if(Math.abs(yVel) < 0.25)
            {
               frame_speed = 0.2;
            }
            else
            {
               frame_speed = 0.4;
               xVel = 0;
            }
            frame_counter += frame_speed;
            if(frame_counter >= 4)
            {
               frame_counter -= 4;
            }
            if(ai_index == 4)
            {
               this.boundariesCheck();
            }
            t_value = getTileAhead(1,1);
            if(t_value == 0)
            {
               stateMachine.performAction("JUMP_ACTION");
            }
            else if(this.isFacingDownSlope(t_value))
            {
               stateMachine.performAction("SLIDE_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_ICE_WALKING_STATE")
         {
            ++this.ice_jump_counter;
            this.drift_tick += 1 / 60;
            if(this.drift_tick > 1)
            {
               this.drift_tick = 1;
               sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
               if(this.ice_jump_counter > 60 && Math.abs(xPos - (path_start_x + path_end_x) * 0.5) < 8)
               {
                  this.ice_jump_counter = 0;
                  if(this.isInsideInnerScreen())
                  {
                     SoundSystem.PlaySound("enemy_jump");
                  }
                  stateMachine.performAction("JUMP_ACTION");
               }
            }
            else if(counter1++ > 2)
            {
               if(this.isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("enemy_ice_slide");
               }
               counter1 = -int(Math.random() * 5);
               level.particlesManager.groundIceParticles(this,WIDTH,DIRECTION);
            }
            this.drift_friction = Easings.easeInQuart(this.drift_tick,0,1,1);
            if(DIRECTION == RIGHT)
            {
               xVel += speed * this.drift_friction * 0.1;
            }
            else
            {
               xVel -= speed * this.drift_friction * 0.1;
            }
            this.boundariesCheck();
         }
         else if(stateMachine.currentState == "IS_SLIDING_STATE")
         {
            t_value = getTileAhead(1,1);
            if(Math.abs(xVel) > 0.5)
            {
               if(this.isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("enemy_brake");
               }
            }
            if(this.isFacingDownSlope(t_value))
            {
               if(DIRECTION == RIGHT)
               {
                  xVel = speed;
               }
               else
               {
                  xVel = -speed;
               }
            }
            else if(Math.abs(xVel) < 0.1)
            {
               stateMachine.performAction("END_ACTION");
            }
            if(counter2++ > 2)
            {
               counter2 = -int(Math.random() * 5);
               level.particlesManager.groundSmokeParticles(this);
            }
         }
         else if(stateMachine.currentState == "IS_READY_TO_JUMP_STATE")
         {
            if(counter1++ > 15)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_GROUND_IMPACT_STATE")
         {
            ++counter1;
            if(counter1 == 5)
            {
               sprite.gfxHandle().gotoAndStop(1);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            else if(counter1 >= 20)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            if(counter1++ > 30)
            {
               xVel *= 0.8;
            }
         }
         else if(stateMachine.currentState == "IS_FISHING_STATE")
         {
            if(this.z_counter++ > 120)
            {
               this.z_counter = 0;
               level.topParticlesManager.pushParticle(new ZSleepParticleSprite(),xPos + WIDTH,yPos - 2,0,0,0,0,0,0);
            }
         }
         else if(stateMachine.currentState == "IS_POGO_STANDING_STATE")
         {
            if(path_end_x > 0)
            {
               if(DIRECTION == Entity.LEFT)
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
            if(counter1++ > 2)
            {
               stateMachine.performAction("JUMP_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_POGO_JUMPING_STATE")
         {
            x_friction = 0.8;
            if(this.param_2 == 0)
            {
               if(DIRECTION == LEFT)
               {
                  xVel -= 0.15;
               }
               else
               {
                  xVel += 0.15;
               }
            }
            else
            {
               xVel = 0;
            }
            gravity_friction = 0.2;
            if(int(counter1) == 0)
            {
               yVel = -0.1;
               this.tick += 1 / 60;
               if(this.tick >= this.time)
               {
                  this.tick = this.time;
                  counter1 = 1;
               }
               yPos = Easings.easeOutSine(this.tick,this.start_y,this.diff__y,this.time);
            }
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            if(this.fishString.alpha > 0)
            {
               if(counter3++ > 1)
               {
                  counter3 = 0;
                  this.fishString.visible = !this.fishString.visible;
               }
            }
            if(this.light != null)
            {
               this.light.scaleX -= 0.05;
               if(this.light.scaleX <= 0)
               {
                  this.light.scaleX = 0;
               }
               this.light.scaleY = this.light.scaleX;
            }
         }
         integratePositionAndCollisionDetection();
      }
      
      override public function ceilCollision() : void
      {
         yVel = 0;
      }
      
      protected function isFacingDownSlope(t_value:int) : Boolean
      {
         if(DIRECTION == LEFT)
         {
            if(t_value == 5 || t_value == 8 || t_value == 9)
            {
               return true;
            }
         }
         else if(t_value == 4 || t_value == 6 || t_value == 7)
         {
            return true;
         }
         return false;
      }
      
      protected function boundariesCheck() : void
      {
         if(path_start_x != 0)
         {
            if(DIRECTION == LEFT)
            {
               if(xPos <= path_start_x)
               {
                  if(ai_index == 4)
                  {
                     stateMachine.performAction("STOP_ACTION");
                  }
                  else
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
               }
            }
            else if(xPos + WIDTH >= path_end_x)
            {
               if(ai_index == 4)
               {
                  stateMachine.performAction("STOP_ACTION");
               }
               else
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
         }
      }
      
      override public function getMidYPos() : Number
      {
         if(ai_index == 6)
         {
            return yPos;
         }
         return super.getMidYPos();
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         this.fishString.x = int(Math.floor(xPos + 21 - camera.xPos));
         this.fishString.y = int(Math.floor(yPos + 14 - camera.yPos));
         this.fishString.height = 32;
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
         if(this.light != null)
         {
            this.light.x = int(sprite.x + 8);
            this.light.y = int(sprite.y + 0);
            this.light.updateScreenPosition();
            if(isInsideScreen())
            {
               this.light.visible = true;
            }
            else
            {
               this.light.visible = false;
            }
         }
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(int(frame_counter + 1));
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
         if(stateMachine.currentState == "IS_JUMPING_STATE" || stateMachine.currentState == "IS_ICE_JUMPING_STATE" || stateMachine.currentState == "IS_POGO_JUMPING_STATE" && counter1 > 0)
         {
            if(yVel >= 0)
            {
               stateMachine.performAction("GROUND_COLLISION_ACTION");
            }
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         if(stateMachine.currentState == "IS_POGO_JUMPING_STATE" || stateMachine.currentState == "IS_POGO_STANDING_STATE")
         {
            return;
         }
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
      }
      
      public function standingAnimation() : void
      {
         if(this.HAS_SNOW)
         {
            sprite.gfxHandle().gotoAndStop(9);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(1);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         counter3 = 60 + int(Math.random() * 3) * 60;
         xVel = 0;
      }
      
      public function turnAnimation() : void
      {
         if(this.HAS_SNOW)
         {
            sprite.gfxHandle().gotoAndStop(10);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(2);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         if(this.HAS_SNOW)
         {
            sprite.gfxHandle().gotoAndStop(11);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(3);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(frame_counter + 1);
         counter1 = 0;
         gravity_friction = 1;
         speed = 0.8;
         x_friction = 0.8;
         xVel = 0;
         MAX_X_VEL = 2;
      }
      
      public function slidingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         speed = 1.75;
         x_friction = 0.95;
         counter2 = 0;
         gravity_friction = 1;
      }
      
      public function readyToJumpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         xVel = 0;
         counter1 = 0;
      }
      
      public function jumpingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_jump");
         }
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         if(DIRECTION == RIGHT)
         {
            xVel = 1.5;
         }
         else
         {
            xVel = -1.5;
         }
         yVel = -1;
         x_friction = 0.98;
         gravity_friction = 0.2;
         counter1 = 0;
      }
      
      public function groundImpactAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         xVel = 0;
         counter1 = 0;
      }
      
      public function fishingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         xVel = 0;
         counter1 = 0;
         if(ai_index == 7)
         {
            sprite.gfxHandle().gotoAndStop(5);
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         }
         else
         {
            this.fishString.visible = true;
            this.fishString.alpha = 1;
         }
      }
      
      public function iceWalkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         speed = 1;
         MAX_X_VEL = 1.25;
         x_friction = 0.96;
      }
      
      public function iceTurningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         this.drift_friction = 0;
         this.drift_tick = 0;
      }
      
      public function iceJumpingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = counter2 = 0;
         yVel = -3;
         gravity_friction = 0.2;
         x_friction = 0.99;
      }
      
      public function hitAnimation() : void
      {
         var __x_vel:Number = NaN;
         var genericBulletSprite:GenericBulletSprite = null;
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(ai_index == 6)
         {
            __x_vel = -2;
            genericBulletSprite = new GenericBulletSprite(GenericBulletSprite.POGO_STICK);
            if(level.hero.getMidXPos() < getMidXPos())
            {
               __x_vel = 2;
            }
            else
            {
               genericBulletSprite.scaleX = -1;
            }
            level.bulletsManager.pushBullet(genericBulletSprite,getMidXPos(),this.getMidYPos(),__x_vel,-(2 + Math.random() * 2),0.98);
         }
         setHitVariables();
         counter1 = counter2 = counter3 = 0;
         xVel = yVel = 0;
      }
      
      public function pogoStandingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(15);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function pogoJumpingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_jump");
         }
         sprite.gfxHandle().gotoAndStop(16);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         oldXPos = xPos + WIDTH * 0.5;
         yVel = 0;
         sinCounter1 = 0;
         this.start_y = yPos;
         if(this.param_2 == 0)
         {
            this.diff__y = -Utils.TILE_HEIGHT * 2;
         }
         else
         {
            this.diff__y = -Utils.TILE_HEIGHT * 2.5;
         }
         this.tick = 0;
         this.time = 0.5;
      }
      
      public function pogoTurningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(17);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      protected function aimingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(12);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         counter1 = 0;
      }
      
      protected function tossingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(13);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.HAS_SNOW = false;
         xVel = 0;
         counter1 = 0;
         var enemy_xPos:Number = xPos + WIDTH * 0.5;
         var hero_xPos:Number = level.hero.xPos + level.hero.WIDTH * 0.5 + level.hero.xVel * 4;
         var diff_x:Number = hero_xPos - enemy_xPos;
         var diff_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5 - (yPos + HEIGHT * 0.5);
         var dist:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         diff_x /= dist;
         diff_y /= dist;
         var _xVel:Number = Math.abs(diff_x * 2.5);
         if(_xVel < 2)
         {
            _xVel = 2;
         }
         else if(_xVel > 4)
         {
            _xVel = 4;
         }
         if(DIRECTION == LEFT)
         {
            _xVel *= -1;
         }
         SoundSystem.PlaySound("throw");
         if(DIRECTION == LEFT)
         {
            level.bulletsManager.pushBullet(new SnowballBulletSprite(),xPos + WIDTH * 0.5 - 4,yPos,_xVel,0,1);
         }
         else
         {
            level.bulletsManager.pushBullet(new SnowballBulletSprite(),xPos + WIDTH * 0.5 + 4,yPos,_xVel,0,1);
         }
      }
      
      protected function makingSnowAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(14);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         counter1 = 0;
         this.HAS_SNOW = true;
      }
      
      override public function isInsideInnerScreen(offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos,level.camera.yPos,level.camera.WIDTH,level.camera.HEIGHT);
         var area:Rectangle = new Rectangle(xPos + aabbPhysics.x,yPos + aabbPhysics.y,aabbPhysics.width,aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
   }
}
