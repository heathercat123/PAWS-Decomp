package entities.enemies
{
   import entities.Entity;
   import entities.Hero;
   import entities.particles.Particle;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.enemies.GiantRockEnemySprite;
   import sprites.particles.WorriedParticleSprite;
   import sprites.particles.ZSleepParticleSprite;
   
   public class GiantRockEnemy extends GiantEnemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var xWhenWalking:int;
      
      protected var wakeUpXPos:Number;
      
      protected var earthquake_flag:Boolean;
      
      protected var z_counter:int;
      
      public function GiantRockEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         ai_index = _ai;
         this.xWhenWalking = originalXPos;
         this.earthquake_flag = false;
         this.z_counter = -Utils.random.nextMax(120);
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         sprite = new GiantRockEnemySprite();
         Utils.world.addChild(sprite);
         aabb.x = -4;
         aabb.y = 4;
         aabb.width = 40;
         aabb.height = 24;
         aabbPhysics.x = 3 - 11;
         aabbPhysics.y = 4 - 4;
         aabbPhysics.width = 26 + 22;
         aabbPhysics.height = 28 + 4;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_SLEEPING_STATE","WAKE_UP_ACTION","IS_WAKING_UP_STATE");
         stateMachine.setRule("IS_WAKING_UP_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SLEEP_ACTION","IS_FALLING_ASLEEP_STATE");
         stateMachine.setRule("IS_FALLING_ASLEEP_STATE","GROUND_COLLISION_ACTION","IS_SLEEPING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_HURT_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_HURT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_SLEEPING_STATE",this.sleepingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_ASLEEP_STATE",this.fallingAsleepAnimation);
         stateMachine.setFunctionToState("IS_WAKING_UP_STATE",this.wakingUpAnimation);
         stateMachine.setFunctionToState("IS_HURT_STATE",this.hurtAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_SLEEPING_STATE");
         energy = 2;
      }
      
      override public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "hurt")
         {
            if(stunHandler.IS_STUNNED)
            {
               SoundSystem.PlaySound("big_enemy_hurt");
            }
            else
            {
               SoundSystem.PlaySound("big_enemy_hit");
            }
         }
      }
      
      override public function reset() : void
      {
         var mid_x:int = getMidXPos() / Utils.TILE_WIDTH;
         var mid_y:int = getMidYPos() / Utils.TILE_HEIGHT;
         var area:Rectangle = new Rectangle((mid_x - 1) * Utils.TILE_WIDTH,(mid_y - 1) * Utils.TILE_HEIGHT,Utils.TILE_WIDTH * 3,Utils.TILE_HEIGHT * 2);
         level.levelData.setTileValueToArea(area,0);
         super.reset();
         stateMachine.setState("IS_SLEEPING_STATE");
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState == "IS_SLEEPING_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override public function update() : void
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         super.update();
         if(stateMachine.currentState == "IS_SLEEPING_STATE")
         {
            if(level.hero.stateMachine.currentState == "IS_HEAD_POUND_STATE")
            {
               diff_x = Math.abs(level.hero.getMidXPos() - getMidXPos());
               diff_y = Math.abs(level.hero.getMidYPos() - getMidYPos());
               if(diff_x <= 32 && diff_y <= 24)
               {
                  stateMachine.performAction("WAKE_UP_ACTION");
               }
            }
            if(this.z_counter++ > 120)
            {
               this.z_counter = 0;
               if(DIRECTION == LEFT)
               {
                  level.topParticlesManager.pushParticle(new ZSleepParticleSprite(),xPos - 8,yPos,0,0,0,0,0,1);
               }
               else
               {
                  level.topParticlesManager.pushParticle(new ZSleepParticleSprite(),xPos + WIDTH,yPos,0,0,0,0,0,0);
               }
            }
         }
         else if(stateMachine.currentState == "IS_WAKING_UP_STATE")
         {
            if(counter1++ > 1)
            {
               if(xPos >= this.wakeUpXPos)
               {
                  xPos = this.wakeUpXPos - 2;
               }
               else
               {
                  xPos = this.wakeUpXPos + 2;
               }
               counter1 = 0;
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               xPos = this.wakeUpXPos;
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(this.walk_counter-- < 0)
            {
               this.walk_counter = int(Math.random() * 2 + 3) * 60;
               stateMachine.performAction("WALK_ACTION");
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
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().currentFrame % 2 == 0)
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
         else if(stateMachine.currentState == "IS_HURT_STATE")
         {
            ++counter1;
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
         if(stateMachine.currentState == "IS_FALLING_ASLEEP_STATE")
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
            if(this.isInsideInnerScreen())
            {
               SoundSystem.PlaySound("ground_stomp");
               level.camera.verShake(4,0.85,1.2);
            }
         }
         else if(stateMachine.currentState == "IS_HURT_STATE")
         {
            if(this.earthquake_flag)
            {
               this.earthquake_flag = false;
               level.camera.shake();
            }
         }
         gravity_friction = 1;
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
         if(Math.abs(this.xWhenWalking - xPos) <= 8)
         {
            stateMachine.performAction("TURN_ACTION");
         }
         else
         {
            stateMachine.performAction("SLEEP_ACTION");
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
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         this.xWhenWalking = xPos;
         speed = 2;
         x_friction = 0.8;
         xVel = 0;
      }
      
      public function fallingAsleepAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
         yVel = 0;
         yPos -= 8;
      }
      
      public function sleepingAnimation() : void
      {
         var mid_x:int = getMidXPos() / Utils.TILE_WIDTH;
         var mid_y:int = getMidYPos() / Utils.TILE_HEIGHT;
         var area:Rectangle = new Rectangle((mid_x - 1) * Utils.TILE_WIDTH,(mid_y - 1) * Utils.TILE_HEIGHT,Utils.TILE_WIDTH * 3,Utils.TILE_HEIGHT * 2);
         level.levelData.setTileValueToArea(area,16);
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function wakingUpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         var mid_x:int = getMidXPos() / Utils.TILE_WIDTH;
         var mid_y:int = getMidYPos() / Utils.TILE_HEIGHT;
         var area:Rectangle = new Rectangle((mid_x - 1) * Utils.TILE_WIDTH,(mid_y - 1) * Utils.TILE_HEIGHT,Utils.TILE_WIDTH * 3,Utils.TILE_HEIGHT * 2);
         this.wakeUpXPos = xPos;
         level.levelData.setTileValueToArea(area,0);
      }
      
      override public function hurtAnimation() : void
      {
         super.hurtAnimation();
         this.earthquake_flag = true;
         level.camera.shake();
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(level.hero.getMidXPos() > getMidXPos())
         {
            xVel = -2;
         }
         else
         {
            xVel = 2;
         }
         yVel = -2;
         gravity_friction = 0.4;
         x_friction = 0.95;
         counter1 = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         SoundSystem.PlaySound("giant_turnip_defeat");
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_SLEEPING_STATE" || stateMachine.currentState == "IS_HURT_STATE" && counter1 < 20)
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
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
