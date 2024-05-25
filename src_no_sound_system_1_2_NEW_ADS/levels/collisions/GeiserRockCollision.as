package levels.collisions
{
   import entities.Easings;
   import entities.Entity;
   import entities.particles.Particle;
   import flash.geom.Rectangle;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.collisions.GeiserHeadCollisionSprite;
   import sprites.collisions.GeiserRockCollisionSprite;
   import sprites.particles.GeiserBubbleParticleSprite;
   import starling.display.Image;
   
   public class GeiserRockCollision extends Collision
   {
       
      
      public var entity:Entity;
      
      public var hero_xDiff:Number;
      
      protected var oldXPos:Number;
      
      protected var xShift:Number;
      
      protected var yShift:Number;
      
      protected var tick_counter:Number;
      
      protected var y_start:Number;
      
      protected var y_diff:Number;
      
      protected var tick_time:Number;
      
      protected var GEISER_HEIGHT:Number;
      
      protected var geiserHeadSprite:GeiserHeadCollisionSprite;
      
      protected var geiserBodyImage:Image;
      
      protected var stateMachine:StateMachine;
      
      protected var yVel:Number;
      
      protected var sinCounter1:Number;
      
      protected var geiserHeadYPos:Number;
      
      protected var geiserYShift:Number;
      
      protected var lava_aabb:Rectangle;
      
      public function GeiserRockCollision(_level:Level, _xPos:Number, _yPos:Number, _height:int)
      {
         super(_level,_xPos,_yPos);
         sprite = new GeiserRockCollisionSprite();
         Utils.world.addChild(sprite);
         this.geiserHeadSprite = new GeiserHeadCollisionSprite();
         Utils.world.addChild(this.geiserHeadSprite);
         this.geiserBodyImage = new Image(TextureManager.sTextureAtlas.getTexture("geiserBody"));
         Utils.world.addChild(this.geiserBodyImage);
         WIDTH = 32;
         HEIGHT = 16;
         aabb.x = 0;
         aabb.y = -2;
         aabb.width = 32;
         aabb.height = 18;
         this.geiserHeadYPos = 0;
         this.geiserYShift = 0;
         this.hero_xDiff = 0;
         this.entity = null;
         this.oldXPos = 0;
         this.xShift = this.yShift = 0;
         this.yVel = 0;
         this.sinCounter1 = 0;
         this.GEISER_HEIGHT = _height * Utils.TILE_HEIGHT;
         this.tick_counter = 0;
         this.y_start = 0;
         this.y_diff = 0;
         this.tick_time = 0;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_DOWN_STATE","ERUPT_ACTION","IS_SHAKING_STATE");
         this.stateMachine.setRule("IS_SHAKING_STATE","END_ACTION","IS_GOING_UP_STATE");
         this.stateMachine.setRule("IS_GOING_UP_STATE","END_ACTION","IS_UP_STATE");
         this.stateMachine.setRule("IS_UP_STATE","END_ACTION","IS_GOING_DOWN_STATE");
         this.stateMachine.setRule("IS_GOING_DOWN_STATE","END_ACTION","IS_DOWN_STATE");
         this.stateMachine.setFunctionToState("IS_DOWN_STATE",this.downAnimation);
         this.stateMachine.setFunctionToState("IS_SHAKING_STATE",this.shakingAnimation);
         this.stateMachine.setFunctionToState("IS_GOING_UP_STATE",this.goingUpAnimation);
         this.stateMachine.setFunctionToState("IS_UP_STATE",this.upAnimation);
         this.stateMachine.setFunctionToState("IS_GOING_DOWN_STATE",this.goingDownAnimation);
         this.stateMachine.setState("IS_DOWN_STATE");
         this.lava_aabb = new Rectangle(0,0,0,0);
      }
      
      override public function reset() : void
      {
         xPos = originalXPos;
         yPos = originalYPos;
         this.tick_counter = 0;
         this.y_start = 0;
         this.y_diff = 0;
         this.tick_time = 0;
         this.stateMachine.setState("IS_DOWN_STATE");
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(this.geiserBodyImage);
         this.geiserBodyImage.dispose();
         this.geiserBodyImage = null;
         Utils.world.removeChild(this.geiserHeadSprite);
         this.geiserHeadSprite.destroy();
         this.geiserHeadSprite.dispose();
         this.geiserHeadSprite = null;
         Utils.world.removeChild(sprite);
         this.stateMachine.destroy();
         this.stateMachine = null;
         this.entity = null;
         this.lava_aabb = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var x_diff:Number = NaN;
         super.update();
         if(this.stateMachine.currentState == "IS_DOWN_STATE")
         {
            ++counter1;
            if(counter1 >= 120)
            {
               this.stateMachine.performAction("ERUPT_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_SHAKING_STATE")
         {
            if(counter1++ > 0)
            {
               counter1 = 0;
               xPos = originalXPos + int(Math.random() * 4 - 2);
               yPos = originalYPos + int(Math.random() * 4 - 2);
            }
            ++counter2;
            if(counter2 >= 60)
            {
               xPos = originalXPos;
               yPos = originalYPos;
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_GOING_UP_STATE")
         {
            this.tick_counter += 1 / 60;
            if(this.tick_counter >= this.tick_time)
            {
               this.tick_counter = this.tick_time;
               this.stateMachine.performAction("END_ACTION");
            }
            yPos = int(Easings.linear(this.tick_counter,this.y_start,this.y_diff,this.tick_time));
         }
         else if(this.stateMachine.currentState == "IS_UP_STATE")
         {
            if(this.yVel > 0 && yPos >= originalYPos - this.GEISER_HEIGHT)
            {
               counter2 = 1;
            }
            else
            {
               yPos += this.yVel;
               this.yVel += 0.25;
            }
            if(counter2 >= 1)
            {
               this.sinCounter1 += 0.2;
               yPos = int(originalYPos - this.GEISER_HEIGHT + Math.sin(this.sinCounter1) * 4);
               ++counter1;
               if(counter1 >= 180)
               {
                  this.stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_GOING_DOWN_STATE")
         {
            this.geiserYShift += 5;
            if(counter1++ > 10)
            {
               this.yVel += 0.5;
               if(this.yVel >= 8)
               {
                  this.yVel = 8;
               }
               yPos += this.yVel;
               if(yPos >= originalYPos)
               {
                  yPos = originalYPos;
                  if(this.isInsideScreen())
                  {
                     SoundSystem.PlaySound("ground_stomp");
                     level.camera.shake(6);
                  }
                  this.stateMachine.performAction("END_ACTION");
               }
            }
            if(this.geiserHeadYPos >= originalYPos + 16)
            {
               this.geiserHeadSprite.visible = false;
            }
         }
         this.geiserHeadYPos = yPos + this.yShift + this.geiserYShift + 16;
         if(this.geiserHeadYPos <= originalYPos - this.GEISER_HEIGHT + 16)
         {
            this.geiserHeadYPos = originalYPos - this.GEISER_HEIGHT + 16;
         }
         else if(this.geiserHeadYPos >= originalYPos + 16)
         {
            this.geiserHeadYPos = originalYPos + 16;
         }
         if(this.isInsideScreen())
         {
            if(counter3++ > 5)
            {
               counter3 = 0;
               this.createBubble(originalXPos + 8 + Math.random() * 16,originalYPos + 16);
            }
         }
         yValue = this.geiserHeadYPos + 4;
         if(this.entity != null)
         {
            x_diff = xPos - this.oldXPos;
            this.entity.xPos += x_diff;
         }
         this.oldXPos = xPos;
      }
      
      protected function createBubble(_xPos:Number, _yPos:Number) : void
      {
         var pSprite:GeiserBubbleParticleSprite = new GeiserBubbleParticleSprite();
         if(Math.random() * 100 > 50)
         {
            pSprite.gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            pSprite.gfxHandleClip().gotoAndStop(2);
         }
         var particle:Particle = level.particlesManager.pushParticle(pSprite,_xPos,_yPos,0,-1,1,Math.random() * Math.PI * 2,0,1);
         particle.collision = this;
      }
      
      override public function checkEntitiesCollision() : void
      {
         var heroAABB:Rectangle = new Rectangle(level.hero.xPos + level.hero.aabbPhysics.x,level.hero.yPos + level.hero.aabbPhysics.y,level.hero.aabbPhysics.width,level.hero.aabbPhysics.height);
         var thisAABB:Rectangle = getAABB();
         if(heroAABB.intersects(thisAABB) && level.hero.yPos + level.hero.HEIGHT * 0.5 < yPos + 16 && level.hero.yVel >= 0)
         {
            if(level.hero.yPos + level.hero.HEIGHT > yPos + 8)
            {
               level.hero.wallCollision();
            }
            else
            {
               level.hero.setOnPlatform(this);
               level.hero.yPos = yPos - level.hero.HEIGHT;
               level.hero.yVel = 0;
               this.entity = level.hero;
            }
         }
         else if(this.entity != null)
         {
            this.entity = null;
            level.hero.IS_ON_PLATFORM = false;
         }
         this.lava_aabb.x = xPos;
         this.lava_aabb.y = this.geiserHeadYPos;
         this.lava_aabb.width = 32;
         this.lava_aabb.height = originalYPos - this.geiserHeadYPos;
         if(heroAABB.intersects(this.lava_aabb))
         {
            level.hero.hurt(xPos + 16,this.lava_aabb.y,null);
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         if(sprite != null)
         {
            sprite.x = int(Math.floor(xPos + this.xShift - camera.xPos));
            sprite.y = int(Math.floor(yPos + this.yShift - camera.yPos));
         }
         this.geiserHeadSprite.x = int(Math.floor(xPos + this.xShift - camera.xPos));
         this.geiserHeadSprite.y = int(Math.floor(this.geiserHeadYPos - camera.yPos));
         this.geiserBodyImage.x = sprite.x;
         this.geiserBodyImage.y = this.geiserHeadSprite.y + 8;
         this.geiserBodyImage.height = originalYPos - this.geiserHeadYPos + 9;
         this.geiserBodyImage.visible = this.geiserHeadSprite.visible;
      }
      
      override public function isInsideScreen() : Boolean
      {
         var area:Rectangle = new Rectangle(xPos,originalYPos - this.GEISER_HEIGHT,32,this.GEISER_HEIGHT);
         var camera:Rectangle = new Rectangle(level.camera.xPos - 48,level.camera.yPos - 48,level.camera.WIDTH + 96,level.camera.HEIGHT + 96);
         if(area.intersects(camera))
         {
            return true;
         }
         return false;
      }
      
      protected function downAnimation() : void
      {
         counter1 = 0;
         this.yVel = 0;
         this.geiserYShift = 0;
         this.geiserHeadSprite.visible = false;
      }
      
      protected function shakingAnimation() : void
      {
         if(this.isInsideScreen())
         {
            SoundSystem.PlaySound("geyser");
         }
         counter1 = counter2 = 0;
      }
      
      protected function goingUpAnimation() : void
      {
         counter1 = counter2 = 0;
         this.tick_counter = 0;
         this.y_start = originalYPos;
         this.y_diff = -this.GEISER_HEIGHT;
         this.tick_time = this.GEISER_HEIGHT / Utils.TILE_HEIGHT * 0.05;
         this.geiserHeadSprite.visible = true;
      }
      
      protected function upAnimation() : void
      {
         counter1 = counter2 = 0;
         this.sinCounter1 = 0;
         this.geiserYShift = 0;
         this.yVel = -2.5;
      }
      
      protected function goingDownAnimation() : void
      {
         this.yVel = 0;
      }
   }
}
