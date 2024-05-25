package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.particles.Particle;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.collisions.SmallBrickCollision;
   import levels.collisions.SmallIceBlockCollision;
   import sprites.GameSprite;
   import sprites.enemies.*;
   import sprites.particles.GlimpseParticleSprite;
   import sprites.particles.WorriedParticleSprite;
   
   public class RockEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var attack_counter:int;
      
      protected var fall_counter:int;
      
      protected var start_x:Number;
      
      protected var diff_x:Number;
      
      protected var start_y:Number;
      
      protected var diff_y:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      protected var jumpXPos:Number;
      
      protected var jumpYPos:Number;
      
      public function RockEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 24;
         HEIGHT = 23;
         speed = 0.8;
         ai_index = _ai;
         this.attack_counter = 0;
         this.fall_counter = 0;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.jumpXPos = this.jumpYPos = 0;
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         sprite = new RockEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 22;
         aabbPhysics.height = 23;
         aabb.x = 1;
         aabb.y = 8;
         aabb.width = 22;
         aabb.height = 15;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HOP_ACTION","IS_HOPPING_STATE");
         stateMachine.setRule("IS_HOPPING_STATE","GROUND_COLLISION_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","SEES_HERO_ACTION","IS_PRE_JUMP_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SEES_HERO_ACTION","IS_PRE_JUMP_STATE");
         stateMachine.setRule("IS_PRE_JUMP_STATE","END_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","END_ACTION","IS_TRANSFORM_START_STATE");
         stateMachine.setRule("IS_TRANSFORM_START_STATE","END_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_ROCK_ON_GROUND_STATE");
         stateMachine.setRule("IS_ROCK_ON_GROUND_STATE","END_ACTION","IS_TRANSFORM_END_STATE");
         stateMachine.setRule("IS_TRANSFORM_END_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_PRE_JUMP_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HOPPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TRANSFORM_END_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_PRE_JUMP_STATE",this.preJumpAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_TRANSFORM_START_STATE",this.transformStartAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_ROCK_ON_GROUND_STATE",this.rockOnGroundAnimation);
         stateMachine.setFunctionToState("IS_TRANSFORM_END_STATE",this.transformEndAnimation);
         stateMachine.setFunctionToState("IS_HOPPING_STATE",this.hoppingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_WALKING_STATE");
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
         stateMachine.setState("IS_WALKING_STATE");
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var brick_aabb:Rectangle = null;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(int(Math.random() * 2) + 0.5));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            if(this.walk_counter-- < 0)
            {
               this.walk_counter = int(Math.random() * 2 + 3) * 60;
               stateMachine.performAction("WALK_ACTION");
            }
            this.seesHeroCheck();
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
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
            this.boundariesCheck();
            this.seesHeroCheck();
         }
         else if(stateMachine.currentState == "IS_PRE_JUMP_STATE")
         {
            ++counter1;
            if(counter1 > 30)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               if(this.isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("throw");
               }
               stateMachine.performAction("END_ACTION");
            }
            xPos = this.jumpXPos = Easings.linear(this.t_tick,this.start_x,this.diff_x,this.t_time);
            yPos = this.jumpYPos = Easings.easeOutQuart(this.t_tick,this.start_y,this.diff_y,this.t_time);
         }
         else if(stateMachine.currentState == "IS_TRANSFORM_START_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
            xPos = this.jumpXPos;
            yPos = this.jumpYPos;
            xVel = yVel = 0;
         }
         else if(stateMachine.currentState == "IS_HOPPING_STATE")
         {
            if(DIRECTION == Entity.RIGHT)
            {
               xVel = 1;
            }
            else
            {
               xVel = -1;
            }
         }
         else if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            brick_aabb = new Rectangle();
            for(i = 0; i < level.collisionsManager.collisions.length; i++)
            {
               if(level.collisionsManager.collisions[i] != null)
               {
                  if(level.collisionsManager.collisions[i] is SmallBrickCollision)
                  {
                     if(level.collisionsManager.collisions[i].dead == false)
                     {
                        brick_aabb.x = level.collisionsManager.collisions[i].xPos - 4;
                        brick_aabb.y = level.collisionsManager.collisions[i].yPos - 4;
                        brick_aabb.width = brick_aabb.height = 24;
                        if(brick_aabb.intersects(getAABBPhysics()))
                        {
                           level.collisionsManager.collisions[i].explode();
                        }
                     }
                  }
                  else if(level.collisionsManager.collisions[i] is SmallIceBlockCollision)
                  {
                     if(level.collisionsManager.collisions[i].dead == false)
                     {
                        brick_aabb.x = level.collisionsManager.collisions[i].xPos - 4;
                        brick_aabb.y = level.collisionsManager.collisions[i].yPos - 4;
                        brick_aabb.width = brick_aabb.height = 24;
                        if(brick_aabb.intersects(getAABBPhysics()))
                        {
                           level.collisionsManager.collisions[i].explode();
                        }
                     }
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_ROCK_ON_GROUND_STATE")
         {
            if(counter2 < 7)
            {
               if(counter1++ > 0)
               {
                  counter1 = 0;
                  if(xPos == this.jumpXPos)
                  {
                     xPos = this.jumpXPos + 2;
                  }
                  else
                  {
                     xPos = this.jumpXPos;
                  }
                  ++counter2;
               }
            }
            else if(counter2++ == 60)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TRANSFORM_END_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         if(!dead)
         {
            if(stateMachine.currentState != "IS_HIT_STATE")
            {
               if(Utils.SEA_LEVEL > 0)
               {
                  if(yPos >= Utils.SEA_LEVEL - 8)
                  {
                     stateMachine.setState("IS_HIT_STATE");
                  }
               }
            }
         }
         ++this.attack_counter;
         if(this.attack_counter > 120)
         {
            this.attack_counter = 120;
         }
         --this.fall_counter;
         if(this.fall_counter <= 0)
         {
            this.fall_counter = 0;
         }
         integratePositionAndCollisionDetection();
      }
      
      override public function noGroundCollision() : void
      {
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(this.fall_counter == 0)
            {
               if(DIRECTION == RIGHT)
               {
                  xPos += 2;
               }
               else
               {
                  xPos -= 2;
               }
               this.fall_counter = 60;
            }
         }
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      protected function seesHeroCheck() : void
      {
         var xDiff:Number = Math.abs(getMidXPos() - level.hero.getMidXPos());
         var yDiff:Number = Math.abs(getMidYPos() - level.hero.getMidYPos());
         if(xDiff > 64 || this.attack_counter < 120 || yDiff > 40)
         {
            return;
         }
         if(DIRECTION == Entity.LEFT)
         {
            if(level.hero.getMidXPos() < getMidXPos())
            {
               stateMachine.performAction("SEES_HERO_ACTION");
            }
         }
         else if(level.hero.getMidXPos() > getMidXPos())
         {
            stateMachine.performAction("SEES_HERO_ACTION");
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
            pSprite = new GlimpseParticleSprite();
            if(DIRECTION == Entity.LEFT)
            {
               particle = level.particlesManager.pushParticle(pSprite,4,12,0,0,1);
            }
            else
            {
               pSprite.scaleX = -1;
               particle = level.particlesManager.pushParticle(pSprite,15 + 5,2 + 10,0,0,1);
            }
            particle.setEntity(this);
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
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE" || stateMachine.currentState == "IS_HOPPING_STATE")
         {
            if(yVel >= 0)
            {
               stateMachine.performAction("GROUND_COLLISION_ACTION");
            }
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         var x_t:int = int((xPos + WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         if(DIRECTION == RIGHT)
         {
            stateMachine.performAction("HOP_ACTION");
         }
         else
         {
            stateMachine.performAction("HOP_ACTION");
         }
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
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(frame_counter + 1);
         counter1 = 0;
         MAX_X_VEL = 0.5;
         speed = 0.8;
         x_friction = 0.8;
         xVel = 0;
         gravity_friction = 1;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function preJumpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = 0;
         this.setEmotionParticle(Entity.EMOTION_SHOCKED);
      }
      
      public function jumpingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.start_x = xPos;
         this.start_y = yPos;
         this.diff_x = level.hero.getMidXPos() - xPos - WIDTH * 0.5;
         if(Math.abs(yPos - level.hero.yPos) < 32)
         {
            this.diff_y = level.hero.yPos - 56 - yPos;
         }
         else
         {
            this.diff_y = -48;
         }
         var time_diff:Number = Math.abs(this.diff_x);
         if(time_diff < 48)
         {
            time_diff = 48;
         }
         this.t_tick = 0;
         this.t_time = Math.abs(time_diff * 0.01);
      }
      
      protected function transformStartAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      protected function fallingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         counter1 = counter2 = 0;
      }
      
      protected function rockOnGroundAnimation() : void
      {
         if(this.isInsideInnerScreen())
         {
            SoundSystem.PlaySound("ground_stomp");
         }
         level.camera.shake(2,true,15);
         counter1 = counter2 = 0;
         this.attack_counter = 0;
         level.particlesManager.createDust(xPos + 8,yPos + HEIGHT,Entity.LEFT);
         level.particlesManager.createDust(xPos + WIDTH - 8,yPos + HEIGHT,Entity.RIGHT);
      }
      
      protected function transformEndAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         this.attack_counter = 0;
      }
      
      protected function hoppingAnimation() : void
      {
         MAX_X_VEL = 2;
         gravity_friction = 0.5;
         if(getTileAhead(0,-1,false) == 0)
         {
            yVel = -3;
         }
         else
         {
            yVel = -4;
         }
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            return false;
         }
         if(stateMachine.currentState == "IS_ROCK_ON_GROUND_STATE")
         {
            return false;
         }
         return true;
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
   }
}
