package levels.collisions
{
   import levels.GenericScript;
   import levels.Level;
   import levels.cameras.*;
   
   public class CollisionsManager
   {
      
      public static var start_index:int = 0;
       
      
      public var level:Level;
      
      public var collisions:Array;
      
      public var teleportBlockFrameCounter:int;
      
      public var teleportBlockFrame:int;
      
      public var disappearCounter:int;
      
      public var visibleState:Boolean;
      
      public var highlightDelayCounter:int;
      
      public var lastHighlightIndex:int;
      
      protected var DOOR_UNLOCKED:Boolean;
      
      protected var PLATFORMS_CHECK:Boolean;
      
      public var IS_HERO_INSIDE_HIDDEN_AREA:Boolean;
      
      public function CollisionsManager(_level:Level)
      {
         var i:int = 0;
         var collision:Collision = null;
         var gScript:GenericScript = null;
         super();
         this.level = _level;
         this.highlightDelayCounter = 60 + Math.random() * 60;
         this.lastHighlightIndex = -1;
         this.DOOR_UNLOCKED = false;
         this.PLATFORMS_CHECK = false;
         this.IS_HERO_INSIDE_HIDDEN_AREA = false;
         this.disappearCounter = 0;
         this.visibleState = true;
         this.collisions = new Array();
         start_index = Utils.CurrentSubLevel * Utils.ITEMS_PER_LEVEL;
         for(i = 0; i < this.level.scriptsManager.levelCollisions.length; i++)
         {
            gScript = this.level.scriptsManager.levelCollisions[i];
            if(gScript.type == 0)
            {
               collision = new CollisionAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 1)
            {
               collision = new CloudAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 4)
            {
               collision = new CloudLeftSlopeAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 5)
            {
               collision = new CloudRightSlopeAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 6)
            {
               collision = new CloudLeftSlopeWideAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 7)
            {
               collision = new CloudRightSlopeWideAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 8)
            {
               collision = new TutorialCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 9)
            {
               collision = new CheckeredSpotCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 10)
            {
               collision = new TopCollisionAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 11)
            {
               collision = new SmallBrickCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.ai,gScript.value1 > 0 ? true : false);
            }
            else if(gScript.type == 12)
            {
               collision = new CatSpotCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 13)
            {
               collision = new FenceExitCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai,gScript.value1,gScript.value2);
            }
            else if(gScript.type == 14)
            {
               collision = new DoorExitCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 15)
            {
               collision = new CircularEngineCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 16)
            {
               collision = new WaterCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 17)
            {
               collision = new FullAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 18)
            {
               collision = new YellowPlatformCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 19)
            {
               collision = new BluePlatformCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 20)
            {
               collision = new WaterStreamCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 21)
            {
               collision = new WaterVerticalStreamCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 22)
            {
               collision = new FireCircleCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 23)
            {
               collision = new LeverCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 24)
            {
               collision = new GateCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 25)
            {
               collision = new TimedLeverCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 27)
            {
               collision = new BigLeverCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 28)
            {
               collision = new BigGateCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 29)
            {
               collision = new IceAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 30)
            {
               collision = new AirCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 31)
            {
               collision = new BigIcycleCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 32)
            {
               collision = new SmallCollisionAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 33)
            {
               collision = new BigIceBlockCollision(this.level,gScript.x,gScript.y,0);
            }
            else if(gScript.type == 34)
            {
               collision = new SmallIceBlockCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 35)
            {
               collision = new FloatingIceCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 36)
            {
               collision = new LavaCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 37)
            {
               collision = new HotBrickCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 38)
            {
               collision = new GeiserRockCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 39)
            {
               collision = new RedPlatformCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 40)
            {
               collision = new CoinsCircleCollision(this.level,gScript.x,gScript.y,gScript.width * 0.5,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 41)
            {
               collision = new WallCannonCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 42)
            {
               collision = new MudAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 43)
            {
               collision = new BigRockIcicleCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 44)
            {
               collision = new FooCollisionAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 45)
            {
               collision = new MisteryCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 46)
            {
               collision = new PotCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 47)
            {
               collision = new CollisionNoClimbAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 48)
            {
               collision = new BirdCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 49)
            {
               collision = new RopeAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 51)
            {
               collision = new GiantFishCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 55)
            {
               collision = new AlarmCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 56)
            {
               collision = new PlatformCollisionArea(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 57)
            {
               collision = new FloatingLogCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 58)
            {
               collision = new WaterfallCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 59)
            {
               collision = new CutsceneYellowPlatformCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 60)
            {
               collision = new BoulderCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 61)
            {
               collision = new ConvoyBeltCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 62)
            {
               collision = new FlameThrowerCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 63)
            {
               collision = new CoconutCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 64)
            {
               collision = new SandfallCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 65)
            {
               collision = new SteamCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.value1);
            }
            else if(gScript.type == 66)
            {
               collision = new CritterCollision(this.level,CritterCollision.MOUSE_1,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 67)
            {
               collision = new CrusherCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.value1,gScript.value2);
            }
            else if(gScript.type == 68)
            {
               collision = new MushroomCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 69)
            {
               collision = new ClodCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,start_index);
               if(Utils.LEVEL_COLLISION_ITEMS[start_index] == true)
               {
                  ClodCollision(collision).stateMachine.setState("IS_DUG_STATE");
               }
               ++start_index;
            }
            else if(gScript.type == 70)
            {
               collision = new CemeterySkullCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 71)
            {
               collision = new CloudLeftIceSlopeWideAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 72)
            {
               collision = new CloudRightIceSlopeWideAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 73)
            {
               collision = new CloudLeftIceSlopeAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 74)
            {
               collision = new CloudRightIceSlopeAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 75)
            {
               collision = new CannonCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.ai);
            }
            else if(gScript.type == 76)
            {
               collision = new CannonHeroCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.ai);
            }
            else if(gScript.type == 77)
            {
               collision = new IceSculptCollision(this.level,gScript.x,gScript.y);
            }
            else if(gScript.type == 78)
            {
               collision = new TreadmillCollision(this.level,gScript.x,gScript.y,gScript.width);
            }
            else if(gScript.type == 79)
            {
               collision = new WoodGateCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation,gScript.ai);
            }
            else if(gScript.type == 80)
            {
               collision = new SpinningSpikesCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 81)
            {
               collision = new NoRunAreaCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 82)
            {
               collision = new PinkBlockCollision(this.level,gScript.x,gScript.y,0,gScript.width);
            }
            else if(gScript.type == 83)
            {
               collision = new TruckCollision(this.level,gScript.x,gScript.y,gScript.width,TruckCollision.TRUCK_TYPE_RED,false);
            }
            else if(gScript.type == 84)
            {
               collision = new YellowVerticalPlatformCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 85)
            {
               collision = new WoodPlatformCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 86)
            {
               collision = new CritterCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 87)
            {
               collision = new SpawnerCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height,gScript.rotation);
            }
            else if(gScript.type == 88)
            {
               collision = new BucketCollision(this.level,gScript.x,gScript.y,start_index,gScript.height);
               if(gScript.height == 0)
               {
                  if(Utils.LEVEL_COLLISION_ITEMS[start_index] == true)
                  {
                     BucketCollision(collision).setHit();
                  }
                  ++start_index;
               }
            }
            else if(gScript.type == 89)
            {
               collision = new BigIceBlockCollision(this.level,gScript.x,gScript.y,gScript.width,1,gScript.rotation);
            }
            else if(gScript.type == 89)
            {
               collision = new BigIceBlockCollision(this.level,gScript.x,gScript.y,gScript.width,1,gScript.rotation);
            }
            else if(gScript.type == 90)
            {
               collision = new ArcadeCabinetCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            else if(gScript.type == 91)
            {
               collision = new GenericCollision(this.level,gScript.x,gScript.y,gScript.width,gScript.height);
            }
            this.collisions.push(collision);
         }
      }
      
      public function postInit() : void
      {
         var i:int = 0;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               this.collisions[i].postInit();
            }
         }
      }
      
      public function levelStart() : void
      {
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               this.collisions[i].destroy();
               this.collisions[i] = null;
            }
         }
         this.collisions = null;
         this.level = null;
      }
      
      public function update() : void
      {
         var i:int = 0;
         this.PLATFORMS_CHECK = false;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               if(this.collisions[i].active)
               {
                  this.collisions[i].update();
                  this.collisions[i].checkEntitiesCollision();
                  if(this.collisions[i].dead)
                  {
                     this.collisions[i].destroy();
                     this.collisions[i] = null;
                  }
               }
            }
         }
         ++this.disappearCounter;
         if(this.disappearCounter > 2)
         {
            this.disappearCounter = 0;
            this.visibleState = !this.visibleState;
         }
         var hidden_area_index:int = -1;
         for(i = 0; i < this.level.scriptsManager.hiddenAreas.length; i++)
         {
            if(this.level.scriptsManager.hiddenAreas[i].contains(this.level.hero.getMidXPos(),this.level.hero.getMidYPos()))
            {
               hidden_area_index = i;
            }
         }
         if(hidden_area_index > -1)
         {
            this.IS_HERO_INSIDE_HIDDEN_AREA = true;
         }
         else
         {
            this.IS_HERO_INSIDE_HIDDEN_AREA = false;
         }
      }
      
      public function postUpdate() : void
      {
         var i:int = 0;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               if(this.collisions[i].active)
               {
                  this.collisions[i].checkPostUpdateEntitiesCollision();
                  if(this.collisions[i].dead)
                  {
                     this.collisions[i].destroy();
                     this.collisions[i] = null;
                  }
               }
            }
         }
      }
      
      public function createHoneyCollision(_xPos:Number, _yPos:Number) : void
      {
         var i:int = 0;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               if(this.collisions[i] is HoneyCollision)
               {
                  diff_x = Math.abs(this.collisions[i].xPos - _xPos);
                  diff_y = Math.abs(this.collisions[i].yPos - _yPos);
                  if(Math.sqrt(diff_x * diff_x + diff_y * diff_y) < 16)
                  {
                     return;
                  }
               }
            }
         }
         var honey:HoneyCollision = new HoneyCollision(this.level,_xPos,_yPos);
         this.collisions.push(honey);
      }
      
      public function destroyHoney(_mid_xPos:Number, _mid_yPos:Number) : void
      {
         var i:int = 0;
         var diff_x:Number = NaN;
         var diff_y:Number = NaN;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               if(this.collisions[i] is HoneyCollision)
               {
                  diff_x = Math.abs(this.collisions[i].xPos - _mid_xPos);
                  diff_y = Math.abs(this.collisions[i].yPos - _mid_yPos);
                  if(Math.sqrt(diff_x * diff_x + diff_y * diff_y) < 24)
                  {
                     this.collisions[i].dead = true;
                     this.level.particlesManager.createDewDroplets(this.collisions[i].xPos + 8,this.collisions[i].yPos,2);
                     return;
                  }
               }
            }
         }
      }
      
      public function setLavaOnTop() : void
      {
         var i:int = 0;
         var lava:LavaCollision = null;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               if(this.collisions[i] is LavaCollision)
               {
                  lava = this.collisions[i] as LavaCollision;
                  lava.setOnTop();
               }
            }
         }
      }
      
      public function checkHeroPlatformsCollision() : void
      {
         var i:int = 0;
         if(this.PLATFORMS_CHECK)
         {
            return;
         }
         this.PLATFORMS_CHECK = true;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               if(this.collisions[i].active)
               {
                  if(this.collisions[i] is BluePlatformCollision || this.collisions[i] is YellowPlatformCollision)
                  {
                     this.collisions[i].checkEntitiesCollision();
                  }
               }
            }
         }
      }
      
      public function shake() : void
      {
         var i:int = 0;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               this.collisions[i].shake();
            }
         }
      }
      
      public function updateScreenPositions(camera:ScreenCamera) : void
      {
         var i:int = 0;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               this.collisions[i].updateScreenPosition(camera);
            }
         }
      }
      
      public function openGate(id:int) : void
      {
         var i:int = 0;
         var gCollision:GateCollision = null;
         var gCollision2:BigGateCollision = null;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               if(this.collisions[i] is GateCollision)
               {
                  gCollision = this.collisions[i] as GateCollision;
                  if(gCollision.ID == id)
                  {
                     gCollision.openDoor();
                  }
               }
               else if(this.collisions[i] is BigGateCollision)
               {
                  gCollision2 = this.collisions[i] as BigGateCollision;
                  if(gCollision2.ID == id)
                  {
                     gCollision2.openDoor();
                  }
               }
            }
         }
      }
      
      public function closeGate(id:int) : void
      {
         var i:int = 0;
         var gCollision:GateCollision = null;
         var gCollision2:BigGateCollision = null;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               if(this.collisions[i] is GateCollision)
               {
                  gCollision = this.collisions[i] as GateCollision;
                  if(gCollision.ID == id)
                  {
                     gCollision.closeDoor();
                  }
               }
               else if(this.collisions[i] is BigGateCollision)
               {
                  gCollision2 = this.collisions[i] as BigGateCollision;
                  if(gCollision2.ID == id)
                  {
                     gCollision2.closeDoor();
                  }
               }
            }
         }
      }
      
      public function lockLevers(id:int) : void
      {
         var i:int = 0;
         var gCollision:TimedLeverCollision = null;
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               if(this.collisions[i] is TimedLeverCollision)
               {
                  gCollision = this.collisions[i] as TimedLeverCollision;
                  if(gCollision.ID == id)
                  {
                     gCollision.lockLever();
                  }
               }
            }
         }
      }
   }
}
