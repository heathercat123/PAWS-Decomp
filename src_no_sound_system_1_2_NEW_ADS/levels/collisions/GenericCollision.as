package levels.collisions
{
   import flash.geom.*;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.GenericCollisionSprite;
   import sprites.tutorials.*;
   
   public class GenericCollision extends Collision
   {
      
      public static var LIFT:int = 100;
      
      public static var PUMPKIN:int = 101;
       
      
      protected var ID:int;
      
      protected var IS_TOP_WORLD:Boolean;
      
      protected var param_1:int;
      
      protected var IS_ON:Boolean;
      
      public function GenericCollision(_level:Level, _xPos:Number, _yPos:Number, _id:int = 100, _param:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.ID = _id;
         this.IS_TOP_WORLD = false;
         this.param_1 = _param;
         this.IS_ON = false;
         sprite = new GenericCollisionSprite(this.ID);
         if(this.ID == 100)
         {
            Utils.topWorld.addChild(sprite);
            this.IS_TOP_WORLD = true;
         }
         else
         {
            Utils.world.addChild(sprite);
         }
         if(this.ID == GenericCollision.PUMPKIN)
         {
            aabb.x = 1;
            aabb.width = 20;
            aabb.height = 16;
            if((Utils.Slot.gameProgression[20] >> this.param_1 & 1) == 0)
            {
               sprite.gotoAndStop(1);
               this.IS_ON = false;
            }
            else
            {
               sprite.gotoAndStop(2);
               this.IS_ON = true;
            }
         }
      }
      
      override public function destroy() : void
      {
         if(this.IS_TOP_WORLD)
         {
            Utils.topWorld.removeChild(sprite);
         }
         else
         {
            Utils.world.removeChild(sprite);
         }
         super.destroy();
      }
      
      override public function update() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(this.ID == GenericCollision.PUMPKIN && this.IS_ON == false)
         {
            if(level.hero.getAABB().intersects(getAABB()))
            {
               SoundSystem.PlaySound("fire_dragon_shoot");
               Utils.Slot.gameProgression[20] |= 1 << this.param_1;
               SaveManager.SaveGameProgression();
               this.IS_ON = true;
               sprite.gotoAndStop(2);
               trace("PUMPKIN_ON");
            }
         }
      }
   }
}
