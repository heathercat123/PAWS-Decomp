package
{
   import flash.display.Bitmap;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class TextureManager
   {
      
      public static var sTextureAtlas:TextureAtlas;
      
      public static var hudTextureAtlas:TextureAtlas;
      
      public static var fishingTextureAtlas:TextureAtlas;
      
      public static var minigamesTextureAtlas:TextureAtlas;
      
      public static var gacha1TextureAtlas:TextureAtlas;
      
      public static var gacha2TextureAtlas:TextureAtlas;
      
      public static var gacha3TextureAtlas:TextureAtlas;
      
      public static var gacha4TextureAtlas:TextureAtlas;
      
      public static var gacha5TextureAtlas:TextureAtlas;
      
      public static var group1TextureAtlas:TextureAtlas;
      
      public static var introTextureAtlas:TextureAtlas;
      
      public static var intro2TextureAtlas:TextureAtlas;
      
      public static var map1TextureAtlas:TextureAtlas;
      
	  [Embed(source="../gfx/textures/entities.png")]
      private static const SpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/entities.xml", mimeType="application/octet-stream")]
      public static const SpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/hud_texture.png")]
      private static const HudSpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/hud_texture.xml", mimeType="application/octet-stream")]
      public static const HudSpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/fishing.png")]
      private static const FishingSpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/fishing.xml", mimeType="application/octet-stream")]
      public static const FishingSpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/minigames.png")]
      private static const MinigamesSpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/minigames.xml", mimeType="application/octet-stream")]
      public static const MinigamesSpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/gacha1_texture.png")]
      private static const Gacha1SpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/gacha1_texture.xml", mimeType="application/octet-stream")]
      public static const Gacha1SpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/gacha2_texture.png")]
      private static const Gacha2SpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/gacha2_texture.xml", mimeType="application/octet-stream")]
      public static const Gacha2SpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/gacha3_texture.png")]
      private static const Gacha3SpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/gacha3_texture.xml", mimeType="application/octet-stream")]
      public static const Gacha3SpriteSheetXML:Class ;
      
	  [Embed(source="../gfx/textures/gacha4_texture.png")]
      private static const Gacha4SpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/gacha4_texture.xml", mimeType="application/octet-stream")]
      public static const Gacha4SpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/gacha5_texture.png")]
      private static const Gacha5SpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/gacha5_texture.xml", mimeType="application/octet-stream")]
      public static const Gacha5SpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/group_1.png")]
      private static const Group1Sheet:Class;
      
	  [Embed(source="../gfx/textures/group_1.xml", mimeType="application/octet-stream")]
      public static const Group1XML:Class;
      
	  [Embed(source="../gfx/textures/intro_texture.png")]
      private static const IntroSpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/intro_texture.xml", mimeType="application/octet-stream")]
      public static const IntroSpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/intro_texture_2.png")]
      private static const Intro2SpriteSheet:Class;
      
	  [Embed(source="../gfx/textures/intro_texture_2.xml", mimeType="application/octet-stream")]
      public static const Intro2SpriteSheetXML:Class;
      
	  [Embed(source="../gfx/textures/map_texture.png")]
      private static const Map1Sheet:Class;
      
	  [Embed(source="../gfx/textures/map_texture.xml", mimeType="application/octet-stream")]
      public static const Map1XML:Class;
      
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

