package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.GiantPollenEnemySprite;
   import sprites.enemies.SmallPollenLeafSprite;
   import sprites.particles.ZSleepParticleSprite;
   
   public class GiantPollenEnemy extends GiantEnemy
   {
       
      
      protected var leafSprite:SmallPollenLeafSprite;
      
      protected var wait_time:int;
      
      protected var walk_counter:int;
      
      protected var x_leaf_shift:int;
      
      protected var y_leaf_shift:int;
      
      protected var leaf_frame:Number;
      
      protected var leaf_speed:Number;
      
      protected var leaf_friction:Number;
      
      protected var x_sin:Number;
      
      protected var t_tick:Number;
      
      protected var z_counter:int;
      
      protected var TYPE:int;
      
      public function GiantPollenEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int, _TYPE:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,0);
         this.TYPE = _TYPE;
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         ai_index = _ai;
         this.leaf_friction = 1;
         this.x_sin = 0;
         this.t_tick = 0;
         this.z_counter = -Utils.random.nextMax(120);
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.leaf_frame = this.leaf_speed = 0;
         this.walk_counter = int(Math.random() * 2 + 1) * 60;
         this.wait_time = int(Math.random() * 5);
         this.leafSprite = new SmallPollenLeafSprite(1);
         Utils.world.addChild(this.leafSprite);
         if(this.TYPE == 1)
         {
            this.leafSprite.visible = false;
         }
         sprite = new GiantPollenEnemySprite(this.TYPE);
         if(this.TYPE == 1)
         {
            Utils.topWorld.addChild(sprite);
         }
         else
         {
            Utils.world.addChild(sprite);
         }
         aabb.x = 3;
         aabb.y = 4;
         aabb.width = 26;
         aabb.height = 28;
         aabbPhysics.x = 3;
         aabbPhysics.y = 4;
         aabbPhysics.width = 26;
         aabbPhysics.height = 28;
         stunHandler.stun_y_offset = 0;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         if(this.TYPE == 1)
         {
            stateMachine.setRule("IS_HURT_STATE","END_ACTION","IS_SLEEPING_STATE");
         }
         else
         {
            stateMachine.setRule("IS_HURT_STATE","END_ACTION","IS_FLYING_STATE");
         }
         stateMachine.setRule("IS_SLEEPING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_FLYING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_HURT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_SLEEPING_STATE",this.sleepingAnimation);
         stateMachine.setFunctionToState("IS_FLYING_STATE",this.flyingAnimation);
         stateMachine.setFunctionToState("IS_HURT_STATE",this.hurtAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_SLEEPING_STATE");
         if(this.TYPE == 1)
         {
            energy = 8;
         }
         else
         {
            energy = 2;
         }
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(this.leafSprite);
         this.leafSprite.destroy();
         this.leafSprite.dispose();
         this.leafSprite = null;
         if(this.TYPE == 1)
         {
            Utils.topWorld.removeChild(sprite);
            sprite.destroy();
            sprite.dispose();
            sprite = null;
         }
         super.destroy();
      }
      
      override public function onTop() : void
      {
         if(this.TYPE == 1)
         {
            Utils.topWorld.setChildIndex(sprite,Utils.topWorld.numChildren - 1);
         }
         else
         {
            super.onTop();
         }
      }
      
      override public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "hurt")
         {
            if(stunHandler.IS_STUNNED)
            {
               SoundSystem.PlaySound("big_enemy_hurt");
            }
            else
            {
               SoundSystem.PlaySound("big_enemy_hit");
            }
         }
      }
      
      override protected function restoreEnergy() : void
      {
         if(this.TYPE == 1)
         {
            energy = 8;
         }
         else
         {
            energy = 2;
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         if(this.TYPE == 1)
         {
            energy = 8;
         }
         else
         {
            energy = 2;
         }
         stateMachine.setState("IS_SLEEPING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_SLEEPING_STATE")
         {
            if(this.z_counter++ > 120)
            {
               this.z_counter = 0;
               if(DIRECTION == LEFT)
               {
                  level.topParticlesManager.pushParticle(new ZSleepParticleSprite(),xPos - 8,yPos + 8,0,0,0,0,0,1);
               }
               else
               {
                  level.topParticlesManager.pushParticle(new ZSleepParticleSprite(),xPos + WIDTH,yPos + 8,0,0,0,0,0,0);
               }
            }
         }
         else if(stateMachine.currentState == "IS_FLYING_STATE")
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= 4)
            {
               this.t_tick = 4;
            }
            yVel = Easings.easeOutCubic(this.t_tick,0,-1,4);
            this.leaf_speed += 0.01;
            this.leaf_speed *= 0.98;
            if(this.leaf_speed < 0.1)
            {
               this.leaf_speed = 0.1;
            }
            else if(this.leaf_speed > 0.5)
            {
               this.leaf_speed = 0.5;
            }
            this.x_sin += 0.1;
            xPos = originalXPos + Math.sin(this.x_sin) * 4;
            if(yPos <= level.camera.yPos - 128)
            {
               yPos = level.camera.yPos - 128;
               yVel = 0;
            }
            this.leaf_frame += this.leaf_speed;
            if(this.leaf_frame > 5)
            {
               this.leaf_frame -= 5;
            }
            else if(this.leaf_frame < 0)
            {
               this.leaf_frame += 5;
            }
         }
         if(this.TYPE != 1)
         {
            integratePositionAndCollisionDetection();
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         this.updateLeafShift();
         this.leafSprite.x = int(Math.floor(xPos + this.x_leaf_shift - camera.xPos));
         this.leafSprite.y = int(Math.floor(yPos + this.y_leaf_shift - camera.yPos));
         this.leafSprite.gfxHandleClip().gotoAndStop(this.leaf_frame + 1);
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
         this.leafSprite.visible = sprite.visible;
         if(this.TYPE == 1)
         {
            this.leafSprite.visible = false;
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            this.onTop();
            this.leafSprite.visible = false;
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
      }
      
      protected function updateLeafShift() : void
      {
         this.x_leaf_shift = 8 + 7;
         this.y_leaf_shift = 4 + 11;
         if(DIRECTION == RIGHT)
         {
            this.x_leaf_shift = 9;
         }
         if(sprite.gfxHandle().frame == 1)
         {
            if(sprite.gfxHandle().gfxHandleClip().currentFrame == 1)
            {
               this.y_leaf_shift = 14;
            }
         }
         else if(sprite.gfxHandle().frame == 2)
         {
            this.y_leaf_shift = 9;
         }
         else
         {
            this.y_leaf_shift = 14;
         }
      }
      
      override public function groundCollision() : void
      {
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
      }
      
      public function sleepingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
      }
      
      public function flyingAnimation() : void
      {
         originalXPos = xPos;
         this.t_tick = 0;
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         level.particlesManager.createDust(xPos,yPos + HEIGHT,Entity.LEFT);
         level.particlesManager.createDust(xPos + WIDTH,yPos + HEIGHT,Entity.RIGHT);
         counter1 = 0;
         this.x_sin = 0;
         gravity_friction = 0;
         speed = 0.8;
         x_friction = 0.8;
         xVel = 0;
         yVel = 0;
      }
      
      override public function hurtAnimation() : void
      {
         super.hurtAnimation();
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
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
         this.leafSprite.visible = false;
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         SoundSystem.PlaySound("giant_turnip_defeat");
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
