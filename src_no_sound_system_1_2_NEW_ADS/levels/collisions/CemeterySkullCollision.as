package levels.collisions
{
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.GameSprite;
   import sprites.bullets.FireballBulletSprite;
   import sprites.collisions.CemeterySkullCollisionSprite;
   import sprites.particles.SpiritSmokeParticleSprite;
   import starling.display.Image;
   
   public class CemeterySkullCollision extends Collision
   {
       
      
      protected var stateMachine:StateMachine;
      
      protected var ID:int;
      
      protected var delay:int;
      
      protected var spirit1Image:Image;
      
      protected var spirit1BackImage:Image;
      
      protected var target1X:Number;
      
      protected var target1Y:Number;
      
      protected var spiritsData:Array;
      
      protected var target_counter_1:int;
      
      protected var spirit2Image:Image;
      
      protected var spirit2BackImage:Image;
      
      protected var target2X:Number;
      
      protected var target2Y:Number;
      
      protected var target_counter_2:int;
      
      protected var particleCounter1:int;
      
      protected var particleCounter2:int;
      
      protected var originalDelay:int;
      
      public function CemeterySkullCollision(_level:Level, _xPos:Number, _yPos:Number, _id:int, _delay:int)
      {
         super(_level,_xPos,_yPos);
         WIDTH = HEIGHT = 16;
         this.ID = _id;
         this.originalDelay = this.delay = _delay;
         this.target_counter_1 = this.target_counter_2 = 0;
         this.particleCounter1 = this.particleCounter2 = 0;
         sprite = new CemeterySkullCollisionSprite();
         Utils.topWorld.addChild(sprite);
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_STANDING_STATE","ATTACK_ACTION","IS_ATTACKING_STATE");
         this.stateMachine.setRule("IS_ATTACKING_STATE","END_ACTION","IS_RESTORING_STATE");
         this.stateMachine.setRule("IS_RESTORING_STATE","END_ACTION","IS_STANDING_STATE");
         this.stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         this.stateMachine.setFunctionToState("IS_ATTACKING_STATE",this.attackingAnimation);
         this.stateMachine.setFunctionToState("IS_RESTORING_STATE",this.restoringAnimation);
         this.stateMachine.setState("IS_STANDING_STATE");
         this.initSpirits();
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         Utils.topWorld.removeChild(sprite);
         Utils.backWorld.removeChild(this.spirit1BackImage);
         Utils.topWorld.removeChild(this.spirit1Image);
         Utils.backWorld.removeChild(this.spirit2BackImage);
         Utils.topWorld.removeChild(this.spirit2Image);
         this.spirit1BackImage.dispose();
         this.spirit1Image.dispose();
         this.spirit2BackImage.dispose();
         this.spirit2Image.dispose();
         this.spirit1BackImage = null;
         this.spirit1Image = null;
         this.spirit2BackImage = null;
         this.spirit2Image = null;
         for(i = 0; i < this.spiritsData.length; i++)
         {
            this.spiritsData[i] = null;
         }
         this.spiritsData = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(this.stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(this.ID == 1)
            {
               if(this.delay++ >= 60)
               {
                  this.delay = 0;
                  this.stateMachine.performAction("ATTACK_ACTION");
               }
            }
         }
         else if(this.stateMachine.currentState == "IS_ATTACKING_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               if(isInsideInnerScreen())
               {
                  SoundSystem.PlaySound("fire_ball");
               }
               level.bulletsManager.pushBullet(new FireballBulletSprite(),xPos + 10,yPos + 24,0,2,1,1,0,-1);
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_RESTORING_STATE")
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         if(this.ID == 1)
         {
            this.updateSpirits();
         }
         else
         {
            this.spirit1Image.visible = this.spirit2Image.visible = false;
            this.spirit1BackImage.visible = this.spirit2BackImage.visible = false;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.spirit1Image.x = int(Math.floor(this.spiritsData[0].x - camera.xPos));
         this.spirit1Image.y = int(Math.floor(this.spiritsData[0].y - camera.yPos));
         this.spirit1BackImage.x = this.spirit1Image.x;
         this.spirit1BackImage.y = this.spirit1Image.y;
         this.spirit2Image.x = int(Math.floor(this.spiritsData[1].x - camera.xPos));
         this.spirit2Image.y = int(Math.floor(this.spiritsData[1].y - camera.yPos));
         this.spirit2BackImage.x = this.spirit2Image.x;
         this.spirit2BackImage.y = this.spirit2Image.y;
         sprite.updateScreenPosition();
      }
      
      protected function initSpirits() : void
      {
         this.spirit1Image = new Image(TextureManager.sTextureAtlas.getTexture("spiritFrontPart"));
         this.spirit1Image.pivotX = this.spirit1Image.pivotY = int(this.spirit1Image.width * 0.5);
         this.spirit1BackImage = new Image(TextureManager.sTextureAtlas.getTexture("spiritBackPart"));
         this.spirit1BackImage.pivotX = this.spirit1BackImage.pivotY = int(this.spirit1BackImage.width * 0.5);
         Utils.backWorld.addChild(this.spirit1BackImage);
         Utils.topWorld.addChild(this.spirit1Image);
         this.spirit2Image = new Image(TextureManager.sTextureAtlas.getTexture("spiritFrontPart"));
         this.spirit2Image.pivotX = this.spirit2Image.pivotY = int(this.spirit2Image.width * 0.5);
         this.spirit2BackImage = new Image(TextureManager.sTextureAtlas.getTexture("spiritBackPart"));
         this.spirit2BackImage.pivotX = this.spirit2BackImage.pivotY = int(this.spirit2BackImage.width * 0.5);
         Utils.backWorld.addChild(this.spirit2BackImage);
         Utils.topWorld.addChild(this.spirit2Image);
         this.spiritsData = new Array();
         this.spiritsData.push(new Rectangle(xPos,yPos,Math.random() * Math.PI * 2,Math.random() * Math.PI * 2));
         this.spiritsData.push(new Rectangle(xPos,yPos,Math.random() * Math.PI * 2,Math.random() * Math.PI * 2));
         if(Math.random() * 100 > 50)
         {
            this.spiritsData[0].x = this.target1X = xPos + Math.random() * 10;
            this.spiritsData[0].y = this.target1Y = yPos - (4 + Math.random() * 8);
            this.spiritsData[1].x = this.target2X = xPos + 10 + Math.random() * 10;
            this.spiritsData[1].y = this.target2Y = yPos - (12 + Math.random() * 4);
         }
         else
         {
            this.spiritsData[0].x = this.target1X = xPos + Math.random() * 10;
            this.spiritsData[0].y = this.target1Y = yPos - (12 + Math.random() * 4);
            this.spiritsData[1].x = this.target2X = xPos + 10 + Math.random() * 10;
            this.spiritsData[1].y = this.target2Y = yPos - (4 + Math.random() * 8);
         }
      }
      
      protected function updateSpirits() : void
      {
         var _yVel:Number = NaN;
         var randAngle:Number = NaN;
         var pSprite:GameSprite = null;
         var pBackSprite:GameSprite = null;
         if(isInsideScreen() == false)
         {
            return;
         }
         this.spiritsData[0].width += 0.1;
         this.spiritsData[0].height += 0.1;
         this.spiritsData[1].width += 0.1;
         this.spiritsData[1].height += 0.1;
         this.spiritsData[0].x = this.target1X + Math.sin(this.spiritsData[0].width) * 2;
         this.spiritsData[0].y = this.target1Y + Math.cos(this.spiritsData[0].height) * 2;
         this.spiritsData[1].x = this.target2X + Math.sin(this.spiritsData[1].width) * 2;
         this.spiritsData[1].y = this.target2Y + Math.cos(this.spiritsData[1].height) * 2;
         if(this.particleCounter1++ > 10)
         {
            _yVel = -(Math.random() * 1 + 0.5);
            randAngle = Math.random() * Math.PI * 2;
            this.particleCounter1 = 0;
            pSprite = new SpiritSmokeParticleSprite();
            pSprite.gotoAndStop(1);
            pBackSprite = new SpiritSmokeParticleSprite();
            pBackSprite.gotoAndStop(2);
            level.particlesManager.pushParticle(pSprite,this.spiritsData[0].x,this.spiritsData[0].y,0,_yVel,1,randAngle);
            level.particlesManager.pushBackParticle(pBackSprite,this.spiritsData[0].x,this.spiritsData[0].y,0,_yVel,1,randAngle);
         }
         if(this.particleCounter2++ > 10)
         {
            _yVel = -(Math.random() * 1 + 0.5);
            randAngle = Math.random() * Math.PI * 2;
            this.particleCounter2 = 0;
            pSprite = new SpiritSmokeParticleSprite();
            pSprite.gotoAndStop(1);
            pBackSprite = new SpiritSmokeParticleSprite();
            pBackSprite.gotoAndStop(2);
            level.particlesManager.pushParticle(pSprite,this.spiritsData[1].x,this.spiritsData[1].y,0,_yVel,1,randAngle);
            level.particlesManager.pushBackParticle(pBackSprite,this.spiritsData[1].x,this.spiritsData[1].y,0,_yVel,1,randAngle);
         }
      }
      
      override public function reset() : void
      {
         this.delay = this.originalDelay;
         this.stateMachine.setState("IS_STANDING_STATE");
      }
      
      public function standingAnimation() : void
      {
         sprite.gotoAndStop(1);
         sprite.gfxHandleClip().gotoAndStop(1);
      }
      
      public function attackingAnimation() : void
      {
         sprite.gotoAndStop(2);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      public function restoringAnimation() : void
      {
         sprite.gotoAndStop(3);
         sprite.gfxHandleClip().gotoAndPlay(1);
      }
      
      override public function getMidXPos() : Number
      {
         return xPos;
      }
      
      override public function getMidYPos() : Number
      {
         return yPos;
      }
   }
}
