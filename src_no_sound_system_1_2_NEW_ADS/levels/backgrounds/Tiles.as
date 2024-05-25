package levels.backgrounds
{
   import flash.geom.Rectangle;
   import game_utils.GameSlot;
   import levels.GenericScript;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.DarkSmallSpotCollisionSprite;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.extensions.pixelmask.PixelMaskDisplayObject;
   
   public class Tiles
   {
       
      
      public var level:Level;
      
      public var tilesBackContainer:Sprite;
      
      public var tilesContainer:Sprite;
      
      public var tilesFrontContainer:PixelMaskDisplayObject;
      
      public var tilesFrontContainerNoMask:Sprite;
      
      public var images:Array;
      
      public var backImages:Array;
      
      public var frontImages:Array;
      
      protected var IS_FRONT_TILES:Boolean;
      
      public var maskContainer:Sprite;
      
      protected var spotlightImage:DarkSmallSpotCollisionSprite;
      
      public var spotlightScale:Number;
      
      public var topLeft:Image;
      
      public var bottomRight:Image;
      
      protected var LOW_SPECS:Boolean;
      
      protected var alpha_counter:int;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      protected var temp_counter:int = 0;
      
      public function Tiles(_level:Level)
      {
         var i:int = 0;
         var image:Image = null;
         var scale_mult:Number = NaN;
         var scale_mult_y:Number = NaN;
         var isBack:Boolean = false;
         var gScript:GenericScript = null;
         var obj:XML = null;
         super();
         this.level = _level;
         this.IS_FRONT_TILES = false;
         this.spotlightScale = 0.1;
         this.alpha_counter = 0;
         this.tilesBackContainer = new Sprite();
         this.tilesBackContainer.x = 0;
         this.tilesBackContainer.y = 0;
         Utils.backWorld.addChild(this.tilesBackContainer);
         this.tilesContainer = new Sprite();
         this.tilesContainer.x = this.xPos = 0;
         this.tilesContainer.y = this.yPos = 0;
         this.tilesFrontContainer = null;
         this.tilesFrontContainerNoMask = null;
         if(Utils.Slot.gameVariables[GameSlot.VARIABLE_GFX] == 0)
         {
            this.tilesFrontContainer = new PixelMaskDisplayObject();
            this.tilesFrontContainer.x = this.tilesFrontContainer.y = 0;
            this.LOW_SPECS = false;
         }
         else
         {
            this.tilesFrontContainerNoMask = new Sprite();
            this.tilesFrontContainerNoMask.x = this.tilesFrontContainerNoMask.y = 0;
            this.LOW_SPECS = true;
         }
         Utils.topWorld.addChild(this.tilesContainer);
         if(this.LOW_SPECS == false)
         {
            Utils.topWorld.addChild(this.tilesFrontContainer);
         }
         else
         {
            Utils.topWorld.addChild(this.tilesFrontContainerNoMask);
         }
         this.images = new Array();
         this.backImages = new Array();
         this.frontImages = new Array();
         for each(obj in this.level.map.tiles[0].obj)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture(obj.@name));
            image.x = obj.@x;
            image.y = obj.@y;
            image.width = obj.@w;
            image.height = obj.@h;
            if(obj.@f_x > 0)
            {
               image.scaleX = -1;
            }
            if(obj.@f_y > 0)
            {
               image.scaleY = -1;
            }
            if(obj.@back > 0)
            {
               this.tilesBackContainer.addChild(image);
               this.backImages.push(image);
            }
            else
            {
               this.tilesContainer.addChild(image);
               this.images.push(image);
            }
         }
         for each(obj in this.level.map.tiles_front[0].obj)
         {
            image = new Image(TextureManager.sTextureAtlas.getTexture(obj.@name));
            image.x = obj.@x;
            image.y = obj.@y;
            image.width = obj.@w;
            image.height = obj.@h;
            if(obj.@f_x > 0)
            {
               image.scaleX = -1;
            }
            if(obj.@f_y > 0)
            {
               image.scaleY = -1;
            }
            if(this.LOW_SPECS == false)
            {
               this.tilesFrontContainer.addChild(image);
            }
            else
            {
               this.tilesFrontContainerNoMask.addChild(image);
            }
            this.frontImages.push(image);
            this.IS_FRONT_TILES = true;
         }
         if(this.IS_FRONT_TILES)
         {
            this.maskContainer = new Sprite();
            this.spotlightImage = new DarkSmallSpotCollisionSprite();
            this.maskContainer.addChild(this.spotlightImage);
            this.topLeft = new Image(TextureManager.sTextureAtlas.getTexture("dark_shade_1"));
            this.bottomRight = new Image(TextureManager.sTextureAtlas.getTexture("dark_shade_1"));
            this.topLeft.width = this.bottomRight.width = this.topLeft.height = this.bottomRight.height = 1;
            this.topLeft.x = -1;
            this.topLeft.y = -1;
            this.bottomRight.x = Utils.WIDTH + 1;
            this.bottomRight.y = Utils.HEIGHT + 1;
            this.topLeft.touchable = this.bottomRight.touchable = false;
            this.maskContainer.addChild(this.topLeft);
            this.maskContainer.addChild(this.bottomRight);
         }
      }
      
      public function addTile(image:Image) : void
      {
         this.tilesContainer.addChild(image);
         this.images.push(image);
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         if(this.IS_FRONT_TILES)
         {
            this.maskContainer.removeChild(this.bottomRight);
            this.maskContainer.removeChild(this.topLeft);
            this.bottomRight.dispose();
            this.topLeft.dispose();
            this.bottomRight = null;
            this.topLeft = null;
            this.maskContainer.removeChild(this.spotlightImage);
            this.spotlightImage.destroy();
            this.spotlightImage.dispose();
            this.spotlightImage = null;
            this.maskContainer = null;
            for(i = 0; i < this.frontImages.length; i++)
            {
               if(this.LOW_SPECS == false)
               {
                  this.tilesFrontContainer.removeChild(this.frontImages[i]);
               }
               else
               {
                  this.tilesFrontContainerNoMask.removeChild(this.frontImages[i]);
               }
               this.frontImages[i].dispose();
               this.frontImages[i] = null;
            }
         }
         this.frontImages = null;
         for(i = 0; i < this.images.length; i++)
         {
            this.tilesContainer.removeChild(this.images[i]);
            this.images[i].dispose();
            this.images[i] = null;
         }
         this.images = null;
         for(i = 0; i < this.backImages.length; i++)
         {
            this.tilesBackContainer.removeChild(this.backImages[i]);
            this.backImages[i].dispose();
            this.backImages[i] = null;
         }
         this.backImages = null;
         if(this.LOW_SPECS == false)
         {
            Utils.topWorld.removeChild(this.tilesFrontContainer);
            this.tilesFrontContainer.dispose();
            this.tilesFrontContainer = null;
         }
         else
         {
            Utils.topWorld.removeChild(this.tilesFrontContainerNoMask);
            this.tilesFrontContainerNoMask.dispose();
            this.tilesFrontContainerNoMask = null;
         }
         Utils.topWorld.removeChild(this.tilesContainer);
         this.tilesContainer.dispose();
         this.tilesContainer = null;
         Utils.backWorld.removeChild(this.tilesBackContainer);
         this.tilesBackContainer.dispose();
         this.tilesBackContainer = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var dObject:DisplayObject = null;
         var rectangle:Rectangle = null;
         var screen:Rectangle = null;
         if(Utils.IS_ON_WINDOWS)
         {
            if(this.temp_counter++ > 5)
            {
               this.temp_counter = 0;
               rectangle = new Rectangle();
               screen = new Rectangle(-64,-64,Utils.WIDTH + 128,Utils.HEIGHT + 128);
               for(i = 0; i < this.tilesBackContainer.numChildren; i++)
               {
                  this.tilesBackContainer.getChildAt(i).getBounds(this.tilesBackContainer,rectangle);
                  rectangle.x += this.tilesBackContainer.x;
                  rectangle.y += this.tilesBackContainer.y;
                  if(rectangle.intersects(screen))
                  {
                     this.tilesBackContainer.getChildAt(i).visible = true;
                  }
                  else
                  {
                     this.tilesBackContainer.getChildAt(i).visible = false;
                  }
               }
               for(i = 0; i < this.tilesContainer.numChildren; i++)
               {
                  this.tilesContainer.getChildAt(i).getBounds(this.tilesContainer,rectangle);
                  rectangle.x += this.tilesContainer.x;
                  rectangle.y += this.tilesContainer.y;
                  if(rectangle.intersects(screen))
                  {
                     this.tilesContainer.getChildAt(i).visible = true;
                  }
                  else
                  {
                     this.tilesContainer.getChildAt(i).visible = false;
                  }
               }
            }
         }
      }
      
      public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.tilesContainer.x = this.tilesBackContainer.x = int(Math.floor(this.xPos - camera.xPos));
         this.tilesContainer.y = this.tilesBackContainer.y = int(Math.floor(this.yPos - camera.yPos));
         if(this.LOW_SPECS == false)
         {
            this.tilesFrontContainer.x = int(Math.floor(this.xPos - camera.xPos));
            this.tilesFrontContainer.y = int(Math.floor(this.yPos - camera.yPos));
         }
         else
         {
            this.tilesFrontContainerNoMask.x = int(Math.floor(this.xPos - camera.xPos));
            this.tilesFrontContainerNoMask.y = int(Math.floor(this.yPos - camera.yPos));
         }
         if(this.IS_FRONT_TILES)
         {
            if(this.LOW_SPECS == false)
            {
               if(this.level.collisionsManager.IS_HERO_INSIDE_HIDDEN_AREA)
               {
                  this.spotlightScale += 0.1;
                  if(this.spotlightScale > 1)
                  {
                     this.spotlightScale = 1;
                  }
               }
               else
               {
                  this.spotlightScale -= 0.2;
                  if(this.spotlightScale < 0.01)
                  {
                     this.spotlightScale = 0.01;
                  }
               }
               this.maskContainer.x = 0;
               this.maskContainer.y = 0;
               this.tilesFrontContainer.pixelMask = this.maskContainer;
               this.tilesFrontContainer.inverted = true;
               this.spotlightImage.gotoAndStop(1);
               this.spotlightImage.x = int(Math.floor(this.level.hero.getMidXPos()));
               this.spotlightImage.y = int(Math.floor(this.level.hero.getMidYPos()));
               this.spotlightImage.scaleX = this.spotlightScale;
               this.spotlightImage.scaleY = this.spotlightScale;
               this.topLeft.x = 0;
               this.topLeft.y = 0;
               this.bottomRight.x = this.level.levelData.END_X + 32;
               this.bottomRight.y = this.level.levelData.END_Y + 32;
               this.spotlightImage.updateScreenPosition();
               Utils.topWorld.setChildIndex(this.tilesFrontContainer,Utils.topWorld.numChildren - 1);
            }
            else
            {
               if(this.level.collisionsManager.IS_HERO_INSIDE_HIDDEN_AREA)
               {
                  if(this.alpha_counter++ > 2)
                  {
                     this.alpha_counter = 0;
                     this.tilesFrontContainerNoMask.alpha -= 0.3;
                     if(this.tilesFrontContainerNoMask.alpha <= 0)
                     {
                        this.tilesFrontContainerNoMask.alpha = 0;
                     }
                  }
               }
               else if(this.alpha_counter++ > 2 && this.tilesFrontContainerNoMask.alpha < 1)
               {
                  this.alpha_counter = 0;
                  this.tilesFrontContainerNoMask.alpha += 0.3;
                  if(this.tilesFrontContainerNoMask.alpha >= 1)
                  {
                     this.tilesFrontContainerNoMask.alpha = 1;
                  }
               }
               Utils.topWorld.setChildIndex(this.tilesFrontContainerNoMask,Utils.topWorld.numChildren - 1);
            }
         }
      }
   }
}
