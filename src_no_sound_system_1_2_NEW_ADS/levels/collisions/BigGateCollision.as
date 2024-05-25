package levels.collisions
{
   import entities.Entity;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.BigGateCollisionSprite;
   
   public class BigGateCollision extends Collision
   {
       
      
      protected var topGateSprite:BigGateCollisionSprite;
      
      protected var bottomGateSprite:BigGateCollisionSprite;
      
      public var stateMachine:StateMachine;
      
      protected var gate_diff_y:int;
      
      protected var amount:int;
      
      protected var current_amount:int;
      
      public var ID:int;
      
      public function BigGateCollision(_level:Level, _xPos:Number, _yPos:Number, _id:int, _amount:int)
      {
         super(_level,_xPos,_yPos);
         this.ID = _id;
         this.amount = _amount;
         this.current_amount = 0;
         WIDTH = 32;
         HEIGHT = 48;
         aabb.x = -16;
         aabb.y = 0;
         aabb.width = 64;
         aabb.height = 32;
         this.gate_diff_y = 0;
         this.topGateSprite = new BigGateCollisionSprite();
         Utils.topWorld.addChild(this.topGateSprite);
         this.bottomGateSprite = new BigGateCollisionSprite();
         Utils.topWorld.addChild(this.bottomGateSprite);
         this.bottomGateSprite.scaleY = -1;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_CLOSED_STATE","OPEN_ACTION","IS_OPENING_STATE");
         this.stateMachine.setRule("IS_OPENING_STATE","END_ACTION","IS_OPEN_STATE");
         this.stateMachine.setRule("IS_OPEN_STATE","CLOSE_ACTION","IS_CLOSING_STATE");
         this.stateMachine.setRule("IS_CLOSING_STATE","END_ACTION","IS_CLOSED_STATE");
         this.stateMachine.setFunctionToState("IS_CLOSED_STATE",this.closedAnimation);
         this.stateMachine.setFunctionToState("IS_OPENING_STATE",this.openingAnimation);
         this.stateMachine.setFunctionToState("IS_OPEN_STATE",this.openAnimation);
         this.stateMachine.setFunctionToState("IS_CLOSING_STATE",this.closingAnimation);
         this.stateMachine.setState("IS_CLOSED_STATE");
      }
      
      override public function destroy() : void
      {
         this.stateMachine.destroy();
         this.stateMachine = null;
         Utils.topWorld.removeChild(this.bottomGateSprite);
         this.bottomGateSprite.destroy();
         this.bottomGateSprite.dispose();
         this.bottomGateSprite = null;
         Utils.topWorld.removeChild(this.topGateSprite);
         this.topGateSprite.destroy();
         this.topGateSprite.dispose();
         this.topGateSprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.stateMachine.currentState != "IS_CLOSED_STATE")
         {
            if(this.stateMachine.currentState == "IS_OPENING_STATE")
            {
               this.gate_diff_y += 6;
               if(this.gate_diff_y >= 24)
               {
                  this.gate_diff_y = 24;
                  level.camera.shake(2);
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.stateMachine.currentState != "IS_OPEN_STATE")
            {
               if(this.stateMachine.currentState == "IS_CLOSING_STATE")
               {
                  this.gate_diff_y -= 6;
                  if(this.gate_diff_y <= 0)
                  {
                     this.gate_diff_y = 0;
                     level.camera.shake(2);
                     level.topParticlesManager.createDust(xPos + WIDTH * 0.25,yPos + HEIGHT * 0.5,Entity.LEFT);
                     level.topParticlesManager.createDust(xPos + WIDTH * 0.75,yPos + HEIGHT * 0.5,Entity.RIGHT);
                     this.stateMachine.performAction("END_ACTION");
                  }
               }
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
      }
      
      public function openDoor() : void
      {
         ++this.current_amount;
         if(this.current_amount >= this.amount)
         {
            level.collisionsManager.lockLevers(this.ID);
            this.stateMachine.performAction("OPEN_ACTION");
            SoundSystem.PlaySound("gate");
         }
      }
      
      public function closeDoor() : void
      {
         --this.current_amount;
         if(this.current_amount < this.amount)
         {
            SoundSystem.PlaySound("gate");
            this.stateMachine.performAction("CLOSE_ACTION");
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.topGateSprite.x = int(Math.floor(xPos + WIDTH * 0.5 - camera.xPos));
         this.topGateSprite.y = int(Math.floor(yPos - this.gate_diff_y + HEIGHT * 0.5 - camera.yPos));
         this.bottomGateSprite.x = int(Math.floor(xPos + WIDTH * 0.5 - camera.xPos));
         this.bottomGateSprite.y = int(Math.floor(yPos + this.gate_diff_y + HEIGHT * 0.5 - camera.yPos));
         Utils.topWorld.setChildIndex(this.topGateSprite,0);
         Utils.topWorld.setChildIndex(this.bottomGateSprite,0);
      }
      
      protected function setLocked() : void
      {
         var x_t:int = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         level.levelData.setTileValueAt(x_t,y_t,11);
         level.levelData.setTileValueAt(x_t,y_t + 1,11);
         level.levelData.setTileValueAt(x_t + 1,y_t,11);
         level.levelData.setTileValueAt(x_t + 1,y_t + 1,11);
         level.levelData.setTileValueAt(x_t,y_t + 2,11);
         level.levelData.setTileValueAt(x_t + 1,y_t + 2,11);
      }
      
      protected function setUnlocked() : void
      {
         var x_t:int = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         level.levelData.setTileValueAt(x_t,y_t,0);
         level.levelData.setTileValueAt(x_t,y_t + 1,0);
         level.levelData.setTileValueAt(x_t + 1,y_t,0);
         level.levelData.setTileValueAt(x_t + 1,y_t + 1,0);
         level.levelData.setTileValueAt(x_t,y_t + 2,0);
         level.levelData.setTileValueAt(x_t + 1,y_t + 2,0);
      }
      
      protected function closedAnimation() : void
      {
         this.setLocked();
      }
      
      protected function openingAnimation() : void
      {
         this.gate_diff_y = 0;
      }
      
      protected function openAnimation() : void
      {
         this.setUnlocked();
      }
      
      protected function closingAnimation() : void
      {
         this.gate_diff_y = 16;
      }
   }
}
