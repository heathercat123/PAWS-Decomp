package interfaces.dialogs.balloons
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import interfaces.dialogs.Dialog;
   import starling.animation.Transitions;
   import starling.animation.Tween;
   import starling.display.Image;
   
   public class CaptionBalloon extends Balloon
   {
       
      
      public var area:Rectangle;
      
      public var tween:Tween;
      
      public var tween2:Tween;
      
      private var IS_TWEEN_OVER:Boolean;
      
      protected var offset:Point;
      
      protected var corner_size:int;
      
      public var top_sx_corner:Image;
      
      public var top_dx_corner:Image;
      
      public var bot_sx_corner:Image;
      
      public var bot_dx_corner:Image;
      
      public var top_border:Image;
      
      public var dx_border:Image;
      
      public var bot_border:Image;
      
      public var sx_border:Image;
      
      public var inside:Image;
      
      public function CaptionBalloon(_dialog:Dialog, _width:int, _height:int)
      {
         super(_dialog,_width,_height);
         this.offset = new Point(0,0);
         this.corner_size = 5;
         this.createBalloon();
      }
      
      override public function destroy() : void
      {
         this.tween = null;
         this.tween2 = null;
         this.area = null;
         removeChild(this.top_sx_corner);
         removeChild(this.top_dx_corner);
         removeChild(this.bot_sx_corner);
         removeChild(this.bot_dx_corner);
         removeChild(this.top_border);
         removeChild(this.dx_border);
         removeChild(this.bot_border);
         removeChild(this.sx_border);
         removeChild(this.inside);
         this.top_sx_corner.dispose();
         this.top_dx_corner.dispose();
         this.bot_sx_corner.dispose();
         this.bot_dx_corner.dispose();
         this.top_border.dispose();
         this.dx_border.dispose();
         this.bot_border.dispose();
         this.sx_border.dispose();
         this.inside.dispose();
         this.top_sx_corner = null;
         this.top_dx_corner = null;
         this.bot_sx_corner = null;
         this.bot_dx_corner = null;
         this.top_border = null;
         this.dx_border = null;
         this.bot_border = null;
         this.sx_border = null;
         this.inside = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         if(stateMachine.currentState == "IS_ENTERING_STATE" || stateMachine.currentState == "IS_EXITING_STATE")
         {
            this.adaptToArea();
            if(this.IS_TWEEN_OVER)
            {
               stateMachine.performAction("END_ACTION");
            }
         }
      }
      
      override protected function enteringState() : void
      {
         this.tween = new Tween(this.area,0.1,Transitions.LINEAR);
         this.tween.moveTo(WIDTH,HEIGHT);
         this.tween.roundToInt = true;
         this.tween.onComplete = this._complete;
         Utils.juggler.add(this.tween);
         this.IS_TWEEN_OVER = false;
         this.tween2 = new Tween(this.offset,0.1,Transitions.LINEAR);
         this.tween2.moveTo(0,this.offset.y);
         this.tween2.roundToInt = true;
         Utils.juggler.add(this.tween2);
      }
      
      override protected function exitingState() : void
      {
         this.tween = new Tween(this.area,0.1,Transitions.LINEAR);
         this.tween.moveTo(WIDTH * 0.1,HEIGHT * 0.1);
         this.tween.roundToInt = true;
         this.tween.onComplete = this._complete;
         Utils.juggler.add(this.tween);
         this.IS_TWEEN_OVER = false;
         this.tween2 = new Tween(this.offset,0.1,Transitions.LINEAR);
         this.tween2.moveTo(this.offset.y,this.offset.y);
         this.tween2.roundToInt = true;
         Utils.juggler.add(this.tween2);
      }
      
      public function _complete() : void
      {
         this.IS_TWEEN_OVER = true;
         this.adaptToArea();
      }
      
      protected function createBalloon() : void
      {
         this.top_sx_corner = new Image(TextureManager.hudTextureAtlas.getTexture("dialog_corner"));
         addChild(this.top_sx_corner);
         this.top_border = new Image(TextureManager.hudTextureAtlas.getTexture("dialog_border"));
         addChild(this.top_border);
         this.top_dx_corner = new Image(TextureManager.hudTextureAtlas.getTexture("dialog_corner"));
         this.top_dx_corner.pivotX = this.top_dx_corner.pivotY = 2;
         this.top_dx_corner.scaleX = -1;
         addChild(this.top_dx_corner);
         this.dx_border = new Image(TextureManager.hudTextureAtlas.getTexture("dialog_border_side"));
         this.dx_border.scaleX = -1;
         addChild(this.dx_border);
         this.bot_dx_corner = new Image(TextureManager.hudTextureAtlas.getTexture("dialog_corner"));
         this.bot_dx_corner.pivotX = this.bot_dx_corner.pivotY = 2;
         this.bot_dx_corner.rotation = Math.PI;
         addChild(this.bot_dx_corner);
         this.bot_border = new Image(TextureManager.hudTextureAtlas.getTexture("dialog_border"));
         this.bot_border.width = WIDTH - this.corner_size * 2;
         this.bot_border.rotation = Math.PI;
         addChild(this.bot_border);
         this.bot_sx_corner = new Image(TextureManager.hudTextureAtlas.getTexture("dialog_corner"));
         this.bot_sx_corner.pivotX = this.bot_sx_corner.pivotY = 2;
         this.bot_sx_corner.scaleY = -1;
         addChild(this.bot_sx_corner);
         this.sx_border = new Image(TextureManager.hudTextureAtlas.getTexture("dialog_border_side"));
         this.sx_border.height = HEIGHT - this.corner_size * 2;
         addChild(this.sx_border);
         this.inside = new Image(TextureManager.hudTextureAtlas.getTexture("dialog_full"));
         addChild(this.inside);
         this.area = new Rectangle(WIDTH * 0.1,HEIGHT * 0.1);
         this.adaptToArea();
      }
      
      protected function adaptToArea() : void
      {
         if(this.area == null)
         {
            return;
         }
         var __width:int = this.area.x;
         var __height:int = this.area.y;
         if(__width < 16)
         {
            __width = 16;
         }
         if(__height < 8)
         {
            __height = 8;
         }
         var origin_x:int = int(Math.floor((WIDTH - __width) * 0.5));
         var origin_y:int = int(Math.floor((HEIGHT - __height) * 0.5));
         this.top_sx_corner.x = origin_x + int(Math.ceil(this.offset.x));
         this.top_sx_corner.y = origin_y;
         this.top_border.x = origin_x + this.corner_size + int(Math.ceil(this.offset.x));
         this.top_border.y = origin_y;
         this.top_border.width = __width - this.corner_size * 2;
         this.top_dx_corner.x = origin_x + __width - 2 + int(Math.ceil(this.offset.x));
         this.top_dx_corner.y = origin_y + 2;
         this.dx_border.height = __height - this.corner_size * 2;
         this.dx_border.x = origin_x + __width + int(Math.ceil(this.offset.x));
         this.dx_border.y = origin_y + this.corner_size;
         this.bot_dx_corner.x = origin_x + __width - 2 + int(Math.ceil(this.offset.x));
         this.bot_dx_corner.y = origin_y + __height - 2;
         this.bot_border.width = __width - this.corner_size * 2;
         this.bot_border.x = origin_x + __width - this.corner_size + int(Math.ceil(this.offset.x));
         this.bot_border.y = origin_y + __height;
         this.bot_sx_corner.x = origin_x + 2 + int(Math.ceil(this.offset.x));
         this.bot_sx_corner.y = origin_y + __height - 2;
         this.sx_border.height = __height - this.corner_size * 2;
         this.sx_border.x = origin_x + int(Math.ceil(this.offset.x));
         this.sx_border.y = origin_y + this.corner_size;
         this.inside.x = origin_x + this.corner_size + int(Math.ceil(this.offset.x));
         this.inside.y = origin_y + this.corner_size;
         this.inside.width = __width - this.corner_size * 2;
         this.inside.height = __height - this.corner_size * 2;
      }
      
      override public function setOffset(amount:int) : void
      {
         this.offset.x = amount;
         this.offset.y = amount;
         this.adaptToArea();
      }
   }
}
