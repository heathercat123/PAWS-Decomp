package interfaces.panels.intro
{
   import entities.Easings;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.display.Sprite3D;
   import starling.filters.FragmentFilter;
   import starling.textures.TextureSmoothing;
   
   public class TapestryCutscenePanel extends Sprite
   {
       
      
      internal var bg:Image;
      
      internal var sprite3D:Sprite3D;
      
      internal var outerSprite3D:Sprite3D;
      
      internal var image:Image;
      
      internal var light:Sprite3D;
      
      internal var light2:Sprite3D;
      
      internal var ground:Sprite3D;
      
      internal var groundSprite:Sprite;
      
      protected var floor_quad_1:Quad;
      
      protected var floor_quad_2:Quad;
      
      protected var floor_quad_3:Quad;
      
      protected var floor_quad_4:Quad;
      
      internal var light_quad_1:Quad;
      
      internal var light_quad_2:Quad;
      
      internal var light_sin_1:Number;
      
      internal var light_sin_2:Number;
      
      internal var t_start_1:Number;
      
      internal var t_diff_1:Number;
      
      internal var t_tick_1:Number;
      
      internal var t_time_1:Number;
      
      internal var rotation_value:Number = 0;
      
      internal var t_start_2:Number;
      
      internal var t_diff_2:Number;
      
      internal var t_tick_2:Number;
      
      internal var t_time_2:Number;
      
      internal var amount:Number = 0;
      
      internal var t_start_3:Number;
      
      internal var t_diff_3:Number;
      
      internal var t_tick_3:Number;
      
      internal var t_time_3:Number;
      
      internal var particles:Vector.<Quad>;
      
      internal var particlesData:Vector.<Rectangle>;
      
      internal var lastUsed:int;
      
      internal var frag:FragmentFilter;
      
      protected var add_z:Number = 0;
      
      protected var amount_z:Number = 0;
      
      protected var HIDE_PARTICLES:Boolean;
      
      public function TapestryCutscenePanel()
      {
         var quad:Quad = null;
         var __size:Number = NaN;
         super();
         this.HIDE_PARTICLES = false;
         this.t_start_1 = this.t_diff_1 = this.t_tick_1 = this.t_time_1 = 0;
         this.lastUsed = 0;
         this.light_sin_1 = Math.random() * Math.PI;
         this.light_sin_2 = Math.random() * Math.PI;
         this.bg = new Image(TextureManager.intro2TextureAtlas.getTexture("intro_2_black_color_1"));
         this.bg.width = Utils.WIDTH * 2;
         this.bg.height = Utils.HEIGHT * 2;
         addChild(this.bg);
         this.bg.x = -Utils.WIDTH * 0.25;
         this.bg.y = -Utils.HEIGHT * 0.25;
         this.frag = new FragmentFilter();
         this.frag.resolution = Utils.GFX_INV_SCALE;
         this.frag.textureSmoothing = TextureSmoothing.NONE;
         this.filter = this.frag;
         this.sprite3D = new Sprite3D();
         this.image = new Image(TextureManager.intro2TextureAtlas.getTexture("ending_pic_9"));
         this.image.pivotX = 114 * 0.5;
         this.image.pivotY = this.image.height * 0.5;
         this.image.rotation -= 0.1;
         this.sprite3D.addChild(this.image);
         this.outerSprite3D = new Sprite3D();
         addChild(this.outerSprite3D);
         this.outerSprite3D.addChild(this.sprite3D);
         this.outerSprite3D.x = Utils.WIDTH * 0.5;
         this.outerSprite3D.y = Utils.HEIGHT * 0.5;
         this.groundSprite = new Sprite();
         __size = 128;
         this.floor_quad_1 = new Quad(__size,__size,3626875);
         this.floor_quad_1.setVertexAlpha(0,0);
         this.floor_quad_1.setVertexAlpha(1,0);
         this.floor_quad_1.setVertexAlpha(2,0);
         this.groundSprite.addChild(this.floor_quad_1);
         this.floor_quad_2 = new Quad(__size,__size,3626875);
         this.floor_quad_2.setVertexAlpha(0,0);
         this.floor_quad_2.setVertexAlpha(1,0);
         this.floor_quad_2.setVertexAlpha(3,0);
         this.groundSprite.addChild(this.floor_quad_2);
         this.floor_quad_2.x = __size;
         this.floor_quad_3 = new Quad(__size,__size,3626875);
         this.floor_quad_3.setVertexAlpha(0,0);
         this.floor_quad_3.setVertexAlpha(2,0);
         this.floor_quad_3.setVertexAlpha(3,0);
         this.groundSprite.addChild(this.floor_quad_3);
         this.floor_quad_3.y = __size;
         this.floor_quad_4 = new Quad(__size,__size,3626875);
         this.floor_quad_4.setVertexAlpha(1,0);
         this.floor_quad_4.setVertexAlpha(2,0);
         this.floor_quad_4.setVertexAlpha(3,0);
         this.groundSprite.addChild(this.floor_quad_4);
         this.floor_quad_4.x = this.floor_quad_4.y = __size;
         this.groundSprite.pivotX = this.groundSprite.width * 0.5;
         this.groundSprite.pivotY = this.groundSprite.height * 0.5;
         this.ground = new Sprite3D();
         this.ground.addChild(this.groundSprite);
         this.outerSprite3D.addChild(this.ground);
         this.outerSprite3D.setChildIndex(this.ground,0);
         this.light = new Sprite3D();
         quad = new Quad(64,256,16777215);
         quad.pivotX = 32;
         quad.setVertexAlpha(2,0);
         quad.setVertexAlpha(3,0);
         quad.setVertexPosition(0,0.25 * quad.width,0);
         quad.setVertexPosition(1,0.75 * quad.width,0);
         this.light_quad_1 = quad;
         this.light.addChild(quad);
         this.outerSprite3D.addChild(this.light);
         this.light2 = new Sprite3D();
         quad = new Quad(64,256,16777215);
         quad.pivotX = 32;
         quad.setVertexAlpha(2,0);
         quad.setVertexAlpha(3,0);
         quad.setVertexPosition(0,0.25 * quad.width,0);
         quad.setVertexPosition(1,0.75 * quad.width,0);
         this.light_quad_2 = quad;
         this.light2.addChild(quad);
         this.outerSprite3D.addChild(this.light2);
         this.outerSprite3D.z = 8000;
         this.t_start_1 = 4000;
         this.t_diff_1 = -5000;
         this.t_time_1 = 20;
         this.t_tick_1 = 0;
         this.t_start_2 = 0;
         this.t_diff_2 = Math.PI * 2;
         this.t_time_2 = 20;
         this.t_tick_2 = 0;
         this.t_start_3 = 0;
         this.t_diff_3 = 1;
         this.t_time_3 = 6;
         this.t_tick_3 = 0;
         var i:int = 0;
         this.particles = new Vector.<Quad>();
         this.particlesData = new Vector.<Rectangle>();
         this.lastUsed = 0;
         for(i = 0; i < 512; i++)
         {
            quad = new Quad(0.5,0.5,16777215);
            this.outerSprite3D.addChild(quad);
            this.particles.push(quad);
            this.particlesData.push(new Rectangle(Math.random() * Math.PI * 2,0,0,0));
            quad.x = Math.random() * 96 - 48;
            quad.y = -Math.random() * Utils.HEIGHT * 2;
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         removeChild(this.bg);
         this.bg.dispose();
         this.bg = null;
         for(i = 0; i < this.particles.length; i++)
         {
            this.particlesData[i] = null;
            this.outerSprite3D.removeChild(this.particles[i]);
            this.particles[i].dispose();
            this.particles[i] = null;
         }
         this.particles = null;
         this.particlesData = null;
         this.outerSprite3D.removeChild(this.light2);
         this.light2.dispose();
         this.light2 = null;
         this.light_quad_2.dispose();
         this.light_quad_2 = null;
         this.outerSprite3D.removeChild(this.light);
         this.light.dispose();
         this.light = null;
         this.light_quad_1.dispose();
         this.light_quad_1 = null;
         this.outerSprite3D.removeChild(this.ground);
         this.ground.removeChild(this.groundSprite);
         this.ground.dispose();
         this.ground = null;
         this.groundSprite.removeChild(this.floor_quad_4);
         this.groundSprite.removeChild(this.floor_quad_3);
         this.groundSprite.removeChild(this.floor_quad_2);
         this.groundSprite.removeChild(this.floor_quad_1);
         this.floor_quad_4.dispose();
         this.floor_quad_3.dispose();
         this.floor_quad_2.dispose();
         this.floor_quad_1.dispose();
         this.floor_quad_4 = null;
         this.floor_quad_3 = null;
         this.floor_quad_2 = null;
         this.floor_quad_1 = null;
         this.groundSprite.dispose();
         this.groundSprite = null;
         this.outerSprite3D.removeChild(this.sprite3D);
         removeChild(this.outerSprite3D);
         this.outerSprite3D.dispose();
         this.outerSprite3D = null;
         this.sprite3D.removeChild(this.image);
         this.image.dispose();
         this.image = null;
         this.sprite3D.dispose();
         this.sprite3D = null;
         this.filter = null;
         this.frag.dispose();
         this.frag = null;
      }
      
      public function hideParticles() : void
      {
         var i:int = 0;
         this.HIDE_PARTICLES = true;
         for(i = 0; i < this.particlesData.length; i++)
         {
            this.particles[i].visible = false;
         }
      }
      
      public function update(skip_particles:Boolean = false) : void
      {
         var i:int = 0;
         this.t_tick_2 += 1 / 60;
         if(this.t_tick_2 >= this.t_time_2)
         {
            this.t_tick_2 = this.t_time_2;
         }
         this.rotation_value = Easings.easeInOutSine(this.t_tick_2,this.t_start_2,this.t_diff_2,this.t_time_2);
         if(this.rotation_value >= Math.PI * 1.5)
         {
            this.t_tick_3 += 1 / 60;
            if(this.t_tick_3 >= this.t_time_3)
            {
               this.t_tick_3 = this.t_time_3;
            }
            this.amount = Easings.easeInOutQuad(this.t_tick_3,0,1,this.t_time_3);
            this.frag.resolution = 0.25 + 0.75 * this.amount;
            filter = this.frag;
         }
         this.sprite3D.rotationX = -Math.PI * 0.5 + this.amount * Math.PI * 0.5;
         this.sprite3D.rotationY = this.rotation_value;
         this.sprite3D.y = 48 - this.amount * 48;
         this.sprite3D.z = 800;
         this.ground.rotationX = -Math.PI * 0.5 + this.amount * Math.PI * 0.5;
         this.ground.rotationY = this.rotation_value;
         this.ground.y = 48 - this.amount * 48;
         this.ground.z = 800;
         this.light.y = this.light2.y = -141 - 250 - 92 - this.amount * 100;
         this.light.z = this.light2.z = -333 + this.amount_z;
         this.amount_z = 875 + DebugInputPanel.getInstance().s1;
         this.light.rotationX = 0;
         this.light.rotationY += 0.01;
         this.light.rotationZ = 0;
         this.light2.rotationX = 0;
         this.light2.rotationY = this.light.rotationY + Math.PI * 0.333;
         this.light2.rotationZ = 0;
         this.light.scaleX = this.light2.scaleX = 2.5;
         this.light.scaleY = this.light2.scaleY = 2;
         this.light_sin_1 += 0.01;
         this.light_sin_2 += 0.01;
         this.light_quad_1.setVertexAlpha(0,0.25 + Math.abs(Math.sin(this.light_sin_1)) * 0.75);
         this.light_quad_1.setVertexAlpha(1,0.25 + Math.abs(Math.cos(this.light_sin_1)) * 0.75);
         this.light_quad_2.setVertexAlpha(0,0.25 + Math.abs(Math.sin(this.light_sin_2)) * 0.75);
         this.light_quad_2.setVertexAlpha(1,0.25 + Math.abs(Math.cos(this.light_sin_2)) * 0.75);
         this.light_quad_1.setVertexColor(0,16777215);
         this.light_quad_1.setVertexColor(1,16777215);
         this.light_quad_2.setVertexColor(0,16777215);
         this.light_quad_2.setVertexColor(1,16777215);
         this.t_tick_1 += 1 / 60;
         if(this.t_tick_1 >= this.t_time_1)
         {
            this.t_tick_1 = this.t_time_1;
         }
         if(this.t_tick_1 >= this.t_time_1 - 1)
         {
            this.add_z -= 0.25;
         }
         this.outerSprite3D.z = Easings.easeOutQuart(this.t_tick_1,this.t_start_1,this.t_diff_1,this.t_time_1) + this.add_z;
         if(this.HIDE_PARTICLES)
         {
            skip_particles = true;
         }
         if(!skip_particles)
         {
            for(i = 0; i < this.particlesData.length; i++)
            {
               this.particlesData[i].x += 0.1;
               this.particles[i].alpha = Math.sin(this.particlesData[i].x);
               this.particles[i].y -= 0.05;
            }
         }
      }
   }
}
