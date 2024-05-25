package levels.collisions
{
   import entities.Easings;
   import entities.Entity;
   import flash.display.DisplayObject;
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class CrusherCollision extends Collision
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
      
      public function CrusherCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number, _type:int, _isDown:int, _t_difference:int)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _height;
         this.TYPE = _type;
         this.isDown = _isDown;
         this.t_difference = _t_difference;
         this.tween_start = this.tween_diff = this.tween_tick = this.tween_time = 0;
         aabb.x = xPos;
         aabb.y = yPos;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         this.areaCollision = new Rectangle(xPos + 2,yPos + 2,WIDTH - 4,HEIGHT - 4);
         this.initImages();
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_UP_STATE","END_ACTION","IS_GOING_DOWN_STATE");
         this.stateMachine.setRule("IS_GOING_DOWN_STATE","END_ACTION","IS_DOWN_STATE");
         this.stateMachine.setRule("IS_DOWN_STATE","END_ACTION","IS_GOING_UP_STATE");
         this.stateMachine.setRule("IS_GOING_UP_STATE","END_ACTION","IS_UP_STATE");
         this.stateMachine.setFunctionToState("IS_UP_STATE",this.isUpState);
         this.stateMachine.setFunctionToState("IS_GOING_DOWN_STATE",this.isGoingDownState);
         this.stateMachine.setFunctionToState("IS_DOWN_STATE",this.isDownState);
         this.stateMachine.setFunctionToState("IS_GOING_UP_STATE",this.isGoingUpState);
         if(_isDown > 0)
         {
            this.stateMachine.setState("IS_DOWN_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_UP_STATE");
         }
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
         var i:int = 0;
         var amount:int = 0;
         if(this.stateMachine.currentState == "IS_GOING_DOWN_STATE")
         {
            this.setCollisionValues(0);
            this.tween_tick += 1 / 60;
            if(this.tween_tick >= this.tween_time)
            {
               this.tween_tick = this.tween_time;
               this.stateMachine.performAction("END_ACTION");
               if(this.isInsideScreen())
               {
                  SoundSystem.PlaySound("big_impact");
                  level.camera.shake(2);
                  level.particlesManager.createDust(xPos + 8,yPos + HEIGHT,Entity.LEFT);
                  level.particlesManager.createDust(xPos + WIDTH - 8,yPos + HEIGHT,Entity.RIGHT);
                  amount = int(Math.random() * 4);
               }
            }
            yPos = Easings.linear(this.tween_tick,this.tween_start,this.tween_diff,this.tween_time);
            this.setCollisionValues(1);
         }
         else if(this.stateMachine.currentState == "IS_DOWN_STATE")
         {
            if(counter1++ > 30)
            {
               this.stateMachine.performAction("END_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_GOING_UP_STATE")
         {
            this.setCollisionValues(0);
            this.tween_tick += 1 / 60;
            if(this.tween_tick >= this.tween_time)
            {
               this.tween_tick = this.tween_time;
               this.stateMachine.performAction("END_ACTION");
            }
            yPos = Easings.linear(this.tween_tick,this.tween_start,this.tween_diff,this.tween_time);
            this.setCollisionValues(1);
         }
         else if(this.stateMachine.currentState == "IS_UP_STATE")
         {
            if(counter1++ > 30)
            {
               this.stateMachine.performAction("END_ACTION");
            }
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
                        level.hero.gameOver(xPos + WIDTH * 0.5,level.hero.yPos,true);
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
      
      protected function setCollisionValues(_value:int) : void
      {
         var __yPos:Number = yPos;
         var __height:Number = HEIGHT;
         if(yPos < 0)
         {
            __yPos = 0;
            __height -= Math.abs(yPos);
         }
         level.levelData.setTileValueToArea(new Rectangle(xPos,__yPos,WIDTH,__height),_value);
         if(_value > 0)
         {
            level.levelData.setTileValueToArea(new Rectangle(xPos + 16,__yPos + __height - 16,WIDTH - 32,16),10);
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.container.x = int(Math.floor(xPos - camera.xPos));
         this.container.y = int(Math.floor(yPos - camera.yPos));
      }
      
      protected function isUpState() : void
      {
         counter1 = counter2 = 0;
      }
      
      protected function isGoingDownState() : void
      {
         counter1 = counter2 = 0;
         this.tween_start = yPos;
         this.tween_diff = this.t_difference * Utils.TILE_HEIGHT;
         this.tween_time = this.t_difference * 0.5;
         this.tween_tick = 0;
      }
      
      protected function isDownState() : void
      {
         counter1 = counter2 = 0;
      }
      
      protected function isGoingUpState() : void
      {
         counter1 = counter2 = 0;
         this.tween_start = yPos;
         this.tween_diff = -this.t_difference * Utils.TILE_HEIGHT;
         this.tween_time = this.t_difference * 0.5;
         this.tween_tick = 0;
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
         if(this.TYPE == 1)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodLargeGateCollision1"));
            image.touchable = false;
            this.container.addChild(image);
            image.height = HEIGHT - 8;
            image.x = image.y = 0;
            image.y -= 64;
            image.height += 64;
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodLargeGateCollision2"));
            image.touchable = false;
            this.container.addChild(image);
            image.x = 0;
            image.y = HEIGHT - 8;
         }
         else
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("canyon_tile_4"));
            image.touchable = false;
            this.container.addChild(image);
            image.height = HEIGHT - Utils.TILE_HEIGHT;
            image.x = image.y = 0;
            image = new Image(TextureManager.sTextureAtlas.getTexture("canyon_tile_16"));
            image.touchable = false;
            this.container.addChild(image);
            image.x = 0;
            image.y = HEIGHT - Utils.TILE_HEIGHT;
            image = new Image(TextureManager.sTextureAtlas.getTexture("canyon_tile_13"));
            image.touchable = false;
            this.container.addChild(image);
            image.width = WIDTH - Utils.TILE_WIDTH * 2;
            image.x = Utils.TILE_WIDTH;
            image.y = HEIGHT - Utils.TILE_HEIGHT;
            image = new Image(TextureManager.sTextureAtlas.getTexture("canyon_tile_16"));
            image.scaleX = -1;
            image.touchable = false;
            this.container.addChild(image);
            image.x = WIDTH;
            image.y = HEIGHT - Utils.TILE_HEIGHT;
            image = new Image(TextureManager.sTextureAtlas.getTexture("canyon_tile_4"));
            image.scaleX = -1;
            image.touchable = false;
            this.container.addChild(image);
            image.height = HEIGHT - Utils.TILE_HEIGHT;
            image.x = WIDTH;
            image.y = 0;
            image = new Image(TextureManager.sTextureAtlas.getTexture("canyon_tile_2"));
            image.touchable = false;
            this.container.addChild(image);
            image.x = Utils.TILE_WIDTH;
            image.y = 0;
            image.width = WIDTH - Utils.TILE_WIDTH * 2;
            image.height = HEIGHT - Utils.TILE_HEIGHT;
         }
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
                     image.width = int(level.scriptsManager.decorationScripts[i].width);
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
