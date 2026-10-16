class Font extends Object
    native
    hidecategories(Object);

const NULLCHARACTER = 127;

struct native atomic immutable FontCharacter
{
    var() int StartU;
    var() int StartV;
    var() int USize;
    var() int VSize;
    var() byte TextureIndex;
    var() int VerticalOffset;

    structdefaultproperties
    {
        StartU=0
        StartV=0
        USize=0
        VSize=0
        TextureIndex=0
        VerticalOffset=0
    }
};

var() editinline array<editinline FontCharacter> Characters;
var array<Texture2D> Textures;
var private native const map{VOID,VOID} CharRemap;
var int IsRemapped;
var() float EmScale;
var() float Ascent;
var() float Descent;
var() float Leading;
var() int Kerning;
var() FontImportOptionsData ImportOptions;
var transient int NumCharacters;
var transient array<int> MaxCharHeight;
var() const float ScalingFactor;

// Export UFont::execGetResolutionPageIndex(FFrame&, void* const)
native function int GetResolutionPageIndex(float HeightTest);

// Export UFont::execGetScalingFactor(FFrame&, void* const)
native function float GetScalingFactor(float HeightTest);

// Export UFont::execGetAuthoredViewportHeight(FFrame&, void* const)
native final function float GetAuthoredViewportHeight(float ViewportHeight);

// Export UFont::execGetMaxCharHeight(FFrame&, void* const)
native function float GetMaxCharHeight();

// Export UFont::execGetStringHeightAndWidth(FFrame&, void* const)
native function GetStringHeightAndWidth(const out string InString, out int Height, out int Width);

defaultproperties
{
    ImportOptions=(FontName="Arial",Height=16.0000000,bEnableAntialiasing=true,bEnableBold=false,bEnableItalic=false,bEnableUnderline=false,bAlphaOnly=false,CharacterSet=EFontImportCharacterSet.FontICS_Default,Chars="",UnicodeRange="",CharsFilePath="",CharsFileWildcard="",bCreatePrintableOnly=false,bIncludeASCIIRange=true,ForegroundColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000),bEnableDropShadow=false,TexturePageWidth=256,TexturePageMaxHeight=256,XPadding=1,YPadding=1,ExtendBoxTop=0,ExtendBoxBottom=0,ExtendBoxRight=0,ExtendBoxLeft=0,bEnableLegacyMode=false,Kerning=0,bUseDistanceFieldAlpha=false,DistanceFieldScaleFactor=16,DistanceFieldScanRadiusScale=1.0000000)
    ScalingFactor=1.0000000
}