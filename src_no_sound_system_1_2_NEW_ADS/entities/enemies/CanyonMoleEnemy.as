package entities.enemies
{
   import entities.Hero;
   import entities.bullets.Bullet;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.CanyonMoleSprite;
   import sprites.particles.GlimpseParticleSprite;
   
   public class CanyonMoleEnemy extends Enemy
   {
       
      
      protected var start_y:Number;
      
      protected var diff_y:Number;
      
      protected var tick:Number;
      
      protected var time:Number;
      
      protected var fell_at_x:Number;
      
      protected var SIDE:int;
      
      protected var x_offset:int;
      
      protected var y_offset:int;
      
      public function CanyonMoleEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _side:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         this.SIDE = _side;
         WIDTH = 16;
         HEIGHT = 16;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         oldXPos = 0;
         oldYPos = 0;
         this.fell_at_x = 0;
         this.x_offset = 0;
         this.y_offset = 0;
         sprite = new CanyonMoleSprite();
         Utils.topWorld.addChild(sprite);
         aabb.x = 1;
         aabb.y = -1;
         aabb.width = 14;
         aabb.height = 13;
         if(this.SIDE == 1)
         {
            sprite.scaleY = -1;
            this.y_offset = 10;
         }
         else if(this.SIDE == 2)
         {
            sprite.rotation = -Math.PI * 0.5;
            this.x_offset = -5;
            this.y_offset = 8;
            aabb.x = 1 + -7;
            aabb.y = -1 + -9 + 3;
            aabb.width = 14;
            aabb.height = 14;
         }
         else if(this.SIDE == 3)
         {
            sprite.rotation = Math.PI * 0.5;
            this.x_offset = 5;
            this.y_offset = -8;
            aabb.x = 1 + 7 - 16;
            aabb.y = -1 + -9 + 3;
            aabb.width = 14;
            aabb.height = 14;
         }
         aabbPhysics.y = 3;
         aabbPhysics.height = 0;
         aabbPhysics.width = 0;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","SEES_HERO_ACTION","IS_SCARED_STATE");
         stateMachine.setRule("IS_SCARED_STATE","END_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_HIDING_STATE","END_ACTION","IS_HIDDEN_STATE");
         stateMachine.setRule("IS_HIDDEN_STATE","END_ACTION","IS_UNHIDING_STATE");
         stateMachine.setRule("IS_UNHIDING_STATE","END_ACTION","IS_PEEKING_STATE");
         stateMachine.setRule("IS_PEEKING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_PEEKING_STATE","SEES_HERO_ACTION","IS_SCARED_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SCARED_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_PEEKING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_SCARED_STATE",this.scaredAnimation);
         stateMachine.setFunctionToState("IS_HIDING_STATE",this.hidingAnimation);
         stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         stateMachine.setFunctionToState("IS_UNHIDING_STATE",this.unhidingAnimation);
         stateMachine.setFunctionToState("IS_PEEKING_STATE",this.peekingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 1;
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState == "IS_MISSING_STATE" || stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_HIDING_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override public function bulletImpact(bullet:Bullet) : void
      {
         if(stateMachine.currentState == "IS_MISSING_STATE" || stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_HIDING_STATE")
         {
            return;
         }
         super.bulletImpact(bullet);
         stateMachine.performAction("SEES_HERO_ACTION");
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
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
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_MISSING_STATE" || stateMachine.currentState == "IS_HIDDEN_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            ++counter1;
            if(counter1 >= 120)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            else if(!Utils.IS_DARK)
            {
               if(this.isOnHeroPlatform())
               {
                  stateMachine.performAction("SEES_HERO_ACTION");
               }
            }
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(Math.random() * 3 + 1));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
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
         else if(stateMachine.currentState == "IS_SCARED_STATE" || stateMachine.currentState == "IS_HIDING_STATE" || stateMachine.currentState == "IS_UNHIDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_HIDDEN_STATE")
         {
            ++counter1;
            if(counter1 >= 300)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_PEEKING_STATE")
         {
            ++counter1;
            if(this.isOnHeroPlatform())
            {
               stateMachine.performAction("SEES_HERO_ACTION");
            }
            else if(counter1 >= 30)
            {
               counter1 = 0;
               ++counter2;
               if(counter2 >= 5)
               {
                  stateMachine.performAction("END_ACTION");
               }
               else
               {
                  changeDirection();
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos + this.x_offset));
         sprite.y = int(Math.floor(yPos - camera.yPos + this.y_offset));
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
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
      }
      
      override protected function isOnHeroPlatform() : Boolean
      {
         var i:int = 0;
         var mid_x:Number = NaN;
         var mid_y:Number = NaN;
         var diff_t:int = 0;
         if(this.SIDE == 0 || this.SIDE == 1)
         {
            mid_x = xPos + WIDTH * 0.5;
            mid_y = yPos + HEIGHT * 0.5;
         }
         else
         {
            mid_x = xPos;
            mid_y = yPos;
         }
         var hero_mid_x:Number = level.hero.xPos + level.hero.WIDTH * 0.5;
         var hero_mid_y:Number = level.hero.yPos + level.hero.HEIGHT * 0.5;
         var hero_x_t:int = int(hero_mid_x / Utils.TILE_WIDTH);
         var hero_y_t:int = int(hero_mid_y / Utils.TILE_HEIGHT);
         var x_t:int = int((xPos + 4) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + 4) / Utils.TILE_HEIGHT);
         if(this.SIDE == 0 || this.SIDE == 1)
         {
            if(Math.abs(mid_y - hero_mid_y) < Utils.TILE_HEIGHT * 2)
            {
               if(DIRECTION == RIGHT)
               {
                  if(hero_mid_x > mid_x)
                  {
                     if(Math.abs(hero_mid_x - mid_x) < Utils.TILE_WIDTH * 5)
                     {
                        if(this.SIDE == 0)
                        {
                           diff_t = hero_x_t - x_t;
                           for(i = 0; i < diff_t; i++)
                           {
                              if(level.levelData.getTileValueAt(x_t + i,y_t) != 0)
                              {
                                 return false;
                              }
                           }
                           return true;
                        }
                        return true;
                     }
                  }
               }
               else if(hero_mid_x < mid_x)
               {
                  if(Math.abs(hero_mid_x - mid_x) < Utils.TILE_WIDTH * 5)
                  {
                     if(this.SIDE == 0)
                     {
                        diff_t = x_t - hero_mid_x;
                        for(i = 0; i < diff_t; i++)
                        {
                           if(level.levelData.getTileValueAt(x_t - i,y_t) != 0)
                           {
                              return false;
                           }
                        }
                        return true;
                     }
                     return true;
                  }
               }
            }
         }
         else if(Math.abs(mid_x - hero_mid_x) < Utils.TILE_WIDTH * 0.5)
         {
            if(this.SIDE == 2)
            {
               if(DIRECTION == RIGHT)
               {
                  if(hero_mid_y < mid_y)
                  {
                     if(Math.abs(hero_mid_y - mid_y) < Utils.TILE_WIDTH * 3.5)
                     {
                        return true;
                     }
                  }
               }
               else if(hero_mid_y > mid_y)
               {
                  if(Math.abs(hero_mid_y - mid_y) < Utils.TILE_WIDTH * 3.5)
                  {
                     return true;
                  }
               }
            }
            else if(DIRECTION == LEFT)
            {
               if(hero_mid_y < mid_y)
               {
                  if(Math.abs(hero_mid_y - mid_y) < Utils.TILE_WIDTH * 3.5)
                  {
                     return true;
                  }
               }
            }
            else if(hero_mid_y > mid_y)
            {
               if(Math.abs(hero_mid_y - mid_y) < Utils.TILE_WIDTH * 3.5)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
         }
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         x_friction = 0.8;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function scaredAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         var pSprite:GlimpseParticleSprite = new GlimpseParticleSprite();
         if(this.SIDE == 0 || this.SIDE == 1)
         {
            if(DIRECTION == LEFT)
            {
               if(this.SIDE == 0)
               {
                  level.particlesManager.pushParticle(pSprite,xPos + 4,yPos,0,0,0);
               }
               else
               {
                  level.particlesManager.pushParticle(pSprite,xPos + 4,yPos + HEIGHT * 0.5,0,0,0);
               }
            }
            else
            {
               pSprite.scaleX = -1;
               if(this.SIDE == 0)
               {
                  level.particlesManager.pushParticle(pSprite,xPos + WIDTH - 4,yPos,0,0,0);
               }
               else
               {
                  level.particlesManager.pushParticle(pSprite,xPos + WIDTH - 4,yPos + HEIGHT * 0.5,0,0,0);
               }
            }
         }
         else if(this.SIDE == 2)
         {
            if(DIRECTION == LEFT)
            {
               pSprite.rotation = -Math.PI * 0.5;
               level.particlesManager.pushParticle(pSprite,xPos - 3,yPos + 3,0,0,0);
            }
            else
            {
               pSprite.rotation = Math.PI * 0.5;
               level.particlesManager.pushParticle(pSprite,xPos - 3,yPos - 3,0,0,0);
            }
         }
         else if(DIRECTION == LEFT)
         {
            pSprite.rotation = Math.PI * 0.5;
            level.particlesManager.pushParticle(pSprite,xPos + 3,yPos - 3,0,0,0);
         }
         else
         {
            pSprite.rotation = -Math.PI * 0.5;
            level.particlesManager.pushParticle(pSprite,xPos + 3,yPos + 3,0,0,0);
         }
         counter1 = 0;
         xVel = 0;
      }
      
      public function hidingAnimation() : void
      {
         SoundSystem.PlaySound("mole");
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function hiddenAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function unhidingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function peekingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(8);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos + 32,level.camera.yPos + 32,level.camera.WIDTH - 64,level.camera.HEIGHT - 64);
         var area:Rectangle = new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
      
      override public function getMidXPos() : Number
      {
         if(this.SIDE == 2)
         {
            return xPos;
         }
         return super.getMidXPos();
      }
   }
}
