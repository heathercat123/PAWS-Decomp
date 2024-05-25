package levels.collisions
{
   import flash.geom.*;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.*;
   import sprites.collisions.CatSpotCollisionSprite;
   import starling.display.Image;
   
   public class CatSpotCollision extends ExitCollision
   {
       
      
      protected var backImage:Image;
      
      protected var outer_aabb:Rectangle;
      
      protected var IS_COLLIDING:Boolean;
      
      protected var TYPE:int;
      
      protected var IS_HERO_INSIDE:Boolean;
      
      protected var time_alive:int;
      
      protected var collision_counter:int;
      
      protected var IS_INVISIBLE:Boolean;
      
      protected var alpha_counter:int = 0;
      
      public function CatSpotCollision(_level:Level, _xPos:Number, _yPos:Number, _id:int, _type:int = 0)
      {
         var x_t:int = 0;
         var y_t:int = 0;
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         EXIT_FLAG = false;
         EXIT_TYPE = 1;
         this.IS_HERO_INSIDE = false;
         this.time_alive = 0;
         this.collision_counter = 0;
         sprite = new CatSpotCollisionSprite();
         Utils.topWorld.addChild(sprite);
         if(this.TYPE == 0)
         {
            sprite.gfxHandleClip().gotoAndStop(1);
            NOT_A_DOOR = true;
         }
         else
         {
            sprite.gfxHandleClip().gotoAndStop(2);
         }
         this.backImage = new Image(TextureManager.sTextureAtlas.getTexture("checkeredSpotBackImage"));
         this.backImage.touchable = false;
         Utils.backWorld.addChild(this.backImage);
         this.IS_COLLIDING = false;
         aabb.x = 10;
         aabb.y = -8;
         aabb.width = 30;
         aabb.height = 24;
         initDoorId();
         this.IS_INVISIBLE = false;
         if(this.TYPE == 1)
         {
            x_t = int((xPos + 24) / Utils.TILE_WIDTH);
            y_t = int((yPos + 8) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) == 0)
            {
               this.IS_INVISIBLE = true;
            }
         }
         if(this.IS_INVISIBLE)
         {
            sprite.alpha = this.backImage.alpha = 0;
            sprite.visible = this.backImage.visible = false;
            this.alpha_counter = 0;
         }
         this.outer_aabb = new Rectangle(2,-16,46,16);
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(this.backImage);
         this.backImage.dispose();
         this.backImage = null;
         Utils.topWorld.removeChild(sprite);
         this.outer_aabb = null;
         super.destroy();
      }
      
      override public function checkEntitiesCollision() : void
      {
         ++this.time_alive;
         if(this.time_alive >= 60)
         {
            this.time_alive = 60;
         }
         if(EXIT_FLAG || this.TYPE == 0)
         {
            return;
         }
         var aabb_1:Rectangle = level.hero.getAABB();
         var aabb_2:Rectangle = getAABB();
         if(aabb_1.intersects(aabb_2))
         {
            if(this.time_alive < 60)
            {
               this.IS_HERO_INSIDE = true;
            }
         }
         else
         {
            this.IS_HERO_INSIDE = false;
         }
         if(level.stateMachine.currentState == "IS_CUTSCENE_STATE" || level.hero.stateMachine.currentState != "IS_STANDING_STATE" && level.hero.stateMachine.currentState != "IS_STANDING_WATER_STATE")
         {
            this.collision_counter = 0;
            return;
         }
         if(aabb_1.intersects(aabb_2) && !this.IS_HERO_INSIDE)
         {
            if(this.collision_counter++ > 5)
            {
               EXIT_FLAG = true;
               Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = DOOR_ID;
               level.exit();
            }
         }
         else
         {
            this.collision_counter = 0;
         }
      }
      
      override public function update() : void
      {
         var x_t:int = 0;
         var y_t:int = 0;
         super.update();
         if(this.IS_INVISIBLE)
         {
            x_t = int((xPos + 24) / Utils.TILE_WIDTH);
            y_t = int((yPos + 8) / Utils.TILE_HEIGHT);
            if(level.levelData.getTileValueAt(x_t,y_t) != 0)
            {
               this.IS_INVISIBLE = false;
               sprite.alpha = this.backImage.alpha = 0;
               sprite.visible = this.backImage.visible = true;
               this.alpha_counter = 0;
            }
         }
         else if(sprite.alpha < 1)
         {
            ++this.alpha_counter;
            if(this.alpha_counter > 2)
            {
               this.alpha_counter = 0;
               sprite.alpha += 0.3;
               this.backImage.alpha += 0.3;
               if(sprite.alpha >= 1)
               {
                  sprite.alpha = this.backImage.alpha = 1;
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.backImage.x = sprite.x;
         this.backImage.y = sprite.y;
         if(this.IS_INVISIBLE)
         {
            sprite.visible = false;
            this.backImage.visible = false;
         }
      }
      
      public function getOuterAABB() : Rectangle
      {
         return new Rectangle(xPos + this.outer_aabb.x,yPos + this.outer_aabb.y,this.outer_aabb.width,this.outer_aabb.height);
      }
   }
}
