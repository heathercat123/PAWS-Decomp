package levels.collisions
{
   import flash.geom.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   
   public class ExitCollision extends Collision
   {
       
      
      public var DOOR_ID:int;
      
      public var IS_SX_EXIT:Boolean;
      
      public var IS_SNOW:Boolean;
      
      protected var EXIT_FLAG:Boolean;
      
      public var NOT_A_DOOR:Boolean;
      
      public var EXIT_TYPE:int;
      
      public function ExitCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos);
         this.EXIT_TYPE = 0;
         this.NOT_A_DOOR = false;
         this.EXIT_FLAG = false;
         this.IS_SNOW = false;
      }
      
      protected function initDoorId() : void
      {
         this.DOOR_ID = level.scriptsManager.getIntersectingNumberId(xPos + aabb.x - 16,yPos + aabb.y,aabb.width + 16,aabb.height);
      }
      
      protected function initWeatherId() : void
      {
         var WEATHER_ID:int = level.scriptsManager.getIntersectingWeatherId(xPos + aabb.x - 16,yPos + aabb.y,aabb.width + 16,aabb.height);
         if(WEATHER_ID == 1)
         {
            this.IS_SNOW = true;
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(this.EXIT_FLAG)
         {
            return;
         }
         if(level.stateMachine.currentState == "IS_CUTSCENE_STATE")
         {
            return;
         }
         var aabb_1:Rectangle = level.hero.getAABB();
         var aabb_2:Rectangle = getAABB();
         if(aabb_1.intersects(aabb_2))
         {
            this.EXIT_FLAG = true;
            Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = this.DOOR_ID;
            this.exitSound();
            level.exit();
         }
      }
      
      protected function exitSound() : void
      {
      }
      
      public function startOutroCutscene() : void
      {
      }
      
      public function endOutroCutscene() : void
      {
      }
      
      public function startIntroCutscene() : void
      {
      }
      
      public function endIntroCutscene() : void
      {
      }
      
      override public function getMidXPos() : Number
      {
         return xPos + aabb.x + aabb.width * 0.5;
      }
      
      override public function getMidYPos() : Number
      {
         return yPos + aabb.y + aabb.height * 0.5;
      }
   }
}
