package levels.collisions
{
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.bullets.SnowballFloatingBulletSprite;
   import sprites.collisions.CannonCollisionSprite;
   
   public class CannonCollision extends Collision
   {
       
      
      protected var ai_index:int;
      
      protected var shoot_index:int;
      
      protected var flip_x:int;
      
      protected var flip_y:int;
      
      public var stateMachine:StateMachine;
      
      public function CannonCollision(_level:Level, _xPos:Number, _yPos:Number, _flip_x:int, _flip_y:int, _ai:int)
      {
         super(_level,_xPos,_yPos);
         this.ai_index = _ai;
         this.shoot_index = 0;
         this.flip_x = _flip_x;
         this.flip_y = _flip_y;
         WIDTH = HEIGHT = 16;
         sprite = new CannonCollisionSprite();
         Utils.topWorld.addChild(sprite);
         if(_flip_y > 0)
         {
            sprite.scaleY = -1;
         }
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_STANDING_SX_STATE","TURN_ACTION","IS_TURNING_DX_STATE");
         this.stateMachine.setRule("IS_TURNING_DX_STATE","END_ACTION","IS_STANDING_DX_STATE");
         this.stateMachine.setRule("IS_STANDING_DX_STATE","TURN_ACTION","IS_TURNING_SX_STATE");
         this.stateMachine.setRule("IS_TURNING_SX_STATE","END_ACTION","IS_STANDING_SX_STATE");
         this.stateMachine.setRule("IS_STANDING_SX_STATE","SHOOT_ACTION","IS_SHOOTING_SX_STATE");
         this.stateMachine.setRule("IS_SHOOTING_SX_STATE","END_ACTION","IS_STANDING_SX_STATE");
         this.stateMachine.setRule("IS_STANDING_DX_STATE","SHOOT_ACTION","IS_SHOOTING_DX_STATE");
         this.stateMachine.setRule("IS_SHOOTING_DX_STATE","END_ACTION","IS_STANDING_DX_STATE");
         this.stateMachine.setRule("IS_SHOOTING_SX_STATE","TURN_ACTION","IS_TURNING_DX_STATE");
         this.stateMachine.setRule("IS_SHOOTING_DX_STATE","TURN_ACTION","IS_TURNING_SX_STATE");
         this.stateMachine.setFunctionToState("IS_STANDING_SX_STATE",this.standingSxState);
         this.stateMachine.setFunctionToState("IS_STANDING_DX_STATE",this.standingDxState);
         this.stateMachine.setFunctionToState("IS_TURNING_DX_STATE",this.turningDxState);
         this.stateMachine.setFunctionToState("IS_TURNING_SX_STATE",this.turningSxState);
         this.stateMachine.setFunctionToState("IS_SHOOTING_SX_STATE",this.shootingSxState);
         this.stateMachine.setFunctionToState("IS_SHOOTING_DX_STATE",this.shootingDxState);
         if(_flip_x > 0)
         {
            this.stateMachine.setState("IS_STANDING_DX_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_STANDING_SX_STATE");
         }
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.stateMachine.currentState == "IS_STANDING_DX_STATE")
         {
            if(counter1++ > 120)
            {
               this.stateMachine.performAction("SHOOT_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_STANDING_SX_STATE")
         {
            if(counter1++ > 120)
            {
               this.stateMachine.performAction("SHOOT_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_TURNING_DX_STATE" || this.stateMachine.currentState == "IS_TURNING_SX_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_SHOOTING_DX_STATE" || this.stateMachine.currentState == "IS_SHOOTING_SX_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               if(this.ai_index == 0)
               {
                  this.stateMachine.performAction("TURN_ACTION");
               }
               else
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
      
      protected function standingSxState() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      protected function standingDxState() : void
      {
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      protected function turningDxState() : void
      {
         sprite.gotoAndStop(3);
         sprite.gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      protected function turningSxState() : void
      {
         sprite.gotoAndStop(4);
         sprite.gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
      }
      
      protected function shootingSxState() : void
      {
         sprite.gotoAndStop(5);
         sprite.gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         if(isInsideInnerScreen())
         {
            SoundSystem.PlaySound("snow_cannon");
         }
         if(this.flip_y > 0)
         {
            level.bulletsManager.pushBackBullet(new SnowballFloatingBulletSprite(),xPos - 16,yPos - 8,-1.5,0,1);
         }
         else
         {
            level.bulletsManager.pushBackBullet(new SnowballFloatingBulletSprite(),xPos - 16,yPos + 8,-1.5,0,1);
         }
      }
      
      protected function shootingDxState() : void
      {
         sprite.gotoAndStop(6);
         sprite.gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         if(isInsideInnerScreen())
         {
            SoundSystem.PlaySound("snow_cannon");
         }
         if(this.flip_y > 0)
         {
            level.bulletsManager.pushBackBullet(new SnowballFloatingBulletSprite(),xPos + 16,yPos - 8,1.5,0,1);
         }
         else
         {
            level.bulletsManager.pushBackBullet(new SnowballFloatingBulletSprite(),xPos + 16,yPos + 8,1.5,0,1);
         }
      }
   }
}
