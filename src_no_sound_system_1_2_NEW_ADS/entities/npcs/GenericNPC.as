package entities.npcs
{
   import entities.*;
   import flash.geom.*;
   import game_utils.CoinPrices;
   import game_utils.GameSlot;
   import game_utils.StateMachine;
   import levels.Level;
   import levels.cameras.*;
   import levels.cutscenes.MoneyQuestionCutscene;
   import levels.cutscenes.world2.GenericWorld2Cutscene;
   import sprites.bullets.GenericBulletSprite;
   import sprites.npcs.*;
   import sprites.particles.*;
   import states.LevelState;
   
   public class GenericNPC extends NPC
   {
      
      public static var NPC_CAT_1:int = 0;
      
      public static var NPC_TOMO_HELMET_1:int = 1;
      
      public static var NPC_WOMBAT_1:int = 2;
      
      public static var NPC_GREEN_TOMO:int = 3;
      
      public static var NPC_WOMBAT_2:int = 4;
      
      public static var NPC_TIN_SOLDIER:int = 5;
      
      public static var NPC_SCIENTIST_CAT:int = 6;
      
      public static var NPC_MCMEOW_DESK:int = 7;
      
      public static var NPC_ACORN_MEDIUM:int = 8;
      
      public static var NPC_ACORN_SMALL:int = 9;
      
      public static var NPC_ACORN_BIG:int = 10;
      
      public static var NPC_BLACK_DUCK:int = 11;
      
      public static var NPC_WORKER_1:int = 12;
      
      public static var NPC_FISH_JANITOR_1:int = 13;
      
      public static var NPC_MOLE_GREY:int = 14;
      
      public static var NPC_MOLE_BROWN:int = 15;
      
      public static var NPC_PIG:int = 16;
      
      public static var NPC_LOBSTER_RED:int = 17;
      
      public static var NPC_TOMO_SAILOR:int = 18;
      
      public static var NPC_LOBSTER_BLUE:int = 19;
      
      public static var NPC_LOBSTER_SMALL_RED:int = 20;
      
      public static var NPC_LOBSTER_SMALL_BLUE:int = 21;
      
      public static var NPC_BEACH_1:int = 22;
      
      public static var NPC_BEACH_2:int = 23;
      
      public static var NPC_BEACH_3:int = 24;
      
      public static var NPC_BEACH_4:int = 25;
      
      public static var NPC_TOMO_PUNK:int = 26;
      
      public static var NPC_WHITE_MOUSE:int = 27;
      
      public static var NPC_GUY:int = 28;
      
      public static var NPC_TOMO_CHEF:int = 29;
      
      public static var NPC_ACORN_OLD:int = 30;
      
      public static var NPC_CONCETTA:int = 31;
      
      public static var NPC_MONKEY:int = 32;
      
      public static var NPC_ZOMBIE:int = 33;
       
      
      public var NPC_TYPE:int;
      
      protected var walk_counter:int;
      
      protected var z_counter:int;
      
      protected var just_turn_head:Boolean;
      
      protected var offset_y:Number;
      
      protected var offset_sin_counter:Number;
      
      public var IS_TURN_ALLOWED:Boolean;
      
      public var IS_SLEEPING:Boolean;
      
      public var flag_1:Boolean;
      
      public function GenericNPC(_level:Level, _xPos:Number, _yPos:Number, _direction:int, _string_id:int = 0, _type:int = 0)
      {
         super(_level,_xPos,_yPos,_direction,_string_id);
         this.IS_TURN_ALLOWED = true;
         this.IS_SLEEPING = false;
         this.NPC_TYPE = _type;
         this.just_turn_head = false;
         this.offset_y = this.offset_sin_counter = 0;
         this.flag_1 = false;
         this.z_counter = 0;
         if(this.NPC_TYPE == GenericNPC.NPC_ACORN_OLD)
         {
            this.IS_TURN_ALLOWED = false;
         }
         sprite = new GenericNPCSprite(this.NPC_TYPE);
         if(this.NPC_TYPE == GenericNPC.NPC_GREEN_TOMO || this.NPC_TYPE == GenericNPC.NPC_MCMEOW_DESK)
         {
            IS_BACK_WORLD = true;
            Utils.backWorld.addChild(sprite);
            if(this.NPC_TYPE == GenericNPC.NPC_CAT_1 && Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_7)
            {
               gravity_friction = 0;
            }
         }
         else
         {
            Utils.world.addChild(sprite);
         }
         if(this.NPC_TYPE == GenericNPC.NPC_MCMEOW_DESK || this.NPC_TYPE == GenericNPC.NPC_CONCETTA)
         {
            allowTurn = false;
            shocked_offset_y = -5;
            if(this.NPC_TYPE == GenericNPC.NPC_CONCETTA)
            {
               this.IS_SLEEPING = true;
            }
         }
         else if(this.NPC_TYPE == GenericNPC.NPC_BEACH_3)
         {
            this.just_turn_head = true;
            gravity_friction = 0;
         }
         else if(this.NPC_TYPE == GenericNPC.NPC_BEACH_4)
         {
            gravity_friction = 0;
         }
         this.walk_counter = 0;
         fetchScripts();
         stateMachine = new StateMachine();
         stateMachine.setRule("IS_STANDING_STATE","CHANGE_DIR_ACTION","IS_TURNING_STATE");
         stateMachine.setRule("IS_TURNING_STATE","END_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_STANDING_STATE","WALK_ACTION","IS_WALKING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","STOP_ACTION","IS_STANDING_STATE");
         stateMachine.setRule("IS_WALKING_STATE","CHANGE_DIR_ACTION","IS_TURNING_WALKING_STATE");
         stateMachine.setRule("IS_TURNING_WALKING_STATE","END_ACTION","IS_WALKING_STATE");
         stateMachine.setFunctionToState("IS_STANDING_STATE",this.standingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_STATE",this.turningAnimation);
         stateMachine.setFunctionToState("IS_WALKING_STATE",this.walkingAnimation);
         stateMachine.setFunctionToState("IS_TURNING_WALKING_STATE",this.turningAnimation);
         stateMachine.setState("IS_STANDING_STATE");
      }
      
      override public function update() : void
      {
         var i:int = 0;
         super.update();
         if(stateMachine.currentState == "IS_STANDING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete && !this.just_turn_head)
            {
               sprite.gfxHandle().gfxHandleClip().setFrameDuration(0,int(Math.random() * 5 + 2));
               sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
            }
            if(isHeroClose())
            {
               if(DIRECTION == Entity.LEFT)
               {
                  if(level.hero.xPos + level.hero.WIDTH * 0.5 > xPos + WIDTH * 0.5 + WIDTH)
                  {
                     this.turn();
                  }
               }
               else if(level.hero.xPos + level.hero.WIDTH * 0.5 < xPos + WIDTH * 0.5 - WIDTH)
               {
                  this.turn();
               }
            }
            else if(!this.just_turn_head)
            {
               if(counter1-- < 0)
               {
                  if(!(this.NPC_TYPE == GenericNPC.NPC_SCIENTIST_CAT && DIRECTION == Entity.RIGHT && Utils.Slot.gameVariables[GameSlot.VARIABLE_LEVEL] == LevelState.LEVEL_1_5_5))
                  {
                     this.turn();
                  }
               }
               if(path_start_x != 0)
               {
                  if(this.walk_counter-- < 0 && !IS_INTERACTING)
                  {
                     this.randomizeWalkCounter();
                     stateMachine.performAction("WALK_ACTION");
                  }
               }
            }
         }
         else if(stateMachine.currentState == "IS_WALKING_STATE")
         {
            if(DIRECTION == LEFT)
            {
               xVel = -speed;
               if(xPos <= path_start_x)
               {
                  xPos = path_start_x;
                  stateMachine.performAction("CHANGE_DIR_ACTION");
               }
               if(this.NPC_TYPE == GenericNPC.NPC_BEACH_4)
               {
                  if(counter1-- <= 0)
                  {
                     counter1 = 24;
                     level.particlesManager.pushParticle(new SplashParticleSprite(0),getMidXPos() + 20,yPos + 6,0,0,0);
                  }
               }
            }
            else
            {
               xVel = speed;
               if(xPos + WIDTH >= path_end_x)
               {
                  xPos = path_end_x - WIDTH;
                  stateMachine.performAction("CHANGE_DIR_ACTION");
               }
               if(this.NPC_TYPE == GenericNPC.NPC_BEACH_4)
               {
                  if(counter1-- <= 0)
                  {
                     counter1 = 24;
                     level.particlesManager.pushParticle(new SplashParticleSprite(0),getMidXPos() - 20,yPos + 6,0,0,0);
                  }
               }
            }
            if(this.NPC_TYPE == GenericNPC.NPC_FISH_JANITOR_1)
            {
               if(counter2++ > 5)
               {
                  counter2 = 0;
                  level.particlesManager.groundSmokeParticles(this);
               }
            }
            if(this.walk_counter-- < 0)
            {
               this.randomizeWalkCounter();
               stateMachine.performAction("STOP_ACTION");
            }
         }
         else if(stateMachine.currentState == "IS_TURNING_STATE" || stateMachine.currentState == "IS_TURNING_WALKING_STATE")
         {
            if(sprite.gfxHandle().gfxHandleClip().isComplete)
            {
               changeDirection();
               stateMachine.performAction("END_ACTION");
            }
         }
         if(this.NPC_TYPE == GenericNPC.NPC_BEACH_4)
         {
            this.offset_sin_counter += 0.05;
            if(this.offset_sin_counter >= Math.PI * 2)
            {
               this.offset_sin_counter -= Math.PI * 2;
            }
            this.offset_y = Math.sin(this.offset_sin_counter) * 1.5;
         }
         else if(this.NPC_TYPE == GenericNPC.NPC_BEACH_2)
         {
            if(stringId != 5)
            {
               for(i = 0; i < level.bulletsManager.bullets.length; i++)
               {
                  if(level.bulletsManager.bullets[i] != null)
                  {
                     if(level.bulletsManager.bullets[i].sprite != null)
                     {
                        if(level.bulletsManager.bullets[i].ID == GenericBulletSprite.BEACH_BALL)
                        {
                           if(level.bulletsManager.bullets[i].getAABB().intersects(this.getAABBPhysics()))
                           {
                              if(level.bulletsManager.bullets[i].xVel <= 0)
                              {
                                 level.bulletsManager.bullets[i].xVel = 5;
                              }
                              else
                              {
                                 level.bulletsManager.bullets[i].xVel = -5;
                              }
                              level.bulletsManager.bullets[i].yVel = -10;
                              level.camera.shake();
                              SoundSystem.PlaySound("explosion_medium");
                              stringId = 5;
                           }
                        }
                     }
                  }
               }
            }
         }
         if(this.IS_SLEEPING)
         {
            if(this.z_counter++ > 120)
            {
               this.z_counter = 0;
               level.particlesManager.pushParticle(new ZSleepParticleSprite(),xPos,yPos - 2,0,0,0,0,0,-1);
            }
         }
         integratePositionAndCollisionDetection();
      }
      
      protected function randomizeWalkCounter() : void
      {
         if(this.NPC_TYPE == GenericNPC.NPC_FISH_JANITOR_1)
         {
            this.walk_counter = int((Math.random() * 3 + 1) * 20);
         }
         else
         {
            this.walk_counter = int((Math.random() * 3 + 1) * 60);
         }
      }
      
      protected function turn() : void
      {
         if(!this.IS_TURN_ALLOWED)
         {
            return;
         }
         if(this.just_turn_head)
         {
            changeDirection();
            if(DIRECTION == Entity.LEFT)
            {
               sprite.gfxHandle().gfxHandleClip().gotoAndStop(2);
            }
            else
            {
               sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
            }
         }
         else if(allowTurn)
         {
            stateMachine.performAction("CHANGE_DIR_ACTION");
         }
      }
      
      override protected function isInteractionAllowed() : Boolean
      {
         if(stateMachine.currentState == "IS_WALKING_STATE" || stateMachine.currentState == "IS_TURNING_WALKING_STATE")
         {
            return false;
         }
         return true;
      }
      
      override public function heroInteractionStart() : void
      {
         if(this.NPC_TYPE == GenericNPC.NPC_GUY)
         {
            if(stringId == 1)
            {
               dialog = level.hud.dialogsManager.createMoneyQuestionBalloonOn(StringsManager.GetString(this.getStringName() + stringId),this,null,0,this.questionHandler,CoinPrices.GetPrice(CoinPrices.BOAT_TRIP));
            }
            else
            {
               dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString(this.getStringName() + stringId),this);
            }
         }
         else if(this.NPC_TYPE == GenericNPC.NPC_MOLE_GREY)
         {
            if(stringId == 2)
            {
               dialog = level.hud.dialogsManager.createMoneyQuestionBalloonOn(StringsManager.GetString(this.getStringName() + stringId),this,null,0,this.questionHandler,CoinPrices.GetPrice(CoinPrices.LIFT_TRIP));
            }
            else
            {
               dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString(this.getStringName() + stringId),this);
            }
         }
         else if(this.NPC_TYPE == GenericNPC.NPC_BEACH_2 && stringId == 5)
         {
            dialog = level.hud.dialogsManager.createQuestionBalloonOn(StringsManager.GetString(this.getStringName() + stringId),this,null,0,this.questionHandler);
         }
         else
         {
            dialog = level.hud.dialogsManager.createBalloonOn(StringsManager.GetString(this.getStringName() + stringId),this);
         }
      }
      
      protected function questionHandler(_result:int) : void
      {
         if(this.NPC_TYPE == GenericNPC.NPC_GUY)
         {
            if(_result > 0)
            {
               level.startCutscene(new MoneyQuestionCutscene(level,0,true,CoinPrices.GetPrice(CoinPrices.BOAT_TRIP)));
            }
            else
            {
               level.startCutscene(new MoneyQuestionCutscene(level,0,false,CoinPrices.GetPrice(CoinPrices.BOAT_TRIP)));
            }
         }
         else if(this.NPC_TYPE == GenericNPC.NPC_MOLE_GREY)
         {
            if(_result > 0)
            {
               level.startCutscene(new MoneyQuestionCutscene(level,MoneyQuestionCutscene.LIFT_TRIP,true,CoinPrices.GetPrice(CoinPrices.LIFT_TRIP)));
            }
            else
            {
               level.startCutscene(new MoneyQuestionCutscene(level,MoneyQuestionCutscene.LIFT_TRIP,false,CoinPrices.GetPrice(CoinPrices.LIFT_TRIP)));
            }
         }
         else if(this.NPC_TYPE == GenericNPC.NPC_BEACH_2)
         {
            level.startCutscene(new GenericWorld2Cutscene(level));
         }
      }
      
      private function getStringName() : String
      {
         if(this.NPC_TYPE == GenericNPC.NPC_CAT_1)
         {
            return "npc_zak_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_TOMO_HELMET_1)
         {
            return "npc_helmet_tomo_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_WOMBAT_1 || this.NPC_TYPE == GenericNPC.NPC_WOMBAT_2)
         {
            return "npc_wombat_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_GREEN_TOMO)
         {
            return "npc_green_tomo_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_TIN_SOLDIER)
         {
            return "npc_tin_soldier_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_SCIENTIST_CAT)
         {
            return "npc_kit_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_MCMEOW_DESK)
         {
            return "npc_mcmeow_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_ACORN_BIG || this.NPC_TYPE == GenericNPC.NPC_ACORN_MEDIUM || this.NPC_TYPE == GenericNPC.NPC_ACORN_SMALL)
         {
            return "npc_acorn_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_WORKER_1)
         {
            return "npc_worker_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_MOLE_BROWN || this.NPC_TYPE == GenericNPC.NPC_MOLE_GREY)
         {
            return "npc_mole_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_PIG)
         {
            return "npc_pig_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_LOBSTER_RED || this.NPC_TYPE == GenericNPC.NPC_LOBSTER_BLUE || this.NPC_TYPE == GenericNPC.NPC_LOBSTER_SMALL_RED || this.NPC_TYPE == GenericNPC.NPC_LOBSTER_SMALL_BLUE)
         {
            return "npc_lobster_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_TOMO_SAILOR)
         {
            return "npc_sailor_tomo_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_BEACH_1 || this.NPC_TYPE == GenericNPC.NPC_BEACH_2 || this.NPC_TYPE == GenericNPC.NPC_BEACH_3 || this.NPC_TYPE == GenericNPC.NPC_BEACH_4)
         {
            return "npc_beach_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_TOMO_PUNK)
         {
            return "npc_tomo_punk_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_WHITE_MOUSE)
         {
            return "npc_white_mouse_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_GUY)
         {
            return "npc_guy_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_TOMO_CHEF)
         {
            return "npc_tomo_chef_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_ACORN_OLD)
         {
            return "npc_acorn_";
         }
         if(this.NPC_TYPE == GenericNPC.NPC_ZOMBIE)
         {
            return "npc_zombie_";
         }
         return "";
      }
      
      override public function getBalloonYOffset() : int
      {
         if(this.NPC_TYPE == GenericNPC.NPC_MCMEOW_DESK)
         {
            return -22;
         }
         if(this.NPC_TYPE == GenericNPC.NPC_GUY)
         {
            return -28;
         }
         return -20;
      }
      
      override public function heroInteractionEnd() : void
      {
         dialog.endRendering();
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
         sprite.y = int(Math.floor(yPos + this.offset_y - camera.yPos));
         if(this.just_turn_head)
         {
            sprite.gfxHandle().scaleX = 1;
         }
      }
      
      protected function standingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(1);
         if(this.just_turn_head)
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndStop(1);
         }
         else
         {
            sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         }
         counter1 = int(Math.random() * 5 + 6) * 60;
         xVel = 0;
      }
      
      protected function turningAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(2);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         xVel = 0;
      }
      
      protected function walkingAnimation() : void
      {
         sprite.gfxHandle().gotoAndStop(3);
         sprite.gfxHandle().gfxHandleClip().gotoAndPlay(1);
         counter1 = counter2 = 0;
         if(this.NPC_TYPE == GenericNPC.NPC_FISH_JANITOR_1)
         {
            speed = 1;
         }
         else
         {
            speed = 0.2;
         }
      }
   }
}
