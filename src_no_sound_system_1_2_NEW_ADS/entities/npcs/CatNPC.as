package entities.npcs
{
   import entities.Entity;
   import entities.Hero;
   import game_utils.*;
   import levels.*;
   import levels.cutscenes.world2.GenericWorld2Cutscene;
   import sprites.cats.*;
   
   public class CatNPC extends NPC
   {
      
      public static var OLLI:int = 0;
      
      public static var ROSE:int = 1;
      
      public static var PASCAL:int = 2;
      
      public static var RIGS:int = 3;
      
      public static var MC_MEOW:int = 4;
      
      public static var MARA:int = 5;
       
      
      public var SPEED:Number;
      
      public var ID:int;
      
      protected var ALLOW_TURN_TO_HERO:Boolean;
      
      public function CatNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _string_id:int = 0, _cat_id:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_string_id);
         this.ALLOW_TURN_TO_HERO = true;
         this.ID = _cat_id;
         if(this.ID == CatNPC.OLLI)
         {
            sprite = new GlideCatSprite(-100);
         }
         else if(this.ID == CatNPC.ROSE)
         {
            sprite = new SmallCatSprite(4);
         }
         else if(this.ID == CatNPC.RIGS)
         {
            sprite = new EvilCatSprite(2);
         }
         else if(this.ID == CatNPC.MC_MEOW)
         {
            sprite = new McMeowHeroSprite();
         }
         else if(this.ID == CatNPC.MARA)
         {
            sprite = new WaterCatSprite(3);
         }
         else
         {
            sprite = new HeroSprite(0);
         }
         Utils.world.addChild(sprite);
         this.SPEED = 2;
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","CHANGE_DIR_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_FALLING_STATE","GROUND_COLLISION_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_EYES_CLOSED_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_FALLING_STATE",this.fallingAnimation);
         stateMachine.setFunctionToState("IS_EYES_CLOSED_STATE",this.eyesClosedAnimation);
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(Math.random() * 5 + 2));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            if(this.ALLOW_TURN_TO_HERO)
            {
               if(level.stateMachine.currentState == "IS_PLAYING_STATE")
               {
                  if(level.hero.xPos + level.hero.WIDTH * 0.5 > xPos + WIDTH * 0.5)
                  {
                     if(DIRECTION == LEFT)
                     {
                        stateMachine.performAction("CHANGE_DIR_ACTION");
                     }
                  }
                  else if(DIRECTION == RIGHT)
                  {
                     stateMachine.performAction("CHANGE_DIR_ACTION");
                  }
               }
            }
            yVel += level.levelPhysics.gravity * gravity_friction;
            xPos += xVel;
            yPos += yVel;
            level.levelPhysics.collisionDetectionMap(this);
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(DIRECTION == Entity.RIGHT)
            {
               xVel = this.SPEED;
            }
            else
            {
               xVel = -this.SPEED;
            }
            yVel += level.levelPhysics.gravity;
            xPos += xVel;
            yPos += yVel;
            level.levelPhysics.collisionDetectionMap(this);
         }
         else if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            yVel += level.levelPhysics.gravity;
            if(yVel >= 8)
            {
               yVel = 8;
            }
            xPos += xVel;
            yPos += yVel;
            level.levelPhysics.collisionDetectionMap(this);
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
      }
      
      override public function groundCollision() : void
      {
         if(stateMachine.currentState == "IS_FALLING_STATE")
         {
            yVel = 0;
            stateMachine.performAction("GROUND_COLLISION_ACTION");
         }
      }
      
      protected function questionHandler(_result:int) : void
      {
         if(this.ID == CatNPC.ROSE)
         {
            if(stringId == 1)
            {
               level.startCutscene(new GenericWorld2Cutscene(level));
            }
         }
      }
      
      override public function heroInteractionStart() : void
      {
         var i:int = 0;
         var amount:int = 0;
         super.heroInteractionStart();
         if(this.ID == CatNPC.OLLI)
         {
            if(Utils.FLAIR == Utils.FLAIR_HALLOWEEN)
            {
               amount = 0;
               for(i = 0; i < 10; i++)
               {
                  if((Utils.Slot.gameProgression[20] >> i & 1) == 1)
                  {
                     amount++;
                  }
               }
               if(Utils.Slot.gameProgression[21] == 1)
               {
                  dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_olli_" + stringId),this);
               }
               else
               {
                  dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_olli_" + stringId) + " " + amount + "/10",this);
               }
            }
            else
            {
               dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_olli_" + stringId),this);
            }
         }
         else if(this.ID == CatNPC.MARA)
         {
            dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_mara_" + stringId),this);
         }
         else if(this.ID == CatNPC.RIGS)
         {
            dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_rigs_" + stringId),this);
         }
         else if(this.ID == CatNPC.ROSE)
         {
            if(stringId == 1)
            {
               if(Utils.LEVEL_LOCAL_PROGRESSION_1 < 2)
               {
                  dialog = level.hud.dialogsManager.createQuestionBalloonOn(StringsManager.GetString("npc_rose_1"),this,null,0,this.questionHandler);
               }
               else if(Hero.GetCurrentCat() == 0 || Hero.GetCurrentCat() == 3)
               {
                  dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_rose_1_" + Hero.GetCurrentCat()),this);
               }
               else
               {
                  dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_rose_1_2"),this);
               }
            }
            else
            {
               dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_rose_" + stringId),this);
            }
         }
         else
         {
            dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_acorn_" + stringId),this);
         }
      }
      
      override public function heroInteractionEnd() : void
      {
         super.heroInteractionEnd();
         dialog.endRendering();
      }
      
      public function setTurnToHero(_isOn:Boolean = true) : void
      {
         this.ALLOW_TURN_TO_HERO = _isOn;
      }
      
      protected function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
         yVel = 0;
      }
      
      protected function eyesClosedAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
         xVel = 0;
         yVel = 0;
      }
      
      protected function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
      
      protected function fallingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(5);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
      }
   }
}
