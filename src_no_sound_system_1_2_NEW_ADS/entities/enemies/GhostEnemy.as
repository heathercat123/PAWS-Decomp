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
   import sprites.bullets.VaseBulletSprite;
   import sprites.enemies.GhostEnemySprite;
   import sprites.particles.WorriedParticleSprite;
   
   public class GhostEnemy extends Enemy
   {
       
      
      protected var wait_time:int;
      
      protected var visible_counter_1:int;
      
      protected var alpha_counter_1:Number;
      
      protected var last_time_invisible_counter:int;
      
      protected var sin_wave:Number;
      
      protected var IS_SPRITE_BACK:Boolean;
      
      protected var offset_y:int;
      
      protected var HAS_VASE_ORIGINAL:Boolean;
      
      protected var HAS_VASE:Boolean;
      
      public function GhostEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 16;
         this.HAS_VASE_ORIGINAL = this.HAS_VASE = false;
         speed = 0.8;
         ai_index = _ai;
         this.visible_counter_1 = 0;
         this.alpha_counter_1 = 1;
         this.last_time_invisible_counter = 60;
         this.sin_wave = Math.random() * Math.PI * 2;
         this.offset_y = 0;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.IS_SPRITE_BACK = false;
         this.wait_time = int(Math.random() * 5);
         sprite = new GhostEnemySprite();
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
         if(ai_index == 3)
         {
            this.HAS_VASE = this.HAS_VASE_ORIGINAL = true;
         }
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","SEES_HERO_ACTION","IS_SCARED_STATE");
         stateMachine.setRule("IS_SCARED_STATE","END_ACTION","IS_DISAPPEARING_STATE");
         stateMachine.setRule("IS_DISAPPEARING_STATE","END_ACTION","IS_HIDDEN_STATE");
         stateMachine.setRule("IS_HIDDEN_STATE","END_ACTION","IS_APPEARING_STATE");
         stateMachine.setRule("IS_APPEARING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_BEHIND_GRAVE_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_BEHIND_GRAVE_SPECIAL_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_DISAPPEARING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_BEHIND_GRAVE_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SCARED_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_SCARED_STATE",this.scaredAnimation);
         stateMachine.setFunctionToState("IS_DISAPPEARING_STATE",this.disappearingAnimation);
         stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         stateMachine.setFunctionToState("IS_APPEARING_STATE",this.appearingAnimation);
         stateMachine.setFunctionToState("IS_BEHIND_GRAVE_STATE",this.behindGraveAnimation);
         stateMachine.setFunctionToState("IS_BEHIND_GRAVE_SPECIAL_STATE",this.behindGraveAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         if(ai_index == 1 || ai_index == 2)
         {
            if(ai_index == 1)
            {
               stateMachine.setState("IS_BEHIND_GRAVE_STATE");
            }
            else if(ai_index == 2)
            {
               stateMachine.setState("IS_BEHIND_GRAVE_SPECIAL_STATE");
            }
            originalXPos -= 4;
            xPos = originalXPos;
         }
         else
         {
            stateMachine.setState("IS_WALKING_STATE");
         }
      }
      
      override public function destroy() : void
      {
         if(this.IS_SPRITE_BACK)
         {
            Utils.backWorld.removeChild(sprite);
         }
         else
         {
            Utils.world.removeChild(sprite);
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
         this.HAS_VASE = this.HAS_VASE_ORIGINAL;
         stateMachine.setState("IS_WALKING_STATE");
      }
      
      override public function update() : void
      {
         var mid_x:Number = NaN;
         var hero_mid_x_vel:Number = NaN;
         var hero_mid_x:Number = NaN;
         super.update();
         if(stateMachine.currentState != "IS_STANDING_STATE")
         {
            if(stateMachine.currentState == "IS_TURNING_STATE")
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
               this.updateSinWave();
               this.boundariesCheck();
               mid_x = getMidXPos();
               hero_mid_x_vel = level.hero.getMidXPos() + level.hero.xVel * 24;
               hero_mid_x = level.hero.getMidXPos();
               if(this.HAS_VASE)
               {
                  if(Math.abs(mid_x - hero_mid_x_vel) < 8 && level.hero.yPos >= yPos + 16)
                  {
                     this.dropVase();
                  }
               }
               else if(this.last_time_invisible_counter++ > 60)
               {
                  if(this.HAS_VASE_ORIGINAL == false)
                  {
                     if(DIRECTION == Entity.LEFT && hero_mid_x < mid_x && level.hero.DIRECTION == Entity.RIGHT || DIRECTION == Entity.RIGHT && hero_mid_x > mid_x && level.hero.DIRECTION == Entity.LEFT)
                     {
                        if(Math.abs(mid_x - hero_mid_x) <= 80)
                        {
                           if(Math.abs(yPos - level.hero.yPos) < 32)
                           {
                              stateMachine.performAction("SEES_HERO_ACTION");
                           }
                        }
                     }
                  }
               }
            }
            else if(stateMachine.currentState == "IS_SCARED_STATE")
            {
               if(counter1++ > 15)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_DISAPPEARING_STATE")
            {
               if(this.visible_counter_1 >= 0)
               {
                  if(this.visible_counter_1++ > 0)
                  {
                     this.visible_counter_1 = 0;
                     sprite.visible = !sprite.visible;
                  }
                  this.alpha_counter_1 -= 0.02;
                  sprite.alpha = this.alpha_counter_1;
                  if(this.alpha_counter_1 <= 0)
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_HIDDEN_STATE")
            {
               ++counter1;
               if(Math.abs(level.hero.getMidXPos() - getMidXPos()) >= 32)
               {
                  if(counter1 >= 240)
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_BEHIND_GRAVE_SPECIAL_STATE")
            {
               if(counter1 == 0)
               {
                  this.sin_wave = Math.PI * 0.5;
                  ++counter2;
                  if(counter2 >= 120)
                  {
                     counter2 = 0;
                     counter1 = 1;
                  }
               }
               else if(counter1 == 1)
               {
                  this.sin_wave = Math.PI * 0.5;
                  yPos -= 0.5;
                  if(yPos <= originalYPos - 8)
                  {
                     yPos = originalYPos - 8;
                     counter1 = 2;
                     counter3 = int(Math.random() * 15 + 15);
                     sprite.gfxHandle().gotoAndStop(5);
                     sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
                     this.setEmotionParticle(Entity.EMOTION_SHOCKED);
                  }
               }
               else if(counter1 == 2)
               {
                  ++counter2;
                  if(counter2 >= 30)
                  {
                     SoundSystem.PlaySound("ghost_scared");
                     DIRECTION = Entity.RIGHT;
                     sprite.gfxHandle().gotoAndStop(3);
                     sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
                     counter1 = 3;
                     counter2 = 0;
                  }
               }
               else if(counter1 == 3)
               {
                  this.updateSinWave();
                  xPos += 2;
                  if(counter2++ > 15)
                  {
                     if(this.visible_counter_1 >= 0)
                     {
                        if(this.visible_counter_1++ > 0)
                        {
                           this.visible_counter_1 = 0;
                           sprite.visible = !sprite.visible;
                        }
                        this.alpha_counter_1 -= 0.02;
                        sprite.alpha = this.alpha_counter_1;
                        if(this.alpha_counter_1 <= 0)
                        {
                           dead = true;
                        }
                     }
                  }
               }
            }
            else if(stateMachine.currentState == "IS_BEHIND_GRAVE_STATE")
            {
               this.sin_wave = Math.PI * 0.5;
               if(counter1 == 0)
               {
                  ++counter2;
                  if(counter2 >= 60)
                  {
                     counter2 = 0;
                     counter1 = 1;
                  }
               }
               else if(counter1 == 1)
               {
                  yPos -= 0.5;
                  if(yPos <= originalYPos - 8)
                  {
                     yPos = originalYPos - 8;
                     counter1 = 2;
                     counter3 = int(Math.random() * 15 + 15);
                  }
               }
               else if(counter1 == 2)
               {
                  ++counter2;
                  if(counter2 >= counter3)
                  {
                     counter2 = 0;
                     counter1 = 3;
                  }
               }
               else if(counter1 == 3)
               {
                  yPos += 2;
                  if(yPos >= originalYPos)
                  {
                     yPos = originalYPos;
                     counter2 = -(60 + Math.random() * 60);
                     counter1 = 0;
                  }
               }
               if(level.hero.xPos > xPos + 32)
               {
                  DIRECTION = RIGHT;
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_APPEARING_STATE")
            {
               if(this.visible_counter_1 >= 0)
               {
                  if(this.visible_counter_1++ > 0)
                  {
                     this.visible_counter_1 = 0;
                     sprite.visible = !sprite.visible;
                  }
                  this.alpha_counter_1 += 0.04;
                  sprite.alpha = this.alpha_counter_1;
                  if(this.alpha_counter_1 >= 1)
                  {
                     sprite.alpha = 1;
                     sprite.visible = true;
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
         }
         gravity_friction = 0;
         integratePositionAndCollisionDetection();
      }
      
      protected function dropVase() : void
      {
         this.HAS_VASE = false;
         sprite.gfxHandle().gotoAndStop(3);
         if(DIRECTION == LEFT)
         {
            level.bulletsManager.pushBullet(new VaseBulletSprite(),xPos - 0,yPos + 10,0,0,1);
         }
         else
         {
            level.bulletsManager.pushBullet(new VaseBulletSprite(),xPos + 16 - 5,yPos + 10,0,0,1);
         }
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
         if(stateMachine.currentState == "IS_DISAPPEARING_STATE" || stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_APPEARING_STATE" || stateMachine.currentState == "IS_BEHIND_GRAVE_STATE" || stateMachine.currentState == "IS_BEHIND_GRAVE_SPECIAL_STATE")
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
         sprite.y = int(Math.floor(yPos + Math.sin(this.sin_wave) * 2 + this.offset_y - camera.yPos));
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
         if(this.HAS_VASE)
         {
            sprite.gfxHandle().gotoAndStop(6);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(2);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         if(this.HAS_VASE)
         {
            sprite.gfxHandle().gotoAndStop(7);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(3);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.alpha = 1;
         counter1 = 0;
         frame_speed = 0.2;
         speed = 0.5;
         MAX_X_VEL = 2;
         x_friction = 0.8;
         xVel = 0;
         if(this.IS_SPRITE_BACK)
         {
            this.IS_SPRITE_BACK = false;
            Utils.backWorld.removeChild(sprite);
            Utils.world.addChild(sprite);
            speed = 3.5;
            MAX_X_VEL = 2;
         }
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function scaredAnimation() : void
      {
         SoundSystem.PlaySound("ghost_scared");
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.setEmotionParticle(Entity.EMOTION_SHOCKED);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function disappearingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.alpha = 1;
         this.visible_counter_1 = 0;
         this.alpha_counter_1 = 1;
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      protected function behindGraveAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.IS_SPRITE_BACK = true;
         Utils.world.removeChild(sprite);
         Utils.backWorld.addChild(sprite);
         Utils.backWorld.setChildIndex(sprite,0);
         xVel = yVel = 0;
         counter1 = counter2 = counter3 = 0;
         this.offset_y = 1;
      }
      
      public function hiddenAnimation() : void
      {
         sprite.visible = false;
         sprite.alpha = 0;
         this.last_time_invisible_counter = 0;
         counter1 = 0;
      }
      
      public function appearingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         sprite.alpha = 0;
         sprite.visible = true;
         counter1 = counter2 = 0;
      }
      
      override public function onTop() : void
      {
         if(this.IS_SPRITE_BACK)
         {
            Utils.backWorld.setChildIndex(sprite,Utils.backWorld.numChildren - 1);
         }
         else
         {
            Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
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
