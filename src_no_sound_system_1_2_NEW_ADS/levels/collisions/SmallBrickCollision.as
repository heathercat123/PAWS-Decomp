package levels.collisions
{
   import entities.Entity;
   import entities.bullets.Bullet;
   import flash.geom.*;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   import sprites.bullets.FireFloatingBulletSprite;
   import sprites.bullets.GenericBulletSprite;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   import states.LevelState;
   
   public class SmallBrickCollision extends Collision
   {
       
      
      protected var IS_SPIKED:Boolean;
      
      protected var IS_FLIPPED:Boolean;
      
      public var LEVEL:int;
      
      protected var hit_shake_counter_1:int;
      
      protected var hit_shake_counter_2:int;
      
      protected var IS_SHAKING:Boolean;
      
      protected var x_offset:int;
      
      public var ENERGY:int;
      
      public var IS_HINT:Boolean;
      
      public function SmallBrickCollision(_level:Level, _xPos:Number, _yPos:Number, _value:int = 0, _collision_type:int = 0, _is_spiked:int = 0, _is_flipped:int = 0, _is_hint:Boolean = false)
      {
         if(_is_flipped > 0)
         {
            _xPos -= 16;
         }
         this.IS_HINT = _is_hint;
         super(_level,_xPos,_yPos);
         WIDTH = HEIGHT = 16;
         this.LEVEL = 1;
         this.hit_shake_counter_1 = this.hit_shake_counter_2 = 0;
         this.IS_SHAKING = false;
         this.x_offset = 0;
         this.ENERGY = 1;
         this.IS_SPIKED = false;
         this.IS_FLIPPED = false;
         if(_is_spiked > 0)
         {
            this.IS_SPIKED = true;
         }
         if(_is_flipped > 0)
         {
            this.IS_FLIPPED = true;
         }
         sprite = new SmallBrickCollisionSprite(_is_spiked,_is_flipped,_value);
         Utils.topWorld.addChild(sprite);
         if(this.IS_FLIPPED)
         {
            sprite.scaleX = -1;
         }
         if(_value == 5)
         {
            this.LEVEL = 2;
            this.ENERGY = 2;
            WIDTH = HEIGHT = 32;
         }
         aabb.x = -2;
         aabb.y = 0;
         aabb.width = 20;
         aabb.height = 16;
         if(this.LEVEL == 2)
         {
            aabb.x = -2;
            aabb.y = 0;
            aabb.width = 36;
            aabb.height = 32;
         }
         if(this.IS_SPIKED)
         {
            aabb.y = 2;
            aabb.height = 14;
         }
         var x_t:int = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         if(_collision_type == 0)
         {
            if(_value == 0 || _value == 2 || _value == 3 || _value == 4)
            {
               level.levelData.setTileValueAt(x_t,y_t,1);
            }
            else if(_value == 5)
            {
               level.levelData.setTileValueAt(x_t,y_t,1);
               level.levelData.setTileValueAt(x_t + 1,y_t,1);
               level.levelData.setTileValueAt(x_t,y_t + 1,1);
               level.levelData.setTileValueAt(x_t + 1,y_t + 1,1);
            }
            else
            {
               level.levelData.setTileValueAt(x_t,y_t,10);
            }
         }
         else
         {
            level.levelData.setTileValueAt(x_t,y_t,10);
         }
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      public function clearTileValue() : void
      {
         var x_t:int = int((xPos + Utils.TILE_WIDTH * 0.5) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + Utils.TILE_HEIGHT * 0.5) / Utils.TILE_HEIGHT);
         level.levelData.setTileValueAt(x_t,y_t,0);
         if(this.LEVEL == 2)
         {
            level.levelData.setTileValueAt(x_t + 1,y_t,0);
            level.levelData.setTileValueAt(x_t,y_t + 1,0);
            level.levelData.setTileValueAt(x_t + 1,y_t + 1,0);
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_7)
            {
               level.levelData.setTileValueAt(x_t,y_t,1);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var is_on_left:Boolean = false;
         var outer_aabb:Rectangle = null;
         var mid_x:Number = xPos + 8;
         var hero_aabb:Rectangle = level.hero.getAABB();
         var brick_aabb:Rectangle = getAABB();
         if(hero_aabb.intersects(brick_aabb))
         {
            if(this.IS_SPIKED && (this.IS_FLIPPED ? level.hero.xPos > mid_x : level.hero.xPos < mid_x))
            {
               level.hero.hurt(xPos + 8,yPos + 8,null);
            }
            else if(level.hero.stateMachine.currentState == "IS_RUNNING_STATE")
            {
               is_on_left = false;
               if(hero_aabb.x + hero_aabb.width * 0.5 < brick_aabb.x + brick_aabb.width * 0.5)
               {
                  is_on_left = true;
               }
               if(is_on_left && level.hero.DIRECTION == Entity.RIGHT || !is_on_left && level.hero.DIRECTION == Entity.LEFT)
               {
                  if(this.LEVEL > 1)
                  {
                     level.headPound();
                     level.hero.headPound();
                  }
                  else if(is_on_left && level.hero.DIRECTION == Entity.RIGHT || !is_on_left && level.hero.DIRECTION == Entity.LEFT)
                  {
                     this.explode(true);
                     level.headPound();
                     level.freezeAction(8);
                  }
               }
            }
            else if(level.hero.stateMachine.currentState == "IS_CANNON_SHOOT_STATE")
            {
               this.explode(true);
               level.headPound();
               level.freezeAction(8);
            }
         }
         else if(this.IS_HINT)
         {
            outer_aabb = getAABB();
            outer_aabb.x -= 48;
            outer_aabb.y -= 48;
            outer_aabb.width += 96;
            outer_aabb.height += 96;
            if(hero_aabb.intersects(outer_aabb))
            {
               if(Math.abs(this.LEVEL - Utils.Slot.playerInventory[LevelItems.ITEM_HELPER_ROCK]) < 2)
               {
                  level.soundHud.showHint(LevelItems.ITEM_HELPER_ROCK);
               }
            }
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(this.IS_SHAKING)
         {
            if(this.hit_shake_counter_1++ > 1)
            {
               this.hit_shake_counter_1 = 0;
               ++this.hit_shake_counter_2;
               if(this.x_offset >= 0)
               {
                  this.x_offset = -1;
               }
               else
               {
                  this.x_offset = 0;
               }
               if(this.hit_shake_counter_2 >= 8)
               {
                  this.x_offset = 0;
                  this.IS_SHAKING = false;
               }
            }
         }
      }
      
      public function explodeBrick() : void
      {
         this.explode(true);
         level.headPound();
      }
      
      override public function isBulletCollision(bullet:Bullet) : Boolean
      {
         var __aabb:Rectangle = null;
         if(bullet.sprite is FireFloatingBulletSprite)
         {
            __aabb = new Rectangle(xPos - 4,yPos - 4,24,24);
            if(bullet.getAABB().intersects(__aabb))
            {
               return true;
            }
         }
         return false;
      }
      
      override public function bulletCollision(bullet:Bullet) : void
      {
         this.explode(true);
      }
      
      public function hitShake() : void
      {
         this.hit_shake_counter_1 = this.hit_shake_counter_2 = 0;
         this.IS_SHAKING = true;
         this.x_offset = 0;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos + this.x_offset - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_7)
         {
            Utils.topWorld.setChildIndex(sprite,0);
         }
         sprite.updateScreenPosition();
      }
      
      public function explode(_isBigCat:Boolean = false) : void
      {
         var sprite:GenericBulletSprite = null;
         SoundSystem.PlaySound("brick_destroyed");
         dead = true;
         level.camera.shake(3);
         this.clearTileValue();
         if(this.LEVEL == 2)
         {
            level.topParticlesManager.createMediumBrickExplosion(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5);
            sprite = new GenericBulletSprite(GenericBulletSprite.ROCK_NO_DAMAGE);
            sprite.gfxHandleClip().gotoAndStop(1);
            level.bulletsManager.pushBullet(sprite,xPos + Math.random() * WIDTH,yPos + Math.random() * HEIGHT,-1.25,-(0.25 + Math.random() * 0.25),0.95);
            sprite = new GenericBulletSprite(GenericBulletSprite.ROCK_NO_DAMAGE);
            sprite.gfxHandleClip().gotoAndStop(2);
            level.bulletsManager.pushBullet(sprite,xPos + Math.random() * WIDTH,yPos + Math.random() * HEIGHT,1.25,-(0.25 + Math.random() * 0.25),0.95);
            if(Math.random() * 100 > 50)
            {
               sprite = new GenericBulletSprite(GenericBulletSprite.ROCK_NO_DAMAGE);
               sprite.gfxHandleClip().gotoAndStop(Math.random() * 100 > 50 ? 1 : 2);
               level.bulletsManager.pushBullet(sprite,xPos + Math.random() * WIDTH,yPos + Math.random() * HEIGHT,1.25,-(0.25 + Math.random() * 0.25),0.95);
            }
         }
         else
         {
            level.topParticlesManager.createSmallBrickExplosion(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,_isBigCat);
         }
      }
   }
}
