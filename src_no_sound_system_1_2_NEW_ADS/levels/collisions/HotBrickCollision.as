package levels.collisions
{
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.HotBigBrickCollisionSprite;
   import sprites.collisions.HotSmallBrickCollisionSprite;
   import sprites.particles.VaporParticleSprite;
   
   public class HotBrickCollision extends Collision
   {
       
      
      protected var stateMachine:StateMachine;
      
      public var IS_BIG:Boolean;
      
      protected var turn:int;
      
      protected var justOnce:Boolean;
      
      public function HotBrickCollision(_level:Level, _xPos:Number, _yPos:Number, _value:int = 0, _turn:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.turn = _turn;
         this.justOnce = true;
         this.IS_BIG = false;
         if(_value > 0)
         {
            this.IS_BIG = true;
         }
         if(this.IS_BIG)
         {
            sprite = new HotBigBrickCollisionSprite();
            aabb.x = -1;
            aabb.y = -1;
            aabb.width = 34;
            aabb.height = 34;
            WIDTH = HEIGHT = 32;
         }
         else
         {
            sprite = new HotSmallBrickCollisionSprite();
            aabb.x = -1;
            aabb.y = -1;
            aabb.width = 18;
            aabb.height = 18;
            WIDTH = HEIGHT = 16;
         }
         Utils.topWorld.addChild(sprite);
         var x_t:int = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         if(this.IS_BIG)
         {
            level.levelData.setTileValueAt(x_t,y_t,1);
            level.levelData.setTileValueAt(x_t + 1,y_t,1);
            level.levelData.setTileValueAt(x_t,y_t + 1,1);
            level.levelData.setTileValueAt(x_t + 1,y_t + 1,1);
         }
         else
         {
            level.levelData.setTileValueAt(x_t,y_t,1);
         }
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_NORMAL_STATE","TURN_ON_ACTION","IS_TURNING_ON_STATE");
         this.stateMachine.setRule("IS_TURNING_ON_STATE","END_ACTION","IS_WAITING_TO_GLOW_STATE");
         this.stateMachine.setRule("IS_WAITING_TO_GLOW_STATE","END_ACTION","IS_GLOWING_STATE");
         this.stateMachine.setRule("IS_GLOWING_STATE","END_ACTION","IS_TURNING_OFF_STATE");
         this.stateMachine.setRule("IS_TURNING_OFF_STATE","END_ACTION","IS_NORMAL_STATE");
         this.stateMachine.setRule("IS_NORMAL_STATE","END_ACTION","IS_MELTED_STATE");
         this.stateMachine.setFunctionToState("IS_NORMAL_STATE",this.normalAnimation);
         this.stateMachine.setFunctionToState("IS_TURNING_ON_STATE",this.turningOnAnimation);
         this.stateMachine.setFunctionToState("IS_WAITING_TO_GLOW_STATE",this.waitingToGlowAnimation);
         this.stateMachine.setFunctionToState("IS_GLOWING_STATE",this.glowingAnimation);
         this.stateMachine.setFunctionToState("IS_TURNING_OFF_STATE",this.turningOffAnimation);
         this.stateMachine.setFunctionToState("IS_MELTED_STATE",this.meltedAnimation);
         this.stateMachine.setState("IS_NORMAL_STATE");
      }
      
      override public function destroy() : void
      {
         this.stateMachine.destroy();
         this.stateMachine = null;
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         var max_amount:int = 0;
         var pSprite:VaporParticleSprite = null;
         super.update();
         if(this.stateMachine.currentState == "IS_NORMAL_STATE")
         {
            ++counter1;
            if(counter1 >= 120)
            {
               this.stateMachine.performAction("TURN_ON_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_TURNING_ON_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_WAITING_TO_GLOW_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_GLOWING_STATE")
         {
            ++counter1;
            if(counter1 >= 120)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_TURNING_OFF_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_MELTED_STATE")
         {
            if(this.IS_BIG)
            {
               max_amount = 3;
            }
            else
            {
               max_amount = 2;
            }
            if(counter2 < max_amount)
            {
               if(counter3-- < 0)
               {
                  counter3 = Math.random() * 10 + 10;
                  pSprite = new VaporParticleSprite();
                  ++counter2;
                  if(Math.random() * 100 > 50)
                  {
                     pSprite.gfxHandleClip().gotoAndStop(1);
                  }
                  else
                  {
                     pSprite.gfxHandleClip().gotoAndStop(2);
                  }
                  if(this.IS_BIG)
                  {
                     level.topParticlesManager.pushParticle(pSprite,xPos + Math.random() * 32,yPos + Math.random() * 32,0,0,1,Math.random() * (Math.PI * 2));
                  }
                  else
                  {
                     level.topParticlesManager.pushParticle(pSprite,xPos + Math.random() * 16,yPos + Math.random() * 16,0,0,1,Math.random() * (Math.PI * 2));
                  }
               }
            }
         }
      }
      
      override public function reset() : void
      {
         if(this.stateMachine.currentState != "IS_MELTED_STATE")
         {
            this.stateMachine.setState("IS_NORMAL_STATE");
         }
      }
      
      public function clearTileValue() : void
      {
         var x_t:int = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         if(this.IS_BIG)
         {
            level.levelData.setTileValueAt(x_t,y_t,0);
            level.levelData.setTileValueAt(x_t + 1,y_t,0);
            level.levelData.setTileValueAt(x_t,y_t + 1,0);
            level.levelData.setTileValueAt(x_t + 1,y_t + 1,0);
         }
         else
         {
            level.levelData.setTileValueAt(x_t,y_t,0);
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(this.stateMachine.currentState != "IS_GLOWING_STATE")
         {
            return;
         }
         var hero_aabb:Rectangle = level.hero.getAABB();
         var brick_aabb:Rectangle = getAABB();
         if(hero_aabb.intersects(brick_aabb))
         {
            level.hero.hurt(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,null);
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         sprite.updateScreenPosition();
      }
      
      protected function normalAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndStop(1);
         if(this.justOnce)
         {
            this.justOnce = false;
            if(this.turn == 0)
            {
               counter1 = 0;
            }
            else
            {
               counter1 = -130;
            }
         }
         else
         {
            counter1 = 0;
         }
      }
      
      protected function turningOnAnimation() : void
      {
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function waitingToGlowAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndStop(1);
         counter1 = 0;
      }
      
      protected function glowingAnimation() : void
      {
         sprite.gotoAndStop(3);
         sprite.gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      protected function turningOffAnimation() : void
      {
         sprite.gotoAndStop(4);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function meltedAnimation() : void
      {
         sprite.gotoAndStop(5);
         sprite.gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
      }
      
      override public function getMidXPos() : Number
      {
         if(this.IS_BIG)
         {
            return xPos + 16;
         }
         return xPos + 8;
      }
      
      override public function getMidYPos() : Number
      {
         if(this.IS_BIG)
         {
            return yPos + 16;
         }
         return yPos + 8;
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var area:Rectangle = null;
         if(this.IS_BIG)
         {
            area = new Rectangle(xPos,yPos,32,32);
         }
         else
         {
            area = new Rectangle(xPos,yPos,16,16);
         }
         var camera:Rectangle = new Rectangle(level.camera.xPos + 16,level.camera.yPos + 16,level.camera.WIDTH - 32,level.camera.HEIGHT - 32);
         if(area.intersects(camera))
         {
            return true;
         }
         return false;
      }
      
      public function melt() : void
      {
         if(!IS_MELTING)
         {
            IS_MELTING = true;
            SoundSystem.PlaySound("fire_freeze");
            this.stateMachine.setState("IS_MELTED_STATE");
         }
      }
   }
}
