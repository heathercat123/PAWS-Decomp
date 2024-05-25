package entities.enemies
{
   import entities.Entity;
   import game_utils.GameSlot;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.*;
   import sprites.particles.WhitePointParticleSprite;
   import starling.display.Image;
   
   public class BatEnemy extends Enemy
   {
       
      
      protected var old_x_vel:Number;
      
      protected var FETCH_HERO:Boolean;
      
      protected var z_counter:int;
      
      protected var last_point_x:Number;
      
      protected var last_point_y:Number;
      
      protected var bat_eyes:Image;
      
      protected var sleep_counter:int;
      
      protected var RADIUS:Number;
      
      protected var WAKE_UP_RADIUS:Number;
      
      public function BatEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _radius:int, _ai:int = 0, _wake_up_radius:Number = 0)
      {
         super(_level,_xPos,_yPos,_direction,_ai);
         WIDTH = HEIGHT = 16;
         if(_radius < 1)
         {
            this.RADIUS = 192;
         }
         else
         {
            this.RADIUS = _radius;
         }
         if(_wake_up_radius < 1)
         {
            this.WAKE_UP_RADIUS = 128;
         }
         else
         {
            this.WAKE_UP_RADIUS = _wake_up_radius;
         }
         this.sleep_counter = 0;
         speed = 0.8;
         this.old_x_vel = 0;
         sinCounter1 = 0;
         this.z_counter = 0;
         this.FETCH_HERO = false;
         sprite = new BatEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = -6.5;
         aabb.y = -6.5;
         aabb.width = 12;
         aabb.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_SLEEPING_STATE","WAKE_UP_ACTION","IS_WAKING_UP_STATE");
         stateMachine.setRule("IS_WAKING_UP_STATE","END_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_FLYING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_FLYING_STATE","END_ACTION","IS_SLEEPING_STATE");
         stateMachine.setRule("IS_FLYING_STATE","SCARED_ACTION","IS_SCARED_STATE");
         stateMachine.setRule("IS_SCARED_STATE","END_ACTION","IS_FLYING_STATE");
         stateMachine.setRule("IS_SLEEPING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_WAKING_UP_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_FLYING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SCARED_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_SLEEPING_STATE",this.sleepingAnimation);
         stateMachine.setFunctionToState("IS_WAKING_UP_STATE",this.wakingUpAnimation);
         stateMachine.setFunctionToState("IS_FLYING_STATE",this.flyingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turnAnimation);
         stateMachine.setFunctionToState("IS_SCARED_STATE",this.scaredAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_SLEEPING_STATE");
         this.bat_eyes = new Image(TextureManager.sTextureAtlas.getTexture("batEyes"));
         Utils.darkWorld.addChild(this.bat_eyes);
         if(!Utils.IS_DARK)
         {
            this.bat_eyes.visible = false;
         }
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         Utils.darkWorld.removeChild(this.bat_eyes);
         this.bat_eyes.dispose();
         this.bat_eyes = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var hero_mid_x:Number = NaN;
         var hero_mid_y:Number = NaN;
         var x_diff:Number = NaN;
         var y_diff:Number = NaN;
         var diff:Number = NaN;
         var point_diff_x:Number = NaN;
         var point_diff_y:Number = NaN;
         var point_dist:Number = NaN;
         var dist_x:Number = NaN;
         var dist_y:Number = NaN;
         var dist:Number = NaN;
         super.update();
         if(stateMachine.currentState == "IS_SLEEPING_STATE")
         {
            --this.sleep_counter;
            if(this.sleep_counter < 0)
            {
               this.sleep_counter = 0;
            }
            hero_mid_x = level.hero.xPos + level.hero.WIDTH * 0.5;
            hero_mid_y = level.hero.yPos + level.hero.HEIGHT * 0.5;
            x_diff = hero_mid_x - xPos;
            y_diff = hero_mid_y - yPos;
            diff = Math.sqrt(x_diff * x_diff + y_diff * y_diff);
            if(diff <= this.WAKE_UP_RADIUS && (hero_mid_y > yPos + 24 || diff <= 32 && hero_mid_y > yPos + 12))
            {
               this.FETCH_HERO = true;
               if(ai_index != 1)
               {
                  if(this.sleep_counter <= 0)
                  {
                     stateMachine.performAction("WAKE_UP_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_WAKING_UP_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               SoundSystem.PlaySound("bird_flying");
               stateMachine.performAction("END_ACTION");
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
         else if(stateMachine.currentState == "IS_SCARED_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
               this.FETCH_HERO = false;
            }
         }
         else if(stateMachine.currentState == "IS_FLYING_STATE")
         {
            if(this.FETCH_HERO)
            {
               this.fetchHero();
               dist_x = originalXPos - xPos;
               dist_y = originalYPos - yPos;
               dist = Math.sqrt(dist_x * dist_x + dist_y * dist_y);
               if(dist >= this.RADIUS || Utils.SEA_LEVEL > 0 && yPos >= Utils.SEA_LEVEL - 8)
               {
                  this.FETCH_HERO = false;
               }
               if(level.stateMachine.currentState == "IS_EXITING_LEVEL_STATE")
               {
                  this.FETCH_HERO = false;
               }
            }
            else
            {
               this.fetchHome();
               if(Math.abs(xPos - originalXPos) <= 2 && Math.abs(yPos - originalYPos) <= 2)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            if(DIRECTION == LEFT && xVel > 0)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            else if(DIRECTION == RIGHT && xVel < 0)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            point_diff_x = this.last_point_x - xPos;
            point_diff_y = this.last_point_y - yPos;
            point_dist = Math.sqrt(point_diff_x * point_diff_x + point_diff_y * point_diff_y);
            if(point_dist >= 24)
            {
               this.last_point_x = xPos;
               this.last_point_y = yPos;
               level.particlesManager.pushBackParticle(new WhitePointParticleSprite(),xPos,yPos,0,0,0);
            }
         }
         if(!Utils.IS_DARK)
         {
            this.bat_eyes.visible = false;
         }
         xVel *= x_friction;
         yVel *= x_friction;
         oldXPos = xPos;
         oldYPos = yPos;
         xPos += xVel;
         yPos += yVel;
      }
      
      override public function shake() : void
      {
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         if(ai_index != 1)
         {
            diff_x = level.hero.getMidXPos() - this.getMidXPos();
            diff_y = level.hero.getMidYPos() - this.getMidYPos();
            distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
            if(isInsideScreen() && distance <= Utils.WIDTH * 0.5)
            {
               this.FETCH_HERO = true;
               stateMachine.performAction("WAKE_UP_ACTION");
            }
         }
      }
      
      override protected function allowCatAttack() : Boolean
      {
         return true;
      }
      
      protected function fetchHero() : void
      {
         var hero_mid_x:Number = NaN;
         var distance:Number = NaN;
         var dest_y:Number = NaN;
         hero_mid_x = level.hero.getMidXPos();
         var hero_mid_y:Number = level.hero.getMidYPos();
         var x_diff:Number = hero_mid_x - xPos;
         var y_diff:Number = hero_mid_y - yPos;
         distance = Math.sqrt(x_diff * x_diff + y_diff * y_diff);
         x_diff /= distance;
         y_diff /= distance;
         var perp_x:Number = -y_diff;
         var perp_y:Number = x_diff;
         sinCounter1 += 0.1;
         if(sinCounter1 >= Math.PI * 2)
         {
            sinCounter1 -= Math.PI * 2;
         }
         var dest_x:Number = x_diff + perp_x * Math.sin(sinCounter1);
         dest_y = y_diff + perp_y * Math.sin(sinCounter1);
         xVel = dest_x;
         yVel = dest_y;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] == 71 && Utils.IS_DARK)
         {
            if(distance < 80)
            {
               if(hero_mid_x < xPos)
               {
                  if(level.hero.DIRECTION == Entity.RIGHT && DIRECTION == Entity.LEFT)
                  {
                     stateMachine.performAction("SCARED_ACTION");
                  }
               }
               else if(level.hero.DIRECTION == Entity.LEFT && DIRECTION == Entity.RIGHT)
               {
                  stateMachine.performAction("SCARED_ACTION");
               }
            }
         }
      }
      
      protected function fetchHome() : void
      {
         var dest_y:Number = NaN;
         var home_mid_x:Number = originalXPos;
         var home_mid_y:Number = originalYPos;
         var x_diff:Number = home_mid_x - xPos;
         var y_diff:Number = home_mid_y - yPos;
         var distance:Number = Math.sqrt(x_diff * x_diff + y_diff * y_diff);
         x_diff /= distance;
         y_diff /= distance;
         var perp_x:Number = -y_diff;
         var perp_y:Number = x_diff;
         sinCounter1 += 0.1;
         if(sinCounter1 >= Math.PI * 2)
         {
            sinCounter1 -= Math.PI * 2;
         }
         var dest_x:Number = x_diff + perp_x * Math.sin(sinCounter1);
         dest_y = y_diff + perp_y * Math.sin(sinCounter1);
         xVel = dest_x;
         yVel = dest_y;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         var x_shift:int = 0;
         var y_shift:int = 0;
         if(sprite.gfxHandle().frame == 2)
         {
            if(sprite.gfxHandle().gfxHandleClip().currentFrame == 0)
            {
               this.bat_eyes.visible = false;
            }
            else if(sprite.gfxHandle().gfxHandleClip().currentFrame == 1)
            {
               this.bat_eyes.visible = true;
               x_shift = -4;
               y_shift = -3;
            }
            else if(sprite.gfxHandle().gfxHandleClip().currentFrame == 2)
            {
               this.bat_eyes.visible = false;
            }
            else if(sprite.gfxHandle().gfxHandleClip().currentFrame == 3)
            {
               this.bat_eyes.visible = true;
               x_shift = -4;
               y_shift = -3;
            }
         }
         else if(sprite.gfxHandle().frame == 3)
         {
            if(sprite.gfxHandle().gfxHandleClip().currentFrame == 0)
            {
               x_shift = -6;
               y_shift = 1;
            }
            else if(sprite.gfxHandle().gfxHandleClip().currentFrame == 1)
            {
               x_shift = -6;
               y_shift = 1;
            }
            else
            {
               x_shift = -6;
               y_shift = -1;
            }
            if(sprite.gfxHandle().scaleX == -1)
            {
               x_shift += 4;
            }
            this.bat_eyes.visible = true;
         }
         else if(sprite.gfxHandle().frame == 4)
         {
            x_shift = -4;
            y_shift = 0;
            this.bat_eyes.visible = true;
         }
         else
         {
            this.bat_eyes.visible = false;
         }
         this.bat_eyes.x = int(sprite.x + x_shift);
         this.bat_eyes.y = int(sprite.y + y_shift);
         if(Utils.IS_DARK == false)
         {
            this.bat_eyes.visible = false;
         }
         Utils.darkWorld.setChildIndex(this.bat_eyes,Utils.darkWorld.numChildren - 1);
      }
      
      public function sleepingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
         xPos = originalXPos;
         yPos = originalYPos;
      }
      
      public function wakingUpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.sleep_counter = 90;
         counter3 = 0;
      }
      
      public function flyingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.last_point_x = xPos;
         this.last_point_y = yPos;
      }
      
      public function turnAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function scaredAnimation() : void
      {
         SoundSystem.PlaySound("blink");
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         if(KILLED_BY_CAT)
         {
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_BAT_DEFEATED_BY_ANY_CAT);
         }
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function getMidXPos() : Number
      {
         return xPos;
      }
      
      override public function getMidYPos() : Number
      {
         return yPos;
      }
   }
}
