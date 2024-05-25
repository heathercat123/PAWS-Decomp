package levels.collisions
{
   import entities.Entity;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.particles.GenericParticleSprite;
   import sprites.particles.GreenLeafBackgroundParticleSprite;
   
   public class NoRunAreaCollision extends Collision
   {
       
      
      public var TYPE:int;
      
      public var entity:Entity;
      
      protected var walk_counter:int;
      
      public function NoRunAreaCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _type:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         WIDTH = _width;
         HEIGHT = _height;
         this.walk_counter = 0;
         aabb.x = 0;
         aabb.y = 0;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         this.entity = null;
      }
      
      override public function destroy() : void
      {
         this.entity = null;
         super.destroy();
      }
      
      override public function update() : void
      {
      }
      
      override public function checkEntitiesCollision() : void
      {
         var heroAABB:Rectangle = new Rectangle(level.hero.xPos + level.hero.aabbPhysics.x,level.hero.yPos + level.hero.aabbPhysics.y,level.hero.aabbPhysics.width,level.hero.aabbPhysics.height);
         var thisAABB:Rectangle = getAABB();
         if(level.hero.IS_RUN_ALLOWED == false)
         {
            if(heroAABB.intersects(thisAABB))
            {
               if(level.hero.stateMachine.currentState == "IS_WALKING_STATE")
               {
                  if(this.walk_counter-- < 0)
                  {
                     this.walk_counter = 6;
                     this.createParticles(true);
                  }
               }
            }
            else if(this.entity != null)
            {
               level.hero.IS_RUN_ALLOWED = true;
               this.entity = null;
            }
         }
         else if(heroAABB.intersects(thisAABB))
         {
            level.hero.IS_RUN_ALLOWED = false;
            this.entity = level.hero;
            this.createParticles();
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
      }
      
      protected function createParticles(_is_small_amount:Boolean = false) : void
      {
         var i:int = 0;
         var pSprite:GenericParticleSprite = null;
         var amount:int = int(Math.random() * 3 + 2);
         if(_is_small_amount)
         {
            amount = 1;
         }
         for(i = 0; i < amount; i++)
         {
            if(this.TYPE == 0)
            {
               level.particlesManager.pushParticle(new GreenLeafBackgroundParticleSprite(),level.hero.getMidXPos() + Math.random() * 8 - 4,level.hero.yPos + 8 - Math.random() * 16,0,-2,0.8,Math.random() * Math.PI * 2,0.5 * int(Math.random() * 3),0,Math.random() * 16);
            }
            else
            {
               pSprite = new GenericParticleSprite(GenericParticleSprite.SAND_BEACH);
               if(Math.random() * 100 > 50)
               {
                  pSprite.gfxHandleClip().gotoAndStop(1);
               }
               else
               {
                  pSprite.gfxHandleClip().gotoAndStop(2);
               }
               level.particlesManager.pushParticle(pSprite,level.hero.getMidXPos() + Math.random() * 8 - 4,level.hero.yPos + 8 - Math.random() * 16,0,-2,0.8,Math.random() * Math.PI * 2,0.5 * int(Math.random() * 3),0,16);
            }
         }
      }
   }
}
