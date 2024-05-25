package levels.collisions
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.particles.GenericParticleSprite;
   import starling.display.Image;
   
   public class HoneyCollision extends Collision
   {
       
      
      public var entity:Entity;
      
      protected var honeyImage:Image;
      
      protected var time_alive:int;
      
      protected var IS_INTERSECTING:Boolean;
      
      public function HoneyCollision(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos + 1,_yPos - 8);
         this.honeyImage = new Image(TextureManager.sTextureAtlas.getTexture("honeyCollision"));
         this.honeyImage.touchable = false;
         Utils.topWorld.addChild(this.honeyImage);
         WIDTH = 12;
         HEIGHT = 9;
         this.time_alive = 0;
         this.IS_INTERSECTING = false;
         aabb.x = 0;
         aabb.y = 0;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         this.entity = null;
      }
      
      override public function destroy() : void
      {
         this.entity = null;
         Utils.topWorld.removeChild(this.honeyImage);
         this.honeyImage.dispose();
         this.honeyImage = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(level.hero.stateMachine.currentState != "IS_GLUED_STATE")
         {
            ++this.time_alive;
         }
         if(this.time_alive >= 120)
         {
            this.time_alive = 120;
            if(this.IS_INTERSECTING == false)
            {
               dead = true;
               level.topParticlesManager.pushParticle(new GenericParticleSprite(0),xPos + 2,yPos + 1,0,0,0);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(this.time_alive < 15)
         {
            return;
         }
         var heroAABB:Rectangle = new Rectangle(level.hero.xPos + level.hero.aabbPhysics.x,level.hero.yPos + level.hero.aabbPhysics.y,level.hero.aabbPhysics.width,level.hero.aabbPhysics.height);
         var thisAABB:Rectangle = getAABB();
         if(level.hero.stateMachine.currentState != "IS_GLUED_STATE")
         {
            if(heroAABB.intersects(thisAABB))
            {
               level.hero.setGlued();
            }
         }
         if(heroAABB.intersects(thisAABB))
         {
            this.IS_INTERSECTING = true;
         }
         else
         {
            this.IS_INTERSECTING = false;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.honeyImage.x = int(Math.floor(xPos - camera.xPos));
         this.honeyImage.y = int(Math.floor(yPos - camera.yPos));
      }
   }
}
