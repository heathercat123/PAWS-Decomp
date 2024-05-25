package levels.cutscenes.world2
{
   import entities.Easings;
   import entities.Entity;
   import entities.Hero;
   import entities.npcs.GenericNPC;
   import game_utils.GameSlot;
   import levels.Level;
   import levels.cameras.ScreenCamera;
   import levels.cutscenes.*;
   import levels.worlds.world2.Level_2_5;
   import sprites.bullets.GenericBulletSprite;
   import sprites.particles.EnemyHurtParticleSprite;
   
   public class BeachMinigame extends Cutscene
   {
       
      
      protected var hero:Hero;
      
      protected var npc:GenericNPC;
      
      protected var condition_1:Boolean;
      
      protected var condition_2:Boolean;
      
      protected var t_start:Number;
      
      protected var t_diff:Number;
      
      protected var t_time:Number;
      
      protected var t_tick:Number;
      
      protected var t_start_2:Number;
      
      protected var t_diff_2:Number;
      
      protected var t_time_2:Number;
      
      protected var t_tick_2:Number;
      
      protected var MINIGAME_OVER:Boolean;
      
      public function BeachMinigame(_level:Level, isMinigameOver:Boolean = false)
      {
         this.MINIGAME_OVER = isMinigameOver;
         super(_level);
         this.condition_1 = this.condition_2 = false;
         counter1 = counter2 = counter3 = 0;
         this.t_start = this.t_diff = this.t_time = this.t_tick = this.t_start_2 = this.t_diff_2 = this.t_time_2 = this.t_tick_2 = 0;
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
         if(this.MINIGAME_OVER)
         {
            if(PROGRESSION == 0)
            {
               level.rightPressed = level.leftPressed = false;
               if(this.hero.getMidXPos() <= 752)
               {
                  level.rightPressed = true;
               }
               else
               {
                  level.leftPressed = true;
               }
               if(Math.abs(this.hero.getMidXPos() - 752) <= 2)
               {
                  level.rightPressed = level.leftPressed = false;
                  this.t_start = this.npc.xPos;
                  this.t_diff = 128;
                  this.t_time = 0.2;
                  this.t_tick = 0;
                  level.hero.xPos = 752 - 8;
                  level.hero.xVel = 0;
                  if(level.hero.DIRECTION == Entity.RIGHT)
                  {
                     level.hero.stateMachine.setState("IS_TURNING_STATE");
                  }
                  counter1 = 0;
                  ++PROGRESSION;
                  SoundSystem.PlaySound("cat_run");
               }
            }
            else if(PROGRESSION == 1)
            {
               this.t_tick += 1 / 60;
               if(this.t_tick >= this.t_time)
               {
                  this.t_tick = this.t_time;
                  counter1 = 0;
                  ++PROGRESSION;
               }
               this.npc.xPos = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
            }
            else if(PROGRESSION == 2)
            {
               counter1 = 0;
               ++PROGRESSION;
               SoundSystem.PlayMusic("outside_sea");
               if(Utils.BEACH_BALL_BOUNCES <= 15)
               {
                  SoundSystem.PlaySound("merchant_voice_1");
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_beach_bad"),this.npc,this.advance);
               }
               else if(Utils.BEACH_BALL_BOUNCES <= 25)
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_beach_normal"),this.npc,this.advance);
               }
               else
               {
                  level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_beach_good"),this.npc,this.advance);
               }
            }
            else if(PROGRESSION == 4)
            {
               stateMachine.performAction("END_ACTION");
               ++PROGRESSION;
            }
         }
         else if(PROGRESSION == 0)
         {
            if(counter1 >= 20)
            {
               counter1 = 0;
               ++PROGRESSION;
               level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_beach_7"),this.npc,this.advance);
            }
         }
         else if(PROGRESSION == 2)
         {
            counter1 = 0;
            ++PROGRESSION;
            level.hud.dialogsManager.createBalloonOn(StringsManager.GetString("npc_beach_8"),this.npc,this.advance);
         }
         else if(PROGRESSION == 4)
         {
            this.t_start = this.npc.xPos;
            this.t_diff = -128;
            this.t_time = 0.2;
            this.t_tick = 0;
            counter1 = 0;
            ++PROGRESSION;
            SoundSystem.PlaySound("whistle");
         }
         else if(PROGRESSION == 5)
         {
            this.t_tick += 1 / 60;
            if(this.t_tick >= this.t_time)
            {
               this.t_tick = this.t_time;
               counter1 = 0;
               ++PROGRESSION;
            }
            this.npc.xPos = Easings.linear(this.t_tick,this.t_start,this.t_diff,this.t_time);
         }
         else if(PROGRESSION == 6)
         {
            this.createBall();
            Level_2_5(level).minigame_counter = 0;
            SoundSystem.PlayMusic("butterflies");
            stateMachine.performAction("END_ACTION");
            ++PROGRESSION;
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
         this.hero = level.hero;
         for(i = 0; i < level.npcsManager.npcs.length; i++)
         {
            if(level.npcsManager.npcs[i] != null)
            {
               if(level.npcsManager.npcs[i] is GenericNPC)
               {
                  this.npc = level.npcsManager.npcs[i];
                  this.npc.IS_TURN_ALLOWED = false;
                  this.npc.DIRECTION = Entity.RIGHT;
               }
            }
         }
         if(this.MINIGAME_OVER)
         {
            SoundSystem.PlaySound("whistle");
            for(i = 0; i < level.bulletsManager.bullets.length; i++)
            {
               if(level.bulletsManager.bullets[i] != null)
               {
                  if(level.bulletsManager.bullets[i].sprite != null)
                  {
                     if(level.bulletsManager.bullets[i].sprite is GenericBulletSprite)
                     {
                        if(level.bulletsManager.bullets[i].ID == GenericBulletSprite.BEACH_BALL)
                        {
                           level.particlesManager.pushParticle(new EnemyHurtParticleSprite(),level.bulletsManager.bullets[i].xPos,level.bulletsManager.bullets[i].yPos,0,0,0);
                           level.bulletsManager.bullets[i].dead = true;
                        }
                     }
                  }
               }
            }
         }
      }
      
      protected function createBall() : void
      {
         level.bulletsManager.pushBullet(new GenericBulletSprite(GenericBulletSprite.BEACH_BALL),level.hero.getMidXPos(),level.hero.getMidYPos() - 48,0,0,0.99);
      }
      
      override public function updateScreenPosition(camera:ScreenCamera) : void
      {
         super.updateScreenPosition(camera);
      }
      
      override protected function execState() : void
      {
      }
      
      override protected function overState() : void
      {
         super.overState();
         if(this.MINIGAME_OVER)
         {
            Utils.Slot.gameVariables[GameSlot.VARIABLE_DOOR] = 7;
            level.CHANGE_ROOM_FLAG = true;
         }
      }
   }
}
