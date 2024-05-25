package entities.helpers
{
   import entities.enemies.Enemy;
   import flash.geom.*;
   import game_utils.LevelItems;
   import game_utils.QuestsManager;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.collisions.CoinsCircleCollision;
   import levels.items.CoinItem;
   import levels.items.DarkCoinItem;
   import levels.items.Item;
   import sprites.helpers.GoldenBatHelperSprite;
   
   public class GoldenBatHelper extends Helper
   {
       
      
      protected var coinTarget:Item;
      
      protected var ADAPT_DIRECTION:Boolean;
      
      public function GoldenBatHelper(_level:Level, _xPos:Number, _yPos:Number, _direction:int)
      {
         super(_level,_xPos,_yPos,_direction,LevelItems.ITEM_HELPER_BAT);
         this.setParams();
         this.initSprites();
         aabb.x = aabb.y = -10;
         aabb.width = aabb.height = 20;
         this.ADAPT_DIRECTION = false;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_EGG_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","TURN_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","TARGET_COIN_ACTION","IS_TARGETING_COIN_STATE");
         stateMachine.setRule("IS_TARGETING_COIN_STATE","END_ACTION","IS_POST_COIN_STATE");
         stateMachine.setRule("IS_POST_COIN_STATE","TARGET_COIN_ACTION","IS_TARGETING_COIN_STATE");
         stateMachine.setRule("IS_POST_COIN_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_CUTSCENE_STATE","END_ACTION","IS_TARGETING_HERO_STATE");
         stateMachine.setRule("IS_TARGETING_HERO_STATE","SET_FREE_ACTION","IS_FLYING_AWAY_STATE");
         stateMachine.setFunctionToState("IS_EGG_STATE",this.eggAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_HERO_STATE",this.targetingHeroAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_TARGETING_COIN_STATE",this.targetingCoinAnimation);
         stateMachine.setFunctionToState("IS_POST_COIN_STATE",this.postCoinAnimation);
         stateMachine.setFunctionToState("IS_FLYING_AWAY_STATE",this.flyingAwayAnimation);
         stateMachine.setFunctionToState("IS_CUTSCENE_STATE",this.cutsceneAnimation);
         stateMachine.setState("IS_TARGETING_HERO_STATE");
         this.coinTarget = null;
      }
      
      override protected function setParams() : void
      {
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
            RADIUS_MAX_DISTANCE_FROM_HERO = 80;
            MAX_X_VEL = 2;
         }
         else
         {
            RADIUS_MAX_DISTANCE_FROM_HERO = 80;
            MAX_X_VEL = 4;
         }
      }
      
      override protected function initSprites() : void
      {
         sprite = new GoldenBatHelperSprite(LEVEL);
         Utils.world.addChild(sprite);
         topSprite = new GoldenBatHelperSprite(LEVEL);
         Utils.topWorld.addChild(topSprite);
      }
      
      override public function destroy() : void
      {
         this.coinTarget = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var j:int = 0;
         var cCollision:CoinsCircleCollision = null;
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
            if(this.canTargetCoin())
            {
               stateMachine.performAction("TARGET_COIN_ACTION");
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
         else if(stateMachine.currentState == "IS_TARGETING_COIN_STATE")
         {
            if(xVel < -0.5)
            {
               DIRECTION = LEFT;
            }
            else if(xVel > 0.5)
            {
               DIRECTION = RIGHT;
            }
            if(this.coinTarget != null)
            {
               this.targetCoin();
               if(this.coinTarget.dead)
               {
                  this.coinTarget = null;
                  stateMachine.performAction("END_ACTION");
               }
            }
            else
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_POST_COIN_STATE")
         {
            this.ADAPT_DIRECTION = true;
            if(this.canTargetCoin())
            {
               stateMachine.performAction("TARGET_COIN_ACTION");
            }
            else
            {
               stateMachine.performAction("END_ACTION");
            }
         }
         for(i = 0; i < level.itemsManager.items.length; i++)
         {
            if(level.itemsManager.items[i] != null)
            {
               if(level.itemsManager.items[i] is CoinItem || level.itemsManager.items[i] is DarkCoinItem)
               {
                  if(level.itemsManager.items[i].IS_FROZEN == false)
                  {
                     if(getAABB().intersects(level.itemsManager.items[i].getAABB()))
                     {
                        if(level.itemsManager.items[i] is DarkCoinItem)
                        {
                           if(DarkCoinItem(level.itemsManager.items[i]).stateMachine.currentState == "IS_STANDING_STATE")
                           {
                              SoundSystem.PlaySound("coin");
                              QuestsManager.SubmitQuestAction(QuestsManager.ACTION_COIN_COLLECTED_BY_GOLDEN_BAT_HELPER);
                           }
                           if(LEVEL == 2)
                           {
                              DarkCoinItem(level.itemsManager.items[i]).collectedAndApplyMultiplier(1.25);
                           }
                           else if(LEVEL == 3)
                           {
                              DarkCoinItem(level.itemsManager.items[i]).collectedAndApplyMultiplier(1.5);
                           }
                           else
                           {
                              DarkCoinItem(level.itemsManager.items[i]).collectedAndApplyMultiplier(1);
                           }
                        }
                        else
                        {
                           QuestsManager.SubmitQuestAction(QuestsManager.ACTION_COIN_COLLECTED_BY_GOLDEN_BAT_HELPER);
                           SoundSystem.PlaySound("coin");
                           if(LEVEL == 2)
                           {
                              CoinItem(level.itemsManager.items[i]).collectedAndApplyMultiplier(1.25);
                           }
                           else if(LEVEL == 3)
                           {
                              CoinItem(level.itemsManager.items[i]).collectedAndApplyMultiplier(1.5);
                           }
                           else
                           {
                              CoinItem(level.itemsManager.items[i]).collectedAndApplyMultiplier(1);
                           }
                        }
                     }
                  }
               }
            }
         }
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is CoinsCircleCollision)
               {
                  cCollision = level.collisionsManager.collisions[i] as CoinsCircleCollision;
                  for(j = 0; j < cCollision.coins.length; j++)
                  {
                     if(cCollision.coins[j] != null)
                     {
                        if(getAABB().intersects(cCollision.coins[j].getAABB()))
                        {
                           SoundSystem.PlaySound("coin");
                           CoinItem(cCollision.coins[j]).collectedAndApplyMultiplier(2);
                        }
                     }
                  }
               }
            }
         }
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
      
      protected function targetCoin() : void
      {
         var dest_x:Number = NaN;
         var dest_y:Number = NaN;
         var dist_perc:Number = NaN;
         var angle:Number = NaN;
         dest_x = this.coinTarget.getMidXPos();
         dest_y = this.coinTarget.getMidYPos();
         var diff_x:Number = dest_x - xPos;
         var diff_y:Number = dest_y - yPos;
         var distance:Number = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance >= 160)
         {
            distance = 160;
         }
         dist_perc = distance / 160;
         if(dist_perc <= 0.25)
         {
            dist_perc = 0.25;
         }
         angle = getAngle(1,0,diff_x,diff_y);
         xVel += Math.cos(angle) * dist_perc;
         yVel += Math.sin(angle) * dist_perc;
      }
      
      protected function canTargetCoin() : Boolean
      {
         var i:int = 0;
         var j:int = 0;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         var distance:Number = NaN;
         var cCollision:CoinsCircleCollision = null;
         diff_x = level.hero.getMidXPos() - xPos;
         diff_y = level.hero.getMidYPos() - yPos;
         distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
         if(distance > 192)
         {
            return false;
         }
         for(i = 0; i < level.itemsManager.items.length; i++)
         {
            if(level.itemsManager.items[i] != null)
            {
               if(level.itemsManager.items[i] is CoinItem || level.itemsManager.items[i] is DarkCoinItem)
               {
                  if(level.itemsManager.items[i].IS_FROZEN == false)
                  {
                     diff_x = level.itemsManager.items[i].xPos - xPos;
                     diff_y = level.itemsManager.items[i].yPos - yPos;
                     distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                     if(distance <= RADIUS_MAX_DISTANCE_FROM_HERO)
                     {
                        if(level.itemsManager.items[i].isInsideInnerScreen())
                        {
                           diff_x = level.itemsManager.items[i].getMidXPos() - level.hero.getMidXPos();
                           diff_y = level.itemsManager.items[i].getMidYPos() - level.hero.getMidYPos();
                           distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                           if(distance <= 176)
                           {
                              this.coinTarget = level.itemsManager.items[i];
                              return true;
                           }
                        }
                     }
                  }
               }
            }
         }
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is CoinsCircleCollision)
               {
                  cCollision = level.collisionsManager.collisions[i] as CoinsCircleCollision;
                  for(j = 0; j < cCollision.coins.length; j++)
                  {
                     if(cCollision.coins[j] != null)
                     {
                        diff_x = cCollision.coins[j].xPos - xPos;
                        diff_y = cCollision.coins[j].yPos - yPos;
                        distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                        if(distance <= RADIUS_MAX_DISTANCE_FROM_HERO)
                        {
                           if(cCollision.coins[j].isInsideInnerScreen())
                           {
                              diff_x = cCollision.coins[j].getMidXPos() - level.hero.getMidXPos();
                              diff_y = cCollision.coins[j].getMidYPos() - level.hero.getMidYPos();
                              distance = Math.sqrt(diff_x * diff_x + diff_y * diff_y);
                              if(distance <= 176)
                              {
                                 this.coinTarget = cCollision.coins[j];
                                 return true;
                              }
                           }
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
      
      public function targetingCoinAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      public function postCoinAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
   }
}
