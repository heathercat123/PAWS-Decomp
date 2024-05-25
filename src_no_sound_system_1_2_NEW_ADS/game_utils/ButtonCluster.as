package game_utils
{
   import sprites.hud.MapBalloonHudSprite;
   import starling.display.Button;
   
   public class ButtonCluster
   {
       
      
      public var button:Button;
      
      public var icons:Vector.<MapBalloonHudSprite>;
      
      public var sin:Number;
      
      public var level_index:int;
      
      public function ButtonCluster(_button:Button, _index:int)
      {
         var i:int = 0;
         var pSprite:MapBalloonHudSprite = null;
         var item_mask:int = 0;
         super();
         this.button = _button;
         this.sin = 0;
         this.level_index = _index;
         this.icons = new Vector.<MapBalloonHudSprite>();
         for(i = 0; i < LevelItems.Items[this.level_index].length; i++)
         {
            pSprite = new MapBalloonHudSprite();
            if(LevelItems.Items[this.level_index][i] == LevelItems.ITEM_KEY)
            {
               pSprite.gfxHandleClip().gotoAndStop(1);
            }
            else
            {
               pSprite.gfxHandleClip().gotoAndStop(2);
            }
            item_mask = int(Utils.Slot.levelItems[this.level_index]);
            if((item_mask >> i & 1) == 1)
            {
               pSprite.visible = false;
            }
            this.icons.push(pSprite);
            Utils.world.addChild(pSprite);
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.icons.length; i++)
         {
            if(this.icons[i] != null)
            {
               Utils.world.removeChild(this.icons[i]);
               this.icons[i].destroy();
               this.icons[i].dispose();
               this.icons[i] = null;
            }
         }
         this.icons = null;
         this.button = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         this.sin -= 0.02;
         if(this.sin <= Math.PI * 2)
         {
            this.sin += Math.PI * 2;
         }
         var step:int = 0;
         for(i = 0; i < this.icons.length; i++)
         {
            this.icons[i].x = int(this.button.x + 16 + Math.sin(this.sin + step * 0.4) * 24);
            this.icons[i].y = int(this.button.y + 16 + Math.cos(this.sin + step * 0.4) * 24);
            Utils.world.setChildIndex(this.icons[i],Utils.world.numChildren - 1);
            if(this.icons[i].visible)
            {
               step++;
            }
         }
      }
   }
}
