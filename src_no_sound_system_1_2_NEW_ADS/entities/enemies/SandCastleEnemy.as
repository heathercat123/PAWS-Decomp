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
   import levels.decorations.GenericDecoration;
   import sprites.GameSprite;
   import sprites.bullets.GenericBulletSprite;
   import sprites.decorations.GenericDecorationSprite;
   import sprites.enemies.SandCastleEnemySprite;
   import sprites.particles.SandParticleSprite;
   import sprites.particles.WorriedParticleSprite;
   
   public class SandCastleEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var IS_ON_TOP_WORLD:Boolean;
      
      protected var unhide_distance:Number;
      
      protected var fall_offset:int;
      
      protected var IS_ARMED:Boolean;
      
      protected var parasolSprite:GenericDecorationSprite;
      
      protected var defending_at_y:Number;
      
      public function SandCastleEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int, _param_2:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         ai_index = _ai;
         this.unhide_distance = _param_2;
         this.fall_offset = this.defending_at_y = 0;
         this.parasolSprite = null;
         if(this.unhide_distance <= 0)
         {
            this.unhide_distance = 80;
         }
         this.IS_ARMED = false;
         if(ai_index == 2)
         {
            this.IS_ARMED = true;
         }
         else if(ai_index == 3 || ai_index == 4)
         {
            this.parasolSprite = new GenericDecorationSprite(GenericDecoration.PARASOL);
            Utils.world.addChild(this.parasolSprite);
         }
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.IS_ON_TOP_WORLD = false;
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         sprite = new SandCastleEnemySprite(this.IS_ARMED);
         Utils.world.addChild(sprite);
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         aabbPhysics.x = 1;
         aabbPhysics.y = 0;
         aabbPhysics.width = 14;
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
         stateMachine.setRule("IS_STANDING_STATE","SEES_HERO_ACTION","IS_DEFENDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SEES_HERO_ACTION","IS_DEFENDING_STATE");
         stateMachine.setRule("IS_DEFENDING_STATE","END_ACTION","IS_UNHIDING_STATE");
         stateMachine.setRule("IS_HIDDEN_STATE","END_ACTION","IS_UNHIDING_STATE");
         stateMachine.setRule("IS_UNHIDING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_OUTSIDE_SCREEN_STATE","END_ACTION","IS_ENTERING_SCREEN_STATE");
         stateMachine.setRule("IS_ENTERING_SCREEN_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIDDEN_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_UNHIDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FALLING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_DEFENDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_ENTERING_SCREEN_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         stateMachine.setFunctionToState("IS_UNHIDING_STATE",this.unhidingAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_DEFENDING_STATE",this.defendingAnimation);
         stateMachine.setFunctionToState("IS_OUTSIDE_SCREEN_STATE",this.outsideScreenAnimation);
         stateMachine.setFunctionToState("IS_ENTERING_SCREEN_STATE",this.enteringScreenAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 1)
         {
            stateMachine.setState("IS_HIDDEN_STATE");
         }
         else if(ai_index == 4)
         {
            stateMachine.setState("IS_OUTSIDE_SCREEN_STATE");
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
         energy = 1;
      }
      
      override public function destroy() : void
      {
         if(!this.IS_ON_TOP_WORLD)
         {
            Utils.world.removeChild(sprite);
         }
         else
         {
            Utils.topWorld.removeChild(sprite);
         }
         if(this.parasolSprite != null)
         {
            Utils.world.removeChild(this.parasolSprite);
            this.parasolSprite.destroy();
            this.parasolSprite.dispose();
            this.parasolSprite = null;
         }
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
         if(ai_index == 1)
         {
            stateMachine.setState("IS_HIDDEN_STATE");
         }
         else if(ai_index == 4)
         {
            stateMachine.setState("IS_OUTSIDE_SCREEN_STATE");
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
      }
      
      override public function noGroundCollision() : void
      {
         stateMachine.performAction("NO_GROUND_ACTION");
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
            if(this.walk_counter-- < 0)
            {
               this.walk_counter = int(Math.random() * 2 + 3) * 60;
               stateMachine.performAction("WALK_ACTION");
            }
            if(ai_index == 3 || ai_index == 4)
            {
               if(isOnHeroPlatform())
               {
                  stateMachine.performAction("SEES_HERO_ACTION");
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
            else if(ai_index == 3 || ai_index == 4)
            {
               if(isOnHeroPlatform())
               {
                  stateMachine.performAction("SEES_HERO_ACTION");
               }
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
         }
         else if(stateMachine.currentState == "IS_HIDDEN_STATE")
         {
            if(Math.abs(level.hero.getMidXPos() - getMidXPos()) < this.unhide_distance && level.hero.getMidYPos() > yPos - 48)
            {
               counter3 = 1;
            }
            if(counter3 > 0)
            {
               if(counter1++ > 1)
               {
                  counter1 = 0;
                  if(xPos <= originalXPos)
                  {
                     xPos = originalXPos + 2;
                     SoundSystem.PlaySound("blue_platform");
                  }
                  else
                  {
                     xPos = originalXPos;
                  }
               }
               if(counter2++ > 30)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_DEFENDING_STATE")
         {
            MAX_X_VEL = 4;
            x_friction = 0.89;
            if(getDistanceFromHero() > 112 || Math.abs(getMidYPos() - level.hero.getMidYPos()) > 40)
            {
               if(this.parasolSprite != null)
               {
                  this.parasolSprite.gfxHandleClip().gotoAndPlay(1);
               }
               stateMachine.performAction("END_ACTION");
            }
            if(Math.abs(this.defending_at_y - yPos) >= 32)
            {
               path_start_x = path_end_x = 0;
            }
         }
         else if(stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            this.walk_counter = 20;
         }
         else if(stateMachine.currentState == "IS_OUTSIDE_SCREEN_STATE")
         {
            if(Math.abs(getMidXPos() - level.hero.getMidXPos()) < this.unhide_distance)
            {
               if(level.hero.getMidXPos() > xPos)
               {
                  DIRECTION = Entity.RIGHT;
               }
               else
               {
                  DIRECTION = Entity.LEFT;
               }
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_ENTERING_SCREEN_STATE")
         {
            yVel = 0.4;
            sinCounter1 += 0.05;
            xPos = originalXPos + Math.sin(sinCounter1) * 8;
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            ++counter1;
            if(counter1 >= 5)
            {
               counter1 = 0;
               this.sandParticles();
            }
         }
         if(Utils.SEA_LEVEL > 0)
         {
            if(getMidYPos() >= Utils.SEA_LEVEL)
            {
               stateMachine.performAction("HIT_ACTION");
            }
         }
         aabb.x = 1;
         aabb.width = 14;
         if(stateMachine.currentState == "IS_DEFENDING_STATE")
         {
            if(DIRECTION == Entity.RIGHT)
            {
               aabb.width = 28;
            }
            else
            {
               aabb.x = 1 - 14;
               aabb.width = 14 + 14;
            }
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
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         if(this.parasolSprite != null)
         {
            if(DIRECTION == Entity.LEFT)
            {
               this.parasolSprite.x = sprite.x - 1;
            }
            else
            {
               this.parasolSprite.x = sprite.x + 18;
            }
            this.parasolSprite.y = sprite.y - 5;
            this.parasolSprite.rotation = 0;
            if(sprite.gfxHandle().frame == 3)
            {
               if(sprite.gfxHandle().gfxHandleClip().currentFrame == 1 || sprite.gfxHandle().gfxHandleClip().currentFrame == 3)
               {
                  this.parasolSprite.y = sprite.y - 6;
               }
            }
            if(stateMachine.currentState == "IS_DEFENDING_STATE")
            {
               if(DIRECTION == Entity.RIGHT)
               {
                  this.parasolSprite.rotation = Math.PI * 0.5;
                  this.parasolSprite.x = sprite.x + 20;
                  this.parasolSprite.y = sprite.y + 5;
               }
               else if(DIRECTION == Entity.LEFT)
               {
                  this.parasolSprite.rotation = Math.PI * -0.5;
                  this.parasolSprite.x = sprite.x - 4;
                  this.parasolSprite.y = sprite.y + 4;
               }
            }
         }
         if(sprite.gfxHandle() != null)
         {
            if(DIRECTION == Entity.LEFT)
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
         if(stateMachine.currentState == "IS_FALLING_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE" || stateMachine.currentState == "IS_ENTERING_SCREEN_STATE")
         {
            if(yVel >= 0)
            {
               stateMachine.performAction("GROUND_COLLISION_ACTION");
            }
         }
      }
      
      protected function sandParticles() : void
      {
         var pSprite:SandParticleSprite = null;
         var angle:Number = NaN;
         var i:int = 0;
         var _vel:Number = 1.25;
         if(DIRECTION == RIGHT)
         {
            _vel = -1.25;
         }
         var max:int = 2;
         if(Math.random() * 100 > 80)
         {
            max = 3;
         }
         pSprite = new SandParticleSprite();
         angle = Math.random() * Math.PI * 2;
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         level.particlesManager.pushParticle(pSprite,getMidXPos(),getMidYPos(),_vel * (i + 1 + Math.random() * 1),-(1 + Math.random() * 2),1);
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
         MAX_X_VEL = 0.25;
         speed = 0.8;
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
         Utils.world.removeChild(sprite);
         Utils.topWorld.addChild(sprite);
         this.IS_ON_TOP_WORLD = true;
         counter1 = counter2 = counter3 = 0;
      }
      
      public function defendingAnimation() : void
      {
         SoundSystem.PlaySound("dig");
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.gfxHandle().gfxHandleClip().y = 3;
         if(this.parasolSprite != null)
         {
            this.parasolSprite.gfxHandleClip().pause();
         }
         this.defending_at_y = yPos;
         yVel = -2;
         gravity_friction = 0.5;
      }
      
      public function unhidingAnimation() : void
      {
         SoundSystem.PlaySound("dig");
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.gfxHandle().gfxHandleClip().y = 0;
         Utils.topWorld.removeChild(sprite);
         Utils.world.addChild(sprite);
         this.IS_ON_TOP_WORLD = false;
         this.dirtParticles();
         counter1 = counter2 = 0;
         yVel = -1.5;
         gravity_friction = 0.4;
      }
      
      protected function outsideScreenAnimation() : void
      {
         gravity_friction = 0;
         sprite.visible = false;
         this.parasolSprite.visible = false;
      }
      
      protected function enteringScreenAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         yPos = level.camera.yPos - HEIGHT;
         sinCounter1 = Math.random() * Math.PI * 2;
         sprite.visible = true;
         this.parasolSprite.visible = true;
         gravity_friction = 0.2;
      }
      
      public function hitAnimation() : void
      {
         var __x_vel:Number = NaN;
         var genericBulletSprite:GenericBulletSprite = null;
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(this.parasolSprite != null)
         {
            this.parasolSprite.visible = false;
            __x_vel = -2;
            genericBulletSprite = new GenericBulletSprite(GenericBulletSprite.PARASOL);
            if(level.hero.getMidXPos() < getMidXPos())
            {
               __x_vel = 2;
            }
            else
            {
               genericBulletSprite.scaleX = -1;
            }
            if(DIRECTION == Entity.RIGHT)
            {
               level.bulletsManager.pushBullet(genericBulletSprite,getMidXPos() + 8,getMidYPos() - 8,__x_vel,-(2 + Math.random() * 2),0.98);
            }
            else
            {
               level.bulletsManager.pushBullet(genericBulletSprite,getMidXPos() - 8,getMidYPos() - 8,__x_vel,-(2 + Math.random() * 2),0.98);
            }
         }
         setHitVariables();
         if(KILLED_BY_CAT)
         {
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_SAND_CASTLE_DEFEATED_BY_ANY_CAT);
         }
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
      
      protected function dirtParticles() : void
      {
         var pSprite:SandParticleSprite = null;
         pSprite = new SandParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         level.particlesManager.pushParticle(pSprite,xPos + WIDTH * 0.25,yPos + HEIGHT,-(Math.random() * 1),-(Math.random() * 1 + 2),1);
         pSprite = new SandParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         level.particlesManager.pushParticle(pSprite,xPos + WIDTH * 0.75,yPos + HEIGHT,Math.random() * 1,-(Math.random() * 1 + 2),1);
      }
      
      override protected function allowEnemyDefend() : Boolean
      {
         if(stateMachine.currentState == "IS_DEFENDING_STATE")
         {
            if(level.hero.getMidXPos() < getMidXPos())
            {
               if(DIRECTION == Entity.LEFT)
               {
                  return true;
               }
            }
            else if(DIRECTION == Entity.RIGHT)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function allowCatAttack() : Boolean
      {
         if(!this.IS_ARMED)
         {
            return true;
         }
         if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            return true;
         }
         if(level.hero.getMidXPos() < getMidXPos())
         {
            if(DIRECTION == Entity.LEFT)
            {
               return false;
            }
         }
         else if(DIRECTION == Entity.RIGHT)
         {
            return false;
         }
         return true;
      }
      
      override public function defend(_source_x:Number = 0, _source_y:Number = 0, _isCatAttacking:Boolean = false) : *
      {
         if(_source_x > getMidXPos())
         {
            xVel = -4;
         }
         else
         {
            xVel = 4;
         }
         yVel = -2;
      }
   }
}
