package interfaces.map.coins
{
   import flash.geom.Rectangle;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import interfaces.map.*;
   import interfaces.panels.SettingsPanel;
   import sprites.map.MapCoinSprite;
   
   public class MapCoin
   {
       
      
      public var worldMap:WorldMap;
      
      public var sprite:MapCoinSprite;
      
      public var level_index:int;
      
      public var xPos:Number;
      
      public var yPos:Number;
      
      protected var aabb:Rectangle;
      
      public var dead:Boolean;
      
      public function MapCoin(_worldMap:WorldMap, _xPos:Number, _yPos:Number, _level_index:int)
      {
         super();
         this.worldMap = _worldMap;
         this.xPos = _xPos;
         this.yPos = _yPos;
         this.level_index = _level_index;
         this.dead = false;
         this.sprite = new MapCoinSprite();
         Utils.topWorld.addChild(this.sprite);
         this.sprite.gotoAndStop(1);
         this.aabb = new Rectangle(-4,-8,20,28);
      }
      
      public function destroy() : void
      {
         this.aabb = null;
         Utils.topWorld.removeChild(this.sprite);
         this.sprite.destroy();
         this.sprite.dispose();
         this.sprite = null;
         this.worldMap = null;
      }
      
      public function update() : void
      {
         if(this.sprite.gfxHandleClip().isComplete)
         {
            this.sprite.gfxHandleClip().setFrameDuration(0,int(Math.random() * 2 + 1));
            this.sprite.gfxHandleClip().gotoAndPlay(1);
         }
      }
      
      public function updateScreenPosition(mapCamera:MapCamera) : void
      {
         this.sprite.x = int(Math.floor(this.xPos - mapCamera.xPos));
         this.sprite.y = int(Math.floor(this.yPos - mapCamera.yPos));
         this.sprite.updateScreenPosition();
      }
      
      public function collect() : void
      {
         if(this.dead)
         {
            return;
         }
         SoundSystem.PlaySound("coin");
         this.dead = true;
         this.worldMap.mapParticlesManager.itemSparkles("yellow",this.xPos + int(this.aabb.x + this.aabb.width * 0.5),this.yPos + int(this.aabb.y + this.aabb.height * 0.5),16);
         ++Utils.Slot.playerInventory[LevelItems.ITEM_COIN];
         SaveManager.SaveInventory(true);
         SettingsPanel.iCloudSaveCoins();
      }
      
      public function getAABB() : Rectangle
      {
         return new Rectangle(this.xPos + this.aabb.x,this.yPos + this.aabb.y,this.aabb.width,this.aabb.height);
      }
      
      public function enableButtons() : void
      {
      }
      
      public function disableButtons() : void
      {
      }
   }
}
