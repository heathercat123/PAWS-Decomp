package entities.enemies
{
   import entities.Hero;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.enemies.LizardBossEnemySprite;
   import starling.display.Quad;
   
   public class GiantLizardEnemy extends GiantEnemy
   {
       
      
      protected var quad:Quad;
      
      public function GiantLizardEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _ai:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         ai_index = _ai;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         sprite = new LizardBossEnemySprite();
         Utils.world.addChild(sprite);
         aabb.x = -4;
         aabb.y = 4;
         aabb.width = 40;
         aabb.height = 24;
         aabbPhysics.x = 0;
         aabbPhysics.y = 0;
         aabbPhysics.width = 32;
         aabbPhysics.height = 32;
         this.quad = new Quad(10,10,16711680);
         this.quad.alpha = 0.5;
         Utils.world.addChild(this.quad);
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         energy = 1;
      }
      
      override public function reset() : void
      {
         super.reset();
      }
      
      override public function update() : void
      {
         integratePositionAndCollisionDetection();
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         if(DebugInputPanel.getInstance().c1 > 0)
         {
            DIRECTION = LEFT;
         }
         else
         {
            DIRECTION = RIGHT;
         }
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
         this.quad.x = sprite.x + aabbPhysics.x;
         this.quad.y = sprite.y + aabbPhysics.y;
         this.quad.width = aabbPhysics.width;
         this.quad.height = aabbPhysics.height;
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
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
