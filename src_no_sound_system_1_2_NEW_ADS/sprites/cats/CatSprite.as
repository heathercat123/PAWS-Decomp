package sprites.cats
{
   import game_utils.FrameData;
   import game_utils.GameSlot;
   import levels.cameras.*;
   import sprites.*;
   import sprites.items.HatItemSprite;
   
   public class CatSprite extends GameSprite
   {
      
      public static var SHOCKED:int = 0;
      
      public static var PEEK:int = 1;
      
      public static var PANT:int = 2;
      
      public static var LOOK_UP:int = 3;
      
      public static var ALERT:int = 4;
       
      
      protected var hatItemSprite:HatItemSprite;
      
      protected var hat_frames:Array;
      
      protected var FORCED_CAT_ID:int;
      
      public function CatSprite(force_cat_id:int = -1)
      {
         super();
         this.FORCED_CAT_ID = force_cat_id;
      }
      
      public function refreshHat() : void
      {
         if(this.hatItemSprite != null)
         {
            removeChild(this.hatItemSprite);
            this.hatItemSprite.destroy();
            this.hatItemSprite.dispose();
            this.hatItemSprite = null;
         }
         if(this.FORCED_CAT_ID == -1)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]] != 0)
            {
               this.hatItemSprite = new HatItemSprite(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + Utils.Slot.gameVariables[GameSlot.VARIABLE_CAT]]);
               addChild(this.hatItemSprite);
               this.updateScreenPosition();
            }
         }
         else if(this.FORCED_CAT_ID != -100)
         {
            if(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + this.FORCED_CAT_ID] != 0)
            {
               this.hatItemSprite = new HatItemSprite(Utils.Slot.gameVariables[GameSlot.VARIABLE_APPAREL_CAT_0_EQUIPPED + this.FORCED_CAT_ID]);
               addChild(this.hatItemSprite);
               this.updateScreenPosition();
            }
         }
      }
      
      override public function destroy() : void
      {
         if(this.hatItemSprite != null)
         {
            removeChild(this.hatItemSprite);
            this.hatItemSprite.destroy();
            this.hatItemSprite.dispose();
            this.hatItemSprite = null;
         }
         super.destroy();
      }
      
      override public function updateScreenPosition() : void
      {
         var frame_1:int = 0;
         var frame_2:int = 0;
         super.updateScreenPosition();
         if(this.hatItemSprite != null)
         {
            this.hatItemSprite.visible = true;
            this.hatItemSprite.scaleX = gfxHandle().scaleX;
            frame_1 = gfxHandle().frame - 1;
            frame_2 = gfxHandle().gfxHandleClip().currentFrame;
            if(frame_1 < this.hat_frames.length)
            {
               if(frame_2 < this.hat_frames[frame_1].length)
               {
                  this.hatItemSprite.x = this.hat_frames[frame_1][frame_2].x;
                  this.hatItemSprite.y = this.hat_frames[frame_1][frame_2].y;
                  this.hatItemSprite.gfxHandleClip().gotoAndStop(this.hat_frames[frame_1][frame_2].hat_frame);
                  this.hatItemSprite.updateScreenPosition();
                  this.hatItemSprite.rotation = this.hat_frames[frame_1][frame_2].rotation * this.hatItemSprite.scaleX;
                  this.hatItemSprite.scaleX *= this.hat_frames[frame_1][frame_2].inv_scale;
                  if(this.hatItemSprite.scaleX < 0)
                  {
                     this.hatItemSprite.x += this.hat_frames[frame_1][frame_2].x_offset;
                  }
               }
            }
         }
      }
      
      public function playSpecialAnim(type:int = 0) : void
      {
      }
      
      protected function initHatArray() : void
      {
         var i:int = 0;
         var j:int = 0;
         this.hat_frames = new Array();
         for(i = 0; i < 32; i++)
         {
            this.hat_frames.push(new Array());
         }
         this.hat_frames[0].push(new FrameData(5,-2,1,6));
         this.hat_frames[0].push(new FrameData(5,-2,1,6));
         this.hat_frames[0].push(new FrameData(5,-2,1,6));
         this.hat_frames[0].push(new FrameData(5,-2,1,6));
         this.hat_frames[1].push(new FrameData(5,0,1,6));
         this.hat_frames[1].push(new FrameData(5,-4,1,6));
         this.hat_frames[1].push(new FrameData(5,-6,1,6));
         this.hat_frames[1].push(new FrameData(5,-4,1,6));
         this.hat_frames[1].push(new FrameData(5,0,1,6));
         this.hat_frames[1].push(new FrameData(5,1,1,6));
         this.hat_frames[2].push(new FrameData(8,-2,2,0));
         this.hat_frames[3].push(new FrameData(5,-4,1,6));
         this.hat_frames[4].push(new FrameData(5,-4,1,6));
         this.hat_frames[5].push(new FrameData(20,5,1,-24,Math.PI * 0.5));
         this.hat_frames[5].push(new FrameData(24,5,1,-32,Math.PI * 0.5));
         this.hat_frames[5].push(new FrameData(25,5,1,-34,Math.PI * 0.5));
         this.hat_frames[5].push(new FrameData(24,5,1,-32,Math.PI * 0.5));
         this.hat_frames[5].push(new FrameData(20,5,1,-24,Math.PI * 0.5));
         this.hat_frames[5].push(new FrameData(19,5,1,-22,Math.PI * 0.5));
         this.hat_frames[6].push(new FrameData(19,6,1,-22,Math.PI * 0.5));
         this.hat_frames[7].push(new FrameData(5,0,1,6,0));
         this.hat_frames[7].push(new FrameData(5,-6,1,6,0));
         this.hat_frames[7].push(new FrameData(5,-4,1,6,0));
         this.hat_frames[7].push(new FrameData(5,1,1,6,0));
         this.hat_frames[8].push(new FrameData(8,0,1,0,0,-1));
         this.hat_frames[9].push(new FrameData(5,-4,1,6));
         this.hat_frames[10].push(new FrameData(5,-4,1,6));
         this.hat_frames[11].push(new FrameData(5,-1,1,6));
         this.hat_frames[12].push(new FrameData(5,-2,1,6));
         this.hat_frames[12].push(new FrameData(5,-2,1,6));
         this.hat_frames[12].push(new FrameData(5,-2,1,6));
         this.hat_frames[12].push(new FrameData(5,-2,1,6));
         this.hat_frames[13].push(new FrameData(4,0,1,8));
         this.hat_frames[13].push(new FrameData(4,0,1,8));
         this.hat_frames[13].push(new FrameData(4,0,1,8));
         this.hat_frames[13].push(new FrameData(4,0,1,8));
         this.hat_frames[13].push(new FrameData(4,0,1,8));
         this.hat_frames[13].push(new FrameData(5,-2,1,6));
         this.hat_frames[13].push(new FrameData(5,-2,1,6));
         this.hat_frames[13].push(new FrameData(5,-2,1,6));
         this.hat_frames[13].push(new FrameData(5,-2,1,6));
         this.hat_frames[14].push(new FrameData(5,-2,1,6));
         this.hat_frames[14].push(new FrameData(5,-4,1,6));
         this.hat_frames[15].push(new FrameData(5,-4,1,6));
         this.hat_frames[16].push(new FrameData(5,-4,1,6));
         this.hat_frames[17].push(new FrameData(5,2,1,6));
         this.hat_frames[18].push(new FrameData(5,-2,3,6));
         this.hat_frames[18].push(new FrameData(5,-2,3,6));
         this.hat_frames[18].push(new FrameData(5,-2,3,6));
         this.hat_frames[18].push(new FrameData(5,-2,3,6));
         this.hat_frames[19].push(new FrameData(7,-5,3,2));
         this.hat_frames[19].push(new FrameData(7,-5,3,2));
         this.hat_frames[20].push(new FrameData(8,-5,4,0));
         this.hat_frames[21].push(new FrameData(5,-2,1,6));
      }
   }
}
