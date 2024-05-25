package entities.npcs
{
   import game_utils.*;
   import levels.*;
   import levels.cameras.ScreenCamera;
   import sprites.*;
   import sprites.cats.*;
   import sprites.enemies.*;
   import starling.filters.FragmentFilter;
   import starling.textures.TextureSmoothing;
   
   public class CutsceneNPC extends NPC
   {
      
      public static var BOSS_LIZARD:int = 0;
      
      public static var BOSS_FOX:int = 1;
      
      public static var BOSS_FISH:int = 2;
      
      public static var BOSS_LACE:int = 3;
       
      
      public var SPEED:Number;
      
      public var TYPE:int;
      
      public var sprite_0:GameSprite;
      
      public var sprite_1:GameSprite;
      
      public var sprite_2:GameSprite;
      
      public var sprite_3:GameSprite;
      
      public var sin_counter_1:Number;
      
      public var sin_counter_2:Number;
      
      protected var y_offset:Number;
      
      public function CutsceneNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _string_id:int = 0, _type:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_string_id);
         this.TYPE = _type;
         this.SPEED = 2;
         this.sin_counter_1 = this.sin_counter_2 = this.y_offset = 0;
         if(this.TYPE == 0)
         {
            sprite = new LizardBossEnemySprite();
         }
         else if(this.TYPE == 1)
         {
            sprite = new FoxBossEnemySprite();
         }
         else if(this.TYPE == 2)
         {
            sprite = new GameSprite();
         }
         else if(this.TYPE == 3)
         {
            sprite = new LaceBossEnemySprite();
         }
         if(this.TYPE == 2)
         {
            this.sin_counter_2 = 0.05;
            Utils.world.addChild(sprite);
            this.sprite_0 = new FishBossEnemySprite(0);
            this.sprite_0.x = -28;
            this.sprite_0.y = -33;
            sprite.addChild(this.sprite_0);
            this.sprite_1 = new FishBossEnemySprite(1);
            this.sprite_1.gfxHandle().gfxHandleClip().gotoAndStop(1);
            sprite.addChild(this.sprite_1);
            this.sprite_1.x = -33;
            this.sprite_2 = new FishBossEnemySprite(2);
            sprite.addChild(this.sprite_2);
            this.sprite_2.x = this.sprite_2.y = 3;
            this.sprite_3 = new FishBossEnemySprite(3);
            sprite.addChild(this.sprite_3);
            this.sprite_3.x = 21;
            shocked_offset_x = 28;
            shocked_offset_y = -16;
            sprite.filter = new FragmentFilter();
            FragmentFilter(sprite.filter).resolution = Utils.GFX_INV_SCALE;
            FragmentFilter(sprite.filter).textureSmoothing = TextureSmoothing.NONE;
         }
         else
         {
            Utils.world.addChild(sprite);
         }
      }
      
      override public function destroy() : void
      {
         if(this.TYPE == 2)
         {
            sprite.filter = null;
            sprite.removeChild(this.sprite_3);
            sprite.removeChild(this.sprite_2);
            sprite.removeChild(this.sprite_1);
            sprite.removeChild(this.sprite_0);
            Utils.world.removeChild(sprite);
            this.sprite_3.destroy();
            this.sprite_2.destroy();
            this.sprite_1.destroy();
            this.sprite_0.destroy();
            sprite.destroy();
            this.sprite_3.dispose();
            this.sprite_2.dispose();
            this.sprite_1.dispose();
            this.sprite_0.dispose();
            sprite.dispose();
            this.sprite_3 = this.sprite_2 = this.sprite_1 = this.sprite_0 = sprite = null;
         }
         super.destroy();
      }
      
      override public function getBalloonXOffset() : int
      {
         if(this.TYPE == 0)
         {
            return 16;
         }
         if(this.TYPE == 2)
         {
            return 0;
         }
         return 8;
      }
      
      override public function getBalloonYOffset() : int
      {
         if(this.TYPE == 0)
         {
            return -28;
         }
         if(this.TYPE == 2)
         {
            return -36;
         }
         if(this.TYPE == 3)
         {
            return -36;
         }
         return -20;
      }
      
      override public function update() : void
      {
         super.update();
         if(this.TYPE == 2)
         {
            this.sin_counter_1 += this.sin_counter_2;
            if(this.sin_counter_1 >= Math.PI * 2)
            {
               this.sin_counter_1 -= Math.PI * 2;
            }
            this.y_offset = Math.sin(this.sin_counter_1) * 2.5;
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         if(this.TYPE == 2)
         {
            sprite.x = int(Math.floor(xPos - camera.xPos));
            sprite.y = int(Math.floor(yPos + this.y_offset - camera.yPos));
            if(DIRECTION == LEFT)
            {
               sprite.scaleX = 1;
            }
            else
            {
               sprite.scaleX = -1;
            }
            this.sprite_0.updateScreenPosition();
            this.sprite_1.updateScreenPosition();
            this.sprite_2.updateScreenPosition();
            this.sprite_3.updateScreenPosition();
         }
         else
         {
            super.updateScreenPosition(camera);
         }
      }
   }
}
