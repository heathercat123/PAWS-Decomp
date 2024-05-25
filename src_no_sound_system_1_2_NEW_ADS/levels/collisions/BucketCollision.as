package levels.collisions
{
   import entities.bullets.Bullet;
   import flash.geom.*;
   import levels.Level;
   import levels.cameras.*;
   import levels.items.CoinItem;
   import sprites.bullets.GenericBulletSprite;
   import sprites.collisions.*;
   import sprites.tutorials.*;
   import starling.display.*;
   import starling.filters.FragmentFilter;
   import starling.textures.TextureSmoothing;
   
   public class BucketCollision extends Collision
   {
       
      
      protected var container:Sprite;
      
      protected var bucketImage:Image;
      
      protected var questionMarkImage:Image;
      
      protected var torque:Number;
      
      protected var sin_counter1:Number;
      
      protected var IS_STILL:Boolean;
      
      protected var IS_HIT:Boolean;
      
      protected var IS_ALREADY_HIT:Boolean;
      
      protected var PROGRESSION:int;
      
      protected var item_index:int;
      
      protected var type:int;
      
      public function BucketCollision(_level:Level, _xPos:Number, _yPos:Number, _index:int, _type:int)
      {
         super(_level,_xPos,_yPos);
         this.item_index = _index;
         this.type = _type;
         WIDTH = 16;
         HEIGHT = 24;
         counter1 = 0;
         this.IS_ALREADY_HIT = false;
         this.initSprites();
         aabb.x = -8;
         aabb.y = -1;
         aabb.width = 16;
         aabb.height = 24;
         if(this.type == 1)
         {
            aabb.x = -33;
            aabb.y = 0;
            aabb.width = 66;
            aabb.height = 70;
         }
         this.torque = this.sin_counter1 = 0;
         this.IS_STILL = true;
         this.IS_HIT = false;
         this.PROGRESSION = 0;
      }
      
      override public function destroy() : void
      {
         this.container.removeChild(this.bucketImage);
         this.bucketImage.dispose();
         this.bucketImage = null;
         if(this.questionMarkImage != null)
         {
            this.container.removeChild(this.questionMarkImage);
            this.questionMarkImage.dispose();
            this.questionMarkImage = null;
         }
         this.container.filter = null;
         if(this.type == 1)
         {
            Utils.topWorld.removeChild(this.container);
         }
         else
         {
            Utils.world.removeChild(this.container);
         }
         this.container.dispose();
         this.container = null;
         super.destroy();
      }
      
      public function setHit() : void
      {
         this.IS_ALREADY_HIT = true;
         this.container.visible = false;
      }
      
      protected function initSprites() : void
      {
         this.container = new Sprite();
         if(this.type == 0)
         {
            this.bucketImage = new Image(TextureManager.sTextureAtlas.getTexture("buckeCollisionAnim_a"));
            this.bucketImage.touchable = false;
            this.bucketImage.x = -11;
            this.bucketImage.y = -1;
            this.bucketImage.textureSmoothing = Utils.getSmoothing();
            this.container.addChild(this.bucketImage);
            this.questionMarkImage = new Image(TextureManager.sTextureAtlas.getTexture("questionMarkItemSpriteAnim_a"));
            this.questionMarkImage.touchable = false;
            this.container.addChild(this.questionMarkImage);
            this.questionMarkImage.x = -8;
            this.questionMarkImage.y = 8;
            this.questionMarkImage.textureSmoothing = Utils.getSmoothing();
            this.container.addChild(this.questionMarkImage);
         }
         else
         {
            this.questionMarkImage = null;
            this.bucketImage = new Image(TextureManager.GetBackgroundTexture().getTexture("bell_background_1"));
            this.bucketImage.touchable = false;
            this.bucketImage.x = -int(this.bucketImage.width * 0.5);
            this.bucketImage.y = 0;
            this.bucketImage.textureSmoothing = Utils.getSmoothing();
            this.container.addChild(this.bucketImage);
         }
         if(this.type == 1)
         {
            Utils.topWorld.addChild(this.container);
         }
         else
         {
            Utils.world.addChild(this.container);
         }
         this.container.filter = new FragmentFilter();
         FragmentFilter(this.container.filter).resolution = Utils.GFX_INV_SCALE;
         FragmentFilter(this.container.filter).textureSmoothing = TextureSmoothing.NONE;
      }
      
      override public function update() : void
      {
         var coinItem:CoinItem = null;
         super.update();
         if(this.IS_ALREADY_HIT)
         {
            return;
         }
         if(this.IS_HIT)
         {
            if(this.PROGRESSION == 0)
            {
               this.sin_counter1 += this.torque;
               this.container.rotation = this.sin_counter1;
               SoundSystem.PlaySound("log_collision");
               if(this.sin_counter1 <= -Math.PI * 5)
               {
                  this.container.rotation = this.sin_counter1 = -Math.PI * 5;
                  counter1 = counter2 = 0;
                  ++this.PROGRESSION;
               }
               else if(this.sin_counter1 >= Math.PI * 5)
               {
                  this.container.rotation = this.sin_counter1 = Math.PI * 5;
                  counter1 = counter2 = 0;
                  ++this.PROGRESSION;
               }
            }
            else if(this.PROGRESSION == 1)
            {
               if(counter1++ > 1)
               {
                  counter1 = 0;
                  ++counter2;
                  SoundSystem.PlaySound("chain");
                  if(xPos >= originalXPos)
                  {
                     xPos = originalXPos - 1;
                  }
                  else
                  {
                     xPos = originalXPos + 1;
                  }
                  if(counter2 >= 8)
                  {
                     xPos = originalXPos;
                     counter2 = 0;
                     counter1 = 60;
                     ++this.PROGRESSION;
                  }
               }
            }
            else if(this.PROGRESSION == 2)
            {
               if(counter1++ > 15)
               {
                  counter1 = 0;
                  ++counter2;
                  SoundSystem.PlaySound("coin_appear");
                  coinItem = new CoinItem(level,xPos - 8,yPos - 24,4);
                  level.itemsManager.items.push(coinItem);
                  if(counter2 >= 10)
                  {
                     ++this.PROGRESSION;
                     counter1 = counter2 = 0;
                  }
               }
            }
            else if(this.PROGRESSION == 3)
            {
               ++counter1;
               if(counter1 >= 3)
               {
                  counter1 = 0;
                  this.container.visible = !this.container.visible;
                  ++counter2;
                  if(counter2 >= 7)
                  {
                     dead = true;
                  }
               }
            }
         }
         else if(Math.abs(this.torque) > 0.1)
         {
            if(this.type == 0)
            {
               this.sin_counter1 += 0.2;
               this.container.rotation = Math.sin(this.sin_counter1) * this.torque * 0.25;
               if(counter1++ > 10)
               {
                  this.torque *= 0.95;
               }
            }
            else
            {
               this.sin_counter1 += 0.1;
               this.container.rotation = Math.sin(this.sin_counter1) * this.torque * 0.3;
               if(counter1++ > 10)
               {
                  this.torque *= 0.98;
               }
            }
         }
         else
         {
            this.IS_STILL = true;
            this.container.rotation = 0;
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         var entityAABB:Rectangle = null;
         var entity:Bullet = null;
         var index:int = 0;
         var i:int = 0;
         if(!this.IS_STILL)
         {
            return;
         }
         if(this.IS_HIT)
         {
            return;
         }
         if(this.IS_ALREADY_HIT)
         {
            return;
         }
         var thisAABB:Rectangle = getAABB();
         if(this.type == 0)
         {
            for(i = 0; i < level.bulletsManager.bullets.length; i++)
            {
               if(level.bulletsManager.bullets[i] != null)
               {
                  entity = level.bulletsManager.bullets[i];
                  if(entity.sprite != null)
                  {
                     if(entity.ID == GenericBulletSprite.BEACH_BALL)
                     {
                        entityAABB = entity.getAABB();
                        if(entityAABB.intersects(thisAABB))
                        {
                           if(Math.abs(entity.xVel) >= 2)
                           {
                              Utils.LEVEL_COLLISION_ITEMS[this.item_index] = true;
                              this.IS_STILL = false;
                              this.IS_HIT = true;
                              this.PROGRESSION = 0;
                              this.sin_counter1 = 0;
                              counter1 = 0;
                              if(entity.xVel < 0)
                              {
                                 this.torque = 0.25;
                              }
                              else
                              {
                                 this.torque = -0.25;
                              }
                           }
                           else
                           {
                              this.torque = -entity.xVel;
                              this.sin_counter1 = 0;
                              this.IS_STILL = false;
                              counter1 = 0;
                           }
                           if(entity.xPos < xPos)
                           {
                              entity.xVel = -Math.abs(entity.xVel);
                           }
                           else
                           {
                              entity.xVel = Math.abs(entity.xVel);
                           }
                        }
                     }
                  }
               }
            }
         }
         else if(this.type == 1)
         {
            if(level.hero.getAABB().intersects(thisAABB))
            {
               this.torque = -level.hero.xVel * 0.5;
               this.sin_counter1 = 0;
               this.IS_STILL = false;
               counter1 = 0;
               SoundSystem.PlaySound("bell");
               level.camera.shake(1,false,15);
               level.customEvent(1);
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.container.x = int(Math.floor(xPos - camera.xPos));
         this.container.y = int(Math.floor(yPos - camera.yPos));
      }
      
      override public function reset() : void
      {
      }
   }
}
