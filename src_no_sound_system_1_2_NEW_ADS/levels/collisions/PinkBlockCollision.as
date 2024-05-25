package levels.collisions
{
   import flash.geom.*;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.*;
   import sprites.particles.ItemExplosionParticleSprite;
   import sprites.tutorials.*;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class PinkBlockCollision extends Collision
   {
       
      
      protected var invisibleImage:Image;
      
      protected var pinkBlockImage:Image;
      
      protected var path_x_start:Number;
      
      protected var path_x_end:Number;
      
      protected var ropeContainer:Sprite;
      
      protected var ropeImages:Vector.<Image>;
      
      protected var ropeAreaCollision:RopeAreaCollision;
      
      protected var gearsSprite:Array;
      
      protected var gearsData:Array;
      
      protected var TILE_VALUE:int;
      
      protected var IS_A_TO_B:Boolean;
      
      protected var ORIGINAL_IS_A_TO_B:Boolean;
      
      public var stateMachine:StateMachine;
      
      public function PinkBlockCollision(_level:Level, _xPos:Number, _yPos:Number, _value:int = 0, _initial_state:int = 0)
      {
         super(_level,_xPos,_yPos);
         this.ropeContainer = null;
         this.ropeImages = null;
         this.ropeAreaCollision = null;
         this.gearsSprite = null;
         this.gearsData = null;
         if(_value == 0)
         {
            this.TILE_VALUE = 1;
         }
         this.path_x_start = this.path_x_end = 0;
         this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = true;
         this.stateMachine = new StateMachine();
         this.stateMachine.setRule("IS_GHOST_STATE","APPEAR_ACTION","IS_VISIBLE_STATE");
         this.stateMachine.setRule("IS_INVISIBLE_STATE","APPEAR_ACTION","IS_VISIBLE_STATE");
         this.stateMachine.setRule("IS_ROPE_PAUSE_STATE","MOVE_ACTION","IS_ROPE_MOVING_STATE");
         this.stateMachine.setRule("IS_ROPE_MOVING_STATE","PAUSE_ACTION","IS_ROPE_PAUSE_STATE");
         this.stateMachine.setFunctionToState("IS_GHOST_STATE",this.ghostAnimation);
         this.stateMachine.setFunctionToState("IS_VISIBLE_STATE",this.visibleAnimation);
         this.stateMachine.setFunctionToState("IS_INVISIBLE_STATE",this.invisibleAnimation);
         this.stateMachine.setFunctionToState("IS_ROPE_PAUSE_STATE",this.ropeAnimation);
         this.stateMachine.setFunctionToState("IS_ROPE_MOVING_STATE",this.movingAnimation);
         this.invisibleImage = new Image(TextureManager.sTextureAtlas.getTexture("pinkBlockCollisionInvisible"));
         this.invisibleImage.touchable = false;
         Utils.backWorld.addChild(this.invisibleImage);
         this.pinkBlockImage = new Image(TextureManager.sTextureAtlas.getTexture("pinkBlockCollision"));
         this.pinkBlockImage.touchable = false;
         level.backgroundsManager.tiles.tilesContainer.addChild(this.pinkBlockImage);
         this.pinkBlockImage.alpha = 0;
         counter1 = 0;
         aabb.x = aabb.y = 0;
         aabb.width = 32;
         aabb.height = 24;
         if(_initial_state == 1)
         {
            this.stateMachine.setState("IS_INVISIBLE_STATE");
         }
         else if(_initial_state == 2)
         {
            this.stateMachine.setState("IS_VISIBLE_STATE");
         }
         else if(_initial_state == 3)
         {
            this.stateMachine.setState("IS_ROPE_PAUSE_STATE");
         }
         else
         {
            this.stateMachine.setState("IS_GHOST_STATE");
         }
      }
      
      override public function postInit() : void
      {
         var i:int = 0;
         var j:int = 0;
         var amount:int = 0;
         var image:Image = null;
         var this_area:Rectangle = null;
         var script_area:Rectangle = null;
         if(this.stateMachine.currentState == "IS_ROPE_PAUSE_STATE")
         {
            this_area = new Rectangle(xPos - 4,yPos - 4,32,32);
            script_area = new Rectangle();
            for(i = 0; i < level.scriptsManager.ropeScripts.length; i++)
            {
               if(level.scriptsManager.ropeScripts[i] != null)
               {
                  script_area.x = level.scriptsManager.ropeScripts[i].x;
                  script_area.y = level.scriptsManager.ropeScripts[i].y;
                  script_area.width = level.scriptsManager.ropeScripts[i].width;
                  script_area.height = level.scriptsManager.ropeScripts[i].height;
                  if(this_area.intersects(script_area))
                  {
                     this.ropeContainer = new Sprite();
                     this.ropeImages = new Vector.<Image>();
                     level.backgroundsManager.tiles.tilesBackContainer.addChild(this.ropeContainer);
                     amount = int(script_area.height / Utils.TILE_HEIGHT);
                     for(j = 0; j < amount; j++)
                     {
                        if(j == 0)
                        {
                           image = new Image(TextureManager.sTextureAtlas.getTexture("rope_tile_1"));
                        }
                        else if(j == amount - 1)
                        {
                           image = new Image(TextureManager.sTextureAtlas.getTexture("rope_tile_3"));
                        }
                        else
                        {
                           image = new Image(TextureManager.sTextureAtlas.getTexture("rope_tile_2"));
                        }
                        image.touchable = false;
                        this.ropeContainer.addChild(image);
                        image.x = 0;
                        image.y = j * Utils.TILE_HEIGHT;
                        this.ropeImages.push(image);
                     }
                     this.ropeAreaCollision = new RopeAreaCollision(level,script_area.x,script_area.y,script_area.width,script_area.height - 8);
                     level.collisionsManager.collisions.push(this.ropeAreaCollision);
                  }
               }
            }
            for(i = 0; i < level.scriptsManager.horPathScripts.length; i++)
            {
               if(level.scriptsManager.horPathScripts[i] != null)
               {
                  script_area.x = level.scriptsManager.horPathScripts[i].x;
                  script_area.y = level.scriptsManager.horPathScripts[i].y;
                  script_area.width = level.scriptsManager.horPathScripts[i].width;
                  script_area.height = level.scriptsManager.horPathScripts[i].height;
                  if(this_area.intersects(script_area))
                  {
                     this.path_x_start = int(Math.round(script_area.x));
                     this.path_x_end = int(Math.round(script_area.x + script_area.width));
                     if(Math.abs(xPos - this.path_x_start) < Math.abs(xPos - this.path_x_end))
                     {
                        this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = true;
                     }
                     else
                     {
                        this.IS_A_TO_B = this.ORIGINAL_IS_A_TO_B = false;
                     }
                     this.initGears();
                  }
               }
            }
         }
      }
      
      override public function update() : void
      {
         if(this.stateMachine.currentState == "IS_ROPE_PAUSE_STATE")
         {
            ++counter1;
            if(counter1 >= 60)
            {
               this.stateMachine.performAction("MOVE_ACTION");
            }
         }
         else if(this.stateMachine.currentState == "IS_ROPE_MOVING_STATE")
         {
            this.ropeAreaCollision.xPos = xPos;
            if(this.IS_A_TO_B)
            {
               ++xPos;
               if(xPos >= this.path_x_end - 16)
               {
                  xPos = this.path_x_end - 16;
                  this.IS_A_TO_B = !this.IS_A_TO_B;
                  this.stateMachine.performAction("PAUSE_ACTION");
               }
            }
            else
            {
               --xPos;
               if(xPos <= this.path_x_start)
               {
                  xPos = this.path_x_start;
                  this.IS_A_TO_B = !this.IS_A_TO_B;
                  this.stateMachine.performAction("PAUSE_ACTION");
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         if(this.invisibleImage != null)
         {
            this.invisibleImage.x = int(Math.floor(xPos - camera.xPos));
            this.invisibleImage.y = int(Math.floor(yPos - camera.yPos));
            this.pinkBlockImage.x = int(Math.floor(xPos));
            this.pinkBlockImage.y = int(Math.floor(yPos));
         }
         if(this.ropeContainer != null)
         {
            this.ropeContainer.x = xPos;
            this.ropeContainer.y = int(Math.floor(yPos + Utils.TILE_HEIGHT));
         }
         if(this.gearsData != null)
         {
            for(i = 0; i < this.gearsData.length; i++)
            {
               this.gearsSprite[i].x = int(Math.floor(this.gearsData[i].x - camera.xPos));
               this.gearsSprite[i].y = int(Math.floor(this.gearsData[i].y - camera.yPos));
               Utils.world.setChildIndex(this.gearsSprite[i],0);
            }
         }
      }
      
      override public function checkEntitiesCollision() : void
      {
      }
      
      public function appear() : void
      {
         if(this.stateMachine.currentState == "IS_GHOST_STATE")
         {
            level.topParticlesManager.pushParticle(new ItemExplosionParticleSprite(),xPos + Utils.TILE_WIDTH * 0.5,yPos + Utils.TILE_HEIGHT * 0.5,0,0,0);
         }
         this.stateMachine.performAction("APPEAR_ACTION");
         SoundSystem.PlaySound("brick_created");
      }
      
      protected function ghostAnimation() : void
      {
         this.invisibleImage.alpha = 1;
         this.pinkBlockImage.alpha = 0;
      }
      
      protected function invisibleAnimation() : void
      {
         this.invisibleImage.alpha = 0;
         this.pinkBlockImage.alpha = 0;
      }
      
      protected function ropeAnimation() : void
      {
         this.invisibleImage.alpha = 0;
         this.pinkBlockImage.alpha = 1;
         counter1 = 0;
         counter2 = 0;
      }
      
      protected function movingAnimation() : void
      {
      }
      
      protected function visibleAnimation() : void
      {
         this.invisibleImage.alpha = 0;
         this.pinkBlockImage.alpha = 1;
         level.levelData.setTileValueAt(int((xPos + 8) / Utils.TILE_WIDTH),int((yPos + 8) / Utils.TILE_HEIGHT),this.TILE_VALUE);
      }
      
      public function explode() : void
      {
         SoundSystem.PlaySound("brick_destroyed");
         dead = true;
         level.camera.shake(3);
         level.levelData.setTileValueAt(int((xPos + 8) / Utils.TILE_WIDTH),int((yPos + 8) / Utils.TILE_HEIGHT),0);
         level.topParticlesManager.createSmallBrickExplosion(xPos + 8,yPos + 8,false);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         Utils.backWorld.removeChild(this.invisibleImage);
         this.invisibleImage.dispose();
         this.invisibleImage = null;
         level.backgroundsManager.tiles.tilesContainer.removeChild(this.pinkBlockImage);
         this.pinkBlockImage.dispose();
         this.pinkBlockImage = null;
         if(this.stateMachine != null)
         {
            this.stateMachine.destroy();
            this.stateMachine = null;
         }
         if(this.gearsData != null)
         {
            if(this.gearsData.length)
            {
               for(i = 0; i < this.gearsData.length; i++)
               {
                  this.gearsData[i] = null;
                  Utils.world.removeChild(this.gearsSprite[i]);
                  this.gearsSprite[i].destroy();
                  this.gearsSprite[i].dispose();
                  this.gearsSprite[i] = null;
               }
               this.gearsData = null;
               this.gearsSprite = null;
            }
         }
         if(this.ropeContainer != null)
         {
            for(i = 0; i < this.ropeImages.length; i++)
            {
               this.ropeContainer.removeChild(this.ropeImages[i]);
               this.ropeImages[i].dispose();
               this.ropeImages[i] = null;
            }
            this.ropeImages = null;
            level.backgroundsManager.tiles.tilesBackContainer.removeChild(this.ropeContainer);
            this.ropeContainer.dispose();
            this.ropeContainer = null;
         }
         this.ropeAreaCollision = null;
         super.destroy();
      }
      
      protected function initGears() : void
      {
         var i:int = 0;
         var _length:Number = NaN;
         var _amount:int = 0;
         var sprite:PlatformGearCollisionSprite = null;
         this.gearsSprite = new Array();
         this.gearsData = new Array();
         _length = this.path_x_end - this.path_x_start;
         _amount = int(_length / 32);
         if(_length % 32 != 0)
         {
            _amount++;
         }
         for(i = 0; i < _amount; i++)
         {
            sprite = new PlatformGearCollisionSprite();
            Utils.world.addChild(sprite);
            this.gearsSprite.push(sprite);
            this.gearsData.push(new Point(this.path_x_start + i * 32 + 8,yPos + 8));
         }
      }
   }
}
