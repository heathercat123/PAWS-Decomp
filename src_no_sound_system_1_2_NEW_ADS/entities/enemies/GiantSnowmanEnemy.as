package entities.enemies
{
   import entities.Entity;
   import entities.Hero;
   import entities.particles.Particle;
   import flash.geom.Rectangle;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.enemies.GiantSnowmanEnemySprite;
   import sprites.particles.RedGooDropParticleSprite;
   import sprites.particles.SnowBigParticleSprite;
   import sprites.particles.WorriedParticleSprite;
   
   public class GiantSnowmanEnemy extends GiantEnemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var SPAWN_SNOWMEN_FLAG:Boolean;
      
      protected var TYPE:int;
      
      public function GiantSnowmanEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int, _type:int = 0)
      {
         this.TYPE = _type;
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         ai_index = _ai;
         this.SPAWN_SNOWMEN_FLAG = false;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         sprite = new GiantSnowmanEnemySprite(this.TYPE);
         Utils.world.addChild(sprite);
         aabb.x = 3;
         aabb.y = 4;
         aabb.width = 26;
         aabb.height = 28;
         if(this.TYPE == 1)
         {
            aabb.x = 3 - 2;
            aabb.y = 4 + 10;
            aabb.width = 26 + 2;
            aabb.height = 28 - 10;
         }
         aabbPhysics.x = 3;
         aabbPhysics.y = 4;
         aabbPhysics.width = 26;
         aabbPhysics.height = 28;
         if(this.TYPE == 1)
         {
            aabbPhysics.x = 3 - 4;
            aabbPhysics.y = 4 + 10;
            aabbPhysics.width = 26 + 6;
            aabbPhysics.height = 28 - 10;
            stunHandler.stun_y_offset = 0;
         }
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
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
         stateMachine.setFunctionToState("IS_HURT_STATE",this.hurtAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",this.deadAnimation);
         if(ai_index == 0)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else if(ai_index == 1)
         {
            stateMachine.setState("IS_HIDDEN_STATE");
         }
         if(this.TYPE == 1)
         {
            aabbSpike.x = 10;
            aabbSpike.y = 4;
            aabbSpike.width = 10;
            aabbSpike.height = 10;
         }
         energy = 2;
      }
      
      override public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "hurt")
         {
            SoundSystem.PlaySound("big_enemy_hurt");
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_WALKING_STATE");
         this.SPAWN_SNOWMEN_FLAG = false;
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            stateMachine.performAction("WALK_ACTION");
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
            if(DIRECTION == RIGHT)
            {
               xVel = speed;
            }
            else
            {
               xVel = -speed;
            }
            this.boundariesCheck();
         }
         integratePositionAndCollisionDetection();
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
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
      
      override protected function allowCatAttack() : Boolean
      {
         if(this.TYPE == 0)
         {
            return true;
         }
         var enemy_mid_x:Number = getMidXPos();
         var hero_mid_x:Number = level.hero.getMidXPos();
         if(ai_index == 0)
         {
            if(level.hero.getAABB().intersects(getAABBSpike()))
            {
               return false;
            }
            return true;
         }
         return true;
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
         if(stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
         }
         gravity_friction = 1;
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
         speed = 0.6;
         x_friction = 0.8;
         xVel = 0;
      }
      
      override public function hurtAnimation() : void
      {
         super.hurtAnimation();
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
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         this.SPAWN_SNOWMEN_FLAG = true;
         if(this.TYPE == 1)
         {
            if(KILLED_BY_CAT)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_YELLOW_SLIME_ENEMY_DEFEATED_BY_ANY_CAT);
            }
         }
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function deadAnimation() : void
      {
         var i:int = 0;
         var amount:int = 0;
         var pSprite:GameSprite = null;
         var rand_angle:Number = NaN;
         var rand_power:Number = NaN;
         dead = true;
         if(this.SPAWN_SNOWMEN_FLAG)
         {
            this.spawnSnowmen();
            amount = int(Math.round(Math.random() * 2 + 4));
            for(i = 0; i < amount; i++)
            {
               if(this.TYPE == 1)
               {
                  pSprite = new RedGooDropParticleSprite(1);
               }
               else
               {
                  pSprite = new SnowBigParticleSprite();
               }
               pSprite.gfxHandleClip().gotoAndStop(int(Math.random() * 2) + 1);
               rand_angle = Math.PI * 0.5 + Math.random() * Math.PI;
               rand_power = Math.random() * 4 + 4;
               level.particlesManager.pushBackParticle(pSprite,getMidXPos() + Math.sin(rand_angle) * rand_power,getMidYPos() + Math.cos(rand_angle) * rand_power,Math.sin(rand_angle) * rand_power * 0.5,Math.cos(rand_angle) * rand_power * 0.5,0.98 + Math.random() * 0.02);
            }
         }
      }
      
      protected function spawnSnowmen() : void
      {
         var enemy:Enemy = null;
         if(this.TYPE == 0)
         {
            enemy = new SnowmanEnemy(level,getMidXPos() + 16,getMidYPos(),Entity.RIGHT,1);
            enemy.updateScreenPosition(level.camera);
            enemy.xVel = 2;
            enemy.yVel = -4;
            level.enemiesManager.enemies.push(enemy);
            enemy = new SnowmanEnemy(level,getMidXPos() - 16,getMidYPos(),Entity.LEFT,1);
            enemy.updateScreenPosition(level.camera);
            enemy.xVel = -4;
            enemy.yVel = -2;
            level.enemiesManager.enemies.push(enemy);
         }
         else
         {
            enemy = new YellowSlimeEnemy(level,getMidXPos() + 16,getMidYPos(),Entity.RIGHT,0,2);
            enemy.updateScreenPosition(level.camera);
            enemy.xVel = 2;
            enemy.yVel = -1;
            level.enemiesManager.enemies.push(enemy);
            enemy = new YellowSlimeEnemy(level,getMidXPos() - 16,getMidYPos(),Entity.LEFT,0,2);
            enemy.updateScreenPosition(level.camera);
            enemy.xVel = -2;
            enemy.yVel = -1;
            level.enemiesManager.enemies.push(enemy);
         }
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
