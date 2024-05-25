package game_utils
{
   import com.distriqt.extension.gameservices.GameServices;
   
   public class AchievementsManager
   {
       
      
      public function AchievementsManager()
      {
         super();
      }
      
      public static function SubmitScore(_id:String, score:int) : void
      {
         if(GameServices.service.leaderboards.isSupported)
         {
            if(_id == "fishing")
            {
               GameServices.service.leaderboards.submitScore("CggIy_z-3CUQAhAJ",score);
            }
            else if(_id == "megapang")
            {
               GameServices.service.leaderboards.submitScore("CggIy_z-3CUQAhAK",score);
            }
            else if(_id == "flappybat")
            {
               GameServices.service.leaderboards.submitScore("CggIy_z-3CUQAhAM",score);
            }
         }
      }
      
      public static function SubmitAchievement(_id:String, percentage:Number = 100) : void
      {
         if(GameServices.service.achievements.isSupported)
         {
            if(_id == "sctp_1")
            {
               GameServices.service.achievements.achievementUnlock("CggIy_z-3CUQAhAB");
            }
            else if(_id == "sctp_2")
            {
               GameServices.service.achievements.achievementUnlock("CggIy_z-3CUQAhAC");
            }
            else if(_id == "sctp_3")
            {
               GameServices.service.achievements.achievementUnlock("CggIy_z-3CUQAhAD");
            }
            else if(_id == "sctp_4")
            {
               GameServices.service.achievements.achievementUnlock("CggIy_z-3CUQAhAE");
            }
            else if(_id == "sctp_5")
            {
               GameServices.service.achievements.achievementUnlock("CggIy_z-3CUQAhAF");
            }
            else if(_id == "sctp_6")
            {
               GameServices.service.achievements.achievementUnlock("CggIy_z-3CUQAhAG");
            }
            else if(_id == "sctp_7")
            {
               GameServices.service.achievements.achievementUnlock("CggIy_z-3CUQAhAH");
            }
            else if(_id == "sctp_8")
            {
               GameServices.service.achievements.achievementUnlock("CggIy_z-3CUQAhAI");
            }
            else if(_id == "sctp_9")
            {
               GameServices.service.achievements.achievementUnlock("CggIy_z-3CUQAhAL");
            }
         }
      }
   }
}
