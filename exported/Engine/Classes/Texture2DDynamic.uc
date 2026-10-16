class Texture2DDynamic extends Texture
    native(Texture)
    hidecategories(Object);

var native transient int SizeX;
var native transient int SizeY;
var native transient Texture.EPixelFormat Format;
var native transient int NumMips;
var native transient bool bIsResolveTarget;

// Export UTexture2DDynamic::execInit(FFrame&, void* const)
native final function Init(int InSizeX, int InSizeY, optional Texture.EPixelFormat InFormat = 2, optional bool InIsResolveTarget = false);

// Export UTexture2DDynamic::execUpdateMip(FFrame&, void* const)
native function UpdateMip(int MipIdx, const out array<byte> MipData);

// Export UTexture2DDynamic::execUpdateMipFromJPEG(FFrame&, void* const)
native function UpdateMipFromJPEG(int MipIdx, const out array<byte> MipData);

// Export UTexture2DDynamic::execUpdateMipFromPNG(FFrame&, void* const)
native function UpdateMipFromPNG(int MipIdx, const out array<byte> MipData);

// Export UTexture2DDynamic::execCreate(FFrame&, void* const)
native static final function Texture2DDynamic Create(int InSizeX, int InSizeY, optional Texture.EPixelFormat InFormat = 2, optional bool InIsResolveTarget = false);

defaultproperties
{
    NeverStream=true
}