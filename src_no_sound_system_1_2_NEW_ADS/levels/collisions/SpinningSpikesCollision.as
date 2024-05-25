package levels.collisions
{
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.GenericCollisionSprite;
   
   public class SpinningSpikesCollision extends Collision
   {
       
      
      protected var spikeSprite:GenericCollisionSprite;
      
      protected var frame_spikes:int;
      
      protected var frame_block:int;
      
      protected var speed:int;
      
      protected var original_frame:int;
      
      protected var IS_DOUBLE_SPIKED:Boolean;
      
      public function SpinningSpikesCollision(_level:Level, _xPos:Number, _yPos:Number, _frame:int = 0, _type:int = 0)
      {
         super(_level,_xPos,_yPos);
         if(_type == 0)
         {
            this.IS_DOUBLE_SPIKED = true;
         }
         else
         {
            this.IS_DOUBLE_SPIKED = false;
         }
         sprite = new GenericCollisionSprite(1);
         Utils.world.addChild(sprite);
         if(this.IS_DOUBLE_SPIKED)
         {
            this.spikeSprite = new GenericCollisionSprite(0);
            Utils.world.addChild(this.spikeSprite);
         }
         else
         {
            this.spikeSprite = new GenericCollisionSprite(2);
            sprite.visible = false;
            Utils.topWorld.addChild(this.spikeSprite);
         }
         this.frame_spikes = this.original_frame = _frame;
         this.frame_block = 0;
         this.speed = 0;
         aabb.x = -1;
         aabb.y = -1;
         aabb.width = 0;
         aabb.height = 0;
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(sprite);
         if(this.IS_DOUBLE_SPIKED)
         {
            Utils.world.removeChild(this.spikeSprite);
         }
         else
         {
            Utils.topWorld.removeChild(this.spikeSprite);
         }
         this.spikeSprite.destroy();
         this.spikeSprite.dispose();
         this.spikeSprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         super.update();
         ++this.speed;
         if(this.speed >= 8)
         {
            this.speed = 0;
            ++this.frame_spikes;
            if(this.frame_spikes >= 12)
            {
               this.frame_spikes = 0;
            }
            ++this.frame_block;
            if(this.frame_block >= 2)
            {
               this.frame_block = 0;
            }
         }
         if(this.IS_DOUBLE_SPIKED)
         {
            if(this.frame_spikes == 6)
            {
               aabb.x = -1 - 2;
               aabb.y = -1 + 6;
               aabb.width = 34 - 16;
               aabb.height = 34 - 12;
            }
            else if(this.frame_spikes == 0)
            {
               aabb.x = -1 + 18;
               aabb.y = -1 + 6;
               aabb.width = 34 - 16;
               aabb.height = 34 - 12;
            }
            else
            {
               aabb.width = aabb.height = 0;
            }
         }
         else if(this.frame_spikes == 6)
         {
            aabb.x = 3;
            aabb.y = 2;
            aabb.width = 6;
            aabb.height = 12;
         }
         else if(this.frame_spikes == 0)
         {
            aabb.x = 39;
            aabb.y = 2;
            aabb.width = 6;
            aabb.height = 12;
         }
         else
         {
            aabb.width = aabb.height = 0;
         }
      }
      
      override public function reset() : void
      {
         this.frame_spikes = this.original_frame;
         this.speed = 0;
      }
      
      override public function checkEntitiesCollision() : void
      {
         var hero_aabb:Rectangle = null;
         var brick_aabb:Rectangle = null;
         if(this.frame_spikes == 6 || this.frame_spikes == 0)
         {
            hero_aabb = level.hero.getAABB();
            brick_aabb = this.getAABB();
            if(hero_aabb.intersects(brick_aabb))
            {
               level.hero.hurt(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,null);
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.spikeSprite.x = sprite.x - 8;
         this.spikeSprite.y = sprite.y;
         this.spikeSprite.gfxHandleClip().gotoAndStop(this.frame_spikes + 1);
         sprite.gfxHandleClip().gotoAndStop(this.frame_block + 1);
         sprite.updateScreenPosition();
         if(this.IS_DOUBLE_SPIKED)
         {
            Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
            Utils.world.setChildIndex(this.spikeSprite,Utils.world.numChildren - 1);
         }
      }
      
      override public function getAABB() : Rectangle
      {
         if(this.frame_spikes == 6)
         {
            aabb.x = 3;
            aabb.y = 2;
            aabb.width = 6;
            aabb.height = 12;
         }
         else if(this.frame_spikes == 0)
         {
            aabb.x = 39;
            aabb.y = 2;
            aabb.width = 6;
            aabb.height = 12;
         }
         else
         {
            aabb.width = aabb.height = 0;
         }
         return new Rectangle(xPos - 8 + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
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
