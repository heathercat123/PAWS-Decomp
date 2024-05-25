package levels.items
{
   import entities.Easings;
   import entities.Hero;
   import flash.geom.Rectangle;
   import game_utils.QuestsManager;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.items.CoinItemSprite;
   
   public class CoinItem extends Item
   {
       
      
      public var IS_FROZEN:Boolean;
      
      public var IS_GHOST:Boolean;
      
      protected var MULTIPLIER:Number;
      
      protected var TYPE:int;
      
      protected var float_sin_counter:Number;
      
      protected var IS_COLLIDING_WITH_HERO:Boolean;
      
      protected var appear_delay:int;
      
      protected var IS_GOING_UP:Boolean;
      
      protected var ground_impact:int;
      
      public function CoinItem(_level:Level, _xPos:Number, _yPos:Number, _type:int = 0)
      {
         super(_level,_xPos,_yPos,-1);
         this.TYPE = _type;
         this.MULTIPLIER = 1;
         this.appear_delay = -1;
         t_start = t_diff = t_time = t_tick = 0;
         this.ground_impact = 0;
         sprite = new CoinItemSprite();
         Utils.world.addChild(sprite);
         Utils.world.setChildIndex(sprite,0);
         stateMachine.setState("IS_STANDING_STATE");
         this.float_sin_counter = 0;
         aabb.x = aabbPhysics.x = 3;
         aabb.y = aabbPhysics.y = 1;
         aabb.width = aabbPhysics.width = 10;
         aabb.height = 15;
         aabbPhysics.height = 13;
         aabb.x = 3;
         aabb.y = 2;
         aabb.width = 10;
         aabb.height = 17;
         this.IS_COLLIDING_WITH_HERO = false;
         this.IS_FROZEN = false;
         this.IS_GHOST = false;
         this.IS_GOING_UP = false;
         if(this.TYPE == 3)
         {
            sprite.gotoAndStop(2);
            this.IS_GHOST = true;
         }
         else if(this.TYPE == 2)
         {
            t_start = yPos;
            t_diff = Utils.TILE_HEIGHT * 1.5 + 1;
            t_time = 1;
            t_tick = 0;
         }
         else if(this.TYPE == 1)
         {
            this.IS_GOING_UP = true;
            t_start = yPos;
            t_diff = -Utils.TILE_HEIGHT * 1.5 + 1;
            t_time = 1;
            t_tick = 0;
         }
         else if(this.TYPE == 5)
         {
            t_start = xPos;
            t_diff = Utils.TILE_WIDTH * 1.5 + 1;
            t_time = 1;
            t_tick = 0;
         }
         else if(this.TYPE == 6)
         {
            this.IS_GOING_UP = true;
            t_start = xPos;
            t_diff = -Utils.TILE_WIDTH * 1.5 + 1;
            t_time = 1;
            t_tick = 0;
         }
      }
      
      override public function postInit() : void
      {
         var x_t:int = int((xPos + 8) / Utils.TILE_WIDTH);
         var y_t:int = int((yPos + 8) / Utils.TILE_HEIGHT);
         var tile_value:int = level.levelData.getTileValueAt(x_t,y_t);
         if(tile_value == 13)
         {
            this.IS_FROZEN = true;
            sprite.gfxHandleClip().gotoAndStop(1);
         }
         if(Utils.SEA_LEVEL > 0)
         {
            if(yPos >= Utils.SEA_LEVEL)
            {
               t_time = 2;
            }
         }
      }
      
      public function unfreeze() : void
      {
         this.IS_FROZEN = false;
      }
      
      override public function update() : void
      {
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            t_tick += 1 / 60;
            if(t_tick >= t_time)
            {
               t_tick = -0.1;
               if(this.IS_GOING_UP)
               {
                  this.IS_GOING_UP = false;
                  t_start -= Utils.TILE_HEIGHT * 1.5;
                  t_diff = Utils.TILE_HEIGHT * 1.5 + 1;
               }
               else
               {
                  this.IS_GOING_UP = true;
                  t_start += Utils.TILE_HEIGHT * 1.5;
                  t_diff = -Utils.TILE_HEIGHT * 1.5 + 1;
               }
            }
            if(t_tick < 0)
            {
               yPos = Easings.easeInOutSine(0,t_start,t_diff,t_time);
            }
            else
            {
               yPos = Easings.easeInOutSine(t_tick,t_start,t_diff,t_time);
            }
         }
         else if(this.TYPE == 5 || this.TYPE == 6)
         {
            t_tick += 1 / 60;
            if(t_tick >= t_time)
            {
               t_tick = -0.1;
               if(this.IS_GOING_UP)
               {
                  this.IS_GOING_UP = false;
                  t_start -= Utils.TILE_HEIGHT * 1.5;
                  t_diff = Utils.TILE_HEIGHT * 1.5 + 1;
               }
               else
               {
                  this.IS_GOING_UP = true;
                  t_start += Utils.TILE_HEIGHT * 1.5;
                  t_diff = -Utils.TILE_HEIGHT * 1.5 + 1;
               }
            }
            if(t_tick < 0)
            {
               xPos = Easings.easeInOutSine(0,t_start,t_diff,t_time);
            }
            else
            {
               xPos = Easings.easeInOutSine(t_tick,t_start,t_diff,t_time);
            }
         }
         else if(this.TYPE == 4)
         {
            yVel += 0.15;
            level.levelPhysics.collisionDetectionMap(this);
            xPos += xVel;
            yPos += yVel;
         }
         if(this.appear_delay >= 0)
         {
            ++this.appear_delay;
            if(this.appear_delay >= 10)
            {
               SoundSystem.PlaySound("coin_appear");
               this.appear_delay = -1;
               this.IS_GHOST = false;
               sprite.visible = true;
               sprite.gotoAndStop(1);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
         if(this.IS_FROZEN)
         {
            return;
         }
         var hero_aabb:Rectangle = level.hero.getAABB();
         var this_aabb:Rectangle = getAABB();
         if(this.IS_GHOST)
         {
            if(hero_aabb.intersects(this_aabb))
            {
               this.IS_COLLIDING_WITH_HERO = true;
            }
            else if(this.IS_COLLIDING_WITH_HERO)
            {
               sprite.visible = false;
               if(this.appear_delay < 0)
               {
                  this.appear_delay = 0;
               }
            }
         }
         else if(hero_aabb.intersects(this_aabb))
         {
            SoundSystem.PlaySound("coin");
            Utils.QUEST_COIN_COLLECTED_BY_HERO_FLAG = true;
            QuestsManager.SubmitQuestAction(QuestsManager.ACTION_COIN_COLLECTED_BY_ANY_CAT);
            if(Hero.GetCurrentCat() == Hero.CAT_PASCAL)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_COIN_COLLECTED_BY_PASCAL);
            }
            else if(Hero.GetCurrentCat() == Hero.CAT_ROSE)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_COIN_COLLECTED_BY_ROSE);
            }
            else if(Hero.GetCurrentCat() == Hero.CAT_RIGS)
            {
               QuestsManager.SubmitQuestAction(QuestsManager.ACTION_COIN_COLLECTED_BY_RIGS);
            }
            collected();
         }
      }
      
      public function collectedAndApplyMultiplier(_multiplier:Number = 1) : void
      {
         this.MULTIPLIER = _multiplier;
         collected();
      }
      
      public function fakeCollected() : void
      {
         SoundSystem.PlaySound("coin");
         level.particlesManager.itemSparkles("yellow",aabb.x + aabb.width * 0.5,aabb.y + aabb.height * 0.5,-1,this);
         dead = true;
      }
      
      override public function groundCollision() : void
      {
         if(this.TYPE == 4)
         {
            if(this.ground_impact == 0)
            {
               ++this.ground_impact;
               if(Math.random() * 100 > 50)
               {
                  xVel = Math.random() * 1;
                  yVel = -2;
               }
               else
               {
                  xVel = -(Math.random() * 1);
                  yVel = -2;
               }
            }
            else
            {
               xVel = yVel = 0;
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         if(sprite.frame == 1 && !this.IS_FROZEN)
         {
            sprite.gfxHandleClip().gotoAndStop(level.itemsManager.coin_frame + 1);
         }
         else if(sprite.frame == 2)
         {
            if(level.itemsManager.coin_frame == 0 || level.itemsManager.coin_frame == 2)
            {
               sprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               sprite.gfxHandleClip().gotoAndStop(2);
            }
         }
      }
      
      override protected function collectedAnimation() : void
      {
         counter_1 = 0;
         counter_2 = 0;
         tick_1 = 0;
         Utils.AddCoins(1 * this.MULTIPLIER);
         level.particlesManager.itemSparkles("yellow",aabb.x + aabb.width * 0.5,aabb.y + aabb.height * 0.5,-1,this);
         this.MULTIPLIER = 1;
         dead = true;
      }
      
      override public function getMidXPos() : Number
      {
         return xPos + 8;
      }
      
      override public function getMidYPos() : Number
      {
         return yPos + 8;
      }
      
      override public function isInsideInnerScreen(_offset:int = 32) : Boolean
      {
         var cameraRect:Rectangle = new Rectangle(level.camera.xPos + 8,level.camera.yPos + 8,level.camera.WIDTH - 16,level.camera.HEIGHT - 16);
         var area:Rectangle = new Rectangle(xPos + aabb.x,yPos + aabb.y,aabb.width,aabb.height);
         if(cameraRect.intersects(area))
         {
            return true;
         }
         return false;
      }
   }
}
