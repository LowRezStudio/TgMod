class TextureRenderTarget extends Texture
    abstract
    native(Texture);

var transient bool bUpdateImmediate;
var() bool bNeedsTwoCopies;
var() bool bRenderOnce;
var() float TargetGamma;

defaultproperties
{
    bNeedsTwoCopies=true
    CompressionNone=true
    NeverStream=true
    LODGroup=TextureGroup.TEXTUREGROUP_RenderTarget
}