package
{
   import flash.display.Bitmap;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class TextureManager
   {
      
      private static const SpriteSheet:Class = TextureManager_SpriteSheet;
      
      public static const SpriteSheetXML:Class = TextureManager_SpriteSheetXML;
      
      public static var sTextureAtlas:TextureAtlas;
      
      private static const HudSpriteSheet:Class = TextureManager_HudSpriteSheet;
      
      public static const HudSpriteSheetXML:Class = TextureManager_HudSpriteSheetXML;
      
      public static var hudTextureAtlas:TextureAtlas;
      
      private static const FishingSpriteSheet:Class = TextureManager_FishingSpriteSheet;
      
      public static const FishingSpriteSheetXML:Class = TextureManager_FishingSpriteSheetXML;
      
      public static var fishingTextureAtlas:TextureAtlas;
      
      private static const MinigamesSpriteSheet:Class = TextureManager_MinigamesSpriteSheet;
      
      public static const MinigamesSpriteSheetXML:Class = TextureManager_MinigamesSpriteSheetXML;
      
      public static var minigamesTextureAtlas:TextureAtlas;
      
      private static const Gacha1SpriteSheet:Class = TextureManager_Gacha1SpriteSheet;
      
      public static const Gacha1SpriteSheetXML:Class = TextureManager_Gacha1SpriteSheetXML;
      
      public static var gacha1TextureAtlas:TextureAtlas;
      
      private static const Gacha2SpriteSheet:Class = TextureManager_Gacha2SpriteSheet;
      
      public static const Gacha2SpriteSheetXML:Class = TextureManager_Gacha2SpriteSheetXML;
      
      public static var gacha2TextureAtlas:TextureAtlas;
      
      private static const Gacha3SpriteSheet:Class = TextureManager_Gacha3SpriteSheet;
      
      public static const Gacha3SpriteSheetXML:Class = TextureManager_Gacha3SpriteSheetXML;
      
      public static var gacha3TextureAtlas:TextureAtlas;
      
      private static const Gacha4SpriteSheet:Class = TextureManager_Gacha4SpriteSheet;
      
      public static const Gacha4SpriteSheetXML:Class = TextureManager_Gacha4SpriteSheetXML;
      
      public static var gacha4TextureAtlas:TextureAtlas;
      
      private static const Gacha5SpriteSheet:Class = TextureManager_Gacha5SpriteSheet;
      
      public static const Gacha5SpriteSheetXML:Class = TextureManager_Gacha5SpriteSheetXML;
      
      public static var gacha5TextureAtlas:TextureAtlas;
      
      private static const Group1Sheet:Class = TextureManager_Group1Sheet;
      
      public static const Group1XML:Class = TextureManager_Group1XML;
      
      public static var group1TextureAtlas:TextureAtlas;
      
      private static const IntroSpriteSheet:Class = TextureManager_IntroSpriteSheet;
      
      public static const IntroSpriteSheetXML:Class = TextureManager_IntroSpriteSheetXML;
      
      public static var introTextureAtlas:TextureAtlas;
      
      private static const Intro2SpriteSheet:Class = TextureManager_Intro2SpriteSheet;
      
      public static const Intro2SpriteSheetXML:Class = TextureManager_Intro2SpriteSheetXML;
      
      public static var intro2TextureAtlas:TextureAtlas;
      
      private static const Map1Sheet:Class = TextureManager_Map1Sheet;
      
      public static const Map1XML:Class = TextureManager_Map1XML;
      
      public static var map1TextureAtlas:TextureAtlas;
       
      
      public function TextureManager()
      {
         super();
      }
      
      public static function Init() : void
      {
         var bitmap:Bitmap = null;
         var texture:Texture = null;
         var xml:XML = null;
         gacha1TextureAtlas = null;
         bitmap = new SpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new SpriteSheetXML());
         sTextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new FishingSpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new FishingSpriteSheetXML());
         fishingTextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new MinigamesSpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new MinigamesSpriteSheetXML());
         minigamesTextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new HudSpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new HudSpriteSheetXML());
         hudTextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new IntroSpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new IntroSpriteSheetXML());
         introTextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new Intro2SpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new Intro2SpriteSheetXML());
         intro2TextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new Map1Sheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new Map1XML());
         map1TextureAtlas = new TextureAtlas(texture,xml);
      }
      
      public static function LoadGachaTextures() : void
      {
         var bitmap:Bitmap = null;
         var texture:Texture = null;
         var xml:XML = null;
         if(gacha1TextureAtlas != null)
         {
            return;
         }
         bitmap = new Gacha1SpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new Gacha1SpriteSheetXML());
         gacha1TextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new Gacha2SpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new Gacha2SpriteSheetXML());
         gacha2TextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new Gacha3SpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new Gacha3SpriteSheetXML());
         gacha3TextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new Gacha4SpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new Gacha4SpriteSheetXML());
         gacha4TextureAtlas = new TextureAtlas(texture,xml);
         bitmap = new Gacha5SpriteSheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new Gacha5SpriteSheetXML());
         gacha5TextureAtlas = new TextureAtlas(texture,xml);
      }
      
      public static function GetBackgroundTexture() : TextureAtlas
      {
         if(group1TextureAtlas != null)
         {
            return group1TextureAtlas;
         }
         return null;
      }
      
      public static function LoadTexture() : void
      {
         var bitmap:Bitmap = null;
         var texture:Texture = null;
         var xml:XML = null;
         bitmap = new Group1Sheet();
         texture = Texture.fromBitmap(bitmap);
         xml = new XML(new Group1XML());
         group1TextureAtlas = new TextureAtlas(texture,xml);
      }
      
      public static function UnloadTexture() : void
      {
         if(group1TextureAtlas != null)
         {
            group1TextureAtlas.dispose();
            group1TextureAtlas = null;
         }
      }
      
      public static function LoadIntroTexture() : void
      {
         var bitmap:Bitmap = null;
         var texture:Texture = null;
         var xml:XML = null;
         if(introTextureAtlas == null)
         {
            bitmap = new IntroSpriteSheet();
            texture = Texture.fromBitmap(bitmap);
            xml = new XML(new IntroSpriteSheetXML());
            introTextureAtlas = new TextureAtlas(texture,xml);
         }
         if(intro2TextureAtlas == null)
         {
            bitmap = new Intro2SpriteSheet();
            texture = Texture.fromBitmap(bitmap);
            xml = new XML(new Intro2SpriteSheetXML());
            intro2TextureAtlas = new TextureAtlas(texture,xml);
         }
      }
      
      public static function UnloadIntroTexture() : void
      {
         if(introTextureAtlas != null)
         {
            introTextureAtlas.dispose();
            introTextureAtlas = null;
         }
         if(intro2TextureAtlas != null)
         {
            intro2TextureAtlas.dispose();
            intro2TextureAtlas = null;
         }
      }
      
      public static function Save() : void
      {
      }
   }
}
