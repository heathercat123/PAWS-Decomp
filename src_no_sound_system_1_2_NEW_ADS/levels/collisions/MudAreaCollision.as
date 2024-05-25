package levels.collisions
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.particles.MudSurfaceBubbleParticleSprite;
   
   public class MudAreaCollision extends Collision
   {
       
      
      public var entity:Entity;
      
      protected var bubbleCounter:int;
      
      protected var segments:int;
      
      protected var last_segment:int;
      
      protected var type:int;
      
      public function MudAreaCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _type:int = 0)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         aabb.x = 0;
         aabb.y = 0;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         this.type = _type;
         this.bubbleCounter = int(Math.random() * 4) * 60;
         this.segments = WIDTH / Utils.TILE_WIDTH - 1;
         this.last_segment = 0;
         this.entity = null;
      }
      
      override public function destroy() : void
      {
         this.entity = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var new_segment:int = 0;
         if(WIDTH <= 32)
         {
            return;
         }
         if(this.type == 0)
         {
            if(yPos <= level.camera.yPos + level.camera.HEIGHT)
            {
               if(this.bubbleCounter-- < 0)
               {
                  do
                  {
                     new_segment = int(Math.random() * this.segments);
                  }
                  while(new_segment == this.last_segment);
                  
                  this.last_segment = new_segment;
                  this.bubbleCounter = (int(Math.random() * 1) + 1) * 60;
                  level.topParticlesManager.pushParticle(new MudSurfaceBubbleParticleSprite(),xPos + (new_segment + 1) * 16,yPos + 1,0,0,0,yPos);
               }
            }
         }
         else if(this.type == 1)
         {
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var heroAABB:Rectangle = new Rectangle(level.hero.xPos + level.hero.aabbPhysics.x,level.hero.yPos + level.hero.aabbPhysics.y,level.hero.aabbPhysics.width,level.hero.aabbPhysics.height);
         var thisAABB:Rectangle = getAABB();
         if(level.hero.IS_IN_MUD)
         {
            if(!heroAABB.intersects(thisAABB))
            {
               if(this.entity != null)
               {
                  level.hero.setOutsideMud();
                  this.entity = null;
               }
            }
         }
         else if(heroAABB.intersects(thisAABB))
         {
            if(this.type == 0)
            {
               SoundSystem.PlaySound("mud");
            }
            else if(this.type == 1)
            {
               SoundSystem.PlaySound("snow_bullet_impact");
            }
            level.hero.setOnMud(this,this.type);
            this.entity = level.hero;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
      }
   }
}
