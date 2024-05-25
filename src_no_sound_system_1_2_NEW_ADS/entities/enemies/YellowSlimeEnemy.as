package entities.enemies
{
   import flash.geom.Rectangle;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.YellowSlimeEnemySprite;
   import sprites.particles.RedGooDropParticleSprite;
   
   public class YellowSlimeEnemy extends Enemy
   {
       
      
      protected var isGravityDown:Boolean;
      
      protected var isTopDown:Boolean;
      
      protected var original_isTopDown:Boolean;
      
      protected var original_isGravityDown:Boolean;
      
      public function YellowSlimeEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _gravity:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         sprite = new YellowSlimeEnemySprite();
         Utils.world.addChild(sprite);
         aabb.y = aabbPhysics.y = 3;
         aabb.height = aabbPhysics.height = 10;
         if(ai_index == 0 || ai_index == 2)
         {
            aabb.y -= 6;
            aabb.height += 6;
            aabb.y += 2;
            aabb.height += 2;
         }
         stateMachine = new StateMachine();
         if(_ai_index == 0 || _ai_index == 2)
         {
            stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
            stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
            stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
            stateMachine.setRule("IS_SLIMEBALL_STATE","GROUND_COLLISION_ACTION","IS_EMERGING_STATE");
            stateMachine.setRule("IS_EMERGING_STATE","END_ACTION","IS_WALKING_STATE");
            stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
            stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
            stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
            stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
            stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
            stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
            stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
            stateMachine.setFunctionToState("IS_SLIMEBALL_STATE",this.slimeballAnimation);
            stateMachine.setFunctionToState("IS_EMERGING_STATE",this.emergingAnimation);
            stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
            stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         }
         else
         {
            stateMachine.setRule("IS_STANDING_STATE","JUMP_ACTION","IS_READY_TO_JUMP_STATE");
            stateMachine.setRule("IS_READY_TO_JUMP_STATE","END_ACTION","IS_SHAKING_STATE");
            stateMachine.setRule("IS_SHAKING_STATE","END_ACTION","IS_PAUSE_STATE");
            stateMachine.setRule("IS_PAUSE_STATE","END_ACTION","IS_JUMPING_STATE");
            stateMachine.setRule("IS_JUMPING_STATE","LANDED_ACTION","IS_LANDING_STATE");
            stateMachine.setRule("IS_LANDING_STATE","END_ACTION","IS_STANDING_STATE");
            stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
            stateMachine.setRule("IS_READY_TO_JUMP_STATE","HIT_ACTION","IS_HIT_STATE");
            stateMachine.setRule("IS_SHAKING_STATE","HIT_ACTION","IS_HIT_STATE");
            stateMachine.setRule("IS_PAUSE_STATE","HIT_ACTION","IS_HIT_STATE");
            stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HIT_STATE");
            stateMachine.setRule("IS_LANDING_STATE","HIT_ACTION","IS_HIT_STATE");
            stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
            stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
            stateMachine.setFunctionToState("IS_READY_TO_JUMP_STATE",this.readyToJumpAnimation);
            stateMachine.setFunctionToState("IS_SHAKING_STATE",this.shakingAnimation);
            stateMachine.setFunctionToState("IS_PAUSE_STATE",this.pauseAnimation);
            stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
            stateMachine.setFunctionToState("IS_LANDING_STATE",this.landingAnimation);
            stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
            stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         }
         if(ai_index == 2)
         {
            stateMachine.setState("IS_SLIMEBALL_STATE");
         }
         else
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
         if(_gravity > 0)
         {
            this.isGravityDown = false;
            this.isTopDown = true;
         }
         else
         {
            this.isGravityDown = true;
            this.isTopDown = false;
         }
         if(ai_index == 0 || ai_index == 2)
         {
            aabbSpike.x = 0 + 3 + 2;
            aabbSpike.y = 0 - 4;
            aabbSpike.width = 0 + 10 - 4;
            aabbSpike.height = 0 + 8;
            aabb.x = 0 + 0;
            aabb.y = -1 + 4;
            aabb.width = 16 + 0;
            aabb.height = 18 - 8;
         }
         this.original_isTopDown = this.isTopDown;
         this.original_isGravityDown = this.isGravityDown;
         energy = 1;
      }
      
      override public function reset() : void
      {
         xPos = originalXPos;
         yPos = originalYPos;
         xVel = yVel = 0;
         DIRECTION = ORIGINAL_DIRECTION;
         energy = 1;
         this.isTopDown = this.original_isTopDown;
         this.isGravityDown = this.original_isGravityDown;
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               if(ai_index == 1)
               {
                  stateMachine.performAction("JUMP_ACTION");
               }
               else
               {
                  stateMachine.performAction("WALK_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_READY_TO_JUMP_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_SHAKING_STATE")
         {
            ++counter1;
            if(counter1 >= 40)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_PAUSE_STATE")
         {
            ++counter1;
            if(counter1 >= 15)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_EMERGING_STATE")
         {
            ++counter1;
            if(counter1 == 60)
            {
               if(isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("enemy_water");
               }
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(2);
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState != "IS_JUMPING_STATE")
         {
            if(stateMachine.currentState == "IS_LANDING_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_WALKING_STATE")
            {
               speed = 1.5;
               if(sprite.gfxHandle().gfxHandleClip().currentFrame % 2 == 1)
               {
                  if(DIRECTION == LEFT)
                  {
                     xVel = -speed;
                  }
                  else
                  {
                     xVel = speed;
                  }
               }
               else
               {
                  xVel = 0;
               }
               this.boundariesCheck();
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
                  if(counter2 > 12)
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
         }
         if(this.isGravityDown)
         {
            yVel += 0.2;
         }
         else
         {
            yVel -= 0.2;
         }
         if(ai_index == 1)
         {
            aabbSpike.x = 0 + 3 + 2;
            aabbSpike.y = 0 - 4;
            aabbSpike.width = 0 + 10 - 4;
            aabbSpike.height = 0 + 8;
            aabb.x = 0 + 0;
            aabb.y = -1 + 4;
            aabb.width = 16 + 0;
            aabb.height = 18 - 8;
            if(this.isTopDown)
            {
               aabbSpike.y += 16;
            }
            if(stateMachine.currentState == "IS_JUMPING_STATE")
            {
               aabbSpike.width = aabbSpike.height = 0;
            }
         }
         else
         {
            aabbSpike.x = 0 + 3 + 2;
            aabbSpike.y = 0 - 4;
            aabbSpike.width = 0 + 10 - 4;
            aabbSpike.height = 0 + 8;
            aabb.x = 0 + 0;
            aabb.y = -1 + 4;
            aabb.width = 16 + 0;
            aabb.height = 18 - 8;
            if(stateMachine.currentState == "IS_SLIMEBALL_STATE" || stateMachine.currentState == "IS_EMERGING_STATE")
            {
               aabbSpike.width = aabbSpike.height = 0;
            }
         }
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         if(ai_index == 0 || ai_index == 2)
         {
            stateMachine.performAction("TURN_ACTION");
         }
      }
      
      override public function getAABB() : Rectangle
      {
         if(stateMachine.currentState == "IS_SLIMEBALL_STATE" || stateMachine.currentState == "IS_EMERGING_STATE")
         {
            return new Rectangle(xPos,yPos,0,0);
         }
         return new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(stateMachine.currentState == "IS_SLIMEBALL_STATE" || stateMachine.currentState == "IS_EMERGING_STATE")
         {
            return false;
         }
         var enemy_mid_x:Number = getMidXPos();
         var hero_mid_x:Number = level.hero.getMidXPos();
         if(ai_index == 0 || ai_index == 2)
         {
            if(level.hero.getAABB().intersects(getAABBSpike()))
            {
               return false;
            }
            return true;
         }
         if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            return true;
         }
         if(this.isTopDown)
         {
            if(level.hero.yPos + level.hero.aabb.y >= yPos + aabb.y + aabb.height - 4)
            {
               return false;
            }
            return true;
         }
         if(level.hero.yPos + level.hero.aabb.y + level.hero.aabb.height <= yPos + aabb.y + 4)
         {
            return false;
         }
         return true;
      }
      
      override public function groundCollision() : void
      {
         if(ai_index == 1)
         {
            if(this.isGravityDown)
            {
               stateMachine.performAction("LANDED_ACTION");
            }
         }
         else if(ai_index == 2)
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
         }
      }
      
      override public function ceilCollision() : void
      {
         if(ai_index == 1)
         {
            if(!this.isGravityDown)
            {
               stateMachine.performAction("LANDED_ACTION");
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.isTopDown)
         {
            sprite.gfxHandle().scaleY = -1;
         }
         else
         {
            sprite.gfxHandle().scaleY = 1;
         }
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function readyToJumpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function shakingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function pauseAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         counter1 = 0;
      }
      
      public function jumpingAnimation() : void
      {
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_jump_low");
         }
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.isGravityDown = !this.isGravityDown;
         if(this.isGravityDown)
         {
            yVel = 0.5;
         }
         else
         {
            yVel = -0.5;
         }
      }
      
      public function landingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         this.isTopDown = !this.isTopDown;
      }
      
      public function slimeballAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         x_friction = 1;
      }
      
      public function emergingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(9);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function hitAnimation() : void
      {
         if(KILLED_BY_CAT)
         {
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_YELLOW_SLIME_ENEMY_DEFEATED_BY_ANY_CAT);
         }
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.yellowGooParticleSprites();
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      protected function yellowGooParticleSprites() : void
      {
         var pSprite:RedGooDropParticleSprite = null;
         var angle:Number = NaN;
         var power:Number = NaN;
         var i:int = 0;
         var x_vel_mult:Number = 1;
         var amount:int = 3;
         if(Math.random() * 100 > 50)
         {
            amount = 4;
         }
         var isLeft:Boolean = true;
         if(level.hero.getMidXPos() > getMidXPos())
         {
            isLeft = false;
         }
         for(i = 0; i < amount; i++)
         {
            pSprite = new RedGooDropParticleSprite(1);
            if(Math.random() * 100 > 80)
            {
               pSprite.gfxHandleClip().gotoAndPlay(2);
            }
            power = 2.5 + Math.random() * 1;
            if(!isLeft)
            {
               angle = Math.PI + Math.PI * 0.25 + Math.random() * (Math.PI * 0.25);
               level.particlesManager.pushBackParticle(pSprite,getMidXPos() + (Math.random() * 8 - 4),getMidYPos() + (Math.random() * 8 - 4),Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power * 1.2,1);
            }
            else
            {
               angle = Math.PI * 0.5 + Math.PI * 0.25 + Math.random() * (Math.PI * 0.25);
               level.particlesManager.pushBackParticle(pSprite,getMidXPos() + (Math.random() * 8 - 4),getMidYPos() + (Math.random() * 8 - 4),Math.sin(angle) * power * x_vel_mult,Math.cos(angle) * power * 1.2,1);
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
   }
}
