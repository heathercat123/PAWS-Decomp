package com.distriqt.extension.gameservices
{
   import com.distriqt.extension.gameservices.accesspoint.AccessPoint;
   import com.distriqt.extension.gameservices.achievements.Achievements;
   import com.distriqt.extension.gameservices.auth.AuthUtil;
   import com.distriqt.extension.gameservices.leaderboards.Leaderboards;
   import com.distriqt.extension.gameservices.players.Players;
   import com.distriqt.extension.gameservices.quests.Quests;
   import com.distriqt.extension.gameservices.recording.ScreenRecording;
   import com.distriqt.extension.gameservices.savedgames.SavedGames;
   import com.distriqt.extension.gameservices.turnbasedmultiplayer.TurnBasedMultiplayer;
   import flash.events.EventDispatcher;
   
   public final class GameServices extends EventDispatcher
   {
      
      public static const EXT_CONTEXT_ID:String = "com.distriqt.GameServices";
      
      private static const EXT_ID_NUMBER:int = 38;
      
      public static const VERSION:String = "8.1.1";
      
      private static const VERSION_DEFAULT:String = "0";
      
      private static const IMPLEMENTATION_DEFAULT:String = "unknown";
      
      private static const ERROR_CREATION:String = "The native extension context could not be created";
      
      private static const ERROR_SINGLETON:String = "The singleton has already been created. Use GameServices.service to access the functionality";
      
      private static var _instance:GameServices;
      
      private static var _shouldCreateInstance:Boolean = false;
       
      
      protected var _extensionId:String = "";
      
      protected var _extensionIdNumber:int = -1;
      
      private var _registered:Boolean = false;
      
      private var _leaderboards:Leaderboards;
      
      private var _achievements:Achievements;
      
      private var _savedGames:SavedGames;
      
      private var _turnBasedMultiplayer:TurnBasedMultiplayer;
      
      private var _players:Players;
      
      private var _authUtil:AuthUtil;
      
      private var _quests:Quests;
      
      private var _recording:ScreenRecording;
      
      private var _accessPoint:AccessPoint;
      
      public function GameServices()
      {
         super();
         if(_shouldCreateInstance)
         {
            try
            {
               _extensionId = "com.distriqt.GameServices";
               _extensionIdNumber = 38;
               _leaderboards = new _LeaderboardsImpl();
               _achievements = new _AchievementsImpl();
               _savedGames = new _SavedGamesImpl();
               _turnBasedMultiplayer = new _TurnBasedMultiplayerImpl();
            }
            catch(e:Error)
            {
               throw new Error("The native extension context could not be created");
            }
            return;
         }
         throw new Error("The singleton has already been created. Use GameServices.service to access the functionality");
      }
      
      public static function get service() : GameServices
      {
         createInstance();
         return _instance;
      }
      
      private static function createInstance() : void
      {
         if(_instance == null)
         {
            _shouldCreateInstance = true;
            _instance = new GameServices();
            _shouldCreateInstance = false;
         }
      }
      
      [Deprecated(message="You no longer need to use an application key")]
      public static function init(param1:String = "") : void
      {
         createInstance();
      }
      
      public static function get isSupported() : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
         if(_leaderboards)
         {
            _LeaderboardsImpl(_leaderboards).dispose();
            _leaderboards = null;
         }
         if(_achievements)
         {
            _AchievementsImpl(_achievements).dispose();
            _achievements = null;
         }
         if(_savedGames)
         {
            _SavedGamesImpl(_savedGames).dispose();
            _savedGames = null;
         }
         if(_turnBasedMultiplayer)
         {
            _TurnBasedMatchImpl(_turnBasedMultiplayer).dispose();
            _turnBasedMultiplayer = null;
         }
         if(_authUtil)
         {
            _AuthUtilImpl(_authUtil).dispose();
            _authUtil = null;
         }
         if(_quests)
         {
            _QuestsImpl(_quests).dispose();
            _quests = null;
         }
         if(_recording)
         {
            _ScreenRecordingImpl(_recording).dispose();
            _recording = null;
         }
         _instance = null;
      }
      
      public function get version() : String
      {
         return "8.1.1";
      }
      
      public function get nativeVersion() : String
      {
         return "0";
      }
      
      public function get implementation() : String
      {
         return "default";
      }
      
      public function isServiceSupported(param1:String) : Boolean
      {
         return false;
      }
      
      public function initialiseService(param1:Service) : Boolean
      {
         return false;
      }
      
      public function isSignedIn() : Boolean
      {
         return false;
      }
      
      public function signIn(param1:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function signOut() : Boolean
      {
         return false;
      }
      
      public function disconnect() : Boolean
      {
         return false;
      }
      
      public function getPlayer() : Player
      {
         return null;
      }
      
      public function loadPlayer() : Boolean
      {
         return false;
      }
      
      public function loadPlayerIcon(param1:Player) : Boolean
      {
         return false;
      }
      
      public function showUI(param1:String = "default") : Boolean
      {
         return false;
      }
      
      public function get players() : Players
      {
         if(_players == null)
         {
            _players = new _PlayersImpl();
         }
         return _players;
      }
      
      public function register() : Boolean
      {
         return false;
      }
      
      public function loadInvites() : void
      {
      }
      
      public function get leaderboards() : Leaderboards
      {
         return _leaderboards;
      }
      
      public function get achievements() : Achievements
      {
         return _achievements;
      }
      
      public function get savedGames() : SavedGames
      {
         return _savedGames;
      }
      
      public function get turnBasedMultiplayer() : TurnBasedMultiplayer
      {
         return _turnBasedMultiplayer;
      }
      
      public function get authUtil() : AuthUtil
      {
         if(_authUtil == null)
         {
            _authUtil = new _AuthUtilImpl();
         }
         return _authUtil;
      }
      
      public function get quests() : Quests
      {
         if(_quests == null)
         {
            _quests = new _QuestsImpl();
         }
         return _quests;
      }
      
      public function get recording() : ScreenRecording
      {
         if(_recording == null)
         {
            _recording = new _ScreenRecordingImpl();
         }
         return _recording;
      }
      
      public function get accessPoint() : AccessPoint
      {
         if(_accessPoint == null)
         {
            _accessPoint = new _AccessPointImpl();
         }
         return _accessPoint;
      }
   }
}
