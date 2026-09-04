class SwfMovie extends GFxRawData
    native
    editinlinenew
    hidecategories(Object)
    autoexpandcategories(Import);

enum FlashTextureRescale
{
    FlashTextureScale_High,         // 0
    FlashTextureScale_Low,          // 1
    FlashTextureScale_NextLow,      // 2
    FlashTextureScale_Mult4,        // 3
    FlashTextureScale_None,         // 4
    FlashTextureScale_MAX           // 5
};

var() bool bUsesFontlib;
var(Import) editconst bool bSetSRGBOnImportedTextures;
var(Import) bool bPackTextures;
var(Import) bool bForceSquarePacking;
var(Import) int PackTextureSize;
var(Import) SwfMovie.FlashTextureRescale TextureRescale;
var(Import) editconst string TextureFormat;
var int RTTextures;
var int RTVideoTextures;

defaultproperties
{
    TextureRescale=FlashTextureRescale.FlashTextureScale_Mult4
    RTTextures=24
    RTVideoTextures=2
}