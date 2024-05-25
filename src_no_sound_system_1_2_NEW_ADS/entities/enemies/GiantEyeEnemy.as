package entities.enemies
{
   import entities.Hero;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.GameSprite;
   import sprites.enemies.*;
   import sprites.particles.DarkExplosionParticleSprite;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class GiantEyeEnemy extends Enemy
   {
       
      
      public var container:Sprite;
      
      protected var bodyImage:Image;
      
      protected var backBodyImage:Image;
      
      protected var eyes:Array;
      
      protected var tentaclesBig:Array;
      
      protected var tentaclesSmall:Array;
      
      protected var blinkCounters:Array;
      
      public function GiantEyeEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         WIDTH = 120;
         HEIGHT = 120;
         speed = 0.8;
         x_friction = 0.8;
         y_friction = 0.8;
         sinCounter1 = 0;
         MAX_Y_VEL = 0.5;
         sprite = null;
         this.initSprites();
         aabbPhysics.y = 3;
         aabbPhysics.height = 10;
         aabb.x = -26;
         aabb.y = -26;
         aabb.width = 52;
         aabb.height = 52;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_SLEEPING_STATE","END_ACTION","IS_APPROACHING_STATE");
         stateMachine.setRule("IS_APPROACHING_STATE","END_ACTION","IS_OPENING_EYES_STATE");
         stateMachine.setRule("IS_OPENING_EYES_STATE","END_ACTION","IS_ROARING_STATE");
         stateMachine.setRule("IS_ROARING_STATE","END_ACTION","IF_CHASING_STATE");
         stateMachine.setRule("IS_CHASING_STATE","END_ACTION","IS_DESTROYED_STATE");
         stateMachine.setRule("IS_DESTROYED_STATE","END_ACTION","IS_GAME_OVER_STATE");
         stateMachine.setFunctionToState("IS_SLEEPING_STATE",this.sleepingAnimation);
         stateMachine.setFunctionToState("IS_APPROACHING_STATE",this.approachingAnimation);
         stateMachine.setFunctionToState("IS_OPENING_EYES_STATE",this.openingEyesAnimation);
         stateMachine.setFunctionToState("IS_ROARING_STATE",this.roaringAnimation);
         stateMachine.setFunctionToState("IF_CHASING_STATE",this.chasingAnimation);
         stateMachine.setFunctionToState("IS_DESTROYED_STATE",this.destroyedAnimation);
         stateMachine.setFunctionToState("IS_GAME_OVER_STATE",this.gameOverAnimation);
         stateMachine.setState("IS_SLEEPING_STATE");
      }
      
      override public function isTargetable() : Boolean
      {
         return false;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_DESTROYED_STATE" || stateMachine.currentState == "IS_DEAD_STATE" || dead || hero.stunHandler.IS_STUNNED && hero.stunHandler.stun_counter_1 < 10)
         {
            return;
         }
         if(stateMachine.currentState == "IS_SLEEPING_STATE")
         {
            return;
         }
         if(level.hero.xPos < xPos + 136)
         {
            hero.hurt(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
         }
      }
      
      override public function update() : void
      {
         var x_diff:Number = NaN;
         var special_amount:int = 0;
         var i:int = 0;
         if(stateMachine.currentState == "IS_APPROACHING_STATE")
         {
            xVel = 1;
            if(xPos >= 528)
            {
               xVel = 0;
               xPos = 528;
               stateMachine.performAction("END_ACTION");
            }
            else
            {
               level.camera.shake(2,true);
            }
         }
         else if(stateMachine.currentState == "IS_OPENING_EYES_STATE")
         {
            ++counter1;
            if(counter1 == 15)
            {
               this.eyes[1].visible = true;
               this.eyes[1].gfxHandle().gfxHandleClip().gotoAndPlay(1);
               level.camera.shake(2);
            }
            else if(counter1 == 35)
            {
               this.eyes[2].visible = true;
               this.eyes[2].gfxHandle().gfxHandleClip().gotoAndPlay(1);
               level.camera.shake(2);
            }
            else if(counter1 == 40)
            {
               this.eyes[3].visible = true;
               this.eyes[3].gfxHandle().gfxHandleClip().gotoAndPlay(1);
               level.camera.shake(2);
            }
            else if(counter1 == 60)
            {
               this.eyes[4].visible = true;
               this.eyes[4].gfxHandle().gfxHandleClip().gotoAndPlay(1);
               level.camera.shake(2);
            }
            else if(counter1 == 80)
            {
               this.eyes[5].visible = true;
               this.eyes[5].gfxHandle().gfxHandleClip().gotoAndPlay(1);
               level.camera.shake(2);
            }
            else if(counter1 == 100)
            {
               SoundSystem.PlaySound("black_sun");
               this.eyes[0].visible = true;
               this.eyes[0].gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            else if(counter1 > 100)
            {
               level.camera.shake(6,true);
               if(counter1 > 160)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_ROARING_STATE")
         {
            ++counter1;
            if(counter1 >= 30)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IF_CHASING_STATE")
         {
            x_diff = Math.abs(level.hero.xPos - xPos);
            if(x_diff > 320)
            {
               xVel = 2;
            }
            else
            {
               xVel = 1;
            }
            special_amount = 0;
            if(level.hero.IS_GOLD)
            {
               special_amount = 128;
            }
            if(xPos >= level.hero.xPos - special_amount)
            {
               xVel = 0;
               xPos = level.hero.xPos - special_amount;
            }
            for(i = 0; i < this.eyes.length; i++)
            {
               if(this.blinkCounters[i]-- < 0)
               {
                  this.blinkCounters[i] = (Math.random() * 4 + 1) * 60;
                  this.eyes[i].gfxHandle().gotoAndStop(3);
                  this.eyes[i].gfxHandle().gfxHandleClip().gotoAndPlay(1);
               }
               if(this.eyes[i].gfxHandle().frame == 3)
               {
                  if(this.eyes[i].gfxHandle().gfxHandleClip().isComplete)
                  {
                     this.eyes[i].gfxHandle().gotoAndStop(1);
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_DESTROYED_STATE")
         {
            ++counter1;
            if(counter1 <= 30)
            {
               level.camera.shake(2,true);
            }
            else if(counter1 > 30 && counter1 <= 60)
            {
               level.camera.shake(3,true);
            }
            else if(counter1 > 60 && counter1 <= 120)
            {
               level.camera.shake(4,true);
               for(i = 0; i < this.eyes.length; i++)
               {
                  this.eyes[i].gfxHandle().gotoAndStop(4);
               }
            }
            else if(counter1 > 120 && counter1 < 240)
            {
               level.camera.shake(4,true);
               if(counter2++ > 3)
               {
                  counter2 = 0;
                  SoundSystem.PlaySound("brick_destroyed");
                  level.topParticlesManager.pushParticle(new DarkExplosionParticleSprite(),xPos + 160,yPos + Math.random() * 320,Math.random() * 3 + 2,0,0.98);
               }
            }
            else if(counter1 >= 240)
            {
               this.container.visible = !this.container.visible;
               level.camera.shake(4,true);
               if(counter2++ > 3)
               {
                  counter2 = 0;
                  SoundSystem.PlaySound("brick_destroyed");
                  level.topParticlesManager.pushParticle(new DarkExplosionParticleSprite(),xPos + 160,yPos + Math.random() * 320,Math.random() * 3 + 2,0,0.98);
               }
               xVel = -1;
               if(xPos + 200 < level.camera.xPos)
               {
                  stateMachine.performAction("END_ACTION");
                  level.camera.shake(8);
               }
            }
         }
         xPos += xVel;
         sinCounter1 += 0.1;
         if(sinCounter1 >= Math.PI * 2)
         {
            sinCounter1 -= Math.PI * 2;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         this.container.x = int(Math.floor(xPos - camera.xPos));
         this.container.y = int(Math.floor(yPos - camera.yPos));
         for(i = 0; i < this.tentaclesBig.length; i++)
         {
            this.tentaclesBig[i].x = int(Math.floor(this.bodyImage.width + Math.sin(sinCounter1) * 16));
            this.tentaclesSmall[i].x = int(Math.floor(this.bodyImage.width + 3 + Math.sin(sinCounter1 + 0.4) * 12));
         }
         this.eyes[0].x = int(Math.floor(56) + Math.sin(sinCounter1 + 0.2) * 4);
         this.eyes[0].y = int(Math.floor(100 + 24));
         this.eyes[1].x = int(Math.floor(80) + Math.sin(sinCounter1) * 6);
         this.eyes[1].y = int(Math.floor(68 + 24));
         this.eyes[2].x = int(Math.floor(40) + Math.sin(sinCounter1 + 0.6) * 2);
         this.eyes[2].y = int(Math.floor(150 + 24));
         this.eyes[3].x = int(Math.floor(54) + Math.sin(sinCounter1 + 1) * 4);
         this.eyes[3].y = int(Math.floor(84 + 24));
         this.eyes[4].x = int(Math.floor(108) + Math.sin(sinCounter1 + 0.8) * 2);
         this.eyes[4].y = int(Math.floor(153 + 24));
         this.eyes[5].x = int(Math.floor(84) + Math.sin(sinCounter1 + 1.2) * 4);
         this.eyes[5].y = int(Math.floor(168 + 24));
         for(i = 0; i < this.eyes.length; i++)
         {
            this.eyes[i].updateScreenPosition();
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.eyes.length; i++)
         {
            this.container.removeChild(this.eyes[i]);
            this.eyes[i].destroy();
            this.eyes[i].dispose();
            this.eyes[i] = null;
         }
         this.eyes = null;
         this.blinkCounters = null;
         this.container.removeChild(this.backBodyImage);
         this.backBodyImage.dispose();
         this.backBodyImage = null;
         this.container.removeChild(this.bodyImage);
         this.bodyImage.dispose();
         this.bodyImage = null;
         for(i = 0; i < this.tentaclesBig.length; i++)
         {
            this.container.removeChild(this.tentaclesBig[i]);
            this.tentaclesBig[i].dispose();
            this.tentaclesBig[i] = null;
         }
         this.tentaclesBig = null;
         for(i = 0; i < this.tentaclesSmall.length; i++)
         {
            this.container.removeChild(this.tentaclesSmall[i]);
            this.tentaclesSmall[i].dispose();
            this.tentaclesSmall[i] = null;
         }
         this.tentaclesSmall = null;
         Utils.topWorld.removeChild(this.container);
         this.container.dispose();
         super.destroy();
      }
      
      protected function initSprites() : void
      {
         var i:int = 0;
         var image:Image = null;
         var sprite:GameSprite = null;
         this.container = new Sprite();
         Utils.topWorld.addChild(this.container);
         this.backBodyImage = new Image(TextureManager.sTextureAtlas.getTexture("giantEyeBody1"));
         this.container.addChild(this.backBodyImage);
         this.backBodyImage.x = this.backBodyImage.y = 0;
         this.backBodyImage.width = -320;
         this.backBodyImage.height = 320;
         this.bodyImage = new Image(TextureManager.sTextureAtlas.getTexture("giantEyeBody1"));
         this.container.addChild(this.bodyImage);
         this.bodyImage.x = this.bodyImage.y = 0;
         this.bodyImage.width = 128;
         this.bodyImage.height = 320;
         this.tentaclesBig = new Array();
         for(i = 0; i < 8; i++)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("giantEyeBody2"));
            image.pivotX = image.pivotY = 24;
            this.container.addChild(image);
            image.x = this.bodyImage.width;
            image.y = i * 48;
            this.tentaclesBig.push(image);
         }
         this.tentaclesSmall = new Array();
         for(i = 0; i < 8; i++)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("giantEyeBody3"));
            image.pivotX = image.pivotY = 16;
            this.container.addChild(image);
            image.x = this.bodyImage.width;
            image.y = i * 48 + 24;
            this.tentaclesSmall.push(image);
         }
         this.eyes = new Array();
         sprite = new BigEyeEnemySprite();
         this.container.addChild(sprite);
         sprite.gfxHandle().gotoAndStop(1);
         this.eyes.push(sprite);
         sprite = new MediumEyeEnemySprite();
         this.container.addChild(sprite);
         sprite.gfxHandle().gotoAndStop(1);
         this.eyes.push(sprite);
         sprite = new MediumEyeEnemySprite();
         this.container.addChild(sprite);
         sprite.gfxHandle().gotoAndStop(1);
         this.eyes.push(sprite);
         sprite = new SmallEyeEnemySprite();
         this.container.addChild(sprite);
         sprite.gfxHandle().gotoAndStop(1);
         this.eyes.push(sprite);
         sprite = new SmallEyeEnemySprite();
         this.container.addChild(sprite);
         sprite.gfxHandle().gotoAndStop(1);
         this.eyes.push(sprite);
         sprite = new SmallEyeEnemySprite();
         this.container.addChild(sprite);
         sprite.gfxHandle().gotoAndStop(1);
         this.eyes.push(sprite);
         this.blinkCounters = new Array();
         for(i = 0; i < this.eyes.length; i++)
         {
            this.blinkCounters.push((Math.random() * 4 + 1) * 60);
         }
      }
      
      protected function sleepingAnimation() : void
      {
         var i:int = 0;
         for(i = 0; i < this.eyes.length; i++)
         {
            this.eyes[i].visible = false;
            this.eyes[i].gfxHandle().gfxHandleClip().gotoAndStop(1);
         }
      }
      
      protected function approachingAnimation() : void
      {
         SoundSystem.PlaySound("swoosh");
      }
      
      protected function openingEyesAnimation() : void
      {
         counter1 = 0;
      }
      
      protected function roaringAnimation() : void
      {
      }
      
      protected function chasingAnimation() : void
      {
         Utils.NoMusicBeingPlayed = false;
         SoundSystem.PlayMusic("boss");
      }
      
      protected function destroyedAnimation() : void
      {
         var i:int = 0;
         SoundSystem.PlaySound("black_sun_defeat");
         for(i = 0; i < this.eyes.length; i++)
         {
            this.eyes[i].gfxHandle().gotoAndStop(3);
         }
         xVel = 0;
         counter1 = 0;
         counter2 = 0;
      }
      
      protected function gameOverAnimation() : void
      {
         dead = true;
      }
   }
}
