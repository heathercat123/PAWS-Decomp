package levels.decorations
{
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import sprites.decorations.GenericDecorationSprite;
   import starling.display.Quad;
   
   public class NeonDecoration extends Decoration
   {
       
      
      protected var TYPE:int;
      
      public var backgroundQuad:Quad;
      
      protected var color:uint;
      
      protected var sin_counter_1:Number;
      
      protected var sin_counter_2:Number;
      
      protected var sin_counter_3:Number;
      
      protected var sin_counter_4:Number;
      
      protected var sin_speed_1:Number;
      
      protected var sin_speed_2:Number;
      
      protected var sin_speed_3:Number;
      
      protected var sin_speed_4:Number;
      
      public function NeonDecoration(_level:Level, _xPos:Number, _yPos:Number, _type:int)
      {
         super(_level,_xPos,_yPos);
         this.TYPE = _type;
         this.sin_counter_1 = Math.random() * Math.PI * 2;
         this.sin_counter_2 = Math.random() * Math.PI * 2;
         this.sin_counter_3 = Math.random() * Math.PI * 2;
         this.sin_counter_4 = Math.random() * Math.PI * 2;
         this.sin_speed_1 = Math.random() * 0.025 + 0.025;
         this.sin_speed_2 = Math.random() * 0.025 + 0.025;
         this.sin_speed_3 = Math.random() * 0.025 + 0.025;
         this.sin_speed_4 = Math.random() * 0.025 + 0.025;
         if(this.TYPE == 0)
         {
            sprite = new GenericDecorationSprite(GenericDecoration.NEON_RED);
            sprite.gfxHandleClip().gotoAndPlay(1);
            this.color = 16711935;
         }
         else
         {
            sprite = new GenericDecorationSprite(GenericDecoration.NEON_BLUE);
            sprite.gfxHandleClip().gotoAndPlay(2);
            this.color = 65535;
         }
         Utils.topWorld.addChild(sprite);
         this.backgroundQuad = new Quad(512,96,this.color);
         this.backgroundQuad.width = 512;
         this.backgroundQuad.height = 80;
         this.backgroundQuad.x = 0;
         this.backgroundQuad.y = 0;
         this.backgroundQuad.setVertexColor(0,this.color);
         this.backgroundQuad.setVertexColor(1,this.color);
         this.backgroundQuad.setVertexColor(2,this.color);
         this.backgroundQuad.setVertexColor(3,this.color);
         this.backgroundQuad.setVertexAlpha(0,0.75 + Math.sin(this.sin_counter_1) * 0.25);
         this.backgroundQuad.setVertexAlpha(1,0.75 + Math.sin(this.sin_counter_2) * 0.25);
         this.backgroundQuad.setVertexAlpha(2,0.75 + Math.sin(this.sin_counter_3) * 0.25);
         this.backgroundQuad.setVertexAlpha(3,0.75 + Math.sin(this.sin_counter_4) * 0.25);
         Utils.backWorld.addChild(this.backgroundQuad);
      }
      
      override public function destroy() : void
      {
         Utils.backWorld.removeChild(this.backgroundQuad);
         this.backgroundQuad.dispose();
         this.backgroundQuad = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         this.sin_counter_1 += this.sin_speed_1;
         if(this.sin_counter_1 > Math.PI * 2)
         {
            this.sin_counter_1 -= Math.PI * 2;
            this.sin_speed_1 = Math.random() * 0.04 + 0.025;
         }
         this.sin_counter_2 += this.sin_speed_2;
         if(this.sin_counter_2 > Math.PI * 2)
         {
            this.sin_counter_2 -= Math.PI * 2;
            this.sin_speed_2 = Math.random() * 0.04 + 0.025;
         }
         this.sin_counter_3 += this.sin_speed_3;
         if(this.sin_counter_3 > Math.PI * 2)
         {
            this.sin_counter_3 -= Math.PI * 2;
            this.sin_speed_3 = Math.random() * 0.04 + 0.025;
         }
         this.sin_counter_4 += this.sin_speed_4;
         if(this.sin_counter_4 > Math.PI * 2)
         {
            this.sin_counter_4 -= Math.PI * 2;
            this.sin_speed_4 = Math.random() * 0.04 + 0.025;
         }
         this.backgroundQuad.setVertexColor(0,this.color);
         this.backgroundQuad.setVertexColor(1,this.color);
         this.backgroundQuad.setVertexColor(2,this.color);
         this.backgroundQuad.setVertexColor(3,this.color);
         this.backgroundQuad.setVertexAlpha(0,0 + Math.sin(this.sin_counter_1) * 0.5);
         this.backgroundQuad.setVertexAlpha(1,0 + Math.sin(this.sin_counter_2) * 0.5);
         this.backgroundQuad.setVertexAlpha(2,0);
         this.backgroundQuad.setVertexAlpha(3,0);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.backgroundQuad.x = int(Math.floor(176 - camera.x));
         this.backgroundQuad.y = int(Math.floor(63 - camera.y));
      }
   }
}
