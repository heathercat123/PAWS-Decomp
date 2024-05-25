package levels.items
{
   import entities.Easings;
   import entities.enemies.*;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.*;
   import sprites.items.BottleItemSprite;
   import sprites.particles.ItemExplosionParticleSprite;
   import starling.display.Image;
   
   public class BottleItem extends Item
   {
       
      
      protected var butterfly_images:Array;
      
      protected var radius:Number;
      
      protected var angle:Number;
      
      protected var radius_speed:Number;
      
      protected var collected_sound_counter:int;
      
      protected var IS_COLLECTED:Boolean;
      
      public function BottleItem(_level:Level, _xPos:Number, _yPos:Number)
      {
         super(_level,_xPos,_yPos,-1);
         sprite = new BottleItemSprite();
         Utils.world.addChild(sprite);
         Utils.world.setChildIndex(sprite,0);
         this.collected_sound_counter = 0;
         stateMachine.setState("IS_STANDING_STATE");
         this.butterfly_images = null;
         this.radius = 0;
         this.angle = 0;
         this.radius_speed = 0.1;
         this.IS_COLLECTED = false;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.butterfly_images != null)
         {
            for(i = 0; i < this.butterfly_images.length; i++)
            {
               Utils.world.removeChild(this.butterfly_images[i]);
               this.butterfly_images[i].dispose();
               this.butterfly_images[i] = null;
            }
            this.butterfly_images = null;
         }
         super.destroy();
      }
      
      override public function updateFreeze() : void
      {
         var i:int = 0;
         var __x:Number = NaN;
         var __y:Number = NaN;
         var point:Point = null;
         var area:Rectangle = null;
         var all_outside:Boolean = false;
         var step:Number = NaN;
         if(!this.IS_COLLECTED)
         {
            return;
         }
         if(sprite.frame == 4)
         {
            if(sprite.gfxHandleClip().currentFrame == 5)
            {
               if(this.collected_sound_counter == 0)
               {
                  this.collected_sound_counter = 1;
                  SoundSystem.PlaySound("pot_pop");
               }
            }
         }
         if(counter_1 == 0)
         {
            ++counter_2;
            if(counter_2 >= 6)
            {
               ++counter_1;
               counter_2 = 0;
               sprite.gotoAndStop(3);
               sprite.gfxHandleClip().gotoAndPlay(1);
               yVel = -8;
            }
         }
         else if(counter_1 == 1)
         {
            yPos += yVel;
            if(yPos <= originalYPos - 8 && sprite.frame == 3)
            {
               sprite.gotoAndStop(4);
               sprite.gfxHandleClip().gotoAndPlay(1);
            }
            if(Math.abs(yPos - originalYPos) >= 12)
            {
               ++counter_1;
               counter_2 = 0;
               yVel = 0;
               yPos = originalYPos - 12;
               tick_1 = 0;
            }
         }
         else if(counter_1 == 2)
         {
            tick_1 += 1 / 60;
            if(tick_1 >= 0.5)
            {
               tick_1 = 0.5;
               counter_1 = 3;
            }
            yPos = Easings.easeOutQuad(tick_1,originalYPos - 12,-12,0.5);
         }
         else if(counter_1 == 3)
         {
            this.butterfly_images = new Array();
            for(i = 0; i < 5; i++)
            {
               this.butterfly_images.push(new Image(TextureManager.sTextureAtlas.getTexture("butterflyItemSprite" + (i + 1) + "Anim_a")));
               Utils.topWorld.addChild(this.butterfly_images[i]);
            }
            ++counter_1;
            SoundSystem.PlaySound("butterflies_appear");
         }
         else if(counter_1 == 4)
         {
            this.radius += this.radius_speed;
            this.angle -= 0.1;
            if(counter2++ > 2)
            {
               counter2 = 0;
               this.radius_speed += 0.2;
               if(this.radius_speed > 3)
               {
                  this.radius_speed = 3;
               }
            }
            point = new Point();
            area = new Rectangle(level.camera.xPos,level.camera.yPos,level.camera.WIDTH,level.camera.HEIGHT);
            all_outside = true;
            step = Math.PI * 2 / this.butterfly_images.length;
            for(i = 0; i < this.butterfly_images.length; i++)
            {
               __x = int(Math.floor(xPos + Math.sin(this.angle + step * i) * this.radius));
               __y = int(Math.floor(yPos + Math.cos(this.angle + step * i) * this.radius));
               point.x = __x;
               point.y = __y;
               if(area.containsPoint(point))
               {
                  all_outside = false;
               }
            }
            if(all_outside)
            {
               ++counter_1;
               for(i = 0; i < this.butterfly_images.length; i++)
               {
                  this.butterfly_images[i].visible = false;
               }
            }
         }
         else if(counter_1 == 5)
         {
            Utils.FreezeOn = false;
            stateMachine.performAction("END_ACTION");
            SoundSystem.PlaySound("item_pop");
            level.topParticlesManager.pushParticle(new ItemExplosionParticleSprite(),xPos + WIDTH * 0.5,yPos + 5,0,0,0);
         }
      }
      
      override protected function collectedAnimation() : void
      {
         this.IS_COLLECTED = true;
         counter_1 = 0;
         counter_2 = 0;
         tick_1 = 0;
         SoundSystem.StopMusic(true);
         SoundSystem.PlayMusic("butterflies");
         if(isInsideScreen())
         {
            SoundSystem.PlaySound("pot_collected");
         }
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
         this.collected_sound_counter = 0;
         level.freezeAction(-1);
      }
      
      override protected function deadAnimation() : void
      {
         level.itemsManager.createButterflies();
         dead = true;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var step:Number = NaN;
         super.updateScreenPosition(camera);
         if(this.butterfly_images != null)
         {
            step = Math.PI * 2 / this.butterfly_images.length;
            for(i = 0; i < this.butterfly_images.length; i++)
            {
               this.butterfly_images[i].x = int(Math.floor(xPos + Math.sin(this.angle + step * i) * this.radius - camera.xPos));
               this.butterfly_images[i].y = int(Math.floor(yPos + Math.cos(this.angle + step * i) * this.radius - camera.yPos));
            }
         }
      }
   }
}
