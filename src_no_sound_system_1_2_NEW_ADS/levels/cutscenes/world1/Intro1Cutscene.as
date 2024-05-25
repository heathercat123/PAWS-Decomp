package levels.cutscenes.world1
{
   import entities.Easings;
   import entities.Entity;
   import entities.npcs.CatNPC;
   import game_utils.GameSlot;
   import game_utils.LevelItems;
   import game_utils.SaveManager;
   import interfaces.dialogs.Dialog;
   import levels.*;
   import levels.backgrounds.RainWoodsBackground;
   import levels.cameras.ScreenCamera;
   import levels.cameras.behaviours.HorTweenShiftBehaviour;
   import levels.collisions.TruckCollision;
   import levels.cutscenes.*;
   import levels.decorations.GenericDecoration;
   import sprites.cats.CatSprite;
   import sprites.cats.SmallCatSprite;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Intro1Cutscene extends Cutscene
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
      
      protected var rainBackground:RainWoodsBackground;
      
      protected var roseBalloon:Dialog;
      
      protected var truckCollision:TruckCollision;
      
      protected var roseSprite:SmallCatSprite;
      
      protected var jumpAnimsOffset:Array;
      
      protected var jumpAnimsIndex:int;
      
      protected var jumpTiles:Sprite;
      
      protected var jumpTiles_x:Number;
      
      protected var jumpTiles_y:Number;
      
      protected var FLAG_1:Boolean;
      
      protected var scroll_speed:Number;
      
      protected var xBehaviour:HorTweenShiftBehaviour;
      
      protected var xBehaviour2:HorTweenShiftBehaviour;
      
      protected var olliNPC:CatNPC;
      
      protected var jumpForceX:Number;
      
      public function Intro1Cutscene(_level:Level)
      {
         super(_level);
         this.GRASS_X_OFFSET = 0;
         this.FLAG_1 = false;
         this.jumpForceX = 0;
         this.initJumpAnims();
         this.jumpTiles_x = Utils.WIDTH + 32;
         this.jumpTiles_y = 144;
         this.scroll_speed = -6;
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
         super.destroy();
      }
      
      override public function update() : void
      {
         var i:int = 0;
         ++counter1;
         this.rainBackground.setScroll(this.scroll_speed);
         if(PROGRESSION >= 2 && PROGRESSION < 15)
         {
            SoundSystem.PlaySound("car_running");
         }
         if(PROGRESSION == 0)
         {
            if(counter1 > 90)
            {
               this.t_start = this.truckCollision.xPos;
               this.t_diff = Utils.WIDTH * 0.75 - this.t_start;
               this.t_tick = 0;
               this.t_time = this.t_diff / 300;
               SoundSystem.PlaySound("car_start");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 1)
         {
            if(counter1 >= 30)
            {
               SoundSystem.PlaySound("car_running");
            }
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               counter1 = 0;
               ++PROGRESSION;
            }
            this.truckCollision.xPos = Easings.easeOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         else if(PROGRESSION == 2)
         {
            this.t_start = this.truckCollision.xPos;
            this.t_diff = Utils.WIDTH * 0.5 - this.t_start;
            this.t_tick = 0;
            this.t_time = 1;
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 3)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               counter1 = 0;
               ++PROGRESSION;
            }
            this.truckCollision.xPos = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         else if(PROGRESSION == 4)
         {
            if(counter1 >= 30)
            {
               SoundSystem.PlaySound("wroom");
               this.t_start = this.truckCollision.xPos;
               this.t_diff = -64;
               this.t_tick = 0;
               this.t_time = 1;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 5)
         {
            this.jumpTiles_x -= 6;
            if(this.jumpTiles_x <= this.truckCollision.xPos + 48)
            {
               this.roseSprite.y = 16;
               this.roseSprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
               }
               this.truckCollision.xPos = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
               if(this.jumpAnimsIndex == 40)
               {
                  SoundSystem.PlaySound("ground_stomp");
               }
               else if(this.jumpAnimsIndex == 60)
               {
                  SoundSystem.PlaySound("ground_stomp");
               }
               this.truckCollision.yPos = this.truckCollision.originalYPos + this.jumpAnimsOffset[this.jumpAnimsIndex] * 0.3;
               ++this.jumpAnimsIndex;
               if(this.jumpAnimsIndex >= this.jumpAnimsOffset.length)
               {
                  counter1 = 0;
                  this.jumpAnimsIndex = this.jumpAnimsOffset.length - 1;
                  ++PROGRESSION;
               }
               if(this.truckCollision.yPos > this.truckCollision.originalYPos)
               {
                  this.truckCollision.yPos = this.truckCollision.originalYPos;
                  this.truckCollision.addForce(5);
               }
            }
         }
         else if(PROGRESSION == 6)
         {
            if(counter1 >= 0)
            {
               this.roseSprite.y = 12;
               this.roseSprite.gfxHandle().gfxHandleClip().gotoAndPlay(2);
               this.t_start = this.truckCollision.xPos;
               this.t_diff = 64;
               this.t_tick = 0;
               this.t_time = 1;
               ++PROGRESSION;
               counter1 = 0;
            }
         }
         else if(PROGRESSION == 7)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               counter1 = 0;
               ++PROGRESSION;
            }
            this.truckCollision.xPos = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         else if(PROGRESSION == 8)
         {
            SoundSystem.PlaySound("phone");
            this.truckCollision.setSignalOn(true);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 9)
         {
            if(counter1 >= 90)
            {
               level.hud.dialogsManager.createCaptionNoCameraAt(StringsManager.GetString("intro_cutscene1_1"),int(Utils.WIDTH * 0.5),int(Utils.HEIGHT * 0.2),this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 11)
         {
            if(counter1 >= 15)
            {
               this.roseBalloon = level.hud.dialogsManager.createBalloonAt(StringsManager.GetString("intro_cutscene1_2"),int(this.truckCollision.xPos + 26),int(this.truckCollision.yPos),this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 12)
         {
            if(this.roseBalloon != null)
            {
               this.roseBalloon.yPos = int(this.truckCollision.yPos + this.truckCollision.is_on_offset_y);
            }
         }
         else if(PROGRESSION == 13)
         {
            SoundSystem.PlaySound("cat_rose");
            this.roseSprite.playSpecialAnim(CatSprite.SHOCKED);
            level.hud.setContinueTextDisplayable(false);
            this.roseBalloon = level.hud.dialogsManager.createTimedBalloonAt(StringsManager.GetString("intro_cutscene1_3"),int(this.truckCollision.xPos + 26),int(this.truckCollision.yPos),30);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 14)
         {
            if(counter1 >= 50)
            {
               this.roseSprite.gfxHandle().gotoAndStop(12);
               this.truckCollision.setSkidOn(true);
               this.truckCollision.setTiresOn(false);
               this.t_start = -6;
               this.t_diff = 6;
               this.t_tick = 0;
               this.t_time = 3.5;
               this.xBehaviour.x_start = level.camera.xPos;
               this.xBehaviour.x_end = 400 - level.camera.WIDTH * 0.5 - this.t_start;
               this.xBehaviour.time = 3;
               this.xBehaviour.tick = 0;
               level.camera.changeHorBehaviour(this.xBehaviour);
               counter1 = 0;
               ++PROGRESSION;
            }
            else if(this.roseBalloon != null)
            {
               this.roseBalloon.yPos = int(this.truckCollision.yPos + this.truckCollision.is_on_offset_y);
            }
         }
         else if(PROGRESSION == 15)
         {
            if(this.t_tick <= this.t_time - 0.5)
            {
               SoundSystem.PlaySound("skid");
            }
            this.truckCollision.xPos += 1;
            if(this.truckCollision.xPos >= 320)
            {
               this.truckCollision.xPos = 320;
            }
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               if(this.truckCollision.xPos >= 320)
               {
                  this.truckCollision.setSkidOn(false);
               }
               if(this.truckCollision.xPos >= 320)
               {
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
            this.scroll_speed = Easings.easeInOutSine(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         else if(PROGRESSION == 16)
         {
            if(counter1 >= 30)
            {
               this.truckCollision.turnOn(false);
               this.roseSprite.playSpecialAnim(CatSprite.PEEK);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 17)
         {
            if(counter1 == 25 || counter1 == 50)
            {
               SoundSystem.PlaySound("wink");
            }
            if(counter1 >= 90)
            {
               this.roseSprite.playSpecialAnim(CatSprite.PANT);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 18)
         {
            this.olliNPC.sprite.visible = true;
            this.olliNPC.sprite.gfxHandle().gotoAndStop(5);
            this.olliNPC.sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            this.jumpForceX = -4;
            this.truckCollision.addForce(10);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 19)
         {
            this.olliNPC.xPos += this.jumpForceX;
            this.olliNPC.yPos += 1;
            this.jumpForceX *= 0.85;
            if(this.olliNPC.yPos >= 144)
            {
               SoundSystem.PlaySound("cat_falls_ground");
               this.olliNPC.yPos = 144;
               this.jumpForceX = 0;
               this.olliNPC.stateMachine.setState("IS_TURNING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 20)
         {
            if(this.olliNPC.stateMachine.currentState == "IS_STANDING_STATE")
            {
               this.olliNPC.onTop();
               this.olliNPC.SPEED = 2.5;
               this.olliNPC.stateMachine.setState("IS_WALKING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 21)
         {
            if(this.olliNPC.xPos >= 384)
            {
               this.olliNPC.xPos = 384;
               this.olliNPC.stateMachine.setState("IS_STANDING_STATE");
               counter1 = 0;
               ++PROGRESSION;
               SoundSystem.PlaySound("cat_glide");
               level.hud.setContinueTextDisplayable(true);
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("intro_cutscene1_4"),this.olliNPC,this.advance);
            }
         }
         else if(PROGRESSION == 23)
         {
            level.hero.sprite.visible = true;
            level.hero.DIRECTION = Entity.LEFT;
            level.hero.xPos = this.truckCollision.xPos - 48;
            level.hero.yPos = this.truckCollision.yPos + 24;
            counter1 = 0;
            ++PROGRESSION;
            this.jumpForceX = -4;
            this.truckCollision.addForce(-10);
         }
         else if(PROGRESSION == 24)
         {
            level.hero.xPos += this.jumpForceX;
            level.hero.yPos += 1;
            this.jumpForceX *= 0.85;
            if(level.hero.yPos >= 144)
            {
               SoundSystem.PlaySound("cat_falls_ground");
               level.hero.yPos = 144;
               this.jumpForceX = 0;
               level.hero.onTop();
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 25)
         {
            if(counter1 >= 15)
            {
               level.rightPressed = true;
               level.hero.MAX_X_VEL = 2.5;
               level.hero.speed = 2.5;
               if(level.hero.xPos >= 384 + 26)
               {
                  level.hero.xVel = 0;
                  level.hero.xPos = 384 + 26;
                  level.rightPressed = false;
                  level.hero.stateMachine.setState("IS_STANDING_STATE");
                  counter1 = 0;
                  ++PROGRESSION;
               }
            }
         }
         else if(PROGRESSION == 26)
         {
            if(counter1 >= 30)
            {
               level.hero.sprite.gfxHandle().gotoAndStop(22);
               level.hero.sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 27)
         {
            if(counter1 >= 60)
            {
               level.hero.stateMachine.setState("IS_TURNING_STATE");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 28)
         {
            if(level.hero.stateMachine.currentState == "IS_STANDING_STATE")
            {
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("intro_cutscene1_5"),level.hero,this.advance);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 30)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("intro_cutscene1_6"),this.olliNPC,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 32)
         {
            if(counter1 == 1)
            {
               Utils.INVENTORY_NOTIFICATION_ID = LevelItems.ITEM_DATA_DRIVE;
               Utils.INVENTORY_NOTIFICATION_ACTION = 1;
            }
            else if(counter1 >= 150)
            {
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 33)
         {
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("intro_cutscene1_7"),this.olliNPC,this.advance);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 35)
         {
            level.hud.catUnlockManager.showUnlockScene(0);
            counter1 = 0;
            ++PROGRESSION;
         }
         else if(PROGRESSION == 36)
         {
            if(level.hud.catUnlockManager.unlockScene == null)
            {
               SoundSystem.PlayMusic("outside_rain",-1,false,true);
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 37)
         {
            if(counter1 >= 30)
            {
               this.xBehaviour2.x_start = level.camera.xPos;
               this.xBehaviour2.x_end = level.camera.xPos + 64;
               this.xBehaviour2.time = 4;
               this.xBehaviour2.tick = 0;
               level.camera.changeHorBehaviour(this.xBehaviour2);
               SoundSystem.PlaySound("cat_run");
               level.rightPressed = true;
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 38)
         {
            level.rightPressed = true;
            if(counter1 == 60)
            {
               level.hud.showDarkFade(120);
            }
            if(counter1 >= 180)
            {
               stateMachine.performAction("END_ACTION");
               counter1 = 0;
               ++PROGRESSION;
            }
         }
         if(PROGRESSION <= 17)
         {
            this.olliNPC.xPos = this.truckCollision.xPos - 48;
            this.olliNPC.yPos = this.truckCollision.yPos + 24;
         }
         this.GRASS_X_OFFSET += this.rainBackground.SPEED;
         if(this.GRASS_X_OFFSET <= -340)
         {
            this.GRASS_X_OFFSET += 340;
         }
         for(i = 0; i < this.grassDecorations.length; i++)
         {
            if(this.grassDecorations[i] != null)
            {
               this.grassDecorations[i].xPos = this.grassDecorations[i].originalXPos + this.GRASS_X_OFFSET;
            }
         }
         if(this.roseSprite.visible)
         {
            if(this.roseSprite.gfxHandle().gfxHandleClip().isComplete)
            {
               this.roseSprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(int(Math.random() * 4) + 2));
               this.roseSprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
         }
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
         this.jumpTiles.x = int(Math.floor(this.jumpTiles_x - camera.xPos));
         this.jumpTiles.y = int(Math.floor(this.jumpTiles_y - camera.yPos));
      }
      
      override protected function initState() : void
      {
         var i:int = 0;
         var j:int = 0;
         var image:Image = null;
         var _type:int = 0;
         super.initState();
         this.olliNPC = new CatNPC(level,100,100,Entity.LEFT,0);
         this.olliNPC.sprite.visible = false;
         this.olliNPC.updateScreenPosition(level.camera);
         level.npcsManager.npcs.push(this.olliNPC);
         this.olliNPC.stateMachine.setState("IS_STANDING_STATE");
         this.truckCollision = new TruckCollision(level,-200,99,Entity.RIGHT,TruckCollision.TRUCK_TYPE_RED);
         level.collisionsManager.collisions.push(this.truckCollision);
         this.truckCollision.updateScreenPosition(level.camera);
         this.truckCollision.IS_ON = true;
         this.truckCollision.setTiresOn(true);
         this.roseSprite = new SmallCatSprite();
         this.roseSprite.gfxHandle().scaleX = -1;
         this.truckCollision.driversContainer.addChild(this.roseSprite);
         this.roseSprite.x = 74;
         this.roseSprite.y = 12;
         this.rainBackground = level.backgroundsManager.background as RainWoodsBackground;
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
         this.jumpTiles = new Sprite();
         Utils.topWorld.addChild(this.jumpTiles);
         image = new Image(TextureManager.sTextureAtlas.getTexture("mountain_tile_4"));
         image.touchable = false;
         this.jumpTiles.addChild(image);
         image = new Image(TextureManager.sTextureAtlas.getTexture("mountain_tile_2"));
         image.touchable = false;
         this.jumpTiles.addChild(image);
         image.x = 32;
         image = new Image(TextureManager.sTextureAtlas.getTexture("mountain_tile_3"));
         image.scaleX = -1;
         image.touchable = false;
         this.jumpTiles.addChild(image);
         image.x = 48;
         image.y = 16;
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         LevelIntroCutscene.FORCE_SHORT_INTRO = true;
         LevelItems.AddItemToInventoryAndSave(LevelItems.ITEM_DATA_DRIVE,1,false);
         Utils.Slot.gameProgression[0] = 1;
         SaveManager.SaveGameProgression();
         Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 1;
         level.CHANGE_ROOM_FLAG = true;
      }
      
      protected function initJumpAnims() : void
      {
         this.jumpAnimsIndex = 0;
         this.jumpAnimsOffset = [-1.5,-7.25,-14.5,-23.75,-32,-40.75,-49.5,-55.5,-61.25,-65,-69.75,-73.5,-75.25,-77,-78.5,-81,-82.25,-83.75,-84.25,-84.5,-84.5,-84.5,-84.5,-84.5,-84.5,-84.5,-84,-83.5,-83.25,-82.25,-81.25,-80,-78.5,-76,-74.25,-70.25,-62.25,-48,-33.5,-18.25,-3.5,10,18,19.25,20.25,20.25,20.25,20.25,14.75,3.75,-21.25,-24.75,-32.75,-32.75,-32.75,-24,-20,-16.5,-2.25,16.5,34.25,43.75,45.5,45.75,45.75,45.75,45.5,45.25,44.75];
      }
   }
}
