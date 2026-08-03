class ScriptedTexture extends TextureRenderTarget2D
    native(Texture)
    hidecategories(Object,Texture);

var transient bool bNeedsUpdate;
var transient bool bSkipNextClear;
//var delegate<Render> __Render__Delegate;

delegate Render(Canvas C)
{
    //return;    
}

defaultproperties
{
    bNeedsUpdate=true
    AddressX=TextureAddress.TA_Clamp
    AddressY=TextureAddress.TA_Clamp
    bNeedsTwoCopies=false
}