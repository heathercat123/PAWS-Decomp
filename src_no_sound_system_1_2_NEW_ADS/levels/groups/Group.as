package levels.groups
{
   import entities.enemies.*;
   import flash.geom.*;
   import levels.Level;
   import levels.cameras.*;
   import levels.collisions.*;
   
   public class Group
   {
       
      
      public var level:Level;
      
      public var aabb:Rectangle;
      
      public var enemies:Array;
      
      public var collisions:Array;
      
      public var scriptsIndex:Array;
      
      public var IS_ACTIVE:Boolean;
      
      public var TYPE:int;
      
      public function Group(_level:Level, _xPos:Number, _yPos:Number, __width:Number, __height:Number, _type:int = 0)
      {
         super();
         this.level = _level;
         this.aabb = new Rectangle(_xPos,_yPos,__width,__height);
         this.TYPE = _type;
         this.enemies = new Array();
         this.collisions = new Array();
         this.scriptsIndex = new Array();
         this.fetchEnemies();
         this.fetchCollisions();
         this.deactiveAll();
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         for(i = 0; i < this.enemies.length; i++)
         {
            this.enemies[i] = null;
         }
         for(i = 0; i < this.collisions.length; i++)
         {
            this.collisions[i] = null;
         }
         this.scriptsIndex = null;
         this.enemies = null;
         this.collisions = null;
         this.level = null;
         this.aabb = null;
      }
      
      public function update() : void
      {
         var cameraAABB:Rectangle = new Rectangle(this.level.camera.xPos,this.level.camera.yPos,this.level.camera.WIDTH,this.level.camera.HEIGHT);
         if(this.TYPE == 1)
         {
            if(!this.IS_ACTIVE)
            {
               if(cameraAABB.x >= this.aabb.x + this.aabb.width)
               {
                  this.activeAll();
               }
            }
         }
         else if(this.TYPE == 2)
         {
            if(!this.IS_ACTIVE)
            {
               if(cameraAABB.y >= this.aabb.y + this.aabb.height)
               {
                  this.activeAll();
               }
            }
         }
         else if(this.TYPE == 0)
         {
            if(!this.IS_ACTIVE)
            {
               if(cameraAABB.intersects(this.aabb))
               {
                  this.activeAll();
               }
            }
            else if(!cameraAABB.intersects(this.aabb))
            {
               this.resetAll();
               this.IS_ACTIVE = false;
            }
         }
      }
      
      protected function fetchEnemies() : void
      {
         var i:int = 0;
         var point:Point = new Point();
         for(i = 0; i < this.level.enemiesManager.enemies.length; i++)
         {
            point.x = this.level.enemiesManager.enemies[i].xPos;
            point.y = this.level.enemiesManager.enemies[i].yPos;
            if(this.aabb.containsPoint(point))
            {
               this.enemies.push(this.level.enemiesManager.enemies[i]);
               this.scriptsIndex.push(i);
            }
         }
      }
      
      protected function fetchCollisions() : void
      {
         var i:int = 0;
         var point:Point = new Point();
         for(i = 0; i < this.level.collisionsManager.collisions.length; i++)
         {
            point.x = this.level.collisionsManager.collisions[i].xPos;
            point.y = this.level.collisionsManager.collisions[i].yPos;
            if(this.aabb.containsPoint(point))
            {
               this.collisions.push(this.level.collisionsManager.collisions[i]);
            }
         }
      }
      
      protected function resetAll() : void
      {
         var i:int = 0;
         var enemy:Enemy = null;
         for(i = 0; i < this.enemies.length; i++)
         {
            if(this.enemies[i] != null)
            {
               if(this.enemies[i].isDead())
               {
                  if(this.enemies[i] is MonkeyRedEnemy)
                  {
                     this.enemies[i].reset();
                     this.enemies[i].deactivate();
                  }
                  else
                  {
                     enemy = this.level.enemiesManager.createEnemy(this.level.scriptsManager.levelEnemies[this.scriptsIndex[i]]);
                     this.enemies[i] = enemy;
                     this.enemies[i].deactivate();
                     this.level.enemiesManager.enemies.push(enemy);
                  }
               }
               else if(this.enemies[i].isInsideScreen() == false)
               {
                  this.enemies[i].reset();
                  this.enemies[i].deactivate();
               }
            }
         }
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               this.collisions[i].reset();
               this.collisions[i].deactivate();
            }
         }
      }
      
      protected function deactiveAll() : void
      {
         var i:int = 0;
         for(i = 0; i < this.enemies.length; i++)
         {
            if(this.enemies[i] != null)
            {
               this.enemies[i].deactivate();
            }
         }
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               this.collisions[i].deactivate();
            }
         }
         this.IS_ACTIVE = false;
      }
      
      protected function activeAll() : void
      {
         var i:int = 0;
         for(i = 0; i < this.enemies.length; i++)
         {
            if(this.enemies[i] != null)
            {
               this.enemies[i].activate();
            }
         }
         for(i = 0; i < this.collisions.length; i++)
         {
            if(this.collisions[i] != null)
            {
               this.collisions[i].activate();
            }
         }
         this.IS_ACTIVE = true;
      }
   }
}
