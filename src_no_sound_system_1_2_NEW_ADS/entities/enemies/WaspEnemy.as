package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import entities.particles.Particle;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.enemies.WaspEnemySprite;
   import sprites.particles.GlimpseParticleSprite;
   import sprites.particles.WhitePointParticleSprite;
   
   public class WaspEnemy extends Enemy
   {
       
      
      protected var param_2:Number;
      
      protected var fly_sin_counter:Number;
      
      protected var last_point_x:Number;
      
      protected var last_point_y:Number;
      
      protected var attack_counter:int;
      
      protected var fly_y_offset:Number;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      public function WaspEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         ai_index = _ai;
         gravity_friction = 0;
         this.fly_sin_counter = Math.random() * Math.PI * 2;
         this.last_point_x = xPos;
         this.last_point_y = yPos;
         this.attack_counter = this.param_2 = 0;
         this.fly_y_offset = 0;
         this.t_start = this.t_diff = this.t_time = this.t_tick = 0;
         MAX_X_VEL = 2;
         MAX_Y_VEL = 4;
         sprite = new WaspEnemySprite();
         Utils.world.addChild(sprite);
         aabb.x = -6;
         aabb.y = -6;
         aabb.width = 12;
         aabb.height = 12;
         aabbPhysics.x = -6;
         aabbPhysics.y = -6;
         aabbPhysics.width = 12;
         aabbPhysics.height = 12;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","FLY_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_FLYING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_FLYING_STATE","ATTACK_ACTION","IS_PRE_ATTACKING_STATE");
         stateMachine.setRule("IS_PRE_ATTACKING_STATE","END_ACTION","IS_ATTACKING_STATE");
         stateMachine.setRule("IS_ATTACKING_STATE","END_ACTION","IS_RETURNING_UP_STATE");
         stateMachine.setRule("IS_RETURNING_UP_STATE","END_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FLYING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ATTACKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_PRE_ATTACKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_RETURNING_UP_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_FLYING_STATE",this.flyingAnimation);
         stateMachine.setFunctionToState("IS_PRE_ATTACKING_STATE",this.preAttackingAnimation);
         stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackingAnimation);
         stateMachine.setFunctionToState("IS_RETURNING_UP_STATE",this.returningUpAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_FLYING_STATE");
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
         this.attack_counter = this.param_2;
         stateMachine.setState("IS_FLYING_STATE");
      }
      
      override public function update() : void
      {
         var point_diff_x:Number = NaN;
         var point_diff_y:Number = NaN;
         var point_dist:Number = NaN;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            this.boundariesCheck();
            stateMachine.performAction("FLY_ACTION");
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
            this.updateFlyWave();
         }
         else if(stateMachine.currentState == "IS_FLYING_STATE")
         {
            this.boundariesCheck();
            if(DIRECTION == LEFT)
            {
               xVel = -0.8;
            }
            else
            {
               xVel = 0.8;
            }
            this.updateFlyWave();
            point_diff_x = this.last_point_x - xPos;
            point_diff_y = this.last_point_y - yPos;
            point_dist = Math.sqrt(point_diff_x * point_diff_x + point_diff_y * point_diff_y);
            if(point_dist >= 16)
            {
               this.last_point_x = xPos;
               this.last_point_y = yPos;
               level.particlesManager.pushBackParticle(new WhitePointParticleSprite(),xPos,yPos + this.fly_y_offset,0,0,0);
            }
            if(this.attack_counter-- < 0)
            {
               if(isFacingHero())
               {
                  if(this.isAttackPathClear())
                  {
                     if(this.isHeroAboutToCollide())
                     {
                        stateMachine.performAction("ATTACK_ACTION");
                     }
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_PRE_ATTACKING_STATE")
         {
            xVel *= 0.8;
            if(counter1++ >= 15)
            {
               stateMachine.performAction("END_ACTION");
            }
            this.updateFlyWave();
         }
         else if(stateMachine.currentState == "IS_ATTACKING_STATE")
         {
            xVel *= 0.8;
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               ++counter1;
               if(counter1 >= 15)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            yPos = Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
            this.updateFlyWave();
         }
         else if(stateMachine.currentState == "IS_RETURNING_UP_STATE")
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               stateMachine.performAction("END_ACTION");
            }
            yPos = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            aabbSpike.x = 1 - 3;
            aabbSpike.y = 5;
            aabbSpike.width = 5;
            aabbSpike.height = 10;
         }
         else if(DIRECTION == Entity.LEFT)
         {
            aabbSpike.x = 1;
            aabbSpike.y = 5;
            aabbSpike.width = 5;
            aabbSpike.height = 10;
         }
         else
         {
            aabbSpike.x = 1 - 7;
            aabbSpike.y = 5;
            aabbSpike.width = 5;
            aabbSpike.height = 10;
         }
         integratePositionAndCollisionDetection();
      }
      
      protected function updateFlyWave() : void
      {
         this.fly_sin_counter += 0.5;
         if(this.fly_sin_counter > Math.PI * 2)
         {
            this.fly_sin_counter -= Math.PI * 2;
         }
         this.fly_y_offset = Math.sin(this.fly_sin_counter) * 2;
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
         sprite.y = int(Math.floor(yPos + this.fly_y_offset - camera.yPos));
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
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(level.hero.getAABB().intersects(getAABBSpike()))
         {
            return false;
         }
         return true;
      }
      
      protected function isAttackPathClear() : Boolean
      {
         var i:int = 0;
         var hero_y_t:int = int(level.hero.getMidYPos() / Utils.TILE_HEIGHT);
         var this_x_t:int = int(xPos / Utils.TILE_WIDTH);
         var this_y_t:int = int(yPos / Utils.TILE_HEIGHT);
         if(hero_y_t <= this_y_t + 2)
         {
            return false;
         }
         var diff_y:int = hero_y_t - this_y_t;
         for(i = 0; i < diff_y + 1; i++)
         {
            if(level.levelData.getTileValueAt(this_x_t,this_y_t + i) != 0)
            {
               return false;
            }
         }
         return true;
      }
      
      protected function isHeroAboutToCollide() : Boolean
      {
         var predicted_hero_x_pos:Number = level.hero.getMidXPos() + level.hero.xVel * 14;
         if(Math.abs(predicted_hero_x_pos - xPos) <= Math.abs(level.hero.xVel) * 16 + 4)
         {
            return true;
         }
         return false;
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
         counter1 = counter2 = 0;
         xVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.last_point_x = this.last_point_y = 0;
         counter1 = 0;
         xVel = 0;
      }
      
      public function flyingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function preAttackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.setEmotionParticle(Entity.EMOTION_SHOCKED);
         this.attack_counter = 60;
         counter1 = 0;
      }
      
      public function attackingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.t_start = yPos;
         this.t_diff = level.hero.getMidYPos() - yPos;
         this.t_time = this.t_diff / Utils.TILE_WIDTH * 0.1;
         this.t_tick = 0;
         counter1 = 0;
      }
      
      public function returningUpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.t_start = yPos;
         this.t_diff = originalYPos - yPos;
         this.t_time = Math.abs(this.t_diff / Utils.TILE_WIDTH * 0.2);
         this.t_tick = 0;
         counter1 = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function setEmotionParticle(emotion_id:int) : void
      {
         var pSprite:GameSprite = null;
         var particle:Particle = null;
         if(emotion_id == Entity.EMOTION_SHOCKED)
         {
            pSprite = new GlimpseParticleSprite();
            if(DIRECTION == Entity.LEFT)
            {
               particle = level.particlesManager.pushParticle(pSprite,-8,-4,0,0,1);
            }
            else
            {
               pSprite.scaleX = -1;
               particle = level.particlesManager.pushParticle(pSprite,8,-4,0,0,1);
            }
            particle.setEntity(this);
         }
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
