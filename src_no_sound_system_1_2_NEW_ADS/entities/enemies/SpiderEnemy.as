package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.FireballBulletSprite;
   import sprites.enemies.SpiderEnemySprite;
   import starling.display.Image;
   
   public class SpiderEnemy extends Enemy
   {
       
      
      protected var spider_web_base:Image;
      
      protected var spider_web_body:Image;
      
      protected var tween_start:Number;
      
      protected var tween_diff:Number;
      
      protected var tween_time:Number;
      
      protected var tween_tick:Number;
      
      protected var RANGE:int;
      
      protected var STARTS_FROM_TOP:Boolean;
      
      protected var shooting_counter:int;
      
      public function SpiderEnemy(_level:Level, _xPos:Number, _yPos:Number, _range:int, _startsFromTop:int, _ai:int = 0)
      {
         super(_level,_xPos,_yPos,Entity.LEFT,0);
         WIDTH = HEIGHT = 16;
         this.RANGE = _range;
         ai_index = _ai;
         if(_startsFromTop == 0)
         {
            this.STARTS_FROM_TOP = false;
         }
         else
         {
            this.STARTS_FROM_TOP = true;
         }
         sprite = new SpiderEnemySprite();
         Utils.world.addChild(sprite);
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = -6.5;
         aabb.y = -6.5;
         aabb.width = 14;
         aabb.height = 13;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_UP_STATE","GO_DOWN_ACTION","IS_GOING_DOWN_STATE");
         stateMachine.setRule("IS_GOING_DOWN_STATE","END_ACTION","IS_STANDING_DOWN_STATE");
         stateMachine.setRule("IS_STANDING_DOWN_STATE","GO_UP_ACTION","IS_GOING_UP_STATE");
         stateMachine.setRule("IS_GOING_UP_STATE","END_ACTION","IS_STANDING_UP_STATE");
         stateMachine.setRule("IS_IN_HOLE_STATE","SHOOT_ACTION","IS_SHOOTING_STATE");
         stateMachine.setRule("IS_SHOOTING_STATE","END_ACTION","IS_IN_HOLE_STATE");
         stateMachine.setRule("IS_STANDING_UP_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_GOING_DOWN_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_STANDING_DOWN_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_GOING_UP_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_SHOOTING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_IN_HOLE_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         stateMachine.setFunctionToState("IS_STANDING_UP_STATE",this.standingUpAnimation);
         stateMachine.setFunctionToState("IS_GOING_DOWN_STATE",this.goingDownAnimation);
         stateMachine.setFunctionToState("IS_STANDING_DOWN_STATE",this.standingDownAnimation);
         stateMachine.setFunctionToState("IS_GOING_UP_STATE",this.goingUpAnimation);
         stateMachine.setFunctionToState("IS_IN_HOLE_STATE",this.inHoleAnimation);
         stateMachine.setFunctionToState("IS_SHOOTING_STATE",this.shootingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         this.shooting_counter = 0;
         if(ai_index == 0)
         {
            if(this.STARTS_FROM_TOP)
            {
               stateMachine.setState("IS_STANDING_UP_STATE");
            }
            else
            {
               stateMachine.setState("IS_STANDING_DOWN_STATE");
            }
         }
         else
         {
            if(_range == 0)
            {
               DIRECTION = ORIGINAL_DIRECTION = Entity.RIGHT;
            }
            else
            {
               DIRECTION = ORIGINAL_DIRECTION = Entity.LEFT;
            }
            stateMachine.setState("IS_IN_HOLE_STATE");
         }
         this.spider_web_base = new Image(TextureManager.sTextureAtlas.getTexture("spider_web_base"));
         Utils.topWorld.addChild(this.spider_web_base);
         this.spider_web_base.pivotX = 4;
         this.spider_web_base.pivotY = 0;
         this.spider_web_body = new Image(TextureManager.sTextureAtlas.getTexture("spider_web_body"));
         Utils.topWorld.addChild(this.spider_web_body);
         this.spider_web_body.pivotX = 2;
         this.spider_web_body.pivotY = 0;
         energy = 1;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         Utils.topWorld.removeChild(this.spider_web_base);
         this.spider_web_base.dispose();
         this.spider_web_base = null;
         Utils.topWorld.removeChild(this.spider_web_body);
         this.spider_web_body.dispose();
         this.spider_web_body = null;
         super.destroy();
      }
      
      override public function reset() : void
      {
         if(ai_index == 0)
         {
            if(this.STARTS_FROM_TOP)
            {
               stateMachine.setState("IS_STANDING_UP_STATE");
            }
            else
            {
               stateMachine.setState("IS_STANDING_DOWN_STATE");
            }
         }
         else
         {
            stateMachine.setState("IS_IN_HOLE_STATE");
         }
         xPos = originalXPos;
         yPos = originalYPos;
         xVel = yVel = 0;
         DIRECTION = ORIGINAL_DIRECTION;
         energy = 2;
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_UP_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               stateMachine.performAction("GO_DOWN_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_GOING_DOWN_STATE")
         {
            this.tween_tick += 1 / 60;
            if(this.tween_tick >= this.tween_time)
            {
               this.tween_tick = this.tween_time;
               stateMachine.performAction("END_ACTION");
            }
            oldYPos = yPos;
            yPos = Easings.easeOutQuad(this.tween_tick,this.tween_start,this.tween_diff,this.tween_time);
            xPos = originalXPos;
            xVel = 0;
         }
         else if(stateMachine.currentState == "IS_STANDING_DOWN_STATE")
         {
            xPos = originalXPos;
            xVel = 0;
            ++counter1;
            if(counter1 >= 60)
            {
               stateMachine.performAction("GO_UP_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_GOING_UP_STATE")
         {
            xPos = originalXPos;
            xVel = 0;
            this.tween_tick += 1 / 60;
            if(this.tween_tick >= this.tween_time)
            {
               this.tween_tick = this.tween_time;
               stateMachine.performAction("END_ACTION");
            }
            oldYPos = yPos;
            yPos = Easings.linear(this.tween_tick,this.tween_start,this.tween_diff,this.tween_time);
         }
         else if(stateMachine.currentState == "IS_IN_HOLE_STATE")
         {
            if(isInsideScreen())
            {
               if(Math.abs(yPos - level.hero.getMidYPos()) < Utils.HEIGHT * 0.5)
               {
                  ++this.shooting_counter;
                  if(this.shooting_counter >= 60)
                  {
                     stateMachine.performAction("SHOOT_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_SHOOTING_STATE")
         {
            if(DIRECTION == Entity.RIGHT)
            {
               ++xPos;
               if(xPos >= this.tween_start)
               {
                  xPos = this.tween_start;
               }
            }
            else
            {
               --xPos;
               if(xPos <= this.tween_start)
               {
                  xPos = this.tween_start;
               }
            }
            if(counter1++ > 30)
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
               this.spider_web_base.visible = this.spider_web_body.visible = sprite.visible;
               if(counter2 > 12)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.spider_web_base.x = int(Math.floor(originalXPos + 0 - camera.xPos));
         this.spider_web_base.y = int(Math.floor(originalYPos - 9 - camera.yPos));
         this.spider_web_body.x = int(Math.floor(originalXPos + 0 - camera.xPos));
         this.spider_web_body.y = int(Math.floor(originalYPos - 6 - camera.yPos));
         if(ai_index == 1)
         {
            this.spider_web_base.visible = this.spider_web_body.visible = false;
         }
         var __height:int = int(yPos - originalYPos - 2);
         if(__height < 0)
         {
            __height = 0;
         }
         this.spider_web_body.height = __height;
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            onTop();
         }
      }
      
      public function standingUpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xPos = originalXPos;
         yPos = originalYPos;
         counter1 = 0;
      }
      
      public function goingDownAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.tween_start = originalYPos;
         this.tween_diff = this.RANGE * Utils.TILE_HEIGHT - 8;
         this.tween_time = this.RANGE * 0.25;
         this.tween_tick = 0;
      }
      
      public function standingDownAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function goingUpAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.tween_start = yPos;
         this.tween_diff = -(yPos - originalYPos);
         this.tween_time = this.RANGE * 0.25;
         this.tween_tick = 0;
      }
      
      public function inHoleAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         if(DIRECTION == Entity.RIGHT)
         {
            sprite.rotation = -Math.PI * 0.5;
         }
         else
         {
            sprite.rotation = Math.PI * 0.5;
         }
         counter1 = 0;
         this.shooting_counter = 0;
      }
      
      public function shootingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         this.tween_start = xPos;
         if(DIRECTION == Entity.RIGHT)
         {
            xPos -= 8;
         }
         else
         {
            xPos += 8;
         }
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("enemy_shoot_sticky");
         }
         if(DIRECTION == Entity.RIGHT)
         {
            level.bulletsManager.pushBullet(new FireballBulletSprite(1),xPos + 12,yPos,1 + 0.5,0,1);
         }
         else
         {
            level.bulletsManager.pushBullet(new FireballBulletSprite(1),xPos - 12,yPos,-1 - 0.5,0,1);
         }
         counter1 = counter2 = 0;
      }
      
      public function hitAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
         xVel = yVel = 0;
      }
      
      override public function getMidXPos() : Number
      {
         return xPos;
      }
   }
}
