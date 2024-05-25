package levels.backgrounds
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import levels.Level;
   import levels.cameras.*;
   import sprites.background.*;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class DesertBackground extends Background
   {
       
      
      protected var pCounter:int;
      
      protected var reflections:Vector.<SeaDawnReflectionBackgroundSprite>;
      
      protected var reflectionsData1:Vector.<Rectangle>;
      
      protected var reflectionsData2:Vector.<Rectangle>;
      
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
      
      protected var sky_layer:Image;
      
      protected var TYPE:int;
      
      protected var thunder_counter:int;
      
      protected var thunder_counter_2:int;
      
      protected var thunder_counter_3:int;
      
      protected var thunder_counter_b:int;
      
      protected var thunder_counter_2_b:int;
      
      protected var thunder_counter_3_b:int;
      
      protected var thunderSprite_b:ThunderBackgroundParticleSprite;
      
      public function DesertBackground(_level:Level, arg:int = 0)
      {
         var i:int = 0;
         var j:int = 0;
         var obj:DisplayObject = null;
         var sub_obj:DisplayObject = null;
         var mClip:MovieClip = null;
         var layer:Sprite = null;
         var amount:int = 0;
         var sprite:SeaDawnReflectionBackgroundSprite = null;
         var rand_y:Number = NaN;
         super(_level);
         this.TYPE = arg;
         this.backgroundQuad = null;
         if(this.TYPE == 2 || this.TYPE == 3)
         {
            this.sin_counter_1 = Math.random() * Math.PI * 2;
            this.sin_counter_2 = Math.random() * Math.PI * 2;
            this.sin_counter_3 = Math.random() * Math.PI * 2;
            this.sin_counter_4 = Math.random() * Math.PI * 2;
            this.sin_speed_1 = Math.random() * 0.025 + 0.025;
            this.sin_speed_2 = Math.random() * 0.025 + 0.025;
            this.sin_speed_3 = Math.random() * 0.025 + 0.025;
            this.sin_speed_4 = Math.random() * 0.025 + 0.025;
            this.color = 6422404;
         }
         Starling.current.stage.color = 0;
         this.pCounter = 0;
         this.reflections = null;
         this.reflectionsData1 = null;
         this.reflectionsData2 = null;
         var ADD_REFLECTIONS_FLAG:Boolean = false;
         var reflection_yRef:Number = 0;
         if(level.levelData.bg_sea_reflections_y > 0)
         {
            ADD_REFLECTIONS_FLAG = true;
            reflection_yRef = level.levelData.bg_sea_reflections_y;
         }
         if(ADD_REFLECTIONS_FLAG)
         {
            this.reflections = new Vector.<SeaDawnReflectionBackgroundSprite>();
            this.reflectionsData1 = new Vector.<Rectangle>();
            this.reflectionsData2 = new Vector.<Rectangle>();
            amount = 32;
            for(i = 0; i < amount; i++)
            {
               if(this.TYPE == 1 || this.TYPE == 2 || this.TYPE == 3)
               {
                  sprite = new SeaDawnReflectionBackgroundSprite(1);
               }
               else
               {
                  sprite = new SeaDawnReflectionBackgroundSprite();
               }
               rand_y = int(Math.random() * 5) * 4;
               this.reflections.push(sprite);
               this.reflectionsData1.push(new Rectangle(Math.random() * Utils.WIDTH,reflection_yRef + 2 + rand_y,(rand_y + 1) * 0.25,0));
               this.reflectionsData2.push(new Rectangle());
               layer_0.addChild(sprite);
            }
         }
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            this.thunderSprite_b = new ThunderBackgroundParticleSprite();
            layer_static.addChild(this.thunderSprite_b);
            this.thunderSprite_b.visible = false;
            this.thunder_counter = int(5 + Math.random() * 10) * 60;
         }
         else
         {
            this.thunderSprite_b = null;
         }
         if(this.TYPE == 0)
         {
            this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_7"));
         }
         else
         {
            this.sky_layer = new Image(TextureManager.GetBackgroundTexture().getTexture("bg_sky_color_20"));
         }
         this.sky_layer.touchable = false;
         this.sky_layer.width = Utils.WIDTH + 1;
         this.sky_layer.height = Utils.HEIGHT + 1;
         layer_static.addChild(this.sky_layer);
         if(this.TYPE == 2)
         {
            this.backgroundQuad = new Quad(512,96,this.color);
            this.backgroundQuad.width = Utils.WIDTH;
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
            layer_0.addChild(this.backgroundQuad);
         }
         else if(this.TYPE == 3)
         {
            this.color = 808172;
            this.backgroundQuad = new Quad(512,96,this.color);
            this.backgroundQuad.width = Utils.WIDTH;
            this.backgroundQuad.height = 40;
            this.backgroundQuad.x = 0;
            this.backgroundQuad.y = reflection_yRef;
            this.backgroundQuad.setVertexAlpha(0,0.5);
            this.backgroundQuad.setVertexAlpha(1,0.5);
            this.backgroundQuad.setVertexAlpha(2,0);
            this.backgroundQuad.setVertexAlpha(3,0);
            layer_0.addChild(this.backgroundQuad);
         }
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         if(this.backgroundQuad != null)
         {
            layer_0.removeChild(this.backgroundQuad);
            this.backgroundQuad.dispose();
            this.backgroundQuad = null;
         }
         if(this.thunderSprite_b != null)
         {
            layer_static.removeChild(this.thunderSprite_b);
            this.thunderSprite_b.destroy();
            this.thunderSprite_b.dispose();
            this.thunderSprite_b = null;
         }
         if(this.reflections != null)
         {
            for(i = 0; i < this.reflections.length; i++)
            {
               layer_0.removeChild(this.reflections[i]);
               this.reflections[i].destroy();
               this.reflections[i].dispose();
               this.reflections[i] = null;
               this.reflectionsData1[i] = null;
               this.reflectionsData2[i] = null;
            }
            this.reflections = null;
            this.reflectionsData1 = null;
            this.reflectionsData2 = null;
         }
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var mult:Number = NaN;
         var time_alive:Number = NaN;
         super.update();
         if(this.TYPE == 2 || this.TYPE == 3)
         {
            mult = 1;
            if(this.TYPE == 3)
            {
               mult = 2;
            }
            this.sin_counter_1 += this.sin_speed_1 * 0.5 * mult;
            if(this.sin_counter_1 > Math.PI * 2)
            {
               this.sin_counter_1 -= Math.PI * 2;
               this.sin_speed_1 = Math.random() * 0.04 + 0.025;
            }
            this.sin_counter_2 += this.sin_speed_2 * 0.5 * mult;
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
            if(this.TYPE == 2)
            {
               this.backgroundQuad.setVertexAlpha(0,0.5 + Math.sin(this.sin_counter_1) * 0.125);
               this.backgroundQuad.setVertexAlpha(1,0.5 + Math.sin(this.sin_counter_2) * 0.125);
               this.backgroundQuad.setVertexAlpha(2,0);
               this.backgroundQuad.setVertexAlpha(3,0);
            }
            else if(this.TYPE == 3)
            {
               this.backgroundQuad.setVertexAlpha(0,0.5 - Math.sin(this.sin_counter_1) * 0.125);
               this.backgroundQuad.setVertexAlpha(1,0.5 - Math.sin(this.sin_counter_1) * 0.125);
               this.backgroundQuad.setVertexAlpha(2,0);
               this.backgroundQuad.setVertexAlpha(3,0);
            }
         }
         if(this.TYPE == 1 || this.TYPE == 2)
         {
            if(this.thunderSprite_b != null)
            {
               if(this.thunder_counter-- < 0)
               {
                  this.thunderSprite_b.visible = true;
                  this.thunder_counter = int(5 + Math.random() * 10) * 60;
                  this.thunderSprite_b.gfxHandleClip().gotoAndPlay(1);
                  this.thunderSprite_b.x = int(Math.random() * Utils.WIDTH - 32);
                  this.thunderSprite_b.y = int(Math.random() * Utils.HEIGHT * 0.125);
                  layer_static.setChildIndex(this.thunderSprite_b,0);
               }
               if(this.thunderSprite_b.gfxHandleClip().isComplete)
               {
                  this.thunderSprite_b.visible = false;
               }
            }
         }
         if(this.reflections != null)
         {
            for(i = 0; i < this.reflectionsData1.length; i++)
            {
               if(this.reflectionsData1[i] != null)
               {
                  if(this.reflections[i].gfxHandleClip().isComplete)
                  {
                     this.reflections[i].visible = false;
                  }
                  --this.reflectionsData1[i].height;
                  this.reflectionsData1[i].x -= 0.02;
                  if(this.reflectionsData1[i].height < 0)
                  {
                     time_alive = (Math.random() * 2 + 1) * 60;
                     this.reflectionsData1[i].x = level.camera.xPos * mult0 + Math.random() * Utils.WIDTH;
                     this.reflectionsData1[i].height = 60 + Math.random() * 90;
                     this.reflections[i].visible = true;
                     this.reflections[i].gfxHandleClip().gotoAndPlay(1);
                  }
               }
            }
         }
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         var i:int = 0;
         var mult:Number = NaN;
         var screenStep:int = 0;
         super.updateScreenPosition(camera);
         if(this.reflections != null)
         {
            for(i = 0; i < this.reflections.length; i++)
            {
               if(this.reflections[i] != null)
               {
                  mult = this.reflectionsData1[i].width;
                  mult *= 0.05;
                  this.reflections[i].x = int(Math.floor(this.reflectionsData1[i].x - camera.xPos * mult));
                  this.reflections[i].y = int(Math.floor(this.reflectionsData1[i].y));
               }
            }
         }
         layer_static.setChildIndex(this.sky_layer,0);
         backgroundContainer.setChildIndex(layer_static,0);
         if(this.TYPE == 2 || this.TYPE == 3)
         {
            layer_0.setChildIndex(this.backgroundQuad,layer_0.numChildren - 1);
         }
         if(this.TYPE == 3)
         {
            this.backgroundQuad.x = int(Math.abs(layer_0.x));
            if(this.reflections != null)
            {
               for(i = 0; i < this.reflections.length; i++)
               {
                  if(this.reflections[i] != null)
                  {
                     layer_0.setChildIndex(this.reflections[i],layer_0.numChildren - 1);
                  }
               }
            }
         }
      }
      
      override public function particles(area:ParticleArea) : void
      {
      }
      
      override public function shake() : void
      {
      }
   }
}
