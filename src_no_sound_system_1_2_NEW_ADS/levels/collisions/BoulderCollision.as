package levels.collisions
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.GenericCollisionSprite;
   
   public class BoulderCollision extends Collision
   {
       
      
      protected var IS_A:Boolean;
      
      protected var PERIOD:int;
      
      protected var AI:int;
      
      public function BoulderCollision(_level:Level, _xPos:Number, _yPos:Number, _isA:int = 0, _period:int = 0, _ai:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.AI = _ai;
         sprite = new GenericCollisionSprite(3);
         Utils.world.addChild(sprite);
         if(_period == 0)
         {
            this.PERIOD = 240;
         }
         else
         {
            this.PERIOD = _period;
         }
         if(_isA > 0)
         {
            this.IS_A = true;
            counter1 = this.PERIOD * 0.5;
         }
         else
         {
            this.IS_A = false;
            counter1 = this.PERIOD;
         }
         aabb.x = -1;
         aabb.y = -1;
         aabb.width = 0;
         aabb.height = 0;
      }
      
      override public function update() : void
      {
         super.update();
         if(this.AI == 0)
         {
            ++counter1;
            if(counter1 >= this.PERIOD)
            {
               counter1 = 0;
               level.bulletsManager.createBoulder(xPos,yPos);
            }
         }
         else if(this.AI == 1)
         {
            if(level.hero.xPos >= this.PERIOD)
            {
               this.AI = 2;
               level.bulletsManager.createBoulder(xPos,yPos,1,Entity.RIGHT);
               sprite.visible = false;
            }
         }
      }
      
      override public function reset() : void
      {
         super.reset();
         if(this.IS_A)
         {
            counter1 = this.PERIOD * 0.5;
         }
         else
         {
            counter1 = this.PERIOD;
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var area:Rectangle = null;
         area = new Rectangle(xPos,yPos,32,32);
         var camera:Rectangle = new Rectangle(level.camera.xPos + 16,level.camera.yPos + 16,level.camera.WIDTH - 32,level.camera.HEIGHT - 32);
         if(area.intersects(camera))
         {
            return true;
         }
         return false;
      }
   }
}
