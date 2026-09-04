class AnimNodeScalePlayRate extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() float ScaleByValue;

defaultproperties
{
    ScaleByValue=1.0000000
    Children[0]=(Name="Input",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    bFixNumChildren=true
}