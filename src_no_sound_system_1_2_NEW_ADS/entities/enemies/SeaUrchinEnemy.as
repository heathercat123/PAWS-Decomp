package entities.enemies
{
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.FirePlantBulletSprite;
   import sprites.enemies.SeaUrchinEnemySprite;
   
   public class SeaUrchinEnemy extends Enemy
   {
       
      
      protected var TYPE:int;
      
      protected var isTopDown:Boolean;
      
      protected var flip_y:Boolean;
      
      protected var IS_WALL:Boolean;
      
      protected var attack_counter:int;
      
      protected var SHOOTING_ANGLE:Number;
      
      public function SeaUrchinEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _upsideDown:int, _ai_index:int, type:int = 0, _flip_y:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_ai_index);
         this.TYPE = type;
         WIDTH = HEIGHT = 0;
         this.attack_counter = 0;
         if(this.TYPE == 0)
         {
            if(_direction == 1)
            {
               this.IS_WALL = true;
            }
            else
            {
               this.IS_WALL = false;
            }
            speed = 0.8;
            this.isTopDown = _upsideDown == 1 ? true : false;
            sprite = new SeaUrchinEnemySprite(this.TYPE);
            Utils.topWorld.addChild(sprite);
            if(this.IS_WALL)
            {
               sprite.rotation = 0.5 * Math.PI;
               this.isTopDown = _upsideDown == 1 ? false : true;
            }
            aabbPhysics.y = 3;
            aabbPhysics.height = 10;
            if(this.IS_WALL)
            {
               aabb.y = -6;
               aabb.x = -10;
               aabb.height = 12;
               aabb.width = 19;
            }
            else
            {
               aabb.x = -6.5;
               aabb.y = -9.5;
               aabb.width = 12;
               aabb.height = 19;
            }
         }
         else if(this.TYPE == 1)
         {
            aabb.x = -8;
            aabb.y = -5;
            aabb.width = 16;
            aabb.height = 10;
            sprite = new SeaUrchinEnemySprite(this.TYPE);
            Utils.topWorld.addChild(sprite);
            this.isTopDown = _upsideDown == 1 ? true : false;
            if(ai_index == 1)
            {
               sprite.rotation = Math.PI * 0.5;
               aabb.x = -5;
               aabb.y = -8;
               aabb.width = 10;
               aabb.height = 16;
            }
            if(ai_index == 0)
            {
               if(this.isTopDown)
               {
                  originalYPos -= 3;
                  yPos -= 3;
                  sprite.scaleY = -1;
                  this.SHOOTING_ANGLE = 0;
               }
               else
               {
                  originalYPos += 3;
                  yPos += 3;
                  this.SHOOTING_ANGLE = Math.PI;
               }
            }
            else if(ai_index == 1)
            {
               if(this.isTopDown)
               {
                  originalXPos -= 3;
                  xPos -= 3;
                  this.SHOOTING_ANGLE = Math.PI * 0.5;
               }
               else
               {
                  originalXPos += 3;
                  xPos += 3;
                  sprite.scaleY = -1;
                  this.SHOOTING_ANGLE = -Math.PI * 0.5;
               }
            }
         }
         else if(this.TYPE == 2)
         {
            aabb.x = -8;
            aabb.y = -5;
            aabb.width = 16;
            aabb.height = 10;
            sprite = new SeaUrchinEnemySprite(this.TYPE);
            Utils.topWorld.addChild(sprite);
            if(_upsideDown > 0)
            {
               sprite.gfxHandle().scaleX = -1;
               xPos -= 3;
               originalXPos -= 3;
            }
            else
            {
               xPos += 3;
               originalXPos += 3;
            }
            if(_flip_y > 0)
            {
               sprite.gfxHandle().scaleY = -1;
               yPos -= 3;
               originalYPos -= 3;
            }
            else
            {
               yPos += 3;
               originalYPos += 3;
            }
            if(_upsideDown < 1 && _flip_y < 1)
            {
               this.SHOOTING_ANGLE = -Math.PI * 0.75;
            }
            else if(_upsideDown > 0 && _flip_y < 1)
            {
               this.SHOOTING_ANGLE = Math.PI * 0.75;
            }
            else if(_upsideDown < 1 && _flip_y > 0)
            {
               this.SHOOTING_ANGLE = -Math.PI * 0.25;
            }
            else if(_upsideDown > 0 && _flip_y > 0)
            {
               this.SHOOTING_ANGLE = Math.PI * 0.25;
            }
            this.isTopDown = _upsideDown == 1 ? true : false;
            this.flip_y = _flip_y == 1 ? true : false;
         }
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_DEAD_STATE");
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            stateMachine.setRule("IS_STANDING_STATE","ATTACK_ACTION","IS_ATTACKING_STATE");
            stateMachine.setRule("IS_ATTACKING_STATE","END_ACTION","IS_STANDING_STATE");
            stateMachine.setRule("IS_ATTACKING_STATE","HIT_ACTION","IS_HIT_STATE");
         }
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackAnimation);
         }
         stateMachine.setFunctionToState("IS_DEAD_STATE",deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 4;
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var x_diff:Number = NaN;
         var y_diff:Number = NaN;
         var dist:Number = NaN;
         super.update();
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            if(stateMachine.currentState == "IS_STANDING_STATE")
            {
               if(this.attack_counter-- <= 0)
               {
                  x_diff = level.hero.getMidXPos() - (xPos + Math.sin(this.SHOOTING_ANGLE) * 40);
                  y_diff = level.hero.getMidYPos() - (yPos + Math.cos(this.SHOOTING_ANGLE) * 40);
                  dist = x_diff * x_diff + y_diff * y_diff;
                  if(dist <= 64 * 64)
                  {
                     stateMachine.performAction("ATTACK_ACTION");
                  }
               }
            }
            else if(stateMachine.currentState == "IS_ATTACKING_STATE")
            {
               if(sprite.gfxHandle().gfxHandleClip().isComplete)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(this.TYPE == 0)
         {
            if(this.isTopDown)
            {
               sprite.gfxHandle().scaleY = -1;
            }
            else
            {
               sprite.gfxHandle().scaleY = 1;
            }
         }
         else if(this.TYPE == 2)
         {
            if(this.isTopDown)
            {
               sprite.gfxHandle().scaleX = -1;
            }
            if(this.flip_y)
            {
               sprite.gfxHandle().scaleY = -1;
            }
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            this.onTop();
         }
      }
      
      override public function onTop() : void
      {
         Utils.topWorld.setChildIndex(sprite,Utils.world.numChildren - 1);
      }
      
      public function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         if(ai_index == 0)
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         else
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(2);
         }
         counter1 = 0;
      }
      
      override protected function allowCatAttack() : Boolean
      {
         return false;
      }
      
      public function hitAnimation() : void
      {
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            sprite.gfxHandle().gotoAndStop(3);
         }
         else
         {
            sprite.gfxHandle().gotoAndStop(2);
         }
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         setHitVariables();
         counter1 = counter2 = 0;
      }
      
      public function attackAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         SoundSystem.PlaySound("fire_ball");
         level.bulletsManager.pushBullet(new FirePlantBulletSprite(),xPos,yPos,Math.sin(this.SHOOTING_ANGLE) * 1,Math.cos(this.SHOOTING_ANGLE) * 1,1,0,0,0,1);
         this.attack_counter = 120;
         counter1 = counter2 = 0;
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
