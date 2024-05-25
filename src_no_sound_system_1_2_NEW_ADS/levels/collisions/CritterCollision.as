package levels.collisions
{
   import entities.Entity;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.particles.GenericParticleSprite;
   import sprites.tutorials.*;
   
   public class CritterCollision extends Collision
   {
      
      public static var MOUSE_1:int = 0;
      
      public static var FISH_1:int = 1;
      
      public static var HERMIT_1:int = 2;
       
      
      public var ID:int;
      
      public var stateMachine:StateMachine;
      
      protected var xVel:Number;
      
      protected var yVel:Number;
      
      protected var friction_1:Number;
      
      protected var friction_2:Number;
      
      protected var tick_counter_1:Number;
      
      protected var tick_counter_2:Number;
      
      protected var sin_counter_1:Number;
      
      protected var targetXPos:Number;
      
      protected var fleeFromThis_xPos:Number;
      
      protected var isSomeEntityOnMySpot:Boolean;
      
      public var DIRECTION:int;
      
      protected var ORIGINAL_DIRECTION:int;
      
      public var MODE:int;
      
      protected var herd:Vector.<CritterCollision>;
      
      protected var time_alive:int;
      
      public function CritterCollision(_level:Level, _xPos:Number, _yPos:Number, _radius:Number, _direction:int, _ID:int)
      {
         super(_level,_xPos,_yPos);
         this.ID = _ID;
         this.herd = null;
         this.time_alive = 0;
         RADIUS = _radius;
         this.fleeFromThis_xPos = 0;
         this.isSomeEntityOnMySpot = false;
         this.xVel = this.yVel = 0;
         sprite = new GenericCritterCollisionSprite(this.ID);
         Utils.world.addChild(sprite);
         if(_direction == 0)
         {
            this.DIRECTION = Entity.LEFT;
         }
         else
         {
            this.DIRECTION = Entity.RIGHT;
         }
         this.ORIGINAL_DIRECTION = this.DIRECTION;
         this.sin_counter_1 = Math.random() * Math.PI * 2;
         var x_t:int = int(originalXPos / Utils.TILE_WIDTH);
         var y_t:int = int((originalYPos + 8) / Utils.TILE_HEIGHT);
         var t_value:int = level.levelData.getTileValueAt(x_t,y_t + 1);
         if(this.ID == CritterCollision.FISH_1)
         {
            xPos = originalXPos + Math.random() * 32 - 16;
            yPos = originalYPos + Math.random() * 4 - 2;
            originalYPos = yPos;
         }
         aabb.x = -48;
         aabb.y = -32;
         aabb.width = 96;
         aabb.height = 64;
         this.stateMachine = new StateMachine();
         if(this.ID == CritterCollision.MOUSE_1)
         {
            this.stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
            this.stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
            this.stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
            this.stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
            this.stateMachine.setRule("IS_STANDING_STATE","RAISE_ACTION","IS_RAISING_STATE");
            this.stateMachine.setRule("IS_RAISING_STATE","END_ACTION","IS_STANDING_STATE");
            this.stateMachine.setRule("IS_STANDING_STATE","HIDE_ACTION","IS_HIDING_STATE");
            this.stateMachine.setRule("IS_WALKING_STATE","HIDE_ACTION","IS_HIDING_STATE");
            this.stateMachine.setRule("IS_TURNING_STATE","HIDE_ACTION","IS_HIDING_STATE");
            this.stateMachine.setRule("IS_RAISING_STATE","HIDE_ACTION","IS_HIDING_STATE");
            this.stateMachine.setRule("IS_HIDING_STATE","END_ACTION","IS_HIDDEN_STATE");
            this.stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
            this.stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
            this.stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
            this.stateMachine.setFunctionToState("IS_RAISING_STATE",this.raisingAnimation);
            this.stateMachine.setFunctionToState("IS_HIDING_STATE",this.hidingAnimation);
            this.stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         }
         else if(this.ID == CritterCollision.FISH_1)
         {
            this.stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
            this.stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_WALKING_STATE");
            this.stateMachine.setRule("IS_WALKING_STATE","HIDE_ACTION","IS_HIDING_STATE");
            this.stateMachine.setRule("IS_TURNING_STATE","HIDE_ACTION","IS_HIDING_STATE");
            this.stateMachine.setRule("IS_HIDING_STATE","END_ACTION","IS_HIDDEN_STATE");
            this.stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
            this.stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
            this.stateMachine.setFunctionToState("IS_HIDING_STATE",this.hidingAnimation);
            this.stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         }
         else if(this.ID == CritterCollision.HERMIT_1)
         {
            this.stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
            this.stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
            this.stateMachine.setRule("IS_WALKING_STATE","HIDE_ACTION","IS_HIDDEN_STATE");
            this.stateMachine.setRule("IS_STANDING_STATE","HIDE_ACTION","IS_HIDDEN_STATE");
            this.stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
            this.stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
            this.stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
            this.xVel = 0.05 + Math.random() * 0.1;
            aabb.x = -8;
            aabb.y = 0;
            aabb.width = 32;
            aabb.height = 16;
         }
         if(Math.random() * 100 > 70)
         {
            this.stateMachine.setState("IS_HIDDEN_STATE");
         }
         else if(this.ID == CritterCollision.FISH_1)
         {
            this.stateMachine.setState("IS_WALKING_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_STANDING_STATE");
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         if(Math.random() * 100 > 70)
         {
            this.stateMachine.setState("IS_HIDDEN_STATE");
         }
         else if(this.ID == CritterCollision.FISH_1)
         {
            this.stateMachine.setState("IS_WALKING_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_STANDING_STATE");
         }
      }
      
      override public function postInit() : void
      {
         var i:int = 0;
         var critter:CritterCollision = null;
         var x_diff:Number = NaN;
         var y_diff:Number = NaN;
         var distance:Number = NaN;
         this.time_alive = 0;
         if(this.ID == CritterCollision.FISH_1)
         {
            this.herd = new Vector.<CritterCollision>();
            for(i = 0; i < level.collisionsManager.collisions.length; i++)
            {
               if(level.collisionsManager.collisions[i] != null)
               {
                  if(level.collisionsManager.collisions[i] is CritterCollision)
                  {
                     critter = level.collisionsManager.collisions[i] as CritterCollision;
                     if(critter.ID == CritterCollision.FISH_1 && critter != this)
                     {
                        x_diff = critter.xPos - this.xPos;
                        y_diff = critter.yPos - this.yPos;
                        distance = Math.sqrt(x_diff * x_diff + y_diff * y_diff);
                        if(distance < 64)
                        {
                           this.herd.push(critter);
                        }
                     }
                  }
               }
            }
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         Utils.world.removeChild(sprite);
         this.stateMachine.destroy();
         this.stateMachine = null;
         if(this.herd != null)
         {
            for(i = 0; i < this.herd.length; i++)
            {
               this.herd[i] = null;
            }
            this.herd = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         var i:int = 0;
         ++this.time_alive;
         if(this.ID == CritterCollision.HERMIT_1)
         {
            if(this.stateMachine.currentState == "IS_STANDING_STATE")
            {
               --counter1;
               if(counter1 <= 0)
               {
                  if(Math.random() * 100 > 50)
                  {
                     this.stateMachine.performAction("WALK_ACTION");
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_WALKING_STATE")
            {
               if(this.DIRECTION == Entity.LEFT)
               {
                  xPos -= this.xVel;
                  if(xPos <= originalXPos - 8)
                  {
                     xPos = originalXPos - 8;
                     this.DIRECTION = Entity.RIGHT;
                     this.stateMachine.setState("IS_STANDING_STATE");
                  }
               }
               else
               {
                  xPos += this.xVel;
                  if(xPos >= originalXPos + 8)
                  {
                     xPos = originalXPos + 8;
                     this.DIRECTION = Entity.LEFT;
                     this.stateMachine.setState("IS_STANDING_STATE");
                  }
               }
            }
         }
         else if(this.ID == CritterCollision.MOUSE_1)
         {
            if(this.stateMachine.currentState == "IS_STANDING_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,Math.random() * 2 + 1);
                  sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               }
               --counter1;
               if(counter1 <= 0)
               {
                  if(Math.random() * 100 > 50)
                  {
                     this.stateMachine.performAction("WALK_ACTION");
                  }
                  else if(Math.random() * 100 > 50)
                  {
                     this.stateMachine.performAction("RAISE_ACTION");
                  }
                  else
                  {
                     this.stateMachine.performAction("TURN_ACTION");
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_RAISING_STATE")
            {
               if(counter1-- < 0)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState == "IS_WALKING_STATE")
            {
               if(this.targetXPos > xPos)
               {
                  xPos += 2;
                  if(xPos >= this.targetXPos)
                  {
                     xPos = this.targetXPos;
                     this.stateMachine.performAction("STOP_ACTION");
                  }
               }
               else
               {
                  xPos -= 2;
                  if(xPos <= this.targetXPos)
                  {
                     xPos = this.targetXPos;
                     this.stateMachine.performAction("STOP_ACTION");
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_HIDING_STATE")
            {
               if(this.DIRECTION == Entity.RIGHT)
               {
                  xPos += 6;
               }
               else
               {
                  xPos -= 6;
               }
               if(this.DIRECTION == Entity.RIGHT)
               {
                  x_t = int(xPos / Utils.TILE_WIDTH);
               }
               else
               {
                  x_t = int((xPos + 16) / Utils.TILE_WIDTH);
               }
               y_t = (yPos + 8) / Utils.TILE_HEIGHT;
               if(level.levelData.getTileValueAt(x_t,y_t) != 0)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else
         {
            this.sin_counter_1 += 0.1;
            if(this.sin_counter_1 >= Math.PI * 2)
            {
               this.sin_counter_1 -= Math.PI * 2;
            }
            yPos = originalYPos + Math.sin(this.sin_counter_1) * 1;
            if(this.stateMachine.currentState == "IS_WALKING_STATE")
            {
               if(this.DIRECTION == Entity.RIGHT)
               {
                  xPos += 0.25;
                  if(xPos >= originalXPos + 16)
                  {
                     this.stateMachine.performAction("TURN_ACTION");
                  }
               }
               else
               {
                  xPos -= 0.25;
                  if(xPos <= originalXPos - 16)
                  {
                     this.stateMachine.performAction("TURN_ACTION");
                  }
               }
               for(i = 0; i < this.herd.length; i++)
               {
                  if(this.herd[i] != null)
                  {
                     if(this.herd[i].stateMachine.currentState == "IS_HIDING_STATE")
                     {
                        this.stateMachine.performAction("HIDE_ACTION");
                     }
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_TURNING_STATE")
            {
               this.changeDirection();
               this.stateMachine.performAction("END_ACTION");
            }
            else if(this.stateMachine.currentState == "IS_HIDING_STATE")
            {
               if(this.DIRECTION == Entity.RIGHT)
               {
                  xPos += 4;
               }
               else
               {
                  xPos -= 4;
               }
               if(this.DIRECTION == Entity.RIGHT)
               {
                  x_t = int(xPos / Utils.TILE_WIDTH);
               }
               else
               {
                  x_t = int((xPos + 16) / Utils.TILE_WIDTH);
               }
               y_t = (yPos + 8) / Utils.TILE_HEIGHT;
               if(level.levelData.getTileValueAt(x_t,y_t) != 0)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = level.hero.getAABB();
         var bird_aabb:Rectangle = getAABB();
         hero_aabb.x += level.hero.xVel;
         if(this.stateMachine.currentState == "IS_HIDING_STATE" || this.stateMachine.currentState == "IS_HIDDEN_STATE")
         {
            return;
         }
         if(hero_aabb.intersects(bird_aabb))
         {
            this.stateMachine.performAction("HIDE_ACTION");
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.DIRECTION == Entity.LEFT)
         {
            sprite.gfxHandle().scaleX = 1;
         }
         else
         {
            sprite.gfxHandle().scaleX = -1;
         }
      }
      
      protected function standingAnimation() : void
      {
         sprite.visible = true;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = (Math.random() * 2 + 1) * 60;
         if(this.ID == CritterCollision.HERMIT_1)
         {
            counter1 = Math.random() * 60;
         }
         else
         {
            this.xVel = 0;
         }
      }
      
      protected function walkingAnimation() : void
      {
         sprite.visible = true;
         if(this.ID == CritterCollision.MOUSE_1)
         {
            sprite.gfxHandle().gotoAndStop(2);
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            counter1 = (Math.random() * 1 + 1) * 60;
            this.targetXPos = originalXPos - RADIUS + Math.random() * RADIUS;
            if(this.targetXPos > xPos)
            {
               this.DIRECTION = Entity.RIGHT;
            }
            else
            {
               this.DIRECTION = Entity.LEFT;
            }
         }
         else if(this.ID == CritterCollision.HERMIT_1)
         {
            sprite.gfxHandle().gotoAndStop(2);
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            counter1 = (Math.random() * 2 + 2) * 60;
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(1);
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         }
      }
      
      protected function turningAnimation() : void
      {
         if(CritterCollision.MOUSE_1)
         {
            this.changeDirection();
            this.stateMachine.performAction("END_ACTION");
         }
         else
         {
            counter1 = 0;
            counter2 = 0;
         }
      }
      
      protected function raisingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 60 + Math.random() * 60;
      }
      
      protected function hidingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.DIRECTION = this.ORIGINAL_DIRECTION;
         if(this.ID == CritterCollision.FISH_1)
         {
            level.topParticlesManager.createBreatheWaterBubble(xPos,yPos);
         }
      }
      
      protected function hiddenAnimation() : void
      {
         sprite.visible = false;
         if(this.ID == CritterCollision.HERMIT_1)
         {
            this.sandParticles();
         }
      }
      
      protected function changeDirection() : void
      {
         if(this.DIRECTION == Entity.RIGHT)
         {
            this.DIRECTION = Entity.LEFT;
         }
         else
         {
            this.DIRECTION = Entity.RIGHT;
         }
      }
      
      protected function sandParticles() : void
      {
         var i:int = 0;
         var pSprite:GenericParticleSprite = null;
         if(this.time_alive < 30)
         {
            return;
         }
         var amount:int = 2;
         if(Math.random() * 100 > 50)
         {
            amount = 3;
         }
         for(i = 0; i < amount; i++)
         {
            pSprite = new GenericParticleSprite(GenericParticleSprite.SAND_BEACH);
            if(Math.random() * 100 > 50)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            level.particlesManager.pushParticle(pSprite,xPos + Math.random() * 8 - 4,yPos + 16,0,-2,0.8,Math.random() * Math.PI * 2,0.5 * int(Math.random() * 3),0,16);
         }
      }
   }
}
