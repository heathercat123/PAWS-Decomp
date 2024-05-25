package levels.collisions
{
   import flash.display.DisplayObject;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class WoodGateCollision extends GearCollision
   {
       
      
      protected var TYPE:int;
      
      protected var container:Sprite;
      
      protected var images:Vector.<Image>;
      
      protected var isDown:int;
      
      protected var t_difference:int;
      
      protected var tween_start:Number;
      
      protected var tween_diff:Number;
      
      protected var tween_tick:Number;
      
      protected var tween_time:Number;
      
      public var stateMachine:StateMachine;
      
      protected var areaCollision:Rectangle;
      
      protected var x_offset:Number;
      
      protected var yVel:Number;
      
      public function WoodGateCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _type:int = 0, _gear_id:int = -1)
      {
         super(_level,_xPos,_yPos);
         GEAR_ID = _gear_id;
         WIDTH = _width;
         HEIGHT = _height;
         this.TYPE = _type;
         this.yVel = 0;
         this.isDown = 1;
         this.t_difference = 10;
         this.tween_start = this.tween_diff = this.tween_tick = this.tween_time = 0;
         this.x_offset = 0;
         aabb.x = xPos;
         aabb.y = yPos;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         this.areaCollision = new Rectangle(xPos + 2,yPos + 2,WIDTH - 4,HEIGHT - 4);
         this.initImages();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_DOWN_STATE","START_ACTION","IS_ACTIVATED_STATE");
         this.stateMachine.setRule("IS_ACTIVATED_STATE","END_ACTION","IS_GOING_UP_STATE");
         this.stateMachine.setRule("IS_GOING_UP_STATE","ZERO_SPEED_ACTION","IS_DEACTIVATED_STATE");
         this.stateMachine.setRule("IS_DEACTIVATED_STATE","END_ACTION","IS_GOING_DOWN_STATE");
         this.stateMachine.setRule("IS_DEACTIVATED_STATE","START_ACTION","IS_GOING_UP_STATE");
         this.stateMachine.setRule("IS_GOING_DOWN_STATE","END_ACTION","IS_DOWN_STATE");
         this.stateMachine.setRule("IS_GOING_UP_STATE","REACHED_TOP_ACTION","IS_LOCKED_STATE");
         this.stateMachine.setFunctionToState("IS_DOWN_STATE",this.isDownState);
         this.stateMachine.setFunctionToState("IS_ACTIVATED_STATE",this.isActivatedState);
         this.stateMachine.setFunctionToState("IS_GOING_UP_STATE",this.isGoingUpState);
         this.stateMachine.setFunctionToState("IS_DEACTIVATED_STATE",this.isDeactivatedState);
         this.stateMachine.setFunctionToState("IS_GOING_DOWN_STATE",this.isGoingDownState);
         this.stateMachine.setFunctionToState("IS_LOCKED_STATE",this.lockedState);
         this.stateMachine.setState("IS_DOWN_STATE");
      }
      
      public static function isFlipped(obj:DisplayObject) : Boolean
      {
         return obj.transform.matrix.a / obj.scaleX == -1;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.areaCollision = null;
         for(i = 0; i < this.images.length; i++)
         {
            this.container.removeChild(this.images[i]);
            this.images[i].dispose();
            this.images[i] = null;
         }
         this.images = null;
         Utils.world.removeChild(this.container);
         this.container.dispose();
         this.container = null;
      }
      
      override public function update() : void
      {
         if(this.stateMachine.currentState != "IS_DOWN_STATE")
         {
            if(this.stateMachine.currentState == "IS_ACTIVATED_STATE")
            {
               if(counter1++ > 1)
               {
                  counter1 = 0;
                  ++counter2;
                  SoundSystem.PlaySound("blue_platform");
                  if(this.x_offset >= 0)
                  {
                     this.x_offset = -1;
                  }
                  else
                  {
                     this.x_offset = 1;
                  }
                  if(counter2 >= 8)
                  {
                     this.x_offset = 0;
                     this.stateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_GOING_UP_STATE")
            {
               if(counter1++ > 15)
               {
                  if(counter2++ >= 5)
                  {
                     counter2 = 0;
                     yPos -= 2;
                     if(yPos <= originalYPos - 64)
                     {
                        this.stateMachine.performAction("REACHED_TOP_ACTION");
                     }
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_DEACTIVATED_STATE")
            {
               if(counter3++ > 60)
               {
                  if(counter1++ > 1)
                  {
                     counter1 = 0;
                     ++counter2;
                     SoundSystem.PlaySound("blue_platform");
                     if(this.x_offset >= 0)
                     {
                        this.x_offset = -1;
                     }
                     else
                     {
                        this.x_offset = 1;
                     }
                     if(counter2 >= 8)
                     {
                        this.x_offset = 0;
                        this.stateMachine.performAction("END_ACTION");
                     }
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_GOING_DOWN_STATE")
            {
               this.yVel += 0.075;
               if(this.yVel >= 4)
               {
                  this.yVel = 4;
               }
               yPos += this.yVel;
               if(yPos >= originalYPos)
               {
                  yPos = originalYPos;
                  this.yVel = 0;
                  if(counter1 == 0)
                  {
                     SoundSystem.PlaySound("big_impact");
                     level.camera.shake();
                  }
                  ++counter1;
                  if(counter1 >= 15)
                  {
                     this.stateMachine.performAction("END_ACTION");
                  }
               }
            }
            else if(this.stateMachine.currentState == "IS_LOCKED_STATE")
            {
               if(counter1 > -1)
               {
                  if(counter1++ > 1)
                  {
                     counter1 = 0;
                     ++counter2;
                     if(this.x_offset >= 0)
                     {
                        this.x_offset = -1;
                     }
                     else
                     {
                        this.x_offset = 1;
                     }
                     if(counter2 >= 8)
                     {
                        this.x_offset = 0;
                        counter1 = -1;
                     }
                  }
               }
            }
         }
         this.setCollisionValues();
      }
      
      override public function spin(power:Number) : void
      {
         if(power >= 0.2)
         {
            this.stateMachine.performAction("START_ACTION");
         }
         else if(power <= 0)
         {
            this.stateMachine.performAction("ZERO_SPEED_ACTION");
         }
      }
      
      override public function checkPostUpdateEntitiesCollision() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         if(level.hero.IS_GOLD)
         {
            return;
         }
         this.areaCollision.x = xPos + 2;
         this.areaCollision.y = yPos + 2;
         var hero_aabb:Rectangle = level.hero.getAABBPhysics();
         var intersection:Rectangle = hero_aabb.intersection(this.areaCollision);
         if(intersection.width > 0 || intersection.height > 0)
         {
            if(intersection.width > intersection.height)
            {
               if(hero_aabb.y > yPos + HEIGHT * 0.5)
               {
                  level.hero.yPos = yPos + HEIGHT - level.hero.aabbPhysics.y;
                  level.hero.yVel = 1;
                  if(this.stateMachine.currentState == "IS_GOING_DOWN_STATE")
                  {
                     x_t = int(level.hero.getMidXPos() / Utils.TILE_WIDTH);
                     y_t = int(level.hero.getMidYPos() / Utils.TILE_HEIGHT);
                     if(level.levelData.getTileValueAt(x_t,y_t + 1) != 0)
                     {
                        SoundSystem.PlaySound("cat_hurt_game_over");
                        level.hero.gameOver(xPos + WIDTH * 0.5,yPos + HEIGHT,true);
                     }
                  }
               }
               else
               {
                  level.hero.yPos = yPos - (level.hero.aabbPhysics.y + level.hero.aabbPhysics.height);
                  level.hero.yVel = 0;
               }
            }
            else if(hero_aabb.x < xPos + WIDTH * 0.5)
            {
               level.hero.xPos = xPos - (level.hero.aabbPhysics.x + level.hero.aabbPhysics.width);
               level.hero.xVel = 0;
            }
            else
            {
               level.hero.xPos = xPos + WIDTH - level.hero.aabbPhysics.x;
               level.hero.xVel = 0;
            }
         }
      }
      
      protected function setCollisionValues() : void
      {
         var xStart:Number = originalXPos;
         var yStart:Number = originalYPos;
         var widthArea:Number = WIDTH;
         var heightArea:Number = HEIGHT;
         level.levelData.setTileValueToArea(new Rectangle(xStart,yStart,widthArea,heightArea),0);
         level.levelData.setTileValueToArea(new Rectangle(xPos,yPos,WIDTH,HEIGHT),1);
         level.levelData.setTileValueToArea(new Rectangle(xPos + 16,yPos + HEIGHT - 16,WIDTH - 32,16),10);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.container.x = int(Math.floor(xPos - camera.xPos + this.x_offset));
         this.container.y = int(Math.floor(yPos - camera.yPos));
      }
      
      protected function isUpState() : void
      {
         counter1 = counter2 = 0;
      }
      
      protected function isGoingDownState() : void
      {
         SoundSystem.PlaySound("flyingship_falldown");
         counter1 = counter2 = 0;
      }
      
      protected function lockedState() : void
      {
         SoundSystem.PlaySound("brick_created");
         yPos = originalYPos - 64;
         counter1 = counter2 = this.x_offset = 0;
         IS_LOCKED = true;
      }
      
      protected function isDownState() : void
      {
         counter1 = counter2 = 0;
      }
      
      protected function isActivatedState() : void
      {
         counter1 = counter2 = 0;
      }
      
      protected function isGoingUpState() : void
      {
         counter1 = counter2 = 0;
      }
      
      protected function isDeactivatedState() : void
      {
         counter1 = counter2 = counter3 = 0;
      }
      
      protected function initImages() : void
      {
         var i:int = 0;
         var xCheck:Number = NaN;
         var yCheck:Number = NaN;
         var image:Image = null;
         this.container = new Sprite();
         Utils.topWorld.addChild(this.container);
         this.images = new Vector.<Image>();
         if(this.TYPE == 0)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodGateCollision1"));
         }
         else
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodLargeGateCollision1"));
         }
         image.touchable = false;
         this.container.addChild(image);
         image.height = HEIGHT - 7 + 48;
         image.x = 0;
         image.y = -48;
         if(this.TYPE == 0)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodGateCollision2"));
         }
         else
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodLargeGateCollision2"));
         }
         image.touchable = false;
         this.container.addChild(image);
         image.x = 0;
         image.y = HEIGHT - 7;
         for(i = 0; i < level.scriptsManager.decorationScripts.length; i++)
         {
            if(level.scriptsManager.decorationScripts[i] != null)
            {
               if(level.scriptsManager.decorationScripts[i].name == "CrusherDecorationScript1")
               {
                  xCheck = level.scriptsManager.decorationScripts[i].x;
                  yCheck = level.scriptsManager.decorationScripts[i].y;
                  if(aabb.contains(xCheck,yCheck))
                  {
                     image = new Image(TextureManager.sTextureAtlas.getTexture("sandDecorationSpriteAnim_b"));
                     image.touchable = false;
                     this.container.addChild(image);
                     image.x = int(level.scriptsManager.decorationScripts[i].x - xPos);
                     image.y = int(level.scriptsManager.decorationScripts[i].y - yPos);
                  }
               }
               else if(level.scriptsManager.decorationScripts[i].name == "WoodVeinCrusherScript13")
               {
                  xCheck = level.scriptsManager.decorationScripts[i].x;
                  yCheck = level.scriptsManager.decorationScripts[i].y;
                  if(aabb.contains(xCheck,yCheck))
                  {
                     image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_k"));
                     image.width = int(Math.round(level.scriptsManager.decorationScripts[i].width));
                     image.scaleX = level.scriptsManager.decorationScripts[i].scale_x;
                     image.touchable = false;
                     this.container.addChild(image);
                     image.x = int(level.scriptsManager.decorationScripts[i].x - xPos);
                     image.y = int(level.scriptsManager.decorationScripts[i].y - yPos);
                  }
               }
               else if(level.scriptsManager.decorationScripts[i].name == "WoodVeinCrusherScript14")
               {
                  xCheck = level.scriptsManager.decorationScripts[i].x;
                  yCheck = level.scriptsManager.decorationScripts[i].y;
                  if(aabb.contains(xCheck,yCheck))
                  {
                     image = new Image(TextureManager.sTextureAtlas.getTexture("woodVeinDecorationSpriteAnim_l"));
                     image.width = int(Math.round(level.scriptsManager.decorationScripts[i].width));
                     image.scaleX = level.scriptsManager.decorationScripts[i].scale_x;
                     image.touchable = false;
                     this.container.addChild(image);
                     image.x = int(level.scriptsManager.decorationScripts[i].x - xPos);
                     image.y = int(level.scriptsManager.decorationScripts[i].y - yPos);
                  }
               }
            }
         }
      }
      
      override public function isInsideScreen() : Boolean
      {
         var area:Rectangle = new Rectangle(xPos,yPos + HEIGHT,WIDTH,8);
         var camera:Rectangle = new Rectangle(level.camera.xPos - 16,level.camera.yPos - 16,level.camera.WIDTH + 32,level.camera.HEIGHT + 32);
         if(area.intersects(camera))
         {
            return true;
         }
         return false;
      }
   }
}
