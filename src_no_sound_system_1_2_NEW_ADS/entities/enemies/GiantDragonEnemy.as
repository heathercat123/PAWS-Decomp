package entities.enemies
{
   import entities.Hero;
   import game_utils.AchievementsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.SnowballBigBulletSprite;
   import sprites.enemies.GiantDragonEnemySprite;
   import sprites.enemies.GiantDragonWingSprite;
   
   public class GiantDragonEnemy extends Enemy
   {
       
      
      protected var sxWing:GiantDragonWingSprite;
      
      protected var dxWing:GiantDragonWingSprite;
      
      protected var yShift:Number;
      
      protected var IS_GOING_UP:Boolean;
      
      protected var attack_counter:int;
      
      protected var shootFlag:Boolean;
      
      public function GiantDragonEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         MAX_Y_VEL = 0.5;
         xVel = yVel = 0;
         this.shootFlag = true;
         this.sxWing = new GiantDragonWingSprite();
         Utils.world.addChild(this.sxWing);
         this.sxWing.scaleX = -1;
         sprite = new GiantDragonEnemySprite();
         Utils.world.addChild(sprite);
         this.dxWing = new GiantDragonWingSprite();
         Utils.world.addChild(this.dxWing);
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
         stateMachine.setRule("IS_CUTSCENE_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_WAITING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","AIM_ACTION","IS_AIMING_STATE");
         stateMachine.setRule("IS_AIMING_STATE","END_ACTION","IS_TOSSING_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_AIMING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_TOSSING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_CUTSCENE_STATE",this.cutsceneAnimation);
         stateMachine.setFunctionToState("IS_WAITING_STATE",this.waitingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_AIMING_STATE",this.aimingAnimation);
         stateMachine.setFunctionToState("IS_TOSSING_STATE",this.tossingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_CUTSCENE_STATE");
         sinCounter1 = 0;
         this.yShift = 0;
         this.IS_GOING_UP = true;
         speed = 0.04;
         this.attack_counter = 120;
         energy = 30;
      }
      
      override public function hit(_source_x:Number = 0, _source_y:Number = 0, _isCatAttacking:Boolean = false) : void
      {
         if(stateMachine.currentState == "IS_HIT_STATE" || stateMachine.currentState == "IS_DEAD_STATE")
         {
            return;
         }
         if(stateMachine.currentState != "IS_HIT_STATE")
         {
            SoundSystem.PlaySound("big_enemy_hurt");
         }
         stateMachine.setState("IS_HIT_STATE");
         counter1 = 0;
         BULLET_HIT_FLAG = false;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(this.dxWing);
         this.dxWing.destroy();
         this.dxWing.dispose();
         this.dxWing = null;
         Utils.world.removeChild(this.sxWing);
         this.sxWing.destroy();
         this.sxWing.dispose();
         this.sxWing = null;
         super.destroy();
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(hero.getAABB().intersects(getAABB()))
         {
            hero.hurt(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
         }
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         super.update();
         var xRef:Number = 2400;
         var yRef:Number = 48;
         if(stateMachine.currentState != "IS_CUTSCENE_STATE")
         {
            if(stateMachine.currentState == "IS_WALKING_STATE")
            {
               xVel = -1;
            }
            else if(stateMachine.currentState == "IS_STANDING_STATE")
            {
               this.moveRoutine();
               ++this.attack_counter;
               if(this.attack_counter >= 150)
               {
                  this.attack_counter = 0;
                  stateMachine.performAction("AIM_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_AIMING_STATE")
            {
               this.moveRoutine();
               ++counter1;
               if(counter1 >= 60)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(stateMachine.currentState == "IS_TOSSING_STATE")
            {
               this.moveRoutine();
               if(sprite.gfxHandle().gfxHandleClip().currentFrame == 1 && this.shootFlag)
               {
                  this.shootFlag = false;
                  this.shoot();
               }
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  stateMachine.performAction("END_ACTION");
               }
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
                  this.sxWing.visible = sprite.visible;
                  this.dxWing.visible = sprite.visible;
                  if(counter2 > 12)
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
         }
         xPos += xVel;
         yPos += yVel;
         yVel *= 0.95;
         sinCounter1 += 0.1;
         if(sinCounter1 >= Math.PI * 2)
         {
            sinCounter1 -= Math.PI * 2;
         }
         if(stateMachine.currentState == "IS_CUTSCENE_STATE" || stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_WAITING_STATE")
         {
            this.yShift = Math.sin(sinCounter1) * (Utils.TILE_HEIGHT * 0.25);
         }
         else
         {
            this.yShift *= 0.9;
            if(this.yShift <= 0.1)
            {
               this.yShift = 0.1;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos + this.yShift - camera.yPos));
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
         this.sxWing.x = int(Math.floor(xPos + 2 - camera.xPos));
         this.dxWing.x = int(Math.floor(xPos + 36 - camera.xPos));
         this.sxWing.y = this.dxWing.y = int(Math.floor(yPos + 3 + this.yShift - camera.yPos));
         sprite.updateScreenPosition();
      }
      
      protected function moveRoutine() : void
      {
         var yRef:Number = NaN;
         var xRef:Number = 2400;
         yRef = 48;
         if(this.IS_GOING_UP)
         {
            yVel -= speed;
            if(yPos <= yRef + Utils.TILE_HEIGHT)
            {
               this.IS_GOING_UP = false;
            }
         }
         else
         {
            yVel += speed;
            if(yPos + HEIGHT >= level.camera.yPos + level.camera.HEIGHT - Utils.TILE_HEIGHT)
            {
               this.IS_GOING_UP = true;
            }
         }
      }
      
      protected function shoot() : void
      {
         SoundSystem.PlaySound("giant_ice_dragon_shoot");
         var xDiff:Number = level.hero.xPos + level.hero.WIDTH * 0.5 - (xPos + WIDTH * 0.5);
         var yDiff:Number = level.hero.yPos + level.hero.HEIGHT * 0.5 - (yPos + HEIGHT * 0.5);
         var distance:Number = Math.sqrt(xDiff * xDiff + yDiff * yDiff);
         xDiff /= distance;
         yDiff /= distance;
         level.bulletsManager.pushBullet(new SnowballBigBulletSprite(),xPos + WIDTH * 0.25,yPos + HEIGHT * 0.5,xDiff * 1.75,yDiff * 1.75,1,0,0,0);
      }
      
      public function cutsceneAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function waitingAnimation() : void
      {
         xVel = yVel = 0;
      }
      
      public function walkingAnimation() : void
      {
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         x_friction = 0.8;
         xVel = yVel = 0;
      }
      
      public function aimingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      public function tossingAnimation() : void
      {
         this.shootFlag = true;
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      public function hitAnimation() : void
      {
         AchievementsManager.SubmitAchievement("DEFEAT_ICE_DRAGON");
         Utils.NoMusicBeingPlayed = true;
         SoundSystem.StopMusic(true);
         level.camera.shake();
         SoundSystem.PlaySound("big_enemy_hurt");
         sprite.gfxHandle().gotoAndStop(4);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         this.sxWing.gfxHandleClip().gotoAndStop(1);
         this.dxWing.gfxHandleClip().gotoAndStop(1);
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
   }
}
