package entities.enemies
{
   import entities.Hero;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.enemies.MonkeyEnemySprite;
   import sprites.enemies.MonkeyRedEnemySprite;
   import sprites.particles.ZSleepParticleSprite;
   
   public class MonkeyRedEnemy extends Enemy
   {
       
      
      protected var lighter_y_diff:Number;
      
      protected var oldShift:Number;
      
      protected var z_counter:int;
      
      public function MonkeyRedEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _color:int, _ai_index:int)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         sinCounter1 = Utils.random.nextMax(6);
         MAX_Y_VEL = 0.5;
         this.oldShift = Utils.SEA_X_SHIFT;
         this.z_counter = -Utils.random.nextMax(120);
         sprite = new MonkeyRedEnemySprite(_color);
         Utils.world.addChild(sprite);
         aabbPhysics.x = 0;
         aabbPhysics.y = 0;
         aabbPhysics.width = 16;
         aabbPhysics.height = 16;
         aabb.x = 0;
         aabb.y = -3;
         aabb.width = 16;
         aabb.height = 16;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_FLOATING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_MISSING_STATE");
         stateMachine.setFunctionToState("IS_FLOATING_STATE",this.floatingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_MISSING_STATE",this.missingAnimation);
         stateMachine.setState("IS_FLOATING_STATE");
         energy = 1;
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_FLOATING_STATE");
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState == "IS_MISSING_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override public function isDead() : Boolean
      {
         if(stateMachine.currentState == "IS_MISSING_STATE" || dead)
         {
            return true;
         }
         return false;
      }
      
      override public function update() : void
      {
         super.update();
         sinCounter1 += 0.05;
         if(sinCounter1 >= Math.PI * 2)
         {
            sinCounter1 -= Math.PI * 2;
         }
         yPos = Utils.SEA_LEVEL - HEIGHT + Math.sin(sinCounter1) * 1.5 + this.lighter_y_diff;
         xVel += (Utils.SEA_X_SHIFT - this.oldShift) * 0.02;
         this.oldShift = Utils.SEA_X_SHIFT;
         if(stateMachine.currentState != "IS_FLOATING_STATE")
         {
            if(stateMachine.currentState == "IS_HIT_STATE")
            {
               stateMachine.performAction("END_ACTION");
            }
            else if(stateMachine.currentState == "IS_MISSING_STATE")
            {
               this.lighter_y_diff -= 0.05;
               if(this.lighter_y_diff <= -1)
               {
                  this.lighter_y_diff = -1;
               }
            }
         }
         if(stateMachine.currentState == "IS_FLOATING_STATE")
         {
            if(this.z_counter++ > 120)
            {
               this.z_counter = 0;
               level.particlesManager.pushParticle(new ZSleepParticleSprite(),xPos + WIDTH,yPos - 2,0,0,0);
            }
         }
         xVel *= x_friction;
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
         level.levelPhysics.collisionDetectionMap(this);
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_MISSING_STATE")
         {
            return;
         }
         super.checkHeroCollisionDetection(hero);
      }
      
      public function floatingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.lighter_y_diff = 0;
         x_friction = 0.95;
         counter2 = 0;
      }
      
      public function hitAnimation() : void
      {
         var _xVel:Number = NaN;
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         setHitVariables();
         var pSprite:MonkeyEnemySprite = new MonkeyEnemySprite();
         pSprite.gfxHandle().gotoAndStop(6);
         pSprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(getMidXPos() > level.hero.getMidXPos())
         {
            _xVel = 2;
         }
         else
         {
            _xVel = -2;
         }
         level.particlesManager.pushParticle(pSprite,xPos,yPos,_xVel,-2,0.9);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function missingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
      }
   }
}
