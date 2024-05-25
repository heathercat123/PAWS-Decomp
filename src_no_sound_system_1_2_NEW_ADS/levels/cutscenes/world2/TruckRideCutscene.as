package levels.cutscenes.world2
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import game_utils.GameSlot;
   import interfaces.dialogs.Dialog;
   import levels.*;
   import levels.backgrounds.DesertBackground;
   import levels.cameras.ScreenCamera;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.collisions.TruckCollision;
   import levels.cutscenes.*;
   import levels.decorations.GenericDecoration;
   import sprites.cats.CatSprite;
   import sprites.cats.EvilCatSprite;
   import sprites.cats.HeroSprite;
   import sprites.cats.SmallCatSprite;
   import sprites.cats.WaterCatSprite;
   import sprites.particles.GenericParticleSprite;
   
   public class TruckRideCutscene extends Cutscene
   {
       
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var t_start_2:Number;
      
      protected var t_diff_2:Number;
      
      protected var t_time_2:Number;
      
      protected var t_tick_2:Number;
      
      protected var PROGRESSION_2:int;
      
      protected var JUST_ONCE_CONDITION_1:Boolean;
      
      protected var GRASS_X_OFFSET:Number;
      
      protected var grassDecorations:Array;
      
      protected var desertBackground:DesertBackground;
      
      protected var roseBalloon:Dialog;
      
      protected var particle_counter_1:int;
      
      protected var truckCollision:TruckCollision;
      
      protected var roseSprite:SmallCatSprite;
      
      protected var jumpAnimsOffset:Array;
      
      protected var jumpAnimsIndex:int;
      
      protected var truck_xVel:Number;
      
      protected var FLAG_1:Boolean;
      
      protected var scroll_speed:Number;
      
      protected var xBehaviour:HorTweenShiftBehaviour;
      
      protected var xBehaviour2:HorTweenShiftBehaviour;
      
      protected var otherCatSprite:CatSprite;
      
      protected var jumpForceX:Number;
      
      protected var layer_2_offset:Number;
      
      protected var layer_1_offset:Number;
      
      protected var mult:Number;
      
      public function TruckRideCutscene(_level:Level)
      {
         super(_level);
         this.GRASS_X_OFFSET = 0;
         this.FLAG_1 = false;
         this.jumpForceX = 0;
         this.particle_counter_1 = 0;
         this.truck_xVel = 0.1;
         this.mult = 1;
         this.scroll_speed = -6;
         this.layer_2_offset = this.layer_1_offset = 0;
         this.t_start_2 = 0;
         this.t_diff_2 = 0;
         this.t_time_2 = 0;
         this.t_tick_2 = 0;
         this.xBehaviour = new HorTweenShiftBehaviour(level);
         this.xBehaviour2 = new HorTweenShiftBehaviour(level);
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.roseSprite.destroy();
         this.roseSprite.dispose();
         this.roseSprite = null;
         this.otherCatSprite.destroy();
         this.otherCatSprite.dispose();
         this.otherCatSprite = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GenericParticleSprite = null;
         ++counter1;
         SoundSystem.PlaySound("car_running");
         if(PROGRESSION == 0)
         {
            if(counter1 == 1)
            {
               level.hud.hideDarkFade(30);
            }
            if(counter1 >= 240)
            {
               level.hud.dialogsManager.createCaptionNoCameraAt("...",int(Utils.WIDTH * 0.5),-100,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 2)
         {
            this.t_start = this.truckCollision.xPos;
            this.t_diff = -32;
            this.t_time = 1;
            this.t_tick = 0;
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 3)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
            }
            this.truckCollision.xPos = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
            if(this.t_tick >= this.t_time)
            {
               SoundSystem.PlaySound("car_start");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 4)
         {
            this.truckCollision.xPos += this.truck_xVel;
            this.truck_xVel *= 1.1;
            if(this.truck_xVel >= 2)
            {
               this.truck_xVel = 2;
            }
            if(this.truckCollision.xPos >= level.camera.xPos + Utils.WIDTH * 0.5)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 5)
         {
            this.truckCollision.xPos += this.truck_xVel - 1;
            this.truck_xVel *= 0.9;
            if(this.truck_xVel <= 0.05)
            {
               SoundSystem.PlaySound("car_start");
               this.truck_xVel = 0.05;
               counter1 = 0;
               counter2 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 6)
         {
            this.truckCollision.xPos += this.truck_xVel;
            this.truckCollision.IS_SLOW_DOWN = false;
            this.truck_xVel *= 1.1;
            if(this.truck_xVel >= 4)
            {
               this.truck_xVel = 4;
            }
            if(counter2 == 0 && this.truckCollision.xPos >= level.camera.xPos + Utils.WIDTH)
            {
               counter2 = 1;
               level.hud.showDarkFade(60);
            }
            if(this.truckCollision.xPos >= level.camera.xPos + Utils.WIDTH + 64)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 7)
         {
            if(counter1 >= 60)
            {
               stateMachine.performAction("END_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         var temp_mult:Number = 1 + this.truck_xVel * 0.25;
         if(temp_mult > this.mult)
         {
            this.mult = temp_mult;
         }
         if(this.roseSprite.visible)
         {
            if(this.roseSprite.gfxHandle().gfxHandleClip().isComplete)
            {
               this.roseSprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(int(Math.random() * 4) + 2));
               this.roseSprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
         }
         if(this.otherCatSprite.visible)
         {
            if(this.otherCatSprite.gfxHandle().gfxHandleClip().isComplete)
            {
               this.otherCatSprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(int(Math.random() * 4) + 2));
               this.otherCatSprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
         }
         this.layer_2_offset -= 4 * this.mult;
         if(this.layer_2_offset <= -731)
         {
            this.layer_2_offset += 731;
         }
         this.layer_1_offset -= 2 * this.mult;
         if(this.layer_1_offset <= -464)
         {
            this.layer_1_offset += 464;
         }
         if(this.particle_counter_1++ > 2)
         {
            this.particle_counter_1 = 0;
            pSprite = new GenericParticleSprite(GenericParticleSprite.SAND_WIND);
            pSprite.gfxHandleClip().gotoAndStop(2);
            if(Math.random() * 100 > 50)
            {
               level.particlesManager.pushParticle(pSprite,this.truckCollision.xPos - 16,this.truckCollision.yPos + 64,-(Math.random() * 4 + 2),0,1,Math.random() * 5,Math.random() * Math.PI * 2);
            }
            else
            {
               level.particlesManager.pushParticle(pSprite,this.truckCollision.xPos + 16,this.truckCollision.yPos + 64,-(Math.random() * 4 + 2),0,1,Math.random() * 5,Math.random() * Math.PI * 2);
            }
         }
         this.otherCatSprite.x = 74;
         this.otherCatSprite.y = 13;
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         ++this.PROGRESSION_2;
         counter1 = 0;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         this.roseSprite.updateScreenPosition();
         this.otherCatSprite.updateScreenPosition();
         this.desertBackground.layer_1.x += this.layer_1_offset;
         this.desertBackground.layer_2.x += this.layer_2_offset;
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         var _type:int = 0;
         super.initState();
         level.hud.showDarkFade(0);
         if(Hero.GetCurrentCat() == Hero.CAT_RIGS)
         {
            this.otherCatSprite = new EvilCatSprite();
         }
         else if(Hero.GetCurrentCat() == Hero.CAT_MARA)
         {
            this.otherCatSprite = new WaterCatSprite();
         }
         else
         {
            this.otherCatSprite = new HeroSprite();
         }
         this.truckCollision = new TruckCollision(level,160,115,Entity.RIGHT,TruckCollision.TRUCK_TYPE_RED);
         this.truckCollision.IS_SLOW_DOWN = true;
         level.collisionsManager.collisions.push(this.truckCollision);
         this.truckCollision.updateScreenPosition(level.camera);
         this.truckCollision.IS_ON = true;
         this.truckCollision.setTiresOn(true);
         this.roseSprite = new SmallCatSprite(4);
         this.roseSprite.gfxHandle().scaleX = -1;
         this.otherCatSprite.scaleX = -1;
         this.truckCollision.driversContainer.addChild(this.roseSprite);
         this.truckCollision.driversContainer.addChild(this.otherCatSprite);
         this.roseSprite.x = 74;
         this.roseSprite.y = 12;
         this.desertBackground = level.backgroundsManager.background as DesertBackground;
         this.grassDecorations = new Array();
         for(i = 0; i < level.decorationsManager.decorations.length; i++)
         {
            if(level.decorationsManager.decorations[i] != null)
            {
               if(level.decorationsManager.decorations[i] is GenericDecoration)
               {
                  _type = int(GenericDecoration(level.decorationsManager.decorations[i]).DECORATION_TYPE);
                  if(_type == GenericDecoration.GRASS_DARK_1 || _type == GenericDecoration.GRASS_DARK_2)
                  {
                     this.grassDecorations.push(level.decorationsManager.decorations[i]);
                     level.decorationsManager.decorations[i].onTop();
                  }
               }
            }
         }
         level.hero.sprite.visible = false;
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         Utils.LEVEL_LOCAL_PROGRESSION_1 = 2;
         Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 7;
         level.CHANGE_ROOM_FLAG = true;
      }
   }
}
