package entities.enemies
{
   import entities.Easings;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.StateMachine;
   import levels.Level;
   import sprites.enemies.*;
   import sprites.particles.DirtyDustParticleSprite;
   import sprites.particles.PollenParticleSprite;
   import states.LevelState;
   
   public class DustEnemy extends Enemy
   {
       
      
      protected var initial_anim_delay:int;
      
      protected var targetXPos:Number;
      
      protected var targetYPos:Number;
      
      protected var t_start_x:Number;
      
      protected var t_diff_x:Number;
      
      protected var t_start_y:Number;
      
      protected var t_diff_y:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      protected var hide_delay:int;
      
      protected var DUST_PARTICLE_FLAG:Boolean;
      
      protected var dust_counter_1:int;
      
      protected var dust_counter_2:int;
      
      public function DustEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 16;
         HEIGHT = 10;
         speed = 0.8;
         this.initial_anim_delay = Math.random() * 15 + 10;
         this.DUST_PARTICLE_FLAG = false;
         this.dust_counter_1 = this.dust_counter_2 = 0;
         MAX_Y_VEL = 0.5;
         sprite = new DustEnemySprite();
         Utils.world.addChild(sprite);
         aabb.y = aabbPhysics.y = 3;
         aabb.height = aabbPhysics.height = 10;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_FLOATING_STATE","HIDE_ACTION","IS_HIDING_STATE");
         stateMachine.setRule("IS_HIDING_STATE","END_ACTION","IS_HIDDEN_STATE");
         stateMachine.setRule("IS_FLOATING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_FLOATING_STATE",this.floatAnimation);
         stateMachine.setFunctionToState("IS_HIDING_STATE",this.hidingAnimation);
         stateMachine.setFunctionToState("IS_HIDDEN_STATE",this.hiddenAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_FLOATING_STATE");
      }
      
      override public function reset() : void
      {
         super.reset();
         stateMachine.setState("IS_FLOATING_STATE");
      }
      
      override public function getMidXPos() : Number
      {
         return xPos;
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         var pSprite:DirtyDustParticleSprite = null;
         super.update();
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_2)
         {
            if(level.hero.xPos >= 672)
            {
               stateMachine.performAction("HIDE_ACTION");
            }
         }
         else if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_1_3)
         {
            if(xPos >= 632 && xPos <= 712)
            {
               if(level.hero.yPos <= 80)
               {
                  stateMachine.performAction("HIDE_ACTION");
               }
            }
            else if(xPos >= 448 && xPos < 632)
            {
               if(level.hero.xPos <= 568 && level.hero.yPos <= 80)
               {
                  stateMachine.performAction("HIDE_ACTION");
               }
            }
            else if(xPos >= 952)
            {
               if(level.hero.xPos >= 872)
               {
                  stateMachine.performAction("HIDE_ACTION");
               }
            }
         }
         if(stateMachine.currentState == "IS_FLOATING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,0.5);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               if(Math.random() * 100 > 50)
               {
                  yPos = originalYPos + 1;
               }
               else
               {
                  yPos = originalYPos - 1;
               }
            }
            xVel = yVel = 0;
         }
         else if(stateMachine.currentState == "IS_HIDING_STATE")
         {
            if(this.hide_delay-- < 0)
            {
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
                  stateMachine.performAction("END_ACTION");
               }
            }
            xPos = Easings.easeInBack(this.t_tick,this.t_start_x,this.t_diff_x,this.t_time);
            yPos = Easings.easeInBack(this.t_tick,this.t_start_y,this.t_diff_y,this.t_time);
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            ++counter1;
            wait_time = 3;
            if(sprite.visible)
            {
               wait_time = 5;
            }
            if(counter1 >= wait_time)
            {
               counter1 = 0;
               ++counter2;
               sprite.visible = !sprite.visible;
               if(!sprite.visible)
               {
                  this.pollenParticle();
               }
               if(counter2 > 12)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         if(this.DUST_PARTICLE_FLAG)
         {
            if(this.dust_counter_1-- < 0)
            {
               this.dust_counter_1 = 10 + Math.random() * 40;
               if(this.dust_counter_2-- < 0)
               {
                  this.DUST_PARTICLE_FLAG = false;
               }
               pSprite = new DirtyDustParticleSprite();
               if(Math.random() * 100 > 50)
               {
                  pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  pSprite.gfxHandleClip().gotoAndStop(2);
               }
               level.particlesManager.pushBackParticle(pSprite,originalXPos - 8 + Math.random() * 16,originalYPos + 4,0,0,0.9,Math.random() * Math.PI * 2,Math.random() * 0.2 + 0.1);
            }
         }
         xPos += xVel;
         yPos += yVel;
      }
      
      public function floatAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         aabb.height = 13;
         counter1 = 0;
      }
      
      override public function isTargetable() : Boolean
      {
         return false;
      }
      
      public function hidingAnimation() : void
      {
         SoundSystem.PlaySound("dust");
         this.t_start_x = xPos;
         this.t_diff_x = this.targetXPos - xPos;
         this.t_start_y = yPos;
         this.t_diff_y = this.targetYPos - yPos;
         this.t_tick = 0;
         this.t_time = 0.2;
         this.DUST_PARTICLE_FLAG = true;
         this.hide_delay = int(Math.random() * 10);
         this.dust_counter_1 = 0;
         this.dust_counter_2 = int(Math.random() * 2);
      }
      
      public function hiddenAnimation() : void
      {
         sprite.visible = false;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         if(stateMachine.lastState == "IS_SLEEPING_STATE")
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         }
         counter1 = counter2 = 0;
         yVel = 0;
      }
      
      protected function pollenParticle() : void
      {
         var _vel:Number = -1.25;
         if(level.hero.xPos + level.hero.WIDTH * 0.5 < xPos + 8)
         {
            _vel = 1.25;
         }
         var pSprite:PollenParticleSprite = new PollenParticleSprite();
         var angle:Number = Math.random() * Math.PI * 2;
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         level.particlesManager.pushParticle(pSprite,xPos + 7 + Math.sin(angle) * 4,yPos + 6 + Math.cos(angle) * 4,_vel * (1 + Math.random() * 0.5),-(int(Math.random() * 2) + 1),1,Math.random() * 0.02 + 0.01,Math.random() * 4 + 4,0);
      }
      
      override protected function fetchScripts() : void
      {
         var i:int = 0;
         var x_diff:Number = NaN;
         var y_diff:Number = NaN;
         var distance:Number = NaN;
         var index:int = -1;
         var minDistance:Number = -1;
         var point:Point = new Point(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5);
         for(i = 0; i < level.scriptsManager.horPathScripts.length; i++)
         {
            if(level.scriptsManager.horPathScripts[i] != null)
            {
               x_diff = level.scriptsManager.horPathScripts[i].x - point.x;
               y_diff = level.scriptsManager.horPathScripts[i].y - point.y;
               distance = Math.sqrt(x_diff * x_diff + y_diff * y_diff);
               if(distance < minDistance || minDistance < 0)
               {
                  minDistance = distance;
                  index = i;
               }
            }
         }
         if(index > -1)
         {
            this.targetXPos = level.scriptsManager.horPathScripts[index].x;
            this.targetYPos = level.scriptsManager.horPathScripts[index].y;
         }
      }
   }
}
