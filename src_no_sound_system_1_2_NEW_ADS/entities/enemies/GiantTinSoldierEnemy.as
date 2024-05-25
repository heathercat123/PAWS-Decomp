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
   import sprites.enemies.GiantEnemyGearSprite;
   import sprites.enemies.GiantTinSoldierEnemySprite;
   import sprites.particles.MetalBigNutParticleSprite;
   import sprites.particles.MetalBoltParticleSprite;
   import sprites.particles.WorriedParticleSprite;
   
   public class GiantTinSoldierEnemy extends GiantEnemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var giantEnemyGearSprite:GiantEnemyGearSprite;
      
      public function GiantTinSoldierEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         ai_index = _ai;
         stunHandler.stun_y_offset = 0;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         this.giantEnemyGearSprite = new GiantEnemyGearSprite();
         Utils.world.addChild(this.giantEnemyGearSprite);
         sprite = new GiantTinSoldierEnemySprite();
         Utils.world.addChild(sprite);
         aabb.x = 3;
         aabb.y = 4;
         aabb.width = 26;
         aabb.height = 28;
         aabbPhysics.x = 3;
         aabbPhysics.y = 4;
         aabbPhysics.width = 26;
         aabbPhysics.height = 28;
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
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 0)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else if(ai_index == 1)
         {
            stateMachine.setState("IS_HIDDEN_STATE");
         }
         energy = 1;
      }
      
      override public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "hurt")
         {
            if(stunHandler.IS_STUNNED)
            {
               SoundSystem.PlaySound("enemy_big_metal_hurt");
            }
            else
            {
               SoundSystem.PlaySound("big_enemy_hit");
            }
         }
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(this.giantEnemyGearSprite);
         this.giantEnemyGearSprite.destroy();
         this.giantEnemyGearSprite.dispose();
         this.giantEnemyGearSprite = null;
         super.destroy();
      }
      
      override public function reset() : void
      {
         super.reset();
         if(ai_index == 0)
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         else
         {
            stateMachine.setState("IS_STANDING_STATE");
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
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
            if(this.walk_counter-- < 0)
            {
               this.walk_counter = int(Math.random() * 3 + 1) * 30;
               stateMachine.performAction("STOP_ACTION");
            }
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
      
      override public function hit(_source_x:Number = 0, _source_y:Number = 0, _isCatAttacking:Boolean = false) : void
      {
         var i:int = 0;
         var amount:int = 0;
         var pSprite:GameSprite = null;
         var vel_x:Number = NaN;
         var vel_mult:Number = NaN;
         super.hit(_source_x,_source_y);
         vel_mult = 1;
         if(Math.random() * 100 > 50)
         {
            amount = 2;
         }
         else if(Math.random() * 100 > 50)
         {
            amount = 3;
         }
         else
         {
            amount = 1;
         }
         if(_source_x > getMidXPos())
         {
            vel_mult = -1;
         }
         for(i = 0; i < amount; i++)
         {
            if(i % 2 == 0)
            {
               pSprite = new MetalBigNutParticleSprite();
            }
            else
            {
               pSprite = new MetalBoltParticleSprite();
            }
            pSprite.gfxHandleClip().gotoAndPlay(int(Math.random() * pSprite.gfxHandleClip().numFrames));
            vel_x = (Math.random() * 2 + 1) * vel_mult;
            if(vel_x < 0)
            {
               pSprite.scaleX = -1;
            }
            level.particlesManager.pushParticle(pSprite,getMidXPos(),getMidYPos(),vel_x,-(Math.random() * 2 + 1),0.98,int(5 + Math.random() * 15));
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
            super.setEmotionParticle(emotion_id);
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var gear_offset_y:int = 0;
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_HIT_STATE")
         {
            this.giantEnemyGearSprite.visible = false;
         }
         else
         {
            this.giantEnemyGearSprite.visible = true;
            this.giantEnemyGearSprite.scaleX = sprite.gfxHandle().scaleX;
            gear_offset_y = 0;
            if(stateMachine.currentState == "IS_WALKING_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().frame % 2 != 0)
               {
                  gear_offset_y = -1;
               }
            }
            if(DIRECTION == Entity.LEFT)
            {
               this.giantEnemyGearSprite.x = sprite.x + 25;
               this.giantEnemyGearSprite.y = sprite.y + 8 + gear_offset_y;
            }
            else
            {
               this.giantEnemyGearSprite.x = sprite.x + 5;
               this.giantEnemyGearSprite.y = sprite.y + 8 + gear_offset_y;
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
            this.onTop();
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
      }
      
      override public function onTop() : void
      {
         Utils.world.setChildIndex(this.giantEnemyGearSprite,Utils.world.numChildren - 1);
         Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
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
         this.giantEnemyGearSprite.gfxHandleClip().stop();
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
         this.giantEnemyGearSprite.gfxHandleClip().play();
         counter1 = 0;
         speed = 0.8;
         x_friction = 0.8;
         xVel = 0;
      }
      
      override public function hurtAnimation() : void
      {
         super.hurtAnimation();
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.giantEnemyGearSprite.gfxHandleClip().stop();
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
         SoundSystem.PlaySound("explosion");
         sprite.gfxHandle().gotoAndStop(5);
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
   }
}
