package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import entities.particles.Particle;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.GameSprite;
   import sprites.bullets.GenericBulletSprite;
   import sprites.enemies.SquidEnemySprite;
   import sprites.enemies.WindEggEnemySprite;
   import sprites.particles.GlimpseParticleSprite;
   
   public class SquidEnemy extends Enemy
   {
       
      
      protected var start_y:Number;
      
      protected var diff_y:Number;
      
      protected var tick:Number;
      
      protected var time:Number;
      
      protected var last_attack_counter:int;
      
      protected var fell_at_x:Number;
      
      protected var bullet_counter:int;
      
      public function SquidEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 10;
         if(ai_index == 1)
         {
            WIDTH = 24;
            HEIGHT = 23;
         }
         speed = 0.8;
         this.bullet_counter = 0;
         this.last_attack_counter = 0;
         MAX_Y_VEL = 0.5;
         oldXPos = 0;
         oldYPos = 0;
         this.fell_at_x = 0;
         if(_ai_index == 0)
         {
            sprite = new SquidEnemySprite();
         }
         else
         {
            sprite = new WindEggEnemySprite(3);
         }
         Utils.world.addChild(sprite);
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         if(ai_index == 1)
         {
            aabbPhysics.x = 1;
            aabbPhysics.y = 0;
            aabbPhysics.width = 22;
            aabbPhysics.height = 23;
            aabb.x = 1;
            aabb.y = 0;
            aabb.width = 22;
            aabb.height = 23;
         }
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","JUMP_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_FLYING_STATE","END_ACTION","IS_FALLING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_GROUND_STATE");
         stateMachine.setRule("IS_GROUND_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_GROUND_STATE","TURN_ACTION","IS_TURNING_STATE");
         if(ai_index == 1)
         {
            stateMachine.setRule("IS_WALKING_STATE","ATTACK_ACTION","IS_ATTACKING_STATE");
            stateMachine.setRule("IS_ATTACKING_STATE","END_ACTION","IS_WALKING_STATE");
            stateMachine.setRule("IS_ATTACKING_STATE","HIT_ACTION","IS_HIT_STATE");
         }
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FLYING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_GROUND_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_FLYING_STATE",this.flyingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_GROUND_STATE",this.groundAnimation);
         if(ai_index == 1)
         {
            stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackingAnimation);
         }
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_WALKING_STATE");
         energy = 1;
         if(ai_index == 1)
         {
            energy = 2;
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         if(ai_index == 1)
         {
            energy = 2;
         }
         stateMachine.setState("IS_WALKING_STATE");
      }
      
      override public function update() : void
      {
         var mid_x:Number = NaN;
         super.update();
         x_friction = 0.8;
         if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().currentFrame == 3)
            {
               if(ai_index == 0)
               {
                  if(counter1 == 0)
                  {
                     ++counter1;
                     ++counter2;
                     if(counter2 == 2)
                     {
                        yVel = -1.5;
                     }
                  }
               }
               if(DIRECTION == LEFT)
               {
                  xVel -= 0.25;
               }
               else
               {
                  xVel += 0.25;
               }
            }
            else
            {
               counter1 = 0;
            }
            if(ai_index == 1)
            {
               --this.last_attack_counter;
               if(isSeeingHero(80,40) && this.last_attack_counter <= 0)
               {
                  stateMachine.performAction("ATTACK_ACTION");
               }
               else if(path_start_x > 0)
               {
                  if(xPos <= path_start_x && DIRECTION == LEFT)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
                  else if(xPos + WIDTH >= path_end_x && DIRECTION == RIGHT)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
               }
            }
            else if(counter2 > 2 && ai_index == 0)
            {
               stateMachine.performAction("JUMP_ACTION");
            }
            yVel += 0.2;
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
            yVel += 0.2;
         }
         else if(stateMachine.currentState == "IS_FLYING_STATE")
         {
            if(DIRECTION == LEFT)
            {
               xVel -= 0.15;
            }
            else
            {
               xVel += 0.15;
            }
            yVel = 0;
            if(counter1 == 0)
            {
               this.tick += 1 / 60;
               if(this.tick >= this.time)
               {
                  this.tick = this.time;
                  counter1 = 1;
               }
               yPos = Easings.easeOutSine(this.tick,this.start_y,this.diff_y,this.time);
            }
            else if(counter1 == 1)
            {
               if(Math.abs(xPos + WIDTH * 0.5 - oldXPos) >= 16 || true)
               {
                  oldYPos = yPos;
                  counter1 = 2;
               }
            }
            else if(counter1 == 2)
            {
               sinCounter1 += 0.125;
               yPos = oldYPos + Math.sin(sinCounter1) * 8;
               if(sinCounter1 >= Math.PI * 1.5)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_ATTACKING_STATE")
         {
            if(counter1 < 1)
            {
               if(counter2++ >= 25)
               {
                  counter1 = 1;
                  this.fell_at_x = int(xPos);
                  counter2 = 0;
                  sprite.gfxHandle().gotoAndStop(5);
                  sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               }
            }
            else
            {
               ++counter2;
               if(counter2 >= 4)
               {
                  counter2 = 0;
                  if(xPos == int(this.fell_at_x))
                  {
                     xPos = int(this.fell_at_x + 1);
                  }
                  else
                  {
                     xPos = int(this.fell_at_x);
                  }
               }
               ++counter3;
               if(counter3 >= 7)
               {
                  counter3 = 0;
                  this.shootBullet();
               }
               --this.last_attack_counter;
               if(this.last_attack_counter <= 0)
               {
                  this.last_attack_counter = 120;
                  stateMachine.performAction("END_ACTION");
               }
            }
            yVel += 0.2;
         }
         else if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            yVel += 0.2;
            x_friction = 0.99;
            mid_x = xPos + WIDTH * 0.5;
            if(Math.abs(mid_x - this.fell_at_x) >= 8)
            {
               xVel = 0;
            }
         }
         else if(stateMachine.currentState == "IS_GROUND_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               if(xPos <= path_start_x && DIRECTION == LEFT)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
               else if(xPos + WIDTH >= path_end_x && DIRECTION == RIGHT)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
               else
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         if(stateMachine.currentState == "IS_FLYING_STATE" || stateMachine.currentState == "IS_FALLING_STATE")
         {
            aabb.y = -3;
            aabb.height = 15;
         }
         else
         {
            aabb.y = -1;
            aabb.height = 13;
         }
         xVel *= x_friction;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      protected function shootBullet() : void
      {
         var genericBulletSprite:GenericBulletSprite = new GenericBulletSprite(GenericBulletSprite.WATER_CANNON);
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_shoot_bubble");
         }
         if(DIRECTION == Entity.LEFT)
         {
            level.bulletsManager.pushBullet(genericBulletSprite,int(this.fell_at_x - 6),yPos + 14,-2,0,1,this.bullet_counter++);
         }
         else
         {
            level.bulletsManager.pushBullet(genericBulletSprite,int(this.fell_at_x + 30),yPos + 14,2,0,1,this.bullet_counter++);
         }
         if(this.bullet_counter > 1)
         {
            this.bullet_counter = 0;
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         if(ai_index == 1)
         {
            stateMachine.performAction("TURN_ACTION");
         }
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
            this.inkBullets();
         }
      }
      
      protected function inkBullets() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_shoot_bubble");
         }
         level.bulletsManager.pushBullet(new GenericBulletSprite(GenericBulletSprite.INK),xPos,yPos + HEIGHT,-0.5,-1,1);
         level.bulletsManager.pushBullet(new GenericBulletSprite(GenericBulletSprite.INK),xPos + WIDTH,yPos + HEIGHT,0.5,-1,1);
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = 0;
         x_friction = 0.8;
      }
      
      public function walkingAnimation() : void
      {
         if(ai_index == 0)
         {
            sprite.gfxHandle().gotoAndStop(1);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(2);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         x_friction = 0.8;
      }
      
      public function turnAnimation() : void
      {
         if(ai_index == 0)
         {
            sprite.gfxHandle().gotoAndStop(2);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(3);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function jumpingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = 0;
         xVel = 0;
         yVel = -2;
      }
      
      public function flyingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_jump");
         }
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         counter3 = 0;
         oldXPos = xPos + WIDTH * 0.5;
         yVel = 0;
         sinCounter1 = 0;
         this.start_y = yPos;
         this.diff_y = -Utils.TILE_HEIGHT * 2;
         this.tick = 0;
         this.time = 0.5;
      }
      
      public function fallingAnimation() : void
      {
         this.fell_at_x = xPos + WIDTH * 0.5;
      }
      
      public function groundAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = yVel = 0;
      }
      
      public function attackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.last_attack_counter = 120;
         xVel = yVel = 0;
         counter1 = counter2 = counter3 = 0;
         this.setEmotionParticle(Entity.EMOTION_SHOCKED);
      }
      
      override public function setEmotionParticle(emotion_id:int) : void
      {
         var pSprite:GameSprite = null;
         var particle:Particle = null;
         shocked_offset_x = -1;
         shocked_offset_y = 10;
         if(emotion_id == Entity.EMOTION_SHOCKED)
         {
            pSprite = new GlimpseParticleSprite();
            if(DIRECTION == Entity.LEFT)
            {
               particle = level.particlesManager.pushParticle(pSprite,1 - shocked_offset_x,2 + shocked_offset_y,0,0,1);
            }
            else
            {
               pSprite.scaleX = -1;
               particle = level.particlesManager.pushParticle(pSprite,15 + shocked_offset_x + 7,2 + shocked_offset_y,0,0,1);
            }
            particle.setEntity(this);
         }
      }
      
      public function hitAnimation() : void
      {
         if(ai_index == 1)
         {
            sprite.gfxHandle().gotoAndStop(4);
            level.camera.shake(6);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(5);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(ai_index == 0)
         {
            if(KILLED_BY_CAT)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_SQUID_DEFEATED_BY_ANY_CAT);
            }
         }
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
   }
}
