package levels.collisions
{
   import flash.geom.Rectangle;
   import game_utils.LevelItems;
   import levels.Level;
   import levels.cameras.*;
   
   public class MisteryCollision extends Collision
   {
       
      
      public var index:int;
      
      public var conditionReached:Boolean;
      
      public function MisteryCollision(_level:Level, _xPos:Number, _yPos:Number, _width:Number, _height:Number)
      {
         super(_level,_xPos,_yPos);
         WIDTH = _width;
         HEIGHT = _width;
         RADIUS = WIDTH * 0.5;
         this.index = _height;
         this.conditionReached = false;
      }
      
      override public function update() : void
      {
      }
      
      public function isConditionReached() : Boolean
      {
         var bricks:int = 0;
         var area:Rectangle = null;
         if(this.index == 0)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 1)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            bricks = this.getBricksAmount(new Rectangle(464,160,128,128));
            if(bricks == 0)
            {
               return true;
            }
            return false;
         }
         if(this.index == 2)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            if(level.hero.getAABB().contains(xPos,yPos))
            {
               this.conditionReached = true;
            }
            return this.conditionReached;
         }
         if(this.index == 3)
         {
            if((Utils.PlayerItems >> 2 & 1) == 1 || LevelItems.HasLevelItemBeenGot(2))
            {
               return true;
            }
            return false;
         }
         if(this.index == 4)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 5)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            return false;
         }
         if(this.index == 6)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 7)
         {
            if((Utils.PlayerItems >> 2 & 1) == 1 || LevelItems.HasLevelItemBeenGot(2))
            {
               return true;
            }
            return false;
         }
         if(this.index == 8)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            return false;
         }
         if(this.index == 9)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 10)
         {
            area = new Rectangle(1168,48,240,64);
            if(level.hero.getAABB().intersects(area))
            {
               this.conditionReached = true;
            }
            return this.conditionReached;
         }
         if(this.index == 11)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 12)
         {
            area = new Rectangle(2192,400,192,176);
            if(level.hero.getAABB().intersects(area))
            {
               this.conditionReached = true;
            }
            return this.conditionReached;
         }
         if(this.index == 13)
         {
            if((Utils.PlayerItems >> 2 & 1) == 1 || LevelItems.HasLevelItemBeenGot(2))
            {
               return true;
            }
            return false;
         }
         if(this.index == 14)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            return false;
         }
         if(this.index == 15)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            return false;
         }
         if(this.index == 16)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 17)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 18)
         {
            if(Utils.Slot.doorUnlocked[4])
            {
               return true;
            }
            return false;
         }
         if(this.index == 19)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 20)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 21)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            return false;
         }
         if(this.index == 22)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 23)
         {
            area = new Rectangle(1776,608,144,80);
            if(level.hero.getAABB().intersects(area))
            {
               this.conditionReached = true;
            }
            return this.conditionReached;
         }
         if(this.index == 24)
         {
            area = new Rectangle(1296,168,128,48);
            if(level.hero.getAABB().intersects(area))
            {
               this.conditionReached = true;
            }
            return this.conditionReached;
         }
         if(this.index == 25)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 26)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            return false;
         }
         if(this.index == 27)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 28)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 29)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            return false;
         }
         if(this.index == 30)
         {
            area = new Rectangle(1456,160,112,80);
            if(level.hero.getAABB().intersects(area) || LevelItems.HasItem(LevelItems.ITEM_GLIDE_CAT))
            {
               this.conditionReached = true;
            }
            return this.conditionReached;
         }
         if(this.index == 31)
         {
            area = new Rectangle(752,400,144,64);
            if(level.hero.getAABB().intersects(area))
            {
               this.conditionReached = true;
            }
            return this.conditionReached;
         }
         if(this.index == 32)
         {
            area = new Rectangle(752,368,32,32);
            if(level.hero.getAABB().intersects(area))
            {
               this.conditionReached = true;
            }
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return this.conditionReached;
         }
         if(this.index == 33)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            return false;
         }
         if(this.index == 34)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 35)
         {
            if((Utils.PlayerItems >> 0 & 1) == 1 || LevelItems.HasLevelItemBeenGot(0))
            {
               return true;
            }
            return false;
         }
         if(this.index == 36)
         {
            if((Utils.PlayerItems >> 1 & 1) == 1 || LevelItems.HasLevelItemBeenGot(1))
            {
               return true;
            }
            return false;
         }
         if(this.index == 37)
         {
            area = new Rectangle(1373,188,101,32);
            if(level.hero.getAABB().intersects(area))
            {
               this.conditionReached = true;
            }
            return this.conditionReached;
         }
         return false;
      }
      
      protected function getBricksAmount(area:Rectangle) : int
      {
         var i:int = 0;
         var amount:int = 0;
         for(i = 0; i < level.collisionsManager.collisions.length; i++)
         {
            if(level.collisionsManager.collisions[i] != null)
            {
               if(level.collisionsManager.collisions[i] is SmallBrickCollision)
               {
                  if(area.contains(level.collisionsManager.collisions[i].xPos,level.collisionsManager.collisions[i].yPos))
                  {
                     amount++;
                  }
               }
            }
         }
         return amount;
      }
   }
}
