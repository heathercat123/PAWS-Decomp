package minigames
{
   import flash.geom.Rectangle;
   import game_utils.AchievementsManager;
   import game_utils.EntityData;
   import game_utils.GameSlot;
   import game_utils.SaveManager;
   import sprites.minigames.GenericMinigameSprite;
   import starling.display.Image;
   
   public class MegaPangMinigame extends ArcadeMinigame
   {
       
      
      protected var gameText_1:Image;
      
      protected var gameText_2:Image;
      
      protected var gameText_3:Image;
      
      protected var bubbles_burst:int;
      
      protected var bonus_burst:int;
      
      protected var flash_image:Image;
      
      protected var flash_counter_1:int;
      
      protected var flash_counter_2:int;
      
      protected var bubble_explosion_big:Image;
      
      protected var bubble_explosion_medium:Image;
      
      protected var bubble_explosion_small:Image;
      
      protected var explosion_counter_1:int;
      
      protected var explosion_counter_2:int;
      
      protected var explosion_counter_3:int;
      
      protected var tiles:Vector.<Image>;
      
      protected var bubbles:Vector.<Image>;
      
      protected var bubblesData:Vector.<EntityData>;
      
      protected var bonusBubble:Image;
      
      protected var bonusBubbleData:EntityData;
      
      protected var bullets:Vector.<Image>;
      
      protected var bulletsData:Vector.<EntityData>;
      
      protected var heroSprite:GenericMinigameSprite;
      
      protected var heroData:EntityData;
      
      protected var HERO_STATE:int;
      
      protected var last_bullet_counter:int;
      
      protected var spawn_counter_1:int;
      
      protected var spawn_counter_2:int;
      
      protected var spawn_counter_3:int;
      
      protected var CURRENT_STATE:int;
      
      protected var counter_1:int;
      
      protected var counter_2:int;
      
      protected var counter_3:int;
      
      public function MegaPangMinigame()
      {
         super();
      }
      
      override public function init() : void
      {
         super.init();
         this.flash_image = new Image(TextureManager.minigamesTextureAtlas.getTexture("dark_blue_quad"));
         this.flash_image.width = Utils.WIDTH;
         this.flash_image.height = Utils.HEIGHT;
         Utils.backWorld.addChild(this.flash_image);
         this.flash_image.visible = false;
         this.flash_counter_1 = this.flash_counter_2 = 0;
         this.CURRENT_STATE = 0;
         this.counter_1 = this.counter_2 = this.counter_3 = 0;
         this.bubbles_burst = this.bonus_burst = 0;
         this.initTiles();
         this.last_bullet_counter = 0;
         this.spawn_counter_1 = this.spawn_counter_2 = this.spawn_counter_3 = 0;
         this.bubble_explosion_big = new Image(TextureManager.minigamesTextureAtlas.getTexture("bubble_explosion_big"));
         this.bubble_explosion_medium = new Image(TextureManager.minigamesTextureAtlas.getTexture("bubble_explosion_medium"));
         this.bubble_explosion_small = new Image(TextureManager.minigamesTextureAtlas.getTexture("bubble_explosion_small"));
         this.bubble_explosion_big.pivotX = this.bubble_explosion_big.pivotY = int(this.bubble_explosion_big.width * 0.5);
         this.bubble_explosion_medium.pivotX = this.bubble_explosion_medium.pivotY = int(this.bubble_explosion_medium.width * 0.5);
         this.bubble_explosion_small.pivotX = this.bubble_explosion_small.pivotY = int(this.bubble_explosion_small.width * 0.5);
         Utils.world.addChild(this.bubble_explosion_big);
         Utils.world.addChild(this.bubble_explosion_medium);
         Utils.world.addChild(this.bubble_explosion_small);
         this.bubble_explosion_big.visible = this.bubble_explosion_medium.visible = this.bubble_explosion_small.visible = false;
         this.explosion_counter_1 = this.explosion_counter_2 = this.explosion_counter_3 = 0;
         this.bonusBubble = new Image(TextureManager.minigamesTextureAtlas.getTexture("bubble_bonus"));
         this.bonusBubble.touchable = false;
         this.bonusBubble.pivotX = this.bonusBubble.pivotY = int(this.bonusBubble.width * 0.5);
         Utils.world.addChild(this.bonusBubble);
         this.bonusBubbleData = new EntityData(-12,12,0,0);
         this.bullets = new Vector.<Image>();
         this.bulletsData = new Vector.<EntityData>();
         this.bubbles = new Vector.<Image>();
         this.bubblesData = new Vector.<EntityData>();
         this.heroSprite = new GenericMinigameSprite(GenericMinigameSprite.SPRITE_MEGAPANG_HERO);
         Utils.world.addChild(this.heroSprite);
         this.heroSprite.gfxHandleClip().gotoAndStop(1);
         this.heroData = new EntityData(96,136,0,0);
         this.HERO_STATE = 0;
         this.gameText_1 = new Image(TextureManager.minigamesTextureAtlas.getTexture("text_ready"));
         this.gameText_2 = new Image(TextureManager.minigamesTextureAtlas.getTexture("text_go"));
         this.gameText_3 = new Image(TextureManager.minigamesTextureAtlas.getTexture("text_game_over"));
         this.gameText_1.pivotX = int(this.gameText_1.width * 0.5);
         this.gameText_1.pivotY = int(this.gameText_1.height * 0.5);
         this.gameText_2.pivotX = int(this.gameText_2.width * 0.5);
         this.gameText_2.pivotY = int(this.gameText_2.height * 0.5);
         this.gameText_3.pivotX = int(this.gameText_3.width * 0.5);
         this.gameText_3.pivotY = int(this.gameText_3.height * 0.5);
         Utils.world.addChild(this.gameText_1);
         Utils.world.addChild(this.gameText_2);
         Utils.world.addChild(this.gameText_3);
         this.gameText_2.visible = this.gameText_3.visible = false;
         this.gameText_1.x = this.gameText_2.x = this.gameText_3.x = 96;
         this.gameText_1.y = this.gameText_2.y = this.gameText_3.y = 72;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         Utils.world.removeChild(this.gameText_1);
         Utils.world.removeChild(this.gameText_2);
         Utils.world.removeChild(this.gameText_3);
         this.gameText_1.dispose();
         this.gameText_2.dispose();
         this.gameText_3.dispose();
         this.gameText_1 = this.gameText_2 = this.gameText_3 = null;
         this.heroData = null;
         Utils.world.removeChild(this.heroSprite);
         this.heroSprite.destroy();
         this.heroSprite.dispose();
         this.heroSprite = null;
         for(i = 0; i < this.bubbles.length; i++)
         {
            if(this.bubbles[i] != null)
            {
               this.bubblesData[i] = null;
               Utils.world.removeChild(this.bubbles[i]);
               this.bubbles[i].dispose();
               this.bubbles[i] = null;
            }
         }
         this.bubblesData = null;
         this.bubbles = null;
         for(i = 0; i < this.bullets.length; i++)
         {
            if(this.bullets[i] != null)
            {
               this.bulletsData[i] = null;
               Utils.world.removeChild(this.bullets[i]);
               this.bullets[i].dispose();
               this.bullets[i] = null;
            }
         }
         this.bulletsData = null;
         this.bullets = null;
         Utils.world.removeChild(this.bonusBubble);
         this.bonusBubble.dispose();
         this.bonusBubble = null;
         this.bonusBubbleData = null;
         Utils.world.removeChild(this.bubble_explosion_big);
         Utils.world.removeChild(this.bubble_explosion_medium);
         Utils.world.removeChild(this.bubble_explosion_small);
         this.bubble_explosion_big.dispose();
         this.bubble_explosion_medium.dispose();
         this.bubble_explosion_small.dispose();
         this.bubble_explosion_big = null;
         this.bubble_explosion_medium = null;
         this.bubble_explosion_small = null;
         Utils.backWorld.removeChild(this.flash_image);
         this.flash_image.dispose();
         this.flash_image = null;
         this.tiles = new Vector.<Image>();
         for(i = 0; i < this.tiles.length; i++)
         {
            Utils.world.removeChild(this.tiles[i]);
            this.tiles[i].dispose();
            this.tiles[i] = null;
         }
         this.tiles = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var j:int = 0;
         var x_diff:Number = NaN;
         var y_diff:Number = NaN;
         var distance:Number = NaN;
         var radius:int = 0;
         var __xVel:Number = NaN;
         var rect:Rectangle = null;
         var _x_diff:Number = NaN;
         var _y_diff:Number = NaN;
         var _distance:Number = NaN;
         var collision_detected:Boolean = false;
         processInput();
         if(this.CURRENT_STATE == 0)
         {
            ++this.counter_1;
            if(this.counter_1 >= 120)
            {
               if(Math.random() * 100 > 50)
               {
                  this.addBubble(96,-16,0.5,0,int(Math.random() * 4));
               }
               else
               {
                  this.addBubble(96,-16,-0.5,0,int(Math.random() * 4));
               }
               this.CURRENT_STATE = 1;
               this.spawn_counter_1 = 600;
               this.spawn_counter_2 = 0;
               this.gameText_2.visible = false;
               BLOCK_INPUT = false;
            }
            else if(this.counter_1 >= 90)
            {
               this.gameText_1.visible = false;
               this.gameText_2.visible = true;
            }
         }
         else if(this.CURRENT_STATE == 1)
         {
            --this.last_bullet_counter;
            __xVel = 0.5;
            --this.spawn_counter_1;
            if(this.spawn_counter_1 <= 0)
            {
               this.spawn_counter_1 = 600 - this.bubbles_burst * 10;
               if(this.spawn_counter_1 <= 360 - this.bonus_burst * 15)
               {
                  this.spawn_counter_1 = 360 - this.bonus_burst * 15;
               }
               if(this.spawn_counter_1 <= 270)
               {
                  this.spawn_counter_1 = 270;
               }
               if(Math.random() * 100 > 50)
               {
                  __xVel = -0.5;
               }
               this.addBubble(16 + int(Math.random() * 11) * 16,-16,__xVel,0,int(Math.random() * 4),2);
            }
            this.heroData.xVel = 0;
            if(leftPressed)
            {
               SoundSystem.PlaySound("enemy_metal_jump");
               this.heroData.xVel = -1;
            }
            else if(rightPressed)
            {
               SoundSystem.PlaySound("enemy_metal_jump");
               this.heroData.xVel = 1;
            }
            this.heroData.xPos += this.heroData.xVel;
            if(this.heroData.xPos <= 8)
            {
               this.heroData.xPos = 8;
            }
            else if(this.heroData.xPos >= 184)
            {
               this.heroData.xPos = 184;
            }
            if(Math.abs(this.heroData.xVel) > 0.5)
            {
               if(this.heroSprite.frame != 2)
               {
                  this.heroSprite.gotoAndStop(2);
                  this.heroSprite.gfxHandleClip().gotoAndPlay(1);
               }
            }
            else
            {
               this.heroSprite.gotoAndStop(1);
            }
            for(i = 0; i < this.bubbles.length; i++)
            {
               if(this.bubbles[i] != null)
               {
                  radius = int(this.bubbles[i].width * 0.5);
                  this.bubblesData[i].yVel += 0.05;
                  if(this.bubblesData[i].yVel > 4)
                  {
                     this.bubblesData[i].yVel = 4;
                  }
                  this.bubblesData[i].xPos += this.bubblesData[i].xVel;
                  this.bubblesData[i].yPos += this.bubblesData[i].yVel;
                  if(this.bubblesData[i].xPos + radius >= 192 && this.bubblesData[i].xVel > 0)
                  {
                     this.bubblesData[i].xPos = 192 - radius;
                     this.bubblesData[i].xVel *= -1;
                  }
                  else if(this.bubblesData[i].xPos - radius <= 0 && this.bubblesData[i].xVel < 0)
                  {
                     this.bubblesData[i].xPos = radius;
                     this.bubblesData[i].xVel *= -1;
                  }
                  if(this.bubblesData[i].yPos + radius >= 144)
                  {
                     this.bubblesData[i].yPos = 144 - radius;
                     if(int(this.bubblesData[i].yFriction) == 2)
                     {
                        this.bubblesData[i].yVel = -3;
                     }
                     else if(int(this.bubblesData[i].yFriction) == 1)
                     {
                        this.bubblesData[i].yVel = -2.75;
                     }
                     else
                     {
                        this.bubblesData[i].yVel = -2.5;
                     }
                  }
               }
            }
            rect = new Rectangle();
            this.spawn_counter_2 += this.getBubblesAmount();
            if(this.spawn_counter_2 >= 60 * 60 + this.bubbles_burst * 60 + this.bonus_burst * 120)
            {
               this.spawn_counter_2 = 0;
               this.bonusBubbleData.xVel = 0.5;
            }
            if(this.bonusBubbleData.xVel > 0)
            {
               this.bonusBubbleData.xPos += this.bonusBubbleData.xVel;
               if(this.bonusBubbleData.xPos >= 204)
               {
                  this.bonusBubbleData.xPos = -12;
                  this.bonusBubbleData.xFriction = 90;
                  this.bonusBubbleData.xVel = 0;
               }
            }
            for(i = 0; i < this.bullets.length; i++)
            {
               if(this.bullets[i] != null)
               {
                  this.bulletsData[i].yPos += this.bulletsData[i].yVel;
                  if(this.bullets[i].height < 64)
                  {
                     this.bullets[i].height += Math.abs(this.bulletsData[i].yVel);
                     if(this.bullets[i].height >= 64)
                     {
                        this.bullets[i].height = 64;
                     }
                  }
                  else
                  {
                     this.bullets[i].height = 64;
                  }
                  rect.x = this.bulletsData[i].xPos;
                  rect.y = this.bulletsData[i].yPos;
                  rect.width = this.bullets[i].width;
                  rect.height = this.bullets[i].height;
                  if(this.bulletsData[i].yPos + this.bullets[i].height <= 0)
                  {
                     this.destroyBullet(i);
                  }
                  else
                  {
                     if(Utils.CircleRectHitTest(this.bonusBubbleData.xPos,this.bonusBubbleData.yPos,8,rect.x,rect.y,rect.x + rect.width,rect.y + rect.height))
                     {
                        collision_detected = true;
                        this.destroyBullet(i);
                        this.bonusBubbleData.xVel = 0;
                        this.bonusBubbleData.xPos = -12;
                        ++this.bonus_burst;
                        this.flash_image.visible = true;
                        this.flash_counter_1 = this.flash_counter_2 = 0;
                        SoundSystem.PlaySound("arcade_bonus");
                        this.destroyAllBubbles();
                     }
                     for(j = 0; j < this.bubbles.length; j++)
                     {
                        if(collision_detected == false)
                        {
                           if(this.bubbles[j] != null)
                           {
                              if(Utils.CircleRectHitTest(this.bubblesData[j].xPos,this.bubblesData[j].yPos,this.bubbles[j].width * 0.5,rect.x,rect.y,rect.x + rect.width,rect.y + rect.height))
                              {
                                 if(int(this.bubblesData[j].yFriction) == 2)
                                 {
                                    this.bubble_explosion_big.x = this.bubblesData[j].xPos;
                                    this.bubble_explosion_big.y = this.bubblesData[j].yPos;
                                    this.explosion_counter_1 = 10;
                                    this.bubble_explosion_big.visible = true;
                                 }
                                 else if(int(this.bubblesData[j].yFriction) == 1)
                                 {
                                    this.bubble_explosion_medium.x = this.bubblesData[j].xPos;
                                    this.bubble_explosion_medium.y = this.bubblesData[j].yPos;
                                    this.explosion_counter_2 = 10;
                                    this.bubble_explosion_medium.visible = true;
                                 }
                                 else
                                 {
                                    this.bubble_explosion_small.x = this.bubblesData[j].xPos;
                                    this.bubble_explosion_small.y = this.bubblesData[j].yPos;
                                    this.explosion_counter_3 = 10;
                                    this.bubble_explosion_small.visible = true;
                                 }
                                 collision_detected = true;
                                 this.destroyBullet(i);
                                 this.destroyBubble(j);
                                 ++this.bubbles_burst;
                                 SoundSystem.PlaySound("arcade_explosion");
                              }
                           }
                        }
                     }
                  }
               }
            }
            for(i = 0; i < this.bubbles.length; i++)
            {
               if(this.bubbles[i] != null)
               {
                  _x_diff = this.heroData.xPos - this.bubblesData[i].xPos;
                  _y_diff = this.heroData.yPos - this.bubblesData[i].yPos;
                  _distance = Math.sqrt(_x_diff * _x_diff + _y_diff * _y_diff);
                  if(_distance < 6 + this.bubbles[i].width * 0.5)
                  {
                     this.gameOver();
                  }
               }
            }
            if(this.flash_image.visible)
            {
               ++this.flash_counter_1;
               if(this.flash_counter_1 > 3)
               {
                  this.flash_counter_1 = 0;
                  ++this.flash_counter_2;
                  if(this.flash_image.alpha > 0.5)
                  {
                     this.flash_image.alpha = 0;
                  }
                  else
                  {
                     this.flash_image.alpha = 1;
                  }
               }
               if(this.flash_counter_2 >= 5)
               {
                  this.flash_image.visible = false;
                  this.flash_image.alpha = 1;
               }
            }
            if(this.explosion_counter_1-- > 0)
            {
               if(this.explosion_counter_1 <= 0 || this.explosion_counter_1 >= 3 && this.explosion_counter_1 <= 5)
               {
                  this.bubble_explosion_big.visible = false;
               }
               else
               {
                  this.bubble_explosion_big.visible = true;
               }
            }
            if(this.explosion_counter_2-- > 0)
            {
               if(this.explosion_counter_2 <= 0 || this.explosion_counter_2 >= 3 && this.explosion_counter_2 <= 5)
               {
                  this.bubble_explosion_medium.visible = false;
               }
               else
               {
                  this.bubble_explosion_medium.visible = true;
               }
            }
            if(this.explosion_counter_3-- > 0)
            {
               if(this.explosion_counter_3 <= 0 || this.explosion_counter_3 >= 3 && this.explosion_counter_3 <= 5)
               {
                  this.bubble_explosion_small.visible = false;
               }
               else
               {
                  this.bubble_explosion_small.visible = true;
               }
            }
         }
         else if(this.CURRENT_STATE == 2)
         {
            if(this.counter_1++ == 120)
            {
               GET_OUT_FLAG = true;
            }
         }
         super.update();
         this.updateScreenPositions();
      }
      
      protected function gameOver() : void
      {
         this.gameText_3.visible = true;
         Utils.world.setChildIndex(this.gameText_3,Utils.world.numChildren - 1);
         BLOCK_INPUT = true;
         this.heroSprite.gotoAndStop(3);
         this.heroSprite.gfxHandleClip().gotoAndPlay(1);
         this.heroData.xVel = 0;
         SoundSystem.PlayMusic("arcade_game_over");
         this.CURRENT_STATE = 2;
         this.counter_1 = 0;
         if(POINTS > Utils.Slot.gameVariables[GameSlot.VARIABLE_ARCADE_1_RECORD])
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_ARCADE_1_RECORD] = POINTS;
            AchievementsManager.SubmitScore("megapang",Utils.Slot.gameVariables[GameSlot.VARIABLE_ARCADE_1_RECORD]);
            SaveManager.SaveGameVariables();
         }
         if(POINTS >= 15000)
         {
            AchievementsManager.SubmitAchievement("sctp_5");
         }
      }
      
      protected function getBubblesAmount() : int
      {
         var i:int = 0;
         var amount:int = 0;
         for(i = 0; i < this.bubbles.length; i++)
         {
            if(this.bubbles[i] != null)
            {
               amount++;
            }
         }
         return amount;
      }
      
      protected function destroyAllBubbles() : void
      {
         var i:int = 0;
         var amount:int = 0;
         this.spawn_counter_1 = 60;
         for(i = 0; i < this.bubbles.length; i++)
         {
            if(this.bubbles[i] != null)
            {
               amount++;
               Utils.world.removeChild(this.bubbles[i]);
               this.bubbles[i].dispose();
               this.bubbles[i] = null;
               this.bubblesData[i] = null;
            }
         }
         if(amount >= 12)
         {
            amount = 12;
         }
         POINTS += Math.pow(2,amount);
      }
      
      protected function destroyBubble(index:int) : void
      {
         var _diff:int = 0;
         var _xPos:Number = this.bubblesData[index].xPos;
         var _yPos:Number = this.bubblesData[index].yPos;
         var _yVel:Number = Math.abs(this.bubblesData[index].yVel);
         var color:int = this.bubblesData[index].xFriction;
         var size:int = this.bubblesData[index].yFriction;
         Utils.world.removeChild(this.bubbles[index]);
         this.bubbles[index].dispose();
         this.bubbles[index] = null;
         this.bubblesData[index] = null;
         if(size == 2)
         {
            POINTS += 100;
         }
         else if(size == 1)
         {
            POINTS += 200;
         }
         else
         {
            POINTS += 300;
         }
         if(size > 0)
         {
            if(_yVel < 1)
            {
               _yVel = 1;
            }
            _diff = 8;
            if(size == 1)
            {
               _diff = 4;
            }
            this.addBubble(_xPos - _diff,_yPos,-0.5,-_yVel,color,size - 1);
            this.addBubble(_xPos + _diff,_yPos,0.5,-_yVel,color,size - 1);
         }
      }
      
      protected function destroyBullet(index:int) : void
      {
         Utils.world.removeChild(this.bullets[index]);
         this.bullets[index].dispose();
         this.bullets[index] = null;
         this.bulletsData[index] = null;
      }
      
      protected function addBubble(_xPos:Number = 96, _yPos:Number = -16, _xVel:Number = 0.5, _yVel:Number = 0, _color:int = 0, _size:int = 2) : void
      {
         var color_string:String = "blue";
         var size_string:String = "big";
         if(_size == 1)
         {
            size_string = "medium";
         }
         else if(_size <= 0)
         {
            size_string = "small";
         }
         if(_color == 1)
         {
            color_string = "green";
         }
         else if(_color == 2)
         {
            color_string = "red";
         }
         else if(_color == 3)
         {
            color_string = "yellow";
         }
         var image:Image = new Image(TextureManager.minigamesTextureAtlas.getTexture("bubble_" + color_string + "_" + size_string));
         image.touchable = false;
         image.pivotX = image.pivotY = int(image.width * 0.5);
         Utils.world.addChild(image);
         this.bubbles.push(image);
         this.bubblesData.push(new EntityData(_xPos,_yPos,_xVel,_yVel,_color,_size));
      }
      
      protected function initTiles() : void
      {
         var i:int = 0;
         var image:Image = null;
         this.tiles = new Vector.<Image>();
         for(i = 0; i < 12; i++)
         {
            if(i == 1 || i == 10)
            {
               image = new Image(TextureManager.minigamesTextureAtlas.getTexture("tile_2"));
            }
            else
            {
               image = new Image(TextureManager.minigamesTextureAtlas.getTexture("tile_1"));
            }
            image.touchable = false;
            image.x = i * 16;
            image.y = 144;
            Utils.world.addChild(image);
            this.tiles.push(image);
         }
         for(i = 0; i < 10; i++)
         {
            image = new Image(TextureManager.minigamesTextureAtlas.getTexture("tile_3"));
            image.touchable = false;
            if(i < 5)
            {
               image.x = 16;
               image.y = 160 + i * 16;
            }
            else
            {
               image.x = 160;
               image.y = 160 + (i - 5) * 16;
            }
            Utils.world.addChild(image);
            this.tiles.push(image);
         }
      }
      
      override protected function spaceKeyPressed() : void
      {
         if(this.last_bullet_counter > 0)
         {
            return;
         }
         SoundSystem.PlaySound("arcade_laser");
         this.last_bullet_counter = 30;
         var image:Image = new Image(TextureManager.minigamesTextureAtlas.getTexture("megapang_bullet"));
         image.touchable = false;
         Utils.world.addChild(image);
         Utils.world.setChildIndex(image,0);
         this.bullets.push(image);
         this.bulletsData.push(new EntityData(this.heroData.xPos - 3,this.heroData.yPos - 8,0,-2.5));
      }
      
      protected function updateScreenPositions() : void
      {
         var i:int = 0;
         for(i = 0; i < this.bubbles.length; i++)
         {
            if(this.bubbles[i] != null)
            {
               this.bubbles[i].x = int(Math.floor(this.bubblesData[i].xPos));
               this.bubbles[i].y = int(Math.floor(this.bubblesData[i].yPos));
            }
         }
         for(i = 0; i < this.bullets.length; i++)
         {
            if(this.bullets[i] != null)
            {
               this.bullets[i].x = int(Math.floor(this.bulletsData[i].xPos));
               this.bullets[i].y = int(Math.floor(this.bulletsData[i].yPos));
            }
         }
         this.bonusBubble.x = int(Math.floor(this.bonusBubbleData.xPos));
         this.bonusBubble.y = int(Math.floor(this.bonusBubbleData.yPos));
         this.heroSprite.x = int(Math.floor(this.heroData.xPos));
         this.heroSprite.y = int(Math.floor(this.heroData.yPos));
         this.heroSprite.updateScreenPosition();
      }
   }
}
