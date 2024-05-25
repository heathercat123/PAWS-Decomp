package entities.helpers
{
   import entities.Entity;
   import entities.enemies.Enemy;
   import flash.geom.*;
   import game_utils.LevelItems;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.collisions.SmallBrickCollision;
   import sprites.helpers.RockHelperSprite;
   import starling.display.Image;
   
   public class RockHelper extends Helper
   {
       
      
      protected var brickTarget:SmallBrickCollision;
      
      protected var ADAPT_DIRECTION:Boolean;
      
      protected var BRICK_LEVEL:int;
      
      protected var rock_particle1:Image;
      
      protected var rock_particle2:Image;
      
      protected var rock_particle3:Image;
      
      protected var rock1_xPos:Number;
      
      protected var rock1_yPos:Number;
      
      protected var rock1_xVel:Number;
      
      protected var rock1_yVel:Number;
      
      protected var offset_sin_1:Number;
      
      protected var rock2_xPos:Number;
      
      protected var rock2_yPos:Number;
      
      protected var rock2_xVel:Number;
      
      protected var rock2_yVel:Number;
      
      protected var offset_sin_2:Number;
      
      protected var rock3_xPos:Number;
      
      protected var rock3_yPos:Number;
      
      protected var rock3_xVel:Number;
      
      protected var rock3_yVel:Number;
      
      protected var offset_sin_3:Number;
      
      public function RockHelper(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,LevelItems.ITEM_HELPER_ROCK);
         this.setParams();
         this.initSprites();
         aabb.x = aabb.y = -10;
         aabb.width = aabb.height = 20;
         this.ADAPT_DIRECTION = false;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_EGG_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","TARGET_ROCK_ACTION","IS_TARGETING_ROCK_STATE");
         stateMachine.setRule("IS_TARGETING_ROCK_STATE","END_ACTION","IS_POST_ROCK_STATE");
         stateMachine.setRule("IS_POST_ROCK_STATE","TARGET_ROCK_ACTION","IS_TARGETING_ROCK_STATE");
         stateMachine.setRule("IS_POST_ROCK_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_AFTER_ATTACK_STATE","END_ACTION","IS_POST_ROCK_STATE");
         stateMachine.setRule("IS_CUTSCENE_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","SET_FREE_ACTION","IS_FLYING_AWAY_STATE");
         stateMachine.setFunctionToState("IS_EGG_STATE",this.eggAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_HERO_STATE",this.targetingHeroAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_ROCK_STATE",this.targetingRockAnimation);
         stateMachine.setFunctionToState("IS_POST_ROCK_STATE",this.postRockAnimation);
         stateMachine.setFunctionToState("IS_FLYING_AWAY_STATE",this.flyingAwayAnimation);
         stateMachine.setFunctionToState("IS_AFTER_ATTACK_STATE",this.afterAttackAnimation);
         stateMachine.setFunctionToState("IS_CUTSCENE_STATE",this.cutsceneAnimation);
         stateMachine.setState("IS_TARGETING_HERO_STATE");
         this.brickTarget = null;
      }
      
      override protected function setParams() : void
      {
         this.offset_sin_1 = Math.random() * Math.PI * 2;
         this.offset_sin_2 = Math.random() * Math.PI * 2;
         this.offset_sin_3 = Math.random() * Math.PI * 2;
         this.rock1_xPos = this.rock2_xPos = this.rock3_xPos = xPos;
         this.rock1_yPos = this.rock2_yPos = this.rock3_yPos = yPos;
         this.rock1_xVel = this.rock2_xVel = this.rock3_xVel = this.rock1_yVel = this.rock2_yVel = this.rock3_yVel = 0;
         if(LEVEL == 1)
         {
            if(IS_IN_WATER)
            {
               RADIUS_MAX_DISTANCE_FROM_HERO = 64;
               MAX_X_VEL = 2;
            }
            else
            {
               RADIUS_MAX_DISTANCE_FROM_HERO = 64;
               MAX_X_VEL = 3;
            }
         }
         else if(IS_IN_WATER)
         {
            RADIUS_MAX_DISTANCE_FROM_HERO = 96;
            MAX_X_VEL = 2;
         }
         else
         {
            RADIUS_MAX_DISTANCE_FROM_HERO = 96;
            MAX_X_VEL = 4;
         }
      }
      
      override protected function initSprites() : void
      {
         this.rock_particle1 = new Image(TextureManager.sTextureAtlas.getTexture("smallRockBulletSpriteAnim_a"));
         this.rock_particle2 = new Image(TextureManager.sTextureAtlas.getTexture("smallRockBulletSpriteAnim_b"));
         this.rock_particle3 = new Image(TextureManager.sTextureAtlas.getTexture("smallRockBulletSpriteAnim_b"));
         this.rock_particle1.touchable = this.rock_particle2.touchable = this.rock_particle3.touchable = false;
         Utils.world.addChild(this.rock_particle1);
         Utils.world.addChild(this.rock_particle2);
         Utils.world.addChild(this.rock_particle3);
         this.rock_particle1.pivotX = int(this.rock_particle1.width * 0.5);
         this.rock_particle1.pivotY = int(this.rock_particle1.height * 0.5);
         this.rock_particle2.pivotX = this.rock_particle3.pivotX = int(this.rock_particle2.width * 0.5);
         this.rock_particle2.pivotY = this.rock_particle3.pivotY = int(this.rock_particle2.height * 0.5);
         this.rock_particle1.visible = this.rock_particle2.visible = this.rock_particle3.visible = false;
         sprite = new RockHelperSprite(LEVEL);
         Utils.world.addChild(sprite);
         topSprite = new RockHelperSprite(LEVEL);
         Utils.topWorld.addChild(topSprite);
      }
      
      override public function destroy() : void
      {
         Utils.world.removeChild(this.rock_particle1);
         Utils.world.removeChild(this.rock_particle2);
         Utils.world.removeChild(this.rock_particle3);
         this.rock_particle1.dispose();
         this.rock_particle2.dispose();
         this.rock_particle3.dispose();
         this.rock_particle1 = this.rock_particle2 = this.rock_particle3 = null;
         this.brickTarget = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var distance:Number = NaN;
         var radius:Number = NaN;
         super.update();
         if(stateMachine.currentState == "IS_EGG_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               level.particlesManager.eggExplosion(xPos,yPos);
               stateMachine.performAction("END_ACTION");
            }
            this.followHero();
         }
         else if(stateMachine.currentState == "IS_FLYING_AWAY_STATE")
         {
            flyAway();
         }
         else if(stateMachine.currentState == "IS_TARGETING_HERO_STATE")
         {
            this.followHero();
            if(this.canTargetRock())
            {
               stateMachine.performAction("TARGET_ROCK_ACTION");
            }
            else if(this.ADAPT_DIRECTION == false)
            {
               if(DIRECTION != level.hero.DIRECTION)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else if(xVel < -0.5)
            {
               if(DIRECTION == RIGHT)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
            else if(xVel > 0.5)
            {
               if(DIRECTION == LEFT)
               {
                  stateMachine.performAction("TURN_ACTION");
               }
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            this.followHero();
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TARGETING_ROCK_STATE")
         {
            if(xVel < -0.5)
            {
               DIRECTION = LEFT;
            }
            else if(xVel > 0.5)
            {
               DIRECTION = RIGHT;
            }
            if(this.brickTarget != null)
            {
               this.targetBrick();
               if(this.brickTarget.dead)
               {
                  if(this.brickTarget.LEVEL == 1)
                  {
                     QuestsManager.SubmitQuestAction(QuestsManager.ACTION_SMALL_ROCK_DESTROYED_BY_ROCK_HELPER);
                  }
                  this.brickTarget = null;
                  stateMachine.performAction("END_ACTION");
               }
               else
               {
                  distance = this.getDistanceFromTarget();
                  radius = 16;
                  if(LEVEL == 2)
                  {
                     radius = 24;
                  }
                  if(distance <= radius)
                  {
                     --this.brickTarget.ENERGY;
                     if(this.brickTarget.ENERGY <= 0)
                     {
                        this.brickTarget.explodeBrick();
                     }
                     else
                     {
                        SoundSystem.PlaySound("rock_stomp");
                        level.camera.shake(2);
                        this.brickTarget.hitShake();
                        stateMachine.setState("IS_AFTER_ATTACK_STATE");
                     }
                  }
               }
            }
            else
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_AFTER_ATTACK_STATE")
         {
            if(counter1++ >= 30)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_POST_ROCK_STATE")
         {
            this.ADAPT_DIRECTION = true;
            if(this.canTargetRock())
            {
               stateMachine.performAction("TARGET_ROCK_ACTION");
            }
            else
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         if(sprite.gfxHandle().frame == 1)
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,Math.random() * 2 + 2);
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
         }
         this.updateRocks();
         x_friction = y_friction = 0.9;
         xVel *= x_friction;
         yVel *= y_friction;
         if(xVel > MAX_X_VEL)
         {
            xVel = MAX_X_VEL;
         }
         else if(xVel < -MAX_X_VEL)
         {
            xVel = -MAX_X_VEL;
         }
         if(yVel > MAX_X_VEL)
         {
            yVel = MAX_X_VEL;
         }
         else if(yVel < -MAX_X_VEL)
         {
            yVel = -MAX_X_VEL;
         }
         xPos += xVel;
         yPos += yVel;
         checkWater();
      }
      
      protected function updateRocks() : void
      {
         var dist_perc:Number = NaN;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         var rock1_xDest:Number = NaN;
         var rock2_xDest:Number = NaN;
         var rock3_xDest:Number = NaN;
         var rock1_yDest:Number = NaN;
         var rock2_yDest:Number = NaN;
         var rock3_yDest:Number = NaN;
         rock1_yDest = yPos + 8;
         rock2_yDest = yPos - 6;
         rock3_yDest = yPos + 12;
         if(DIRECTION == Entity.RIGHT)
         {
            rock1_xDest = xPos - 4;
            rock2_xDest = xPos + 7;
            rock3_xDest = xPos + 4;
         }
         else
         {
            rock1_xDest = xPos + 4;
            rock2_xDest = xPos - 7;
            rock3_xDest = xPos - 4;
         }
         diff_x = rock1_xDest - this.rock1_xPos;
         diff_y = rock1_yDest - this.rock1_yPos;
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / (Math.random() * 40 + 40);
         if(distance <= 0.1)
         {
            distance = 0.1;
         }
         diff_x /= distance;
         diff_y /= distance;
         this.rock1_xVel += diff_x * dist_perc;
         this.rock1_yVel += diff_y * dist_perc;
         this.rock1_xPos += this.rock1_xVel;
         this.rock1_yPos += this.rock1_yVel;
         this.rock1_xVel *= x_friction;
         this.rock1_yVel *= y_friction;
         diff_x = rock2_xDest - this.rock2_xPos;
         diff_y = rock2_yDest - this.rock2_yPos;
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / (Math.random() * 20 + 20);
         if(distance <= 0.1)
         {
            distance = 0.1;
         }
         diff_x /= distance;
         diff_y /= distance;
         this.rock2_xVel += diff_x * dist_perc;
         this.rock2_yVel += diff_y * dist_perc;
         this.rock2_xPos += this.rock2_xVel;
         this.rock2_yPos += this.rock2_yVel;
         this.rock2_xVel *= x_friction;
         this.rock2_yVel *= y_friction;
         diff_x = rock3_xDest - this.rock3_xPos;
         diff_y = rock3_yDest - this.rock3_yPos;
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / (Math.random() * 30 + 30);
         if(distance <= 0.1)
         {
            distance = 0.1;
         }
         diff_x /= distance;
         diff_y /= distance;
         this.rock3_xVel += diff_x * dist_perc;
         this.rock3_yVel += diff_y * dist_perc;
         this.rock3_xPos += this.rock3_xVel;
         this.rock3_yPos += this.rock3_yVel;
         this.rock3_xVel *= x_friction;
         this.rock3_yVel *= y_friction;
         this.offset_sin_1 += 0.1;
         this.offset_sin_2 += 0.1;
         this.offset_sin_3 += 0.1;
         if(this.offset_sin_1 >= Math.PI * 2)
         {
            this.offset_sin_1 -= Math.PI * 2;
         }
         if(this.offset_sin_2 >= Math.PI * 2)
         {
            this.offset_sin_2 -= Math.PI * 2;
         }
         if(this.offset_sin_3 >= Math.PI * 2)
         {
            this.offset_sin_3 -= Math.PI * 2;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.rock_particle1.x = int(Math.floor(this.rock1_xPos - camera.xPos));
         this.rock_particle1.y = int(Math.floor(this.rock1_yPos + Math.sin(this.offset_sin_1) * 2 - camera.yPos));
         this.rock_particle2.x = int(Math.floor(this.rock2_xPos - camera.xPos));
         this.rock_particle2.y = int(Math.floor(this.rock2_yPos + Math.sin(this.offset_sin_2) * 2 - camera.yPos));
         this.rock_particle3.x = int(Math.floor(this.rock3_xPos - camera.xPos));
         this.rock_particle3.y = int(Math.floor(this.rock3_yPos + Math.sin(this.offset_sin_3) * 2 - camera.yPos));
      }
      
      override public function setVisible() : void
      {
         super.setVisible();
         if(LEVEL >= 3)
         {
            this.rock_particle1.visible = this.rock_particle2.visible = this.rock_particle3.visible = true;
         }
         else
         {
            this.rock_particle1.visible = this.rock_particle2.visible = this.rock_particle3.visible = false;
         }
      }
      
      override public function setInvisible() : void
      {
         sprite.visible = false;
         topSprite.visible = false;
         this.rock_particle1.visible = this.rock_particle2.visible = this.rock_particle3.visible = false;
      }
      
      protected function getDistanceFromTarget() : Number
      {
         if(this.brickTarget == null)
         {
            return -1;
         }
         var diff_x:Number = this.brickTarget.getMidXPos() - xPos;
         var diff_y:Number = this.brickTarget.getMidYPos() - yPos;
         return Math.sqrt(diff_x * diff_x + diff_y * diff_y);
      }
      
      override protected function followHero() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var dist_perc:Number = NaN;
         var angle:Number = NaN;
         if(level.hero.DIRECTION == RIGHT)
         {
            dest_x = level.hero.xPos - Utils.TILE_WIDTH;
         }
         else
         {
            dest_x = level.hero.xPos + level.hero.WIDTH + Utils.TILE_WIDTH;
         }
         dest_y = level.hero.yPos - Utils.TILE_HEIGHT;
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / 160;
         if(dist_perc <= 0.1)
         {
            this.ADAPT_DIRECTION = false;
            dist_perc = 0;
         }
         angle = getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * dist_perc;
         yVel += Math.sin(angle) * dist_perc;
      }
      
      protected function targetBrick() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var angle:Number = NaN;
         dest_x = this.brickTarget.getMidXPos();
         dest_y = this.brickTarget.getMidYPos();
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         var dist_perc:Number = distance / 160;
         if(dist_perc <= 0.25)
         {
            dist_perc = 0.25;
         }
         angle = getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * dist_perc;
         yVel += Math.sin(angle) * dist_perc;
      }
      
      protected function canTargetRock() : Boolean
      {
         var i:int = 0;
         var j:int = 0;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         diff_x = level.hero.getMidXPos() - xPos;
         diff_y = level.hero.getMidYPos() - yPos;
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance > 192)
         {
            return false;
         }
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is SmallBrickCollision)
               {
                  diff_x = level.collisionsManager.collisions[i].getMidXPos() - xPos;
                  diff_y = level.collisionsManager.collisions[i].getMidYPos() - yPos;
                  distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                  if(distance <= RADIUS_MAX_DISTANCE_FROM_HERO)
                  {
                     if(level.collisionsManager.collisions[i].isInsideInnerScreen())
                     {
                        diff_x = level.collisionsManager.collisions[i].getMidXPos() - level.hero.getMidXPos();
                        diff_y = level.collisionsManager.collisions[i].getMidYPos() - level.hero.getMidYPos();
                        distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                        if(distance <= 176 && SmallBrickCollision(level.collisionsManager.collisions[i]).LEVEL <= LEVEL)
                        {
                           this.brickTarget = level.collisionsManager.collisions[i];
                           this.BRICK_LEVEL = this.brickTarget.LEVEL;
                           return true;
                        }
                     }
                  }
               }
            }
         }
         return false;
      }
      
      override protected function canBeAttacked(enemy:Enemy) : Boolean
      {
         var i:int = 0;
         var mid_x_t:Number = enemy.getMidXPos() / Utils.TILE_WIDTH;
         var mid_y_t:Number = enemy.getMidYPos() / Utils.TILE_HEIGHT;
         for(i = 0; i < 3; i++)
         {
            if(level.levelData.getTileValueAt(mid_x_t,mid_y_t - i) != 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public function eggAnimation() : void
      {
         counter1 = 0;
         float_y = 0;
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function flyingAwayAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function cutsceneAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function targetingHeroAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function targetingRockAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function afterAttackAnimation() : void
      {
         xVel *= -1;
         yVel *= -1;
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = 0;
      }
      
      public function postRockAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
   }
}
