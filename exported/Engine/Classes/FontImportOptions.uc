class FontImportOptions extends Object
    transient
    native
    hidecategories(Object);

enum EFontImportCharacterSet
{
    FontICS_Default,                // 0
    FontICS_Ansi,                   // 1
    FontICS_Symbol,                 // 2
    FontICS_MAX                     // 3
};

struct native FontImportOptionsData
{
    var() string FontName;
    var() float Height;
    var() bool bEnableAntialiasing;
    var() bool bEnableBold;
    var() bool bEnableItalic;
    var() bool bEnableUnderline;
    var() bool bAlphaOnly;
    var() FontImportOptions.EFontImportCharacterSet CharacterSet;
    var() string Chars;
    var() string UnicodeRange;
    var() string CharsFilePath;
    var() string CharsFileWildcard;
    var() bool bCreatePrintableOnly;
    var() bool bIncludeASCIIRange;
    var() LinearColor ForegroundColor;
    var() bool bEnableDropShadow;
    var() int TexturePageWidth;
    var() int TexturePageMaxHeight;
    var() int XPadding;
    var() int YPadding;
    var() int ExtendBoxTop;
    var() int ExtendBoxBottom;
    var() int ExtendBoxRight;
    var() int ExtendBoxLeft;
    var() bool bEnableLegacyMode;
    var() int Kerning;
    var() bool bUseDistanceFieldAlpha;
    var() int DistanceFieldScaleFactor;
    var() float DistanceFieldScanRadiusScale;

    structdefaultproperties
    {
        FontName="Arial"
        Height=16.0000000
        bEnableAntialiasing=true
        bEnableBold=false
        bEnableItalic=false
        bEnableUnderline=false
        bAlphaOnly=false
        CharacterSet=EFontImportCharacterSet.FontICS_Default
        Chars=""
        UnicodeRange=""
        CharsFilePath=""
        CharsFileWildcard=""
        bCreatePrintableOnly=false
        bIncludeASCIIRange=true
        ForegroundColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
        bEnableDropShadow=false
        TexturePageWidth=256
        TexturePageMaxHeight=256
        XPadding=1
        YPadding=1
        ExtendBoxTop=0
        ExtendBoxBottom=0
        ExtendBoxRight=0
        ExtendBoxLeft=0
        bEnableLegacyMode=false
        Kerning=0
        bUseDistanceFieldAlpha=false
        DistanceFieldScaleFactor=16
        DistanceFieldScanRadiusScale=1.0000000
    }
};

var() FontImportOptionsData Data;

defaultproperties
{
    Data=(FontName="Arial",Height=16.0000000,bEnableAntialiasing=true,bEnableBold=false,bEnableItalic=false,bEnableUnderline=false,bAlphaOnly=false,CharacterSet=EFontImportCharacterSet.FontICS_Default,Chars="",UnicodeRange="",CharsFilePath="",CharsFileWildcard="",bCreatePrintableOnly=false,bIncludeASCIIRange=true,ForegroundColor=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000),bEnableDropShadow=false,TexturePageWidth=256,TexturePageMaxHeight=256,XPadding=1,YPadding=1,ExtendBoxTop=0,ExtendBoxBottom=0,ExtendBoxRight=0,ExtendBoxLeft=0,bEnableLegacyMode=false,Kerning=0,bUseDistanceFieldAlpha=false,DistanceFieldScaleFactor=16,DistanceFieldScanRadiusScale=1.0000000)
}