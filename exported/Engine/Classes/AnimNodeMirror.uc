class AnimNodeMirror extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() bool bEnableMirroring;

defaultproperties
{
    bEnableMirroring=true
    Children[0]=(Name="Child",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    bFixNumChildren=true
}