class Texture2DComposite extends Texture
    native(Texture)
    hidecategories(Object);

struct native SourceTexture2DRegion
{
    var int OffsetX;
    var int OffsetY;
    var int SizeX;
    var int SizeY;
    var int DestOffsetX;
    var int DestOffsetY;
    var Texture2D Texture2D;

    structdefaultproperties
    {
        OffsetX=0
        OffsetY=0
        SizeX=0
        SizeY=0
        DestOffsetX=0
        DestOffsetY=0
        Texture2D=none
    }
};

var array<SourceTexture2DRegion> SourceRegions;
var int MaxTextureSize;
var int DestSizeX;
var int DestSizeY;

// Export UTexture2DComposite::execSourceTexturesFullyStreamedIn(FFrame&, void* const)
native final function bool SourceTexturesFullyStreamedIn();

// Export UTexture2DComposite::execUpdateCompositeTexture(FFrame&, void* const)
native final function UpdateCompositeTexture(int NumMipsToGenerate);

// Export UTexture2DComposite::execResetSourceRegions(FFrame&, void* const)
native final function ResetSourceRegions();

defaultproperties
{
    NeverStream=true
}