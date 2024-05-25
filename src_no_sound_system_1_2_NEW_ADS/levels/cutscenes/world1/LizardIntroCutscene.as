package levels.cutscenes.world1
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.npcs.CutsceneNPC;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.cameras.behaviours.StaticHorBehaviour;
   import levels.cutscenes.*;
   import sprites.GameSprite;
   import starling.display.Image;
   
   public class LizardIntroCutscene extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var lizardNPC:CutsceneNPC;
      
      protected var tongue1:Image;
      
      protected var tongue2:Image;
      
      protected var tongue3:Image;
      
      protected var penDrive:Image;
      
      protected var tongueEndX:Number;
      
      protected var tongueStartX:Number;
      
      protected var tongueStartY:Number;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_tick:Number;
      
      protected var t_time:Number;
      
      protected var xVel:Number;
      
      public function LizardIntroCutscene(_level:Level)
      {
         super(_level);
         counter1 = counter2 = counter3 = 0;
         this.tongueEndX = 0;
         this.tongueStartX = 0;
         this.tongueStartY = 0;
         this.xVel = 0;
         this.t_start = this.t_diff = this.t_tick = this.t_time = 0;
      }
      
      override public function destroy() : void
      {
         var i:int = 0;
         this.hero = null;
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var pSprite:GameSprite = null;
         ++counter1;
         if(PROGRESSION == 0)
         {
            if(counter1 >= 15)
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene1_1"),this.hero,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 2)
         {
            if(counter1 == 1)
            {
               SoundSystem.PlaySound("woosh");
            }
            this.lizardNPC.yPos += 6;
            if(this.lizardNPC.yPos >= 144)
            {
               SoundSystem.PlayMusic("bandits");
               SoundSystem.PlaySound("ground_stomp");
               this.lizardNPC.sprite.gfxHandle().gotoAndStop(2);
               this.lizardNPC.yPos = 144;
               level.camera.shake();
               ++PROGRESSION;
               this.hero.sprite.gfxHandle().gotoAndStop(18);
               level.particlesManager.createDust(this.lizardNPC.xPos + 8,this.lizardNPC.yPos + 32,Entity.LEFT);
               level.particlesManager.createDust(this.lizardNPC.xPos + 32 - 8,this.lizardNPC.yPos + 32,Entity.RIGHT);
            }
         }
         else if(PROGRESSION == 3)
         {
            this.hero.xPos -= 4;
            if(this.hero.xPos <= 1520 - 48)
            {
               this.hero.xPos = 1520 - 48;
            }
            if(counter1 >= 90)
            {
               this.lizardNPC.sprite.gfxHandle().gotoAndStop(1);
               this.lizardNPC.yPos = 144 - 24;
               SoundSystem.PlaySound("enemy_jump_low");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 4)
         {
            this.lizardNPC.yPos += 4;
            if(this.lizardNPC.yPos >= 144)
            {
               this.lizardNPC.yPos = 144;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 5)
         {
            if(counter1 >= 30)
            {
               SoundSystem.PlaySound("mesa_snarl");
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene1_2"),this.lizardNPC,this.advance);
               this.hero.sprite.gfxHandle().gotoAndStop(1);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 7)
         {
            this.lizardNPC.sprite.gfxHandle().gotoAndStop(3);
            this.lizardNPC.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            SoundSystem.PlaySound("tongue_mesa");
            this.t_start = -5;
            this.t_diff = -61 + 5;
            this.t_time = 0.25;
            this.t_tick = 0;
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 8)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               counter1 = 0;
               ++PROGRESSION;
            }
            this.tongueEndX = this.tongueStartX + Easings.easeOutQuad(this.t_tick,this.t_start,this.t_diff,this.t_time);
            this.tongue1.visible = this.tongue2.visible = this.tongue3.visible = true;
         }
         else if(PROGRESSION == 9)
         {
            this.penDrive.visible = true;
            if(counter1 > 24)
            {
               this.tongueEndX += 6;
               if(this.tongueEndX >= this.tongueStartX)
               {
                  this.tongueEndX = this.tongueStartX;
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 10)
         {
            if(counter1 >= 15)
            {
               this.hero.setEmotionParticle(Entity.EMOTION_SHOCKED);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 11)
         {
            if(counter1 >= 30)
            {
               Utils.INVENTORY_NOTIFICATION_ID = LevelItems.ITEM_DATA_DRIVE;
               Utils.INVENTORY_NOTIFICATION_ACTION = -1;
               SoundSystem.PlaySound("eat");
               this.lizardNPC.sprite.gfxHandle().gotoAndStop(4);
               this.lizardNPC.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
               this.tongue1.visible = this.tongue2.visible = this.tongue3.visible = this.penDrive.visible = false;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 12)
         {
            if(counter1 >= 30)
            {
               this.lizardNPC.sprite.gfxHandle().gotoAndStop(1);
               this.lizardNPC.yPos = 144 - 24;
               SoundSystem.PlaySound("enemy_jump_low");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 13)
         {
            this.lizardNPC.yPos += 4;
            if(this.lizardNPC.yPos >= 144)
            {
               this.lizardNPC.yPos = 144;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 14)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("world_0_cutscene1_3"),this.hero,this.advance);
            this.hero.sprite.gfxHandle().gotoAndStop(18);
            this.hero.yPos -= 8;
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 16)
         {
            this.lizardNPC.sprite.gfxHandle().gotoAndStop(2);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 17)
         {
            if(counter1 >= 15)
            {
               SoundSystem.PlaySound("woosh");
               level.particlesManager.createDust(this.lizardNPC.xPos + 8,this.lizardNPC.yPos + 32,Entity.LEFT);
               level.particlesManager.createDust(this.lizardNPC.xPos + 32 - 8,this.lizardNPC.yPos + 32,Entity.RIGHT);
               this.lizardNPC.sprite.gfxHandle().gotoAndStop(1);
               this.hero.sprite.gfxHandle().gotoAndStop(1);
               level.camera.shake();
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 18)
         {
            this.xVel += 1;
            this.lizardNPC.yPos -= 6;
            this.lizardNPC.xPos += this.xVel;
            if(this.lizardNPC.xPos >= level.camera.xPos + Utils.WIDTH + 48)
            {
               level.rightPressed = true;
               this.hero.stateMachine.setState("IS_RUNNING_STATE");
               this.hero.playSound("run");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 19)
         {
            level.rightPressed = true;
            if(counter1 > 60)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 20)
         {
            level.rightPressed = true;
         }
         this.tongueStartX = this.lizardNPC.xPos - 18;
         this.tongueStartY = this.lizardNPC.yPos + 21;
         if(this.tongueEndX >= this.tongueStartX - 5)
         {
            this.tongueEndX = this.tongueStartX - 5;
         }
      }
      
      protected function advance() : void
      {
         ++PROGRESSION;
         counter1 = 0;
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         super.initState();
         SoundSystem.StopMusic(false,false);
         this.hero = level.hero;
         this.hero.xVel = 0;
         this.hero.xPos = 1520;
         level.camera.changeHorBehaviour(new StaticHorBehaviour(level,level.camera.xPos));
         this.lizardNPC = new CutsceneNPC(level,1568,-32,Entity.LEFT,0,0);
         level.npcsManager.npcs.push(this.lizardNPC);
         this.lizardNPC.sprite.gfxHandle().gotoAndStop(1);
         this.lizardNPC.updateScreenPosition(level.camera);
         this.tongue1 = new Image(TextureManager.sTextureAtlas.getTexture("lizardBossTongue1"));
         this.tongue2 = new Image(TextureManager.sTextureAtlas.getTexture("lizardBossTongue2"));
         this.tongue3 = new Image(TextureManager.sTextureAtlas.getTexture("lizardBossTongue3"));
         this.penDrive = new Image(TextureManager.sTextureAtlas.getTexture("pen_drive"));
         this.tongue1.touchable = false;
         this.tongue2.touchable = false;
         this.tongue3.touchable = false;
         this.penDrive.touchable = false;
         Utils.world.addChild(this.tongue1);
         Utils.world.addChild(this.tongue2);
         Utils.world.addChild(this.tongue3);
         Utils.world.addChild(this.penDrive);
         this.tongue1.visible = this.tongue2.visible = this.tongue3.visible = this.penDrive.visible = false;
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         this.tongue1.x = int(Math.floor(this.tongueStartX - level.camera.xPos));
         this.tongue1.y = int(Math.floor(this.tongueStartY - level.camera.yPos));
         this.tongue3.x = int(Math.floor(this.tongueEndX - level.camera.xPos));
         this.tongue3.y = int(Math.floor(this.tongueStartY - 1 - level.camera.yPos));
         this.tongue2.x = this.tongue3.x + 10;
         this.tongue2.y = this.tongue3.y + 3;
         this.tongue2.width = int(Math.abs(this.tongueStartX - this.tongueEndX) - 9);
         this.penDrive.x = this.tongue3.x - 7;
         this.penDrive.y = this.tongue3.y - 2;
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         Utils.world.removeChild(this.tongue1);
         Utils.world.removeChild(this.tongue2);
         Utils.world.removeChild(this.tongue3);
         Utils.world.removeChild(this.penDrive);
         this.tongue1.dispose();
         this.tongue2.dispose();
         this.tongue3.dispose();
         this.penDrive.dispose();
         this.tongue1 = null;
         this.tongue2 = null;
         this.tongue3 = null;
         this.penDrive = null;
         LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_DATA_DRIVE,-1,false);
         Utils.Slot.gameProgression[1] = 1;
         SaveManager.SaveGameProgression();
         level.won();
      }
   }
}
