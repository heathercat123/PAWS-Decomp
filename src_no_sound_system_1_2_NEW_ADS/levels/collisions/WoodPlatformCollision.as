package levels.collisions
{
   import flash.display.DisplayObject;
   import flash.geom.*;
   import levels.Level;
   import levels.cameras.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class WoodPlatformCollision extends GearCollision
   {
       
      
      protected var TYPE:int;
      
      protected var container:Sprite;
      
      protected var images:Vector.<Image>;
      
      protected var areaCollision:Rectangle;
      
      protected var yVel:Number;
      
      protected var hor_collision:YellowPlatformCollision;
      
      protected var ver_collision:YellowVerticalPlatformCollision;
      
      protected var IS_GOING_UP:Boolean;
      
      protected var IS_LARGE:Boolean;
      
      protected var wait_time:int;
      
      protected var delay:int;
      
      protected var yTarget:Number;
      
      protected var yAmount:Number;
      
      protected var additionalWaitTime:Number;
      
      public function WoodPlatformCollision(_level:Level, _xPos:Number, _yPos:Number, _type:int, _amount:int, _additionalWaitTime:Number)
      {
         super(_level,_xPos,_yPos);
         if(_type == 2 || _type == 3)
         {
            this.IS_LARGE = true;
         }
         if(this.IS_LARGE)
         {
            WIDTH = 64;
         }
         else
         {
            WIDTH = 48;
         }
         HEIGHT = 128;
         this.TYPE = 0;
         this.yVel = 0;
         this.wait_time = 0;
         this.delay = 0;
         this.yAmount = _amount;
         this.additionalWaitTime = _additionalWaitTime * 32;
         aabb.x = xPos;
         aabb.y = yPos;
         aabb.width = WIDTH;
         aabb.height = HEIGHT;
         this.areaCollision = new Rectangle(xPos + 2,yPos + 2,WIDTH - 4,HEIGHT - 4);
         if(_type == 0 || _type == 2)
         {
            this.IS_GOING_UP = false;
         }
         else
         {
            this.IS_GOING_UP = true;
         }
         if(this.IS_GOING_UP)
         {
            this.yTarget = originalYPos - this.yAmount;
         }
         else
         {
            this.yTarget = originalYPos + this.yAmount;
         }
         this.initImages();
      }
      
      public static function isFlipped(obj:DisplayObject) : Boolean
      {
         return obj.transform.matrix.a / obj.scaleX == -1;
      }
      
      override public function postInit() : void
      {
         super.postInit();
         this.hor_collision = new YellowPlatformCollision(level,xPos,yPos);
         if(this.IS_LARGE)
         {
            this.hor_collision.setWidth(64);
         }
         else
         {
            this.hor_collision.setWidth(48);
         }
         level.collisionsManager.collisions.push(this.hor_collision);
         this.hor_collision.sprite.visible = false;
         this.ver_collision = new YellowVerticalPlatformCollision(level,xPos,yPos,0);
         if(this.IS_LARGE)
         {
            this.ver_collision.setWidth(64);
         }
         else
         {
            this.ver_collision.setWidth(48);
         }
         level.collisionsManager.collisions.push(this.ver_collision);
         this.ver_collision.sprite.visible = false;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.areaCollision = null;
         this.ver_collision = null;
         this.hor_collision = null;
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
         if(this.wait_time-- <= 0)
         {
            if(this.delay++ > 0)
            {
               this.setCollisionArea(0);
               this.delay = 0;
               if(this.IS_GOING_UP)
               {
                  --yPos;
                  if(yPos <= this.yTarget)
                  {
                     yPos = this.yTarget;
                     this.IS_GOING_UP = false;
                     this.yTarget = yPos + this.yAmount;
                     this.wait_time = 60 + this.additionalWaitTime;
                  }
               }
               else
               {
                  yPos += 1;
                  if(yPos >= this.yTarget)
                  {
                     yPos = this.yTarget;
                     this.yTarget = yPos - this.yAmount;
                     this.IS_GOING_UP = true;
                     this.wait_time = 60 + this.additionalWaitTime;
                  }
               }
               this.setCollisionArea(1);
            }
         }
         this.ver_collision.yPos = yPos - 8;
         this.hor_collision.yPos = yPos;
         this.hor_collision.aabb.x = 0 - 2;
         this.hor_collision.aabb.y = -2;
         this.hor_collision.aabb.width = 64 + 4;
         this.hor_collision.aabb.height = 12;
         this.ver_collision.update();
         this.hor_collision.update();
      }
      
      protected function setCollisionArea(_value:int) : void
      {
         var _yPos:int = int(yPos / Utils.TILE_HEIGHT);
         if(yPos % 16 == 0)
         {
            level.levelData.setTileValueToArea(new Rectangle(xPos,_yPos * Utils.TILE_HEIGHT,WIDTH,HEIGHT),_value);
         }
         else
         {
            level.levelData.setTileValueToArea(new Rectangle(xPos,(_yPos + 1) * Utils.TILE_HEIGHT,WIDTH,HEIGHT),_value);
         }
      }
      
      override public function checkPostUpdateEntitiesCollision() : void
      {
         if(isInsideInnerScreen())
         {
            this.ver_collision.update();
            this.hor_collision.update();
            this.ver_collision.checkEntitiesCollision();
            this.hor_collision.checkEntitiesCollision();
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.container.x = int(Math.floor(xPos - camera.xPos));
         this.container.y = int(Math.floor(yPos - camera.yPos));
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
         if(this.IS_LARGE)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodLargeGateCollision1"));
         }
         else
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodGateCollision1"));
         }
         image.touchable = false;
         this.container.addChild(image);
         image.height = HEIGHT - 8 + 48;
         image.x = 0;
         image.y = 8;
         if(this.IS_LARGE)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodLargeGateCollision2"));
         }
         else
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture("woodGateCollision2"));
         }
         image.scaleY = -1;
         image.touchable = false;
         this.container.addChild(image);
         image.x = 0;
         image.y = 8;
         for(i = 0; i < level.scriptsManager.decorationScripts.length; i++)
         {
            if(level.scriptsManager.decorationScripts[i] != null)
            {
               if(level.scriptsManager.decorationScripts[i].name == "WoodVeinCrusherScript13")
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
