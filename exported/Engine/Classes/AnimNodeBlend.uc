class AnimNodeBlend extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var float Child2Weight;
var float Child2WeightTarget;
var float BlendTimeToGo;
var() bool bSkipBlendWhenNotRendered;

// Export UAnimNodeBlend::execSetBlendTarget(FFrame&, void* const)
native function SetBlendTarget(float BlendTarget, float BlendTime);

defaultproperties
{
    bSkipBlendWhenNotRendered=true
    Children[0]=(Name="Child1",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[1]=(Name="Child2",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    bFixNumChildren=true
}