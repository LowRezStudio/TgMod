class TextureRenderTarget2D extends TextureRenderTarget
    native(Texture)
    hidecategories(Object,Texture);

var() const int SizeX;
var() const int SizeY;
var const Texture.EPixelFormat Format;
var() Texture.TextureAddress AddressX;
var() Texture.TextureAddress AddressY;
var private const LinearColor ClearColor;
var() const transient bool bForceLinearGamma;

// Export UTextureRenderTarget2D::execCreate(FFrame&, void* const)
native static final function TextureRenderTarget2D Create(int InSizeX, int InSizeY, optional Texture.EPixelFormat InFormat = 2, optional LinearColor InClearColor, optional bool bOnlyRenderOnce);

defaultproperties
{
    Format=EPixelFormat.PF_A8R8G8B8
    ClearColor=(R=0.0000000,G=1.0000000,B=0.0000000,A=1.0000000)
}