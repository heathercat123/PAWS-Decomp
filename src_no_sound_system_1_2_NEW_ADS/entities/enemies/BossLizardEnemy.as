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
   import sprites.GameSprite;
   import sprites.enemies.*;
   import sprites.particles.WorriedParticleSprite;
   import starling.display.Image;
   import starling.filters.ColorMatrixFilter;
   
   public class BossLizardEnemy extends GiantEnemy
   {
       
      
      protected var HITS:int;
      
      protected var IS_ON_TOP_WORLD:Boolean;
      
      protected var t_start_x:Number;
      
      protected var t_diff_x:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var jumpTarget_xPos:Number;
      
      protected var jumpAt_yPos:Number;
      
      protected var tongueImage1:Image;
      
      protected var tongueImage2:Image;
      
      protected var tongueImage3:Image;
      
      protected var tongueStart_xPos:Number;
      
      protected var tongueEnd_xPos:Number;
      
      protected var tongue_yPos:Number;
      
      protected var hero_tongue_xDiff:Number;
      
      protected var JUMP_AMOUNTS:int;
      
      protected var TONGUE_HIT_FLAG:Boolean;
      
      protected var IS_HIT_HIGHLIGHT:Boolean;
      
      protected var IS_YELLOW:Boolean;
      
      protected var hit_highlight_counter_1:int;
      
      protected var hit_hightlight_counter_2:int;
      
      public function BossLizardEnemy(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,0);
         IS_BOSS = true;
         this.t_start_x = this.t_diff_x = this.t_time = this.t_tick = 0;
         this.jumpTarget_xPos = this.jumpAt_yPos = 0;
         this.tongueStart_xPos = this.tongueEnd_xPos = 0;
         this.tongue_yPos = 0;
         this.IS_HIT_HIGHLIGHT = this.IS_YELLOW = false;
         this.hit_highlight_counter_1 = this.hit_hightlight_counter_2 = 0;
         WIDTH = 32;
         HEIGHT = 32;
         speed = 0.8;
         MAX_Y_VEL = 4;
         MAX_X_VEL = 2;
         this.HITS = 0;
         this.JUMP_AMOUNTS = 0;
         this.TONGUE_HIT_FLAG = false;
         sprite = new LizardBossEnemySprite();
         Utils.world.addChild(sprite);
         this.tongueImage1 = new Image(TextureManager.sTextureAtlas.getTexture("lizardBossTongue1"));
         this.tongueImage2 = new Image(TextureManager.sTextureAtlas.getTexture("lizardBossTongue2"));
         this.tongueImage3 = new Image(TextureManager.sTextureAtlas.getTexture("lizardBossTongue3"));
         this.tongueImage1.pivotX = int(this.tongueImage1.width * 0.5);
         this.tongueImage1.pivotY = int(this.tongueImage1.height * 0.5);
         this.tongueImage3.pivotX = int(this.tongueImage3.width * 0.5);
         this.tongueImage3.pivotY = int(this.tongueImage3.height * 0.5);
         this.tongueImage1.touchable = this.tongueImage2.touchable = this.tongueImage3.touchable = false;
         Utils.world.addChild(this.tongueImage1);
         Utils.world.addChild(this.tongueImage2);
         Utils.world.addChild(this.tongueImage3);
         this.setTongueVisible(false);
         aabb.x = aabb.y = 0;
         aabb.width = aabb.height = 32;
         aabbPhysics.x = -8;
         aabbPhysics.y = 0;
         aabbPhysics.width = 48;
         aabbPhysics.height = 32;
         counter2 = int(Math.random() * 5 + 2) * 5;
         counter3 = int(Math.round(Math.random() * 2 + 1)) * 60;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_FALLING_FROM_SKY_STATE","GROUND_COLLISION_ACTION","IS_INTRO_IMPACT_STATE");
         stateMachine.setRule("IS_INTRO_IMPACT_STATE","END_ACTION","IS_WAITING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","JUMP_ACTION","IS_PRE_JUMPING_STATE");
         stateMachine.setRule("IS_PRE_JUMPING_STATE","END_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","ATTACK_ACTION","IS_OPENING_MOUTH_STATE");
         stateMachine.setRule("IS_OPENING_MOUTH_STATE","END_ACTION","IS_TONGUE_OUT_STATE");
         stateMachine.setRule("IS_TONGUE_OUT_STATE","CAUGHT_HERO_ACTION","IS_TONGUE_IN_STATE");
         stateMachine.setRule("IS_TONGUE_OUT_STATE","SNAP_ACTION","IS_TONGUE_SNAPPING_BACK_STATE");
         stateMachine.setRule("IS_TONGUE_IN_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_TONGUE_IN_STATE","SNAP_ACTION","IS_TONGUE_SNAPPING_BACK_STATE");
         stateMachine.setRule("IS_TONGUE_SNAPPING_BACK_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","GROUND_COLLISION_ACTION","IS_GROUND_IMPACT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","TOO_CLOSE_TO_HERO_ACTION","IS_JUMPING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_TURNING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_PRE_JUMPING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_JUMPING_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_GROUND_IMPACT_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_OPENING_MOUTH_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_TONGUE_OUT_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_TONGUE_IN_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_TONGUE_SNAPPING_BACK_STATE","HIT_ACTION","IS_HURT_STATE");
         stateMachine.setRule("IS_HURT_STATE","HIT_ACTION","IS_HIT_STATE");
         stateMachine.setRule("IS_HIT_STATE","DEAD_ACTION","IS_DEAD_STATE");
         stateMachine.setRule("IS_HURT_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_HIT_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setFunctionToState("IS_FALLING_FROM_SKY_STATE",this.fallingFromSkyAnimation);
         stateMachine.setFunctionToState("IS_INTRO_IMPACT_STATE",this.introImpactAnimation);
         stateMachine.setFunctionToState("IS_WAITING_STATE",this.waitingAnimation);
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_PRE_JUMPING_STATE",this.preJumpingAnimation);
         stateMachine.setFunctionToState("IS_JUMPING_STATE",this.jumpingAnimation);
         stateMachine.setFunctionToState("IS_GROUND_IMPACT_STATE",this.groundImpactAnimation);
         stateMachine.setFunctionToState("IS_OPENING_MOUTH_STATE",this.openMouthAnimation);
         stateMachine.setFunctionToState("IS_TONGUE_OUT_STATE",this.tongueOutAnimation);
         stateMachine.setFunctionToState("IS_TONGUE_IN_STATE",this.tongueInAnimation);
         stateMachine.setFunctionToState("IS_TONGUE_SNAPPING_BACK_STATE",this.tongueSnapBackAnimation);
         stateMachine.setFunctionToState("IS_HURT_STATE",this.hurtAnimation);
         stateMachine.setFunctionToState("IS_HIT_STATE",this.hitAnimation);
         stateMachine.setFunctionToState("IS_DEAD_STATE",this.deadAnimation);
         stateMachine.setState("IS_STANDING_STATE");
         energy = 4;
      }
      
      override public function destroy() : void
      {
         if(this.IS_ON_TOP_WORLD)
         {
            Utils.topWorld.removeChild(sprite);
         }
         else
         {
            Utils.world.removeChild(sprite);
         }
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
         if(stateMachine.currentState == "IS_JUMPING_STATE" || stateMachine.currentState == "IS_TONGUE_OUT_STATE" || stateMachine.currentState == "IS_TONGUE_IN_STATE" || stateMachine.currentState == "IS_TONGUE_SNAPPING_BACK_STATE")
         {
            return true;
         }
         if(stateMachine.currentState == "IS_HURT_STATE")
         {
            return false;
         }
         var mid_hero_xPos:Number = level.hero.getMidXPos();
         var mid_xPos:Number = getMidXPos();
         if(DIRECTION == Entity.LEFT && mid_hero_xPos > mid_xPos)
         {
            return false;
         }
         if(DIRECTION == Entity.RIGHT && mid_hero_xPos < mid_xPos)
         {
            return false;
         }
         return true;
      }
      
      override public function update() : void
      {
         var wait_time:int = 0;
         var _perc:Number = NaN;
         if(stunHandler)
         {
            stunHandler.update();
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
         if(stateMachine.currentState == "IS_FALLING_FROM_SKY_STATE")
         {
            yPos += 8;
            yVel = 2;
         }
         else if(stateMachine.currentState != "IS_INTRO_IMPACT_STATE")
         {
            if(stateMachine.currentState == "IS_WAITING_STATE")
            {
            }
         }
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            ++counter1;
            if(DIRECTION == Entity.LEFT && level.hero.getMidXPos() > getMidXPos() || DIRECTION == Entity.RIGHT && level.hero.getMidXPos() < getMidXPos() && counter1 > 15)
            {
               stateMachine.performAction("TURN_ACTION");
            }
            else if(counter1 >= 30)
            {
               if(this.JUMP_AMOUNTS > 2 && Math.abs(getMidXPos() - level.hero.getMidXPos()) > 64)
               {
                  this.JUMP_AMOUNTS = 0;
                  stateMachine.performAction("ATTACK_ACTION");
               }
               else
               {
                  ++this.JUMP_AMOUNTS;
                  stateMachine.performAction("JUMP_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_PRE_JUMPING_STATE")
         {
            ++counter1;
            if(counter1 >= 15)
            {
               this.jumpTarget_xPos = level.hero.getMidXPos();
               if(this.jumpTarget_xPos < 640)
               {
                  this.jumpTarget_xPos = 640;
               }
               else if(this.jumpTarget_xPos > 864)
               {
                  this.jumpTarget_xPos = 864;
               }
               this.jumpAt_yPos = yPos;
               this.t_start_x = xPos;
               this.t_diff_x = this.jumpTarget_xPos - WIDTH * 0.5 - this.t_start_x;
               this.t_tick = 0;
               if(this.HITS == 0)
               {
                  this.t_time = 1.5;
               }
               else if(this.HITS == 1)
               {
                  this.t_time = 1.25;
               }
               else
               {
                  this.t_time = 1;
               }
               level.camera.shake(4);
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_JUMPING_STATE")
         {
            _perc = this.t_tick / this.t_time;
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               SoundSystem.PlaySound("big_impact");
               this.t_tick = this.t_time;
               stateMachine.performAction("GROUND_COLLISION_ACTION");
            }
            xPos = Easings.linear(this.t_tick,this.t_start_x,this.t_diff_x,this.t_time);
            yPos = this.jumpAt_yPos - Math.sin(_perc * Math.PI) * 80;
            yVel = 0;
         }
         else if(stateMachine.currentState == "IS_GROUND_IMPACT_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               yPos -= 24;
               SoundSystem.PlaySound("enemy_jump_low");
               stateMachine.performAction("END_ACTION");
            }
            else if((level.hero.getMidXPos() > 864 || level.hero.getMidXPos() < 640) && Math.abs(level.hero.getMidXPos() - getMidXPos()) < 24)
            {
               this.jumpTarget_xPos = 752;
               this.jumpAt_yPos = yPos;
               this.t_start_x = xPos;
               this.t_diff_x = this.jumpTarget_xPos - WIDTH * 0.5 - this.t_start_x;
               this.t_tick = 0;
               this.t_time = 1.5;
               level.camera.shake(4);
               stateMachine.performAction("TOO_CLOSE_TO_HERO_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_OPENING_MOUTH_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TONGUE_OUT_STATE")
         {
            if(DIRECTION == Entity.LEFT)
            {
               this.tongueEnd_xPos -= 4;
            }
            else
            {
               this.tongueEnd_xPos += 4;
            }
            if(this.tongueEnd_xPos <= 628)
            {
               this.tongueEnd_xPos = 628;
               this.TONGUE_HIT_FLAG = false;
               stateMachine.performAction("SNAP_ACTION");
            }
            else if(this.tongueEnd_xPos >= 876)
            {
               this.tongueEnd_xPos = 876;
               this.TONGUE_HIT_FLAG = false;
               stateMachine.performAction("SNAP_ACTION");
            }
            else if(this.isHeroCollidingWithTongue())
            {
               stateMachine.performAction("CAUGHT_HERO_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TONGUE_IN_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               if(counter2++ > 0)
               {
                  counter2 = 0;
                  if(DIRECTION == Entity.LEFT)
                  {
                     this.tongueEnd_xPos += 2;
                  }
                  else
                  {
                     this.tongueEnd_xPos -= 2;
                  }
               }
            }
            level.hero.xPos = this.tongueEnd_xPos + this.hero_tongue_xDiff;
            level.hero.ropeMidX = level.hero.xPos;
            if(level.hero.stateMachine.currentState == "IS_STUN_STATE" || level.hero.stateMachine.currentState == "IS_GAME_OVER_STATE")
            {
               stateMachine.performAction("END_ACTION");
               yPos -= 24;
            }
            else if(level.hero.stateMachine.currentState != "IS_GLUED_STATE")
            {
               this.TONGUE_HIT_FLAG = false;
               if(Math.abs(this.tongueEnd_xPos - this.tongueStart_xPos) > 48)
               {
                  this.TONGUE_HIT_FLAG = true;
               }
               stateMachine.performAction("SNAP_ACTION");
            }
            else if(DIRECTION == Entity.LEFT)
            {
               if(this.tongueEnd_xPos >= this.tongueStart_xPos)
               {
                  stateMachine.performAction("END_ACTION");
               }
            }
            else if(this.tongueEnd_xPos <= this.tongueStart_xPos)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TONGUE_SNAPPING_BACK_STATE")
         {
            if(DIRECTION == Entity.LEFT)
            {
               this.tongueEnd_xPos += 16;
               if(this.tongueEnd_xPos >= this.tongueStart_xPos)
               {
                  if(this.TONGUE_HIT_FLAG)
                  {
                     level.camera.shake(4);
                     level.particlesManager.hurtImpactParticle(this,xPos,getMidYPos());
                     stateMachine.performAction("HIT_ACTION");
                     SoundSystem.PlaySound("enemy_hit");
                  }
                  else
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
            else
            {
               this.tongueEnd_xPos -= 16;
               if(this.tongueEnd_xPos <= this.tongueStart_xPos)
               {
                  if(this.TONGUE_HIT_FLAG)
                  {
                     level.camera.shake(4);
                     level.particlesManager.hurtImpactParticle(this,xPos + WIDTH,getMidYPos());
                     stateMachine.performAction("HIT_ACTION");
                     stateMachine.performAction("HIT_ACTION");
                  }
                  else
                  {
                     stateMachine.performAction("END_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_HURT_STATE")
         {
            if(stunHandler.IS_STUNNED == false)
            {
               yPos -= 24;
               this.restoreEnergy();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_DEAD_STATE")
         {
            if(counter3++ == 1)
            {
               SoundSystem.PlaySound("flyingship_falldown");
            }
            if(yPos >= 416)
            {
               dead = true;
               SoundSystem.PlaySound("big_impact");
               level.camera.shake();
            }
         }
         if(stateMachine.currentState == "IS_TONGUE_IN_STATE")
         {
            aabb.x = -24;
            aabb.width = 80;
         }
         else if(stateMachine.currentState == "IS_STANDING_STATE" || stateMachine.currentState == "IS_GROUND_IMPACT_STATE" || stateMachine.currentState == "IS_PRE_JUMPING_STATE")
         {
            aabb.x = aabb.y = 0;
            aabb.width = aabb.height = 32;
            if(DIRECTION == Entity.RIGHT)
            {
               aabb.x -= 10;
               aabb.width += 10;
            }
            else
            {
               aabb.width += 10;
            }
         }
         else if(stateMachine.currentState == "IS_HURT_STATE")
         {
            aabb.x = aabb.y = 0;
            aabb.width = aabb.height = 32;
            aabb.x -= 8;
            aabb.width += 16;
         }
         else
         {
            aabb.x = aabb.y = 0;
            aabb.width = aabb.height = 32;
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
         integratePositionAndCollisionDetection();
      }
      
      override public function playSound(sfx_name:String) : void
      {
         if(sfx_name == "hurt")
         {
            if(stunHandler.IS_STUNNED)
            {
               SoundSystem.PlaySound("big_enemy_hurt");
            }
            else
            {
               SoundSystem.PlaySound("big_enemy_hit");
            }
         }
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
         if(sprite.gfxHandle().frame == 7)
         {
            if(DIRECTION == Entity.LEFT)
            {
               stunHandler.stun_x_offset = -1;
            }
            else
            {
               stunHandler.stun_x_offset = 7;
            }
            stunHandler.stun_y_offset = -19;
         }
         else
         {
            if(DIRECTION == Entity.LEFT)
            {
               stunHandler.stun_x_offset = -8;
            }
            else
            {
               stunHandler.stun_x_offset = 12;
            }
            stunHandler.stun_y_offset = 0;
         }
         if(sprite.gfxHandle() != null)
         {
            if(DIRECTION == LEFT)
            {
               sprite.gfxHandle().scaleX = 1;
            }
            else
            {
               sprite.gfxHandle().scaleX = -1;
            }
            this.tongueImage1.scaleX = this.tongueImage3.scaleX = sprite.gfxHandle().scaleX;
         }
         if(stateMachine.currentState == "IS_HIT_STATE")
         {
            this.onTop();
         }
         this.tongueImage1.x = int(Math.floor(this.tongueStart_xPos - camera.xPos));
         this.tongueImage1.y = int(Math.floor(this.tongue_yPos - camera.yPos));
         this.tongueImage3.x = int(Math.floor(this.tongueEnd_xPos - camera.xPos));
         this.tongueImage3.y = this.tongueImage1.y;
         if(DIRECTION == Entity.LEFT)
         {
            this.tongueImage2.x = this.tongueImage3.x + 5;
            this.tongueImage2.y = this.tongueImage3.y - 2;
            this.tongueImage2.width = int(this.tongueImage1.x - this.tongueImage3.x) - 7;
         }
         else
         {
            this.tongueImage2.x = this.tongueImage1.x + 2;
            this.tongueImage2.y = this.tongueImage3.y - 2;
            this.tongueImage2.width = int(this.tongueImage3.x - this.tongueImage1.x) - 7;
         }
         if(stunHandler)
         {
            stunHandler.updateScreenPosition(camera);
         }
         sprite.updateScreenPosition();
      }
      
      protected function setTongueVisible(_value:Boolean) : void
      {
         this.tongueImage1.visible = this.tongueImage2.visible = this.tongueImage3.visible = _value;
      }
      
      override public function noGroundCollision() : void
      {
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_FROM_SKY_STATE")
         {
            level.particlesManager.createDust(xPos + 8,yPos + 32,Entity.LEFT);
            level.particlesManager.createDust(xPos + 32 - 8,yPos + 32,Entity.RIGHT);
            level.camera.verShake(48,0.9);
            stateMachine.performAction("GROUND_COLLISION_ACTION");
         }
         else if(stateMachine.currentState == "IS_HURT_STATE")
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
      
      public function fallingFromSkyAnimation() : void
      {
         sprite.visible = true;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function introImpactAnimation() : void
      {
         sprite.visible = true;
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
      }
      
      public function waitingAnimation() : void
      {
         sprite.visible = true;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = yVel = 0;
         x_friction = 0.8;
         gravity_friction = 1;
      }
      
      public function standingAnimation() : void
      {
         sprite.visible = true;
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         this.setTongueVisible(false);
         counter1 = counter2 = counter3 = 0;
         xVel = 0;
      }
      
      public function turningAnimation() : void
      {
         sprite.visible = true;
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
         xVel = 0;
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
         SoundSystem.PlaySound("woosh");
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
      
      public function openMouthAnimation() : void
      {
         sprite.visible = true;
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         xVel = 0;
      }
      
      public function tongueOutAnimation() : void
      {
         SoundSystem.PlaySound("tongue_mesa");
         sprite.visible = true;
         this.setTongueVisible(true);
         if(DIRECTION == Entity.LEFT)
         {
            this.tongueStart_xPos = xPos - 17;
         }
         else
         {
            this.tongueStart_xPos = xPos + 49;
         }
         this.tongueEnd_xPos = this.tongueStart_xPos;
         this.tongue_yPos = yPos + 24;
      }
      
      public function tongueInAnimation() : void
      {
         sprite.visible = true;
         level.hero.setGlued();
         this.hero_tongue_xDiff = level.hero.xPos - this.tongueEnd_xPos;
         counter1 = counter2 = counter3 = 0;
      }
      
      public function tongueSnapBackAnimation() : void
      {
         sprite.visible = true;
         counter1 = counter2 = counter3 = 0;
      }
      
      override public function hurtAnimation() : void
      {
         this.playSound("hurt");
         sprite.visible = true;
         super.hurtAnimation();
         energy = 4;
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = counter3 = 0;
         if(level.hero.getMidXPos() > getMidXPos())
         {
            xVel = -2;
         }
         else
         {
            xVel = 2;
         }
         yVel = -2;
         gravity_friction = 0.4;
         x_friction = 0.95;
         this.setTongueVisible(false);
      }
      
      override protected function restoreEnergy() : void
      {
         energy = 4;
      }
      
      public function hitAnimation() : void
      {
         sprite.visible = true;
         sprite.gfxHandle().gotoAndStop(7);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         energy = 4;
         stunHandler.unstun();
         ++this.HITS;
         this.setYellowHighlight(true);
         if(level.hero.getMidXPos() > getMidXPos())
         {
            xVel = -2;
         }
         else
         {
            xVel = 2;
         }
         yVel = -2;
         gravity_friction = 0.4;
         x_friction = 0.95;
         counter1 = counter2 = counter3 = 0;
         if(this.HITS >= 3)
         {
            stateMachine.performAction("DEAD_ACTION");
         }
      }
      
      override public function deadAnimation() : void
      {
         SoundSystem.PlaySound("mesa_defeat");
         sprite.visible = true;
         level.freezeAction(60);
         level.camera.shake();
         counter3 = 0;
         xVel = 0;
         yVel = -4;
         AVOID_COLLISION_DETECTION = true;
         Utils.world.removeChild(sprite);
         Utils.topWorld.addChild(sprite);
         this.IS_ON_TOP_WORLD = true;
         this.setYellowHighlight(false);
      }
      
      protected function isHeroCollidingWithTongue() : Boolean
      {
         var x_diff:Number = this.tongueEnd_xPos - level.hero.getMidXPos();
         var y_diff:Number = this.tongue_yPos - level.hero.getMidYPos();
         if(Math.sqrt(x_diff * x_diff + y_diff * y_diff) <= 12)
         {
            return true;
         }
         return false;
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
         Utils.world.setChildIndex(sprite,Utils.world.numChildren - 1);
         Utils.world.setChildIndex(this.tongueImage1,Utils.world.numChildren - 1);
         Utils.world.setChildIndex(this.tongueImage2,Utils.world.numChildren - 1);
         Utils.world.setChildIndex(this.tongueImage3,Utils.world.numChildren - 1);
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
            if(hero.stateMachine.currentState == "IS_RUNNING_STATE" || hero.stateMachine.currentState == "IS_JUMPING_STATE" || hero.stateMachine.currentState == "IS_FALLING_RUNNING_STATE" || hero.stateMachine.currentState == "IS_HOPPING_STATE" && !hero.wasOnRope() || specialAttackCondition())
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
