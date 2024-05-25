package entities.enemies
{
   import entities.Entity;
   import entities.Hero;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.FireFloatingBulletSprite;
   import sprites.enemies.GhostEnemySprite;
   import sprites.particles.GenericParticleSprite;
   
   public class WarlockEnemy extends Enemy
   {
       
      
      protected var portalSprite:GenericParticleSprite;
      
      protected var redOrbSprite:GenericParticleSprite;
      
      protected var SUB_STATE:int;
      
      protected var portal_counter_1:int;
      
      protected var portal_counter_2:int;
      
      protected var IS_PORTAL_DISAPPEARING:Boolean;
      
      protected var IS_TIME_TO_ATTACK:Boolean;
      
      protected var GO_UP:Boolean;
      
      protected var SPAWN_DISTANCE:Number;
      
      protected var wait_time:int;
      
      protected var visible_counter_1:int;
      
      protected var alpha_counter_1:Number;
      
      protected var last_time_invisible_counter:int;
      
      protected var sin_wave:Number;
      
      protected var offset_y:int;
      
      public function WarlockEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _spawnDistance:Number = 96)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         this.SPAWN_DISTANCE = _spawnDistance;
         if(this.SPAWN_DISTANCE <= 1)
         {
            this.SPAWN_DISTANCE = 96;
         }
         speed = 0.8;
         ai_index = 0;
         this.visible_counter_1 = 0;
         this.alpha_counter_1 = 1;
         this.last_time_invisible_counter = 60;
         this.sin_wave = Math.random() * Math.PI * 2;
         this.offset_y = 0;
         this.portal_counter_1 = this.portal_counter_2 = 0;
         this.GO_UP = false;
         this.IS_PORTAL_DISAPPEARING = false;
         this.SUB_STATE = 0;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         AVOID_COLLISION_DETECTION = true;
         this.IS_TIME_TO_ATTACK = true;
         this.wait_time = int(Math.random() * 5);
         this.portalSprite = new GenericParticleSprite(GenericParticleSprite.DARK_PORTAL_APPEAR);
         Utils.world.addChild(this.portalSprite);
         this.portalSprite.visible = false;
         sprite = new GhostEnemySprite(1);
         Utils.world.addChild(sprite);
         this.redOrbSprite = new GenericParticleSprite(GenericParticleSprite.RED_ORB);
         Utils.world.addChild(this.redOrbSprite);
         this.redOrbSprite.visible = false;
         aabb.x = -6;
         aabb.y = -6;
         aabb.width = 12;
         aabb.height = 12;
         aabbPhysics.x = aabbPhysics.y = aabbPhysics.width = aabbPhysics.height = 0;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_AWAY_STATE","END_ACTION","IS_APPEARING_STATE");
         stateMachine.setRule("IS_MOVING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_MOVING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_APPEARING_STATE","END_ACTION","IS_MOVING_STATE");
         stateMachine.setRule("IS_MOVING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","MOVE_ACTION","IS_MOVING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","ATTACK_ACTION","IS_ATTACKING_STATE");
         stateMachine.setRule("IS_ATTACKING_STATE","END_ACTION","IS_MOVING_STATE");
         stateMachine.setRule("IS_MOVING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ATTACKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_AWAY_STATE",this.awayAnimation);
         stateMachine.setFunctionToState("IS_APPEARING_STATE",this.appearingAnimation);
         stateMachine.setFunctionToState("IS_MOVING_STATE",this.movingAnimation);
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_AWAY_STATE");
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         Utils.world.removeChild(this.portalSprite);
         Utils.world.removeChild(this.redOrbSprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         this.redOrbSprite.destroy();
         this.redOrbSprite.dispose();
         this.redOrbSprite = null;
         this.portalSprite.destroy();
         this.portalSprite.dispose();
         this.portalSprite = null;
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
         stateMachine.setState("IS_AWAY_STATE");
      }
      
      override public function update() : void
      {
         var vector:Point = null;
         super.update();
         if(stateMachine.currentState != "IS_AWAY_STATE")
         {
            if(stateMachine.currentState == "IS_APPEARING_STATE")
            {
               if(this.SUB_STATE == 0)
               {
                  if(this.portalSprite.gfxHandleClip().isComplete)
                  {
                     sprite.visible = true;
                     sprite.gfxHandle().gotoAndStop(5);
                     sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
                     this.SUB_STATE = 1;
                  }
               }
               else if(this.SUB_STATE == 1)
               {
                  if(sprite.gfxHandle().gfxHandleClip().isComplete)
                  {
                     this.IS_PORTAL_DISAPPEARING = true;
                     this.portal_counter_1 = this.portal_counter_2 = 0;
                     this.SUB_STATE = 2;
                  }
               }
               else if(this.SUB_STATE == 2)
               {
                  if(counter1++ > 20)
                  {
                     if(level.hero.getMidXPos() > xPos)
                     {
                        DIRECTION = Entity.RIGHT;
                     }
                     else
                     {
                        DIRECTION = Entity.LEFT;
                     }
                     if(level.hero.getMidYPos() < yPos)
                     {
                        this.GO_UP = true;
                     }
                     else
                     {
                        this.GO_UP = false;
                     }
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_MOVING_STATE")
            {
               ++counter1;
               if(counter1 >= 30)
               {
                  stateMachine.performAction("STOP_ACTION");
               }
               else if(DIRECTION == Entity.LEFT && xVel > 0)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
               else if(DIRECTION == Entity.RIGHT && xVel < 0)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
               if(path_start_y > 0)
               {
                  if(yPos < path_start_y)
                  {
                     yPos = path_start_y;
                  }
                  else if(yPos > path_end_y)
                  {
                     yPos = path_end_y;
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
            else if(stateMachine.currentState == "IS_STANDING_STATE")
            {
               ++counter1;
               if(counter1 >= 60)
               {
                  if(DIRECTION == Entity.LEFT && level.hero.xPos > xPos + 8)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
                  else if(DIRECTION == Entity.RIGHT && level.hero.xPos < xPos - 8)
                  {
                     stateMachine.performAction("TURN_ACTION");
                  }
                  else if(this.IS_TIME_TO_ATTACK)
                  {
                     stateMachine.performAction("ATTACK_ACTION");
                  }
                  else
                  {
                     stateMachine.performAction("MOVE_ACTION");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_ATTACKING_STATE")
            {
               if(counter2++ > 1)
               {
                  counter2 = 0;
                  if(sprite.gfxHandle().gfxHandleClip().frame == 1)
                  {
                     sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
                  }
                  else
                  {
                     sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
                  }
               }
               if(counter3++ > 0)
               {
                  counter3 = 0;
                  this.redOrbSprite.visible = !this.redOrbSprite.visible;
               }
               ++counter1;
               if(counter1 >= 60)
               {
                  this.redOrbSprite.visible = false;
                  vector = this.getNormalizedDistanceToHero();
                  SoundSystem.PlaySound("fire_ball");
                  level.bulletsManager.pushBullet(new FireFloatingBulletSprite(),xPos + vector.x * 8,yPos + vector.y * 8,vector.x * 0.8,vector.y * 0.8,1);
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         if(this.IS_PORTAL_DISAPPEARING)
         {
            if(this.portal_counter_2++ > 15)
            {
               this.portalSprite.visible = !this.portalSprite.visible;
               if(this.portal_counter_1++ > 3)
               {
                  this.portal_counter_1 = 0;
                  this.portalSprite.alpha -= 0.2;
                  if(this.portalSprite.alpha <= 0)
                  {
                     this.IS_PORTAL_DISAPPEARING = false;
                     this.portalSprite.visible = false;
                  }
               }
            }
         }
         gravity_friction = 0;
         integratePositionAndCollisionDetection();
      }
      
      protected function getNormalizedDistanceToHero() : Point
      {
         var x_diff:Number = level.hero.getMidXPos() - xPos;
         var y_diff:Number = level.hero.getMidYPos() - yPos;
         var dist:Number = Math.sqrt(x_diff * x_diff + y_diff * y_diff);
         if(Math.abs(dist) < 0.1)
         {
            dist = 0.1;
         }
         return new Point(x_diff / dist,y_diff / dist);
      }
      
      protected function updateSinWave() : void
      {
         this.sin_wave += 0.1;
         if(this.sin_wave >= Math.PI * 2)
         {
            this.sin_wave -= Math.PI * 2;
         }
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         if(stateMachine.currentState == "IS_AWAY_STATE")
         {
            diff_x = hero.getMidXPos() - originalXPos;
            diff_y = hero.getMidYPos() - originalYPos;
            if(Math.sqrt(diff_x * diff_x + diff_y * diff_y) <= this.SPAWN_DISTANCE)
            {
               stateMachine.performAction("END_ACTION");
            }
            return;
         }
         if(stateMachine.currentState == "IS_APPEARING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos + Math.sin(this.sin_wave) * 2 + this.offset_y - camera.yPos));
         this.portalSprite.x = sprite.x;
         this.portalSprite.y = sprite.y;
         if(DIRECTION == Entity.LEFT)
         {
            this.redOrbSprite.x = sprite.x - 5;
            this.redOrbSprite.y = sprite.y + 3;
         }
         else
         {
            this.redOrbSprite.x = sprite.x + 5;
            this.redOrbSprite.y = sprite.y + 3;
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
      
      override public function groundCollision() : void
      {
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
      }
      
      public function awayAnimation() : void
      {
         sprite.visible = false;
         this.redOrbSprite.visible = false;
         this.portalSprite.visible = false;
         xPos = yPos = -100;
      }
      
      public function appearingAnimation() : void
      {
         SoundSystem.PlaySound("warlock_appear");
         this.portalSprite.visible = true;
         this.portalSprite.gfxHandleClip().gotoAndPlay(1);
         this.SUB_STATE = 0;
         counter1 = counter2 = 0;
         xPos = originalXPos;
         yPos = originalYPos;
         xVel = yVel = 0;
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function movingAnimation() : void
      {
         var distance:Point = null;
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.alpha = 1;
         counter1 = counter2 = 0;
         frame_speed = 0.2;
         distance = this.getNormalizedDistanceToHero();
         var hero_diff_y:Number = level.hero.getMidYPos() - getMidYPos();
         if(Math.abs(hero_diff_y) >= 64)
         {
            if(hero_diff_y > 0)
            {
               this.GO_UP = false;
            }
            else
            {
               this.GO_UP = true;
            }
         }
         if(path_start_y != 0)
         {
            if(getMidYPos() <= path_start_y)
            {
               this.GO_UP = false;
            }
            else if(getMidYPos() >= path_end_y)
            {
               this.GO_UP = true;
            }
         }
         if(this.GO_UP)
         {
            distance.y = Math.abs(distance.y) * -1;
         }
         else
         {
            distance.y = Math.abs(distance.y);
         }
         this.GO_UP = !this.GO_UP;
         xVel = distance.x * 0.5;
         yVel = distance.y * 0.5;
         speed = 0.5;
         MAX_X_VEL = 2;
         x_friction = y_friction = 1;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function attackAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.redOrbSprite.visible = true;
         this.redOrbSprite.gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         xVel = yVel = 0;
      }
      
      public function scaredAnimation() : void
      {
         SoundSystem.PlaySound("ghost_scared");
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setEmotionParticle(Entity.EMOTION_SHOCKED);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function hiddenAnimation() : void
      {
         sprite.visible = false;
         sprite.alpha = 0;
         this.last_time_invisible_counter = 0;
         counter1 = 0;
      }
      
      override public function onTop() : void
      {
         Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
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
