package entities.enemies
{
   import entities.Entity;
   import entities.particles.Particle;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.enemies.RockMoonEnemySprite;
   import sprites.particles.WorriedParticleSprite;
   
   public class RockMoonEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var TYPE:int;
      
      protected var HITS:int;
      
      protected var SHAKE_FLAG:Boolean;
      
      protected var shake_counter_1:int;
      
      protected var shake_counter_2:int;
      
      protected var fall_offset:int;
      
      protected var hidden_counter:int;
      
      protected var param_1:Number;
      
      public function RockMoonEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int, _type:int = 0, _param_1:Number = 0)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         ai_index = _ai;
         this.TYPE = _type;
         this.fall_offset = 0;
         this.param_1 = _param_1;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.HITS = 0;
         this.SHAKE_FLAG = false;
         this.shake_counter_1 = this.shake_counter_2 = 0;
         this.hidden_counter = 0;
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         sprite = new RockMoonEnemySprite(this.TYPE);
         Utils.world.addChild(sprite);
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         aabbPhysics.x = 0;
         aabbPhysics.y = 0;
         aabbPhysics.width = 16;
         aabbPhysics.height = 13;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","NO_GROUND_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","SCARED_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SCARED_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_HIDING_STATE","GROUND_COLLISION_ACTION","IS_HIDDEN_STATE");
         stateMachine.setRule("IS_HIDDEN_STATE","UNHIDE_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIDDEN_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_HIDING_STATE",this.hidingAnimation);
         stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(this.TYPE == 2)
         {
            if(ai_index == 0)
            {
               stateMachine.setState("IS_WALKING_STATE");
            }
            else if(ai_index == 1)
            {
               stateMachine.setState("IS_HIDDEN_STATE");
            }
         }
         else if(ai_index == 0)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else if(ai_index == 1)
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
         energy = 1;
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
         if(this.TYPE == 2)
         {
            if(ai_index == 0)
            {
               stateMachine.setState("IS_WALKING_STATE");
            }
            else if(ai_index == 1)
            {
               stateMachine.setState("IS_HIDDEN_STATE");
            }
         }
         else if(ai_index == 0)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else if(ai_index == 1)
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
         energy = 1;
      }
      
      override protected function allowEnemyDefend() : Boolean
      {
         if(stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_HIDING_STATE")
         {
            if(this.HITS == 0)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(int(Math.random() * 2) + 0.5));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            if(ai_index == 0)
            {
               if(this.walk_counter-- < 0)
               {
                  this.walk_counter = int(Math.random() * 2 + 3) * 60;
                  stateMachine.performAction("WALK_ACTION");
               }
               else if(this.isOnHeroPlatform() && this.TYPE != 2)
               {
                  stateMachine.performAction("SCARED_ACTION");
               }
            }
            else if(ai_index == 1)
            {
               if(Math.abs(getMidXPos() - level.hero.getMidXPos()) <= this.param_1)
               {
                  ai_index = 0;
                  stateMachine.performAction("WALK_ACTION");
               }
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
         else if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            if(this.fall_offset != 0)
            {
               if(this.fall_offset > 0)
               {
                  --this.fall_offset;
                  ++xPos;
               }
               else
               {
                  ++this.fall_offset;
                  --xPos;
               }
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(this.walk_counter-- < 0)
            {
               this.walk_counter = int(Math.random() * 3 + 1) * 30;
               stateMachine.performAction("STOP_ACTION");
            }
            if(DIRECTION == RIGHT)
            {
               xVel += speed;
            }
            else
            {
               xVel += -speed;
            }
            if(Math.abs(yVel) < 0.1)
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
            if(this.isOnHeroPlatform() && ai_index == 0 && this.TYPE != 2)
            {
               stateMachine.performAction("SCARED_ACTION");
            }
            else
            {
               this.boundariesCheck();
            }
         }
         else if(stateMachine.currentState == "IS_HIDDEN_STATE")
         {
            if(this.TYPE == 2)
            {
               if(Math.abs(level.hero.getMidXPos() - getMidXPos()) <= this.param_1)
               {
                  level.levelData.setTileValueAt(int(getMidXPos() / Utils.TILE_WIDTH),int(getMidYPos() / Utils.TILE_HEIGHT),0);
                  stateMachine.performAction("UNHIDE_ACTION");
                  yVel = -2;
               }
            }
            else
            {
               ++this.hidden_counter;
               if(Math.abs(level.hero.getMidXPos() - getMidXPos()) >= 96)
               {
                  if(this.hidden_counter >= 120)
                  {
                     stateMachine.performAction("UNHIDE_ACTION");
                     yVel = -2;
                  }
               }
               if(this.SHAKE_FLAG)
               {
                  if(counter1++ >= 1)
                  {
                     counter1 = 0;
                     ++counter2;
                     if(xPos >= originalXPos)
                     {
                        xPos = originalXPos - 1;
                     }
                     else
                     {
                        xPos = originalXPos + 1;
                     }
                     if(counter2 >= 20)
                     {
                        this.SHAKE_FLAG = false;
                        counter1 = counter2 = 0;
                        xPos = originalXPos;
                     }
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_HIDING_STATE")
         {
            xVel = 0;
         }
         integratePositionAndCollisionDetection();
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
      
      override public function setEmotionParticle(emotion_id:int) : void
      {
         var pSprite:GameSprite = null;
         var particle:Particle = null;
         if(emotion_id == Entity.EMOTION_WORRIED)
         {
            pSprite = new WorriedParticleSprite();
            if(DIRECTION == Entity.LEFT)
            {
               particle = level.particlesManager.pushParticle(pSprite,9,-2,0,0,1);
            }
            else
            {
               particle = level.particlesManager.pushParticle(pSprite,0,-2,0,0,1);
            }
            particle.entity = this;
         }
         else if(emotion_id == Entity.EMOTION_SHOCKED)
         {
            super.setEmotionParticle(emotion_id);
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
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
      
      override public function noGroundCollision() : void
      {
         stateMachine.performAction("NO_GROUND_ACTION");
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            if(yVel >= 0)
            {
               if(this.isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("rock_stomp");
                  level.camera.verShake(4,0.85,1.2);
               }
               stateMachine.performAction("GROUND_COLLISION_ACTION");
            }
         }
         if(stateMachine.currentState == "IS_HIDING_STATE")
         {
            if(yVel >= 0)
            {
               if(counter1 == 0)
               {
                  SoundSystem.PlaySound("rock_stomp");
                  yVel = -1.5;
                  ++counter1;
               }
               else
               {
                  SoundSystem.PlaySound("rock_stomp");
                  stateMachine.performAction("GROUND_COLLISION_ACTION");
               }
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
      }
      
      override public function defend(_source_x:Number = 0, _source_y:Number = 0, _isCatAttacking:Boolean = false) : *
      {
         if(this.HITS == 0)
         {
            this.SHAKE_FLAG = true;
            this.shake_counter_1 = this.shake_counter_2 = 0;
         }
         ++this.HITS;
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(frame_counter + 1);
         counter1 = 0;
         MAX_X_VEL = 0.5;
         speed = 1;
         x_friction = 0.8;
         xVel = 0;
         gravity_friction = 1;
      }
      
      public function fallingAnimation() : void
      {
         counter1 = counter2 = 0;
         if(DIRECTION == Entity.RIGHT)
         {
            this.fall_offset = 8;
         }
         else
         {
            this.fall_offset = -8;
         }
         xVel = 0;
         gravity_friction = 1;
      }
      
      public function hiddenAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.TYPE == 2)
         {
            level.levelData.setTileValueAt(int(getMidXPos() / Utils.TILE_WIDTH),int(getMidYPos() / Utils.TILE_HEIGHT),13);
         }
         this.hidden_counter = 0;
         counter1 = counter2 = counter3 = 0;
      }
      
      public function hidingAnimation() : void
      {
         originalXPos = xPos;
         this.HITS = 0;
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         yVel = -2;
         gravity_friction = 0.5;
      }
      
      public function hitAnimation() : void
      {
         if(this.TYPE == 2)
         {
            if(stateMachine.lastState == "IS_HIDDEN_STATE")
            {
               level.levelData.setTileValueAt(int(getMidXPos() / Utils.TILE_WIDTH),int(getMidYPos() / Utils.TILE_HEIGHT),0);
            }
         }
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos,level.camera.yPos,level.camera.WIDTH,level.camera.HEIGHT);
         var area:Rectangle = new Rectangle(xPos + aabbPhysics.x,yPos + aabbPhysics.y,aabbPhysics.width,aabbPhysics.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
      
      override protected function isOnHeroPlatform() : Boolean
      {
         var i:int = 0;
         var mid_x:Number = NaN;
         var mid_y:Number = NaN;
         var diff_t:int = 0;
         mid_x = xPos + WIDTH * 0.5;
         mid_y = yPos + HEIGHT * 0.5;
         var hero_mid_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5;
         var hero_mid_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5;
         var hero_x_t:int = int(hero_mid_x / Utils.TILE_WIDTH);
         var hero_y_t:int = int(hero_mid_y / Utils.TILE_HEIGHT);
         var x_t:int = int((xPos + 4) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + 4) / Utils.TILE_HEIGHT);
         if(Math.abs(mid_y - hero_mid_y) < Utils.TILE_HEIGHT * 1.5)
         {
            if(DIRECTION == RIGHT)
            {
               if(hero_mid_x > mid_x)
               {
                  if(Math.abs(hero_mid_x - mid_x) < Utils.TILE_WIDTH * 5)
                  {
                     diff_t = hero_x_t - x_t;
                     for(i = 0; i < diff_t; i++)
                     {
                        if(level.levelData.getTileValueAt(x_t + i,y_t) != 0)
                        {
                           return false;
                        }
                     }
                     return true;
                  }
               }
            }
            else if(hero_mid_x < mid_x)
            {
               if(Math.abs(hero_mid_x - mid_x) < Utils.TILE_WIDTH * 5)
               {
                  diff_t = x_t - hero_mid_x;
                  for(i = 0; i < diff_t; i++)
                  {
                     if(level.levelData.getTileValueAt(x_t - i,y_t) != 0)
                     {
                        return false;
                     }
                  }
                  return true;
               }
            }
         }
         return false;
      }
   }
}
