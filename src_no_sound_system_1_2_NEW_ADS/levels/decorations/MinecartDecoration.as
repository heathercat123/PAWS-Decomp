package levels.decorations
{
   import levels.Level;
   import sprites.decorations.MinecartDecorationSprite;
   
   public class MinecartDecoration extends Decoration
   {
       
      
      protected var counter1:int;
      
      protected var last_anim:int;
      
      protected var index:int;
      
      public function MinecartDecoration(_level:Level, _xPos:Number, _yPos:Number, _index:int)
      {
         super(_level,_xPos,_yPos);
         this.index = _index;
         sprite = new MinecartDecorationSprite(this.index);
         sprite.gotoAndStop(1);
         Utils.topWorld.addChild(sprite);
         this.counter1 = Math.random() * 30 + 20;
         this.last_anim = 0;
      }
      
      override public function destroy() : void
      {
         Utils.topWorld.removeChild(sprite);
         super.destroy();
      }
      
      override public function update() : void
      {
         var rand:int = 0;
         var anim:int = 0;
         if(sprite.frame == 1)
         {
            if(sprite.gfxHandleClip().isComplete)
            {
               do
               {
                  rand = Math.random() * 100;
                  if(rand < 33)
                  {
                     anim = 2;
                  }
                  else if(rand >= 33 && rand < 66)
                  {
                     anim = 3;
                  }
                  else
                  {
                     anim = 4;
                  }
               }
               while(anim == this.last_anim);
               
               this.last_anim = anim;
               sprite.gotoAndStop(this.last_anim);
               sprite.gfxHandleClip().gotoAndPlay(1);
            }
         }
         else if(sprite.gfxHandleClip().isComplete)
         {
            sprite.gotoAndStop(1);
            sprite.gfxHandleClip().gotoAndPlay(1);
            sprite.gfxHandleClip().setFrameDuration(0,Math.random() * 0.2 + 0.1);
            this.counter1 = Math.random() * 30 + 20;
         }
      }
   }
}
