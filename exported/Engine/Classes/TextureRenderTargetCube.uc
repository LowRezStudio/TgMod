class TextureRenderTargetCube extends TextureRenderTarget
    native(Texture)
    hidecategories(Object,Texture);

var() int SizeX;
var const Texture.EPixelFormat Format;

defaultproperties
{
    Format=EPixelFormat.PF_A8R8G8B8
}