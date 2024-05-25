package entities.enemies
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.particles.Particle;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.decorations.GenericDecoration;
   import sprites.GameSprite;
   import sprites.decorations.GenericDecorationSprite;
   import sprites.enemies.*;
   import sprites.particles.*;
   import starling.display.Image;
   import starling.filters.ColorMatrixFilter;
   import starling.filters.FragmentFilter;
   import starling.textures.TextureSmoothing;
   
   public class BossSpiderEnemy extends GiantEnemy
   {
       
      
      protected var HITS:int;
      
      protected var IS_ON_TOP_WORLD:Boolean;
      
      protected var FIGHT_STARTED_FLAG:Boolean;
      
      protected var IS_GOING_UP:Boolean;
      
      protected var WAS_WALKING:Boolean;
      
      protected var ATTACK_COUNTER:int;
      
      protected var t_start_y:Number;
      
      protected var t_diff_y:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var rotation_angle:Number;
      
      protected var jumpTarget_xPos:Number;
      
      protected var jumpAt_yPos:Number;
      
      protected var legsSinCounter:Number;
      
      protected var legsWalkSinCounter:Number;
      
      protected var bodyImage:Image;
      
      protected var sxBackLegImage:Image;
      
      protected var dxBackLegImage:Image;
      
      protected var sxFrontLegImage:Image;
      
      protected var dxFrontLegImage:Image;
      
      protected var webImage:Image;
      
      protected var eye1Image:Image;
      
      protected var eye2Image:Image;
      
      protected var eye3Image:Image;
      
      protected var tongue:GenericDecorationSprite;
      
      protected var IS_HIT_HIGHLIGHT:Boolean;
      
      protected var IS_YELLOW:Boolean;
      
      protected var hit_highlight_counter_1:int;
      
      protected var hit_hightlight_counter_2:int;
      
      protected var ATTACKS_COUNTER:int;
      
      protected var first_time_entering_counter:int;
      
      protected var fall_sfx_counter:int;
      
      public function BossSpiderEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         IS_BOSS = true;
         this.FIGHT_STARTED_FLAG = this.IS_GOING_UP = this.WAS_WALKING = false;
         this.t_start_y = this.t_diff_y = this.t_time = this.t_tick = this.jumpTarget_xPos = this.jumpAt_yPos = 0;
         this.first_time_entering_counter = 0;
         this.fall_sfx_counter = 0;
         this.IS_HIT_HIGHLIGHT = this.IS_YELLOW = false;
         this.ATTACK_COUNTER = 0;
         this.hit_highlight_counter_1 = this.hit_hightlight_counter_2 = 0;
         this.legsSinCounter = this.legsWalkSinCounter = this.rotation_angle = 0;
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.HITS = 0;
         this.ATTACKS_COUNTER = 0;
         this.IS_ON_TOP_WORLD = true;
         this.initSprites();
         aabb.x = -24;
         aabb.y = -32;
         aabb.width = 48;
         aabb.height = 64;
         aabbPhysics.x = aabbPhysics.y = aabbPhysics.width = aabbPhysics.height = 0;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_GONE_STATE","ENTER_SCREEN_ACTION","IS_ENTERING_SCREEN_STATE");
         stateMachine.setRule("IS_ENTERING_SCREEN_STATE","GO_UP_ACTION","IS_GOING_UP_STATE");
         stateMachine.setRule("IS_GOING_UP_STATE","END_ACTION","IS_GONE_STATE");
         stateMachine.setRule("IS_GONE_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","END_ACTION","IS_GONE_STATE");
         stateMachine.setRule("IS_ENTERING_SCREEN_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_GOING_UP_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_WALKING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_HURT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","DEAD_ACTION","IS_DEAD_STATE");
         stateMachine.setRule("IS_HURT_STATE","END_ACTION","IS_GOING_UP_STATE");
         stateMachine.setRule("IS_HIT_STATE","END_ACTION","IS_GOING_UP_STATE");
         stateMachine.setFunctionToState("IS_GONE_STATE",this.goneAnimation);
         stateMachine.setFunctionToState("IS_ENTERING_SCREEN_STATE",this.enteringScreenAnimation);
         stateMachine.setFunctionToState("IS_GOING_UP_STATE",this.goingUpAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_PRE_JUMPING_STATE",this.preJumpingAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_GROUND_IMPACT_STATE",this.groundImpactAnimation);
         stateMachine.setFunctionToState("IS_HURT_STATE",this.hurtAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",this.deadAnimation);
         stateMachine.setState("IS_GONE_STATE");
         energy = 8;
      }
      
      override public function destroy() : void
      {
         sprite.removeChild(this.sxBackLegImage);
         sprite.removeChild(this.dxBackLegImage);
         sprite.removeChild(this.sxFrontLegImage);
         sprite.removeChild(this.dxFrontLegImage);
         sprite.removeChild(this.bodyImage);
         sprite.removeChild(this.eye1Image);
         sprite.removeChild(this.eye2Image);
         sprite.removeChild(this.eye3Image);
         sprite.removeChild(this.tongue);
         Utils.topWorld.removeChild(this.webImage);
         this.sxBackLegImage.dispose();
         this.sxBackLegImage.dispose();
         this.sxBackLegImage.dispose();
         this.sxBackLegImage.dispose();
         this.bodyImage.dispose();
         this.eye1Image.dispose();
         this.eye2Image.dispose();
         this.eye3Image.dispose();
         this.tongue.destroy();
         this.tongue.dispose();
         this.webImage.dispose();
         this.sxBackLegImage = null;
         this.sxBackLegImage = null;
         this.sxBackLegImage = null;
         this.sxBackLegImage = null;
         this.bodyImage = null;
         this.eye1Image = null;
         this.eye2Image = null;
         this.eye3Image = null;
         this.tongue = null;
         this.webImage = null;
         Utils.topWorld.removeChild(sprite);
         sprite.destroy();
         sprite.dispose();
         sprite = null;
         if(stateMachine != null)
         {
            stateMachine.destroy();
            stateMachine = null;
         }
         if(stunHandler != null)
         {
            stunHandler.destroy();
            stunHandler = null;
         }
         aabb = aabbPhysics = null;
         level = null;
      }
      
      override public function isTargetable() : Boolean
      {
         if(stateMachine.currentState == "IS_HIT_STATE" || stateMachine.currentState == "IS_GAME_OVER_STATE")
         {
            return false;
         }
         return super.isTargetable();
      }
      
      override protected function allowEnemyDefend() : Boolean
      {
         if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            return true;
         }
         if(stateMachine.currentState == "IS_HURT_STATE")
         {
            return false;
         }
         var mid_hero_xPos:Number = level.hero.getMidXPos();
         var mid_xPos:Number = getMidXPos();
         return false;
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         if(stunHandler)
         {
            stunHandler.update();
            stunHandler.onTop();
         }
         if(BULLET_HIT_FLAG)
         {
            ++bullet_hit_counter1;
            wait_time = 3;
            if(sprite.visible)
            {
               wait_time = 5;
            }
            if(bullet_hit_counter1 >= wait_time)
            {
               bullet_hit_counter1 = 0;
               ++bullet_hit_counter2;
               sprite.visible = !sprite.visible;
               if(bullet_hit_counter2 > 6)
               {
                  sprite.visible = true;
                  BULLET_HIT_FLAG = false;
               }
            }
         }
         --hero_collision_detection_cool_off_counter;
         if(hero_collision_detection_cool_off_counter < 0)
         {
            hero_collision_detection_cool_off_counter = 0;
         }
         if(stateMachine.currentState == "IS_GONE_STATE")
         {
            if(this.FIGHT_STARTED_FLAG)
            {
               ++counter1;
               if(counter1 >= 5)
               {
                  if(level.hero.getMidXPos() < 824)
                  {
                     xPos = 776;
                  }
                  else if(level.hero.getMidXPos() > 920)
                  {
                     xPos = 968;
                  }
                  else
                  {
                     xPos = 872;
                  }
                  ++this.ATTACKS_COUNTER;
                  if(this.HITS > 0)
                  {
                     if(this.ATTACK_COUNTER++ < 2)
                     {
                        stateMachine.performAction("WALK_ACTION");
                     }
                     else
                     {
                        stateMachine.performAction("ENTER_SCREEN_ACTION");
                        this.ATTACK_COUNTER = 0;
                     }
                  }
                  else
                  {
                     stateMachine.performAction("ENTER_SCREEN_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_ENTERING_SCREEN_STATE")
         {
            if(this.first_time_entering_counter > -1)
            {
               ++this.first_time_entering_counter;
               if(this.first_time_entering_counter == 40)
               {
                  SoundSystem.PlaySound("spider_voice");
                  this.first_time_entering_counter = -1;
               }
            }
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
            }
            yPos = Easings.easeOutElastic(this.t_tick,this.t_start_y,this.t_diff_y,this.t_time);
            if(this.FIGHT_STARTED_FLAG)
            {
               if(counter1++ > 90)
               {
                  stateMachine.performAction("GO_UP_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_GOING_UP_STATE")
         {
            yVel -= 0.2;
            yVel *= 0.9;
            yPos += yVel;
            this.legsSinCounter += yVel * 0.4;
            if(this.legsSinCounter >= Math.PI * 2)
            {
               this.legsSinCounter -= Math.PI * 2;
               SoundSystem.PlaySound("spider_leg");
            }
            else if(this.legsSinCounter <= -Math.PI * 2)
            {
               SoundSystem.PlaySound("spider_leg");
               this.legsSinCounter += Math.PI * 2;
            }
            if(yPos <= level.camera.yPos - 64)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(this.IS_GOING_UP)
            {
               yVel -= 0.4;
            }
            else
            {
               yVel += 0.4;
            }
            yVel *= 0.85;
            yPos += yVel;
            this.legsWalkSinCounter += yVel * 0.2;
            if(this.legsWalkSinCounter >= Math.PI * 2)
            {
               this.legsWalkSinCounter -= Math.PI * 2;
               SoundSystem.PlaySound("spider_leg");
            }
            else if(this.legsWalkSinCounter <= -Math.PI * 2)
            {
               this.legsWalkSinCounter += Math.PI * 2;
               SoundSystem.PlaySound("spider_leg");
            }
            if(!this.IS_GOING_UP)
            {
               if(yPos >= 128 && !this.IS_GOING_UP)
               {
                  this.IS_GOING_UP = true;
                  stateMachine.performAction("TURN_ACTION");
               }
               else if(counter1-- < 0)
               {
                  stateMachine.performAction("STOP_ACTION");
               }
            }
            else if(yPos <= level.camera.yPos - 64)
            {
               this.rotation_angle = 0;
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(counter1-- < 0)
            {
               stateMachine.performAction("WALK_ACTION");
            }
            else if(yPos <= 64)
            {
               if(Math.abs(level.hero.getMidXPos() - xPos) >= 64)
               {
                  this.IS_GOING_UP = true;
                  stateMachine.performAction("TURN_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               stateMachine.performAction("WALK_ACTION");
            }
            this.rotation_angle = Easings.linear(this.t_tick,this.t_start_y,this.t_diff_y,this.t_time);
            this.legsWalkSinCounter += 0.5;
            if(this.legsWalkSinCounter >= Math.PI * 2)
            {
               this.legsWalkSinCounter -= Math.PI * 2;
               SoundSystem.PlaySound("spider_leg");
            }
            else if(this.legsWalkSinCounter <= -Math.PI * 2)
            {
               this.legsWalkSinCounter += Math.PI * 2;
               SoundSystem.PlaySound("spider_leg");
            }
         }
         else if(stateMachine.currentState == "IS_HURT_STATE")
         {
            yVel -= 0.2;
            yVel *= 0.9;
            yPos += yVel;
            if(yVel <= -0.5)
            {
               yVel = -0.5;
            }
            if(this.WAS_WALKING)
            {
               this.legsWalkSinCounter += yVel * 0.4;
               if(this.legsWalkSinCounter >= Math.PI * 2)
               {
                  this.legsWalkSinCounter -= Math.PI * 2;
                  SoundSystem.PlaySound("spider_leg");
               }
               else if(this.legsWalkSinCounter <= -Math.PI * 2)
               {
                  this.legsWalkSinCounter += Math.PI * 2;
                  SoundSystem.PlaySound("spider_leg");
               }
            }
            else
            {
               this.legsSinCounter += yVel * 0.2;
               if(this.legsSinCounter >= Math.PI * 2)
               {
                  this.legsSinCounter -= Math.PI * 2;
                  SoundSystem.PlaySound("spider_leg");
               }
               else if(this.legsSinCounter <= -Math.PI * 2)
               {
                  this.legsSinCounter += Math.PI * 2;
                  SoundSystem.PlaySound("spider_leg");
               }
            }
            if(yPos <= level.camera.yPos - 64)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            if(counter1++ > 30)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_DEAD_STATE")
         {
            ++this.fall_sfx_counter;
            if(this.fall_sfx_counter == 1)
            {
               SoundSystem.PlaySound("flyingship_falldown");
            }
            this.webImage.visible = false;
            yPos += yVel;
            yVel += 0.2;
            if(yPos >= 416)
            {
               dead = true;
               SoundSystem.PlaySound("big_impact");
               level.camera.shake();
            }
         }
         if(this.IS_HIT_HIGHLIGHT)
         {
            ++this.hit_highlight_counter_1;
            if(this.hit_highlight_counter_1 > 3)
            {
               this.hit_highlight_counter_1 = 0;
               ++this.hit_hightlight_counter_2;
               if(!this.IS_YELLOW)
               {
                  sprite.filter = new ColorMatrixFilter();
                  ColorMatrixFilter(sprite.filter).adjustBrightness(1);
                  ColorMatrixFilter(sprite.filter).tint(268431360,1);
               }
               else
               {
                  sprite.filter = null;
               }
               this.IS_YELLOW = !this.IS_YELLOW;
               if(this.hit_hightlight_counter_2 > 9)
               {
                  sprite.filter = null;
                  this.setYellowHighlight(false);
               }
            }
         }
         this.onTop();
      }
      
      override public function setEmotionParticle(emotion_id:int) : void
      {
         var pSprite:GameSprite = null;
         var particle:Particle = null;
         if(emotion_id == Entity.EMOTION_WORRIED)
         {
            pSprite = new WorriedParticleSprite();
            if(DIRECTION == Entity.LEFT)
            {
               particle = level.particlesManager.pushParticle(pSprite,9,-2,0,0,1);
            }
            else
            {
               particle = level.particlesManager.pushParticle(pSprite,0,-2,0,0,1);
            }
            particle.entity = this;
         }
         else if(emotion_id == Entity.EMOTION_SHOCKED)
         {
            super.setEmotionParticle(emotion_id);
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         sprite.x = int(Math.floor(xPos - camera.xPos));
         sprite.y = int(Math.floor(yPos - camera.yPos));
         this.webImage.x = sprite.x - 2;
         this.webImage.y = 0;
         this.webImage.height = sprite.y - 27;
         sprite.rotation = this.rotation_angle;
         this.sxBackLegImage.x = int(-33);
         this.dxBackLegImage.x = int(33);
         this.sxBackLegImage.y = int(-47 + Math.sin(this.legsSinCounter) * 3 + Math.sin(this.legsWalkSinCounter) * 3);
         this.dxBackLegImage.y = int(-47 - Math.sin(this.legsSinCounter) * 3 + Math.sin(this.legsWalkSinCounter) * 3);
         this.sxFrontLegImage.x = int(-40);
         this.dxFrontLegImage.x = int(40);
         this.sxFrontLegImage.y = this.dxFrontLegImage.y = int(-2 - Math.sin(this.legsWalkSinCounter) * 3);
         this.tongue.x = -12;
         this.tongue.y = 24;
         this.eye1Image.x = -16;
         this.eye1Image.y = 12;
         this.eye2Image.x = -5;
         this.eye2Image.y = 14;
         this.eye3Image.x = 6;
         this.eye3Image.y = 12;
         this.tongue.updateScreenPosition();
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            this.onTop();
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
      }
      
      override public function noGroundCollision() : void
      {
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_HURT_STATE")
         {
            if(sprite.gfxHandle().frame == 7)
            {
               level.particlesManager.createDust(xPos + 8,yPos + 32,Entity.LEFT);
               level.particlesManager.createDust(xPos + 32 - 8,yPos + 32,Entity.RIGHT);
               sprite.gfxHandle().gotoAndStop(8);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               level.camera.verShake(8,0.9);
            }
         }
         else if(stateMachine.currentState == "IS_HIT_STATE")
         {
            stateMachine.performAction("GROUND_COLLISION_ACTION");
         }
      }
      
      override public function wallCollision(t_value:int = 1) : void
      {
      }
      
      override public function defend(_source_x:Number = 0, _source_y:Number = 0, _isCatAttacking:Boolean = false) : *
      {
      }
      
      public function goneAnimation() : void
      {
         yPos = level.camera.yPos - 64;
         counter1 = counter2 = 0;
         this.rotation_angle = 0;
         stunHandler.unstun();
         this.webImage.visible = true;
      }
      
      public function enteringScreenAnimation() : void
      {
         SoundSystem.PlaySound("bounce");
         this.WAS_WALKING = false;
         this.setEyesVisible(false);
         stunHandler.unstun();
         Utils.topWorld.setChildIndex(sprite,Utils.topWorld.numChildren - 1);
         this.t_start_y = yPos;
         this.t_diff_y = 96 - this.t_start_y;
         this.t_time = 5;
         this.t_tick = 0;
         counter1 = 0;
      }
      
      public function goingUpAnimation() : void
      {
         this.setEyesVisible(false);
         this.FIGHT_STARTED_FLAG = true;
      }
      
      public function walkingAnimation() : void
      {
         this.WAS_WALKING = true;
         if(stateMachine.lastState == "IS_GONE_STATE")
         {
            this.IS_GOING_UP = false;
            if(level.hero.getMidXPos() < 872)
            {
               xPos = 824;
            }
            else
            {
               xPos = 920;
            }
         }
         this.webImage.visible = false;
         this.setEyesVisible(false);
         this.legsSinCounter = 0;
         counter1 = 30 + Math.random() * 120;
         counter2 = 0;
         xVel = yVel = 0;
      }
      
      public function standingAnimation() : void
      {
         this.addFragmentFilter(false);
         this.WAS_WALKING = true;
         sprite.visible = true;
         this.setEyesVisible(false);
         counter2 = counter3 = 0;
         counter1 = (Math.random() * 2 + 1) * 30;
         xVel = 0;
      }
      
      public function turningAnimation() : void
      {
         this.addFragmentFilter(true);
         this.WAS_WALKING = true;
         this.t_start_y = 0;
         this.t_diff_y = Math.PI;
         this.t_time = 0.75;
         this.t_tick = 0;
         sprite.visible = true;
         this.setEyesVisible(false);
         counter1 = 0;
         xVel = 0;
      }
      
      protected function addFragmentFilter(_value:Boolean) : void
      {
         if(_value)
         {
            sprite.filter = new FragmentFilter();
            FragmentFilter(sprite.filter).resolution = Utils.GFX_INV_SCALE;
            FragmentFilter(sprite.filter).textureSmoothing = TextureSmoothing.NONE;
         }
         else if(sprite.filter != null)
         {
            sprite.filter.dispose();
            sprite.filter = null;
         }
      }
      
      public function preJumpingAnimation() : void
      {
         sprite.visible = true;
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         xVel = 0;
      }
      
      public function jumpingAnimation() : void
      {
         sprite.visible = true;
         level.particlesManager.createDust(xPos + 8,yPos + 32,Entity.LEFT);
         level.particlesManager.createDust(xPos + 32 - 8,yPos + 32,Entity.RIGHT);
         sprite.gfxHandle().gotoAndStop(6);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         xVel = 0;
      }
      
      public function groundImpactAnimation() : void
      {
         sprite.visible = true;
         level.particlesManager.createDust(xPos + 8,yPos + 32,Entity.LEFT);
         level.particlesManager.createDust(xPos + 32 - 8,yPos + 32,Entity.RIGHT);
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         level.camera.verShake(16,0.9);
         counter1 = counter2 = counter3 = 0;
         xVel = 0;
      }
      
      override public function hurtAnimation() : void
      {
         super.hurtAnimation();
         this.addFragmentFilter(false);
         this.setEyesVisible(true);
         sprite.visible = true;
         energy = 8;
         counter1 = counter2 = counter3 = 0;
      }
      
      override protected function restoreEnergy() : void
      {
         energy = 8;
      }
      
      public function hitAnimation() : void
      {
         this.setEyesVisible(true);
         sprite.visible = true;
         energy = 8;
         stunHandler.unstun();
         ++this.HITS;
         SoundSystem.PlaySound("spider_defeat");
         this.setYellowHighlight(true);
         counter1 = counter2 = counter3 = 0;
         if(this.HITS >= 3)
         {
            stateMachine.performAction("DEAD_ACTION");
         }
      }
      
      override public function deadAnimation() : void
      {
         sprite.visible = true;
         level.freezeAction(60);
         level.camera.shake();
         this.tongue.gfxHandleClip().gotoAndStop(1);
         xVel = 0;
         yVel = -4;
         AVOID_COLLISION_DETECTION = true;
         this.setYellowHighlight(false);
      }
      
      protected function setYellowHighlight(value:Boolean) : void
      {
         this.IS_HIT_HIGHLIGHT = value;
         this.IS_YELLOW = false;
         this.hit_highlight_counter_1 = this.hit_hightlight_counter_2 = 0;
         if(value)
         {
            this.hit_highlight_counter_1 = 30;
         }
      }
      
      override public function onTop() : void
      {
         Utils.topWorld.setChildIndex(sprite,Utils.topWorld.numChildren - 1);
      }
      
      protected function initSprites() : void
      {
         stunHandler.stun_x_offset = -14;
         sprite = new GameSprite();
         Utils.topWorld.addChild(sprite);
         this.bodyImage = new Image(TextureManager.sTextureAtlas.getTexture("giantSpiderEnemyBody_a"));
         this.bodyImage.x = -24;
         this.bodyImage.y = -28;
         this.bodyImage.touchable = false;
         this.sxBackLegImage = new Image(TextureManager.sTextureAtlas.getTexture("giantSpiderEnemyRearLegs_a"));
         this.dxBackLegImage = new Image(TextureManager.sTextureAtlas.getTexture("giantSpiderEnemyRearLegs_a"));
         this.sxFrontLegImage = new Image(TextureManager.sTextureAtlas.getTexture("giantSpiderEnemyFrontLegs_a"));
         this.dxFrontLegImage = new Image(TextureManager.sTextureAtlas.getTexture("giantSpiderEnemyFrontLegs_a"));
         this.sxBackLegImage.touchable = this.dxBackLegImage.touchable = this.sxFrontLegImage.touchable = this.dxFrontLegImage.touchable = false;
         this.dxBackLegImage.scaleX = this.dxFrontLegImage.scaleX = -1;
         this.tongue = new GenericDecorationSprite(GenericDecoration.GIANT_SPIDER_TONGUE);
         this.eye1Image = new Image(TextureManager.sTextureAtlas.getTexture("giantSpiderEnemyEye_a"));
         this.eye2Image = new Image(TextureManager.sTextureAtlas.getTexture("giantSpiderEnemyEye_a"));
         this.eye3Image = new Image(TextureManager.sTextureAtlas.getTexture("giantSpiderEnemyEye_a"));
         this.eye1Image.touchable = this.eye2Image.touchable = this.eye3Image.touchable = false;
         this.setEyesVisible(false);
         sprite.addChild(this.sxBackLegImage);
         sprite.addChild(this.dxBackLegImage);
         sprite.addChild(this.sxFrontLegImage);
         sprite.addChild(this.dxFrontLegImage);
         sprite.addChild(this.bodyImage);
         sprite.addChild(this.eye1Image);
         sprite.addChild(this.eye2Image);
         sprite.addChild(this.eye3Image);
         sprite.addChild(this.tongue);
         this.webImage = new Image(TextureManager.sTextureAtlas.getTexture("spider_web_body"));
         this.webImage.touchable = false;
         Utils.topWorld.addChild(this.webImage);
      }
      
      protected function setEyesVisible(value:Boolean) : void
      {
         this.eye1Image.visible = this.eye2Image.visible = this.eye3Image.visible = value;
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos + _offset,level.camera.yPos + _offset,level.camera.WIDTH - _offset * 2,level.camera.HEIGHT - _offset * 2);
         var area:Rectangle = new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
      
      override public function checkHeroCollisionDetection(hero:Hero) : void
      {
         if(stateMachine.currentState == "IS_HIT_STATE" || stateMachine.currentState == "IS_DEAD_STATE" || dead || hero.stunHandler.IS_STUNNED && hero.stunHandler.stun_counter_1 < 10)
         {
            return;
         }
         if(hero_collision_detection_cool_off_counter > 0)
         {
            return;
         }
         var isCatAttacking:Boolean = false;
         var isEnemyDefending:Boolean = false;
         if(hero.getAABB().intersects(getAABB()))
         {
            if(hero.stateMachine.currentState == "IS_RUNNING_STATE" || hero.stateMachine.currentState == "IS_JUMPING_STATE" || hero.stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || specialAttackCondition())
            {
               if(allowCatAttack())
               {
                  isCatAttacking = true;
               }
            }
            if(this.allowEnemyDefend())
            {
               isEnemyDefending = true;
            }
            if(hero.stateMachine.currentState == "IS_INSIDE_VEHICLE_STATE" && allowCatAttack())
            {
               isCatAttacking = true;
            }
            if(isCatAttacking)
            {
               if(isEnemyDefending)
               {
                  hero.enemyDefend(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
               }
            }
            else if(hero.stateMachine.currentState != "IS_HEAD_POUND_STATE")
            {
               hero.hurt(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
            }
            if(hero.stateMachine.currentState != "IS_GAME_OVER_STATE")
            {
               if(isEnemyDefending)
               {
                  this.defend(hero.getMidXPos(),hero.getMidYPos(),isCatAttacking);
               }
               else if(isCatAttacking)
               {
                  hit(hero.getMidXPos(),hero.getMidYPos(),isCatAttacking);
                  hero.attack(xPos + WIDTH * 0.5,yPos + HEIGHT * 0.5,this);
                  hero.stateMachine.performAction("WALL_COLLISION_ACTION");
               }
            }
         }
      }
   }
}
