package entities.enemies
{
   import entities.Hero;
   import game_utils.QuestsManager;
   import levels.GenericScript;
   import levels.Level;
   import levels.cameras.*;
   
   public class EnemiesManager
   {
      
      public static var STATUS_1:Boolean;
      
      public static var STATUS_2:Boolean;
       
      
      public var level:Level;
      
      public var enemies:Array;
      
      protected var counter_status_1:int;
      
      protected var counter_status_2:int;
      
      public function EnemiesManager(_level:Level)
      {
         var gScript:GenericScript = null;
         var i:int = 0;
         super();
         this.level = _level;
         STATUS_1 = false;
         STATUS_2 = true;
         this.counter_status_1 = 0;
         this.counter_status_2 = 0;
         this.enemies = new Array();
         for(i = 0; i < this.level.scriptsManager.levelEnemies.length; i++)
         {
            gScript = this.level.scriptsManager.levelEnemies[i];
            this.enemies.push(this.createEnemy(gScript));
         }
      }
      
      public function createEnemy(gScript:GenericScript) : Enemy
      {
         var enemy:Enemy = null;
         if(gScript.type == 0)
         {
            enemy = new YellowSlimeEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai);
         }
         else if(gScript.type == 1)
         {
            enemy = new SmallPollenEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 2)
         {
            enemy = new WoodBeetleEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.ai,gScript.value1);
         }
         else if(gScript.type == 3)
         {
            enemy = new GiantWoodBeetleEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.ai);
         }
         else if(gScript.type == 4)
         {
            enemy = new SquidEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 5)
         {
            enemy = new MonkeyRedEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai);
         }
         else if(gScript.type == 6)
         {
            enemy = new SeaFishEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 7)
         {
            enemy = new SeaUrchinEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai);
         }
         else if(gScript.type == 8)
         {
            enemy = new SeaJumperFishEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 9)
         {
            enemy = new MonkeyEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 10)
         {
            enemy = new CanyonMoleEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 11)
         {
            enemy = new BoulderEnemy(this.level,gScript.x,gScript.y,gScript.width);
         }
         else if(gScript.type == 12)
         {
            enemy = new CanyonWalkingMoleEnemy(this.level,gScript.x,gScript.y,gScript.width);
         }
         else if(gScript.type == 13)
         {
            enemy = new BatEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai,gScript.value1);
         }
         else if(gScript.type == 14)
         {
            enemy = new SkullEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 15)
         {
            enemy = new SnowmanEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 16)
         {
            enemy = new MountainGoatEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 18)
         {
            enemy = new FireFlameEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.ai);
         }
         else if(gScript.type == 19)
         {
            enemy = new FlameJumperEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 20)
         {
            enemy = new FirePlantEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 21)
         {
            enemy = new FireLizardEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 22)
         {
            enemy = new SpiderEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai);
         }
         else if(gScript.type == 23)
         {
            enemy = new WaspEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 24)
         {
            enemy = new DarkSlimeEnemy(this.level,gScript.x,gScript.y,gScript.width);
         }
         else if(gScript.type == 25)
         {
            enemy = new DustEnemy(this.level,gScript.x,gScript.y,gScript.width);
         }
         else if(gScript.type == 26)
         {
            enemy = new TinSoldierEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 27)
         {
            enemy = new SpringSoldierEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height,gScript.value1);
         }
         else if(gScript.type == 28)
         {
            enemy = new TurnipEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 29)
         {
            enemy = new TravelerEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 30)
         {
            enemy = new ScarecrowEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 31)
         {
            enemy = new GiantTurnipEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 32)
         {
            enemy = new FrogEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 33)
         {
            enemy = new CrowEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 34)
         {
            enemy = new RiverFishEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai);
         }
         else if(gScript.type == 35)
         {
            enemy = new RedGooEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 36)
         {
            enemy = new TankSoldierEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 37)
         {
            enemy = new GiantTinSoldierEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 38)
         {
            enemy = new SandCastleEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 39)
         {
            enemy = new JellyfishEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.value1,gScript.value2);
         }
         else if(gScript.type == 40)
         {
            enemy = new CrabEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.ai);
         }
         else if(gScript.type == 41)
         {
            enemy = new WallSoldierEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 42)
         {
            enemy = new GiantTankSoldierEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 43)
         {
            enemy = new RaiderEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 44)
         {
            enemy = new SandWormEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 45)
         {
            enemy = new GenieEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
         }
         else if(gScript.type == 47)
         {
            enemy = new RockEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 48)
         {
            enemy = new FireSoldierEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 49)
         {
            enemy = new GhostEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 50)
         {
            enemy = new GiantSnowmanEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 51)
         {
            enemy = new YetiEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai);
         }
         else if(gScript.type == 52)
         {
            enemy = new AnglerFishEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai);
         }
         else if(gScript.type == 53)
         {
            enemy = new CaveBeetleEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.ai);
         }
         else if(gScript.type == 55)
         {
            enemy = new LogTreeEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height);
         }
         else if(gScript.type == 56)
         {
            enemy = new GiantPollenEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.value1);
         }
         else if(gScript.type == 57)
         {
            enemy = new RockMoonEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.ai,gScript.height,gScript.value1);
         }
         else if(gScript.type == 58)
         {
            enemy = new WindEggEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 59)
         {
            enemy = new GiantRockEnemy(this.level,gScript.x,gScript.y,gScript.width,0);
         }
         else if(gScript.type == 60)
         {
            enemy = new GiantLizardEnemy(this.level,gScript.x,gScript.y,gScript.width,0);
         }
         else if(gScript.type == 61)
         {
            enemy = new SeedPollenEnemy(this.level,gScript.x,gScript.y,gScript.width);
         }
         else if(gScript.type == 62)
         {
            enemy = new CactusEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 63)
         {
            enemy = new SandHippoEnemy(this.level,gScript.x,gScript.y,gScript.width);
         }
         else if(gScript.type == 64)
         {
            enemy = new WarlockEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 65)
         {
            enemy = new CloudEnemy(this.level,gScript.x,gScript.y,gScript.width);
         }
         else if(gScript.type == 66)
         {
            enemy = new GiantCrabEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.ai);
         }
         else if(gScript.type == 67)
         {
            enemy = new SeaPufferEnemy(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
         }
         else if(gScript.type == 68)
         {
            enemy = new SeaUrchinEnemy(this.level,gScript.x,gScript.y,0,gScript.width,gScript.height,1,gScript.value1);
         }
         else if(gScript.type == 69)
         {
            enemy = new SeaUrchinEnemy(this.level,gScript.x,gScript.y,0,gScript.width,gScript.height,2,gScript.value1);
         }
         return enemy;
      }
      
      public function postInit() : void
      {
         var i:int = 0;
         for(i = 0; i < this.enemies.length; i++)
         {
            if(this.enemies[i] != null)
            {
               this.enemies[i].postInit();
            }
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.enemies.length; i++)
         {
            if(this.enemies[i] != null)
            {
               this.enemies[i].destroy();
               this.enemies[i] = null;
            }
         }
         this.enemies = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         ++this.counter_status_1;
         if(this.counter_status_1 >= 180)
         {
            this.counter_status_1 = 0;
            STATUS_1 = !STATUS_1;
         }
         for(i = 0; i < this.enemies.length; i++)
         {
            if(this.enemies[i] != null)
            {
               if(this.enemies[i].active)
               {
                  this.enemies[i].update();
                  this.enemies[i].checkHeroCollisionDetection(this.level.hero);
                  if(this.enemies[i].dead)
                  {
                     if(this.enemies[i].stateMachine.lastState == "IS_HIT_STATE")
                     {
                        Utils.QUEST_ENEMY_DEFEATED_FLAG = true;
                        if(this.enemies[i].KILLED_BY_CAT)
                        {
                           QuestsManager.SubmitQuestAction(QuestsManager.ACTION_ANY_ENEMY_DEFEATED_BY_ANY_CAT);
                           if(Hero.GetCurrentCat() == Hero.CAT_ROSE)
                           {
                              QuestsManager.SubmitQuestAction(QuestsManager.ACTION_ANY_ENEMY_DEFEATED_BY_ROSE);
                           }
                           else if(Hero.GetCurrentCat() == Hero.CAT_RIGS)
                           {
                              QuestsManager.SubmitQuestAction(QuestsManager.ACTION_ANY_ENEMY_DEFEATED_BY_RIGS);
                           }
                        }
                     }
                     this.enemies[i].destroy();
                     this.enemies[i] = null;
                  }
               }
            }
         }
      }
      
      public function getEnemiesAlive() : int
      {
         var i:int = 0;
         var amount:int = 0;
         for(i = 0; i < this.enemies.length; i++)
         {
            if(this.enemies[i] != null)
            {
               if(this.enemies[i].active)
               {
                  amount++;
               }
            }
         }
         return amount;
      }
      
      public function shake() : void
      {
         var i:int = 0;
         for(i = 0; i < this.enemies.length; i++)
         {
            if(this.enemies[i] != null)
            {
               if(this.enemies[i].active)
               {
                  this.enemies[i].shake();
               }
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.enemies.length; i++)
         {
            if(this.enemies[i] != null)
            {
               this.enemies[i].updateScreenPosition(camera);
            }
         }
      }
   }
}
