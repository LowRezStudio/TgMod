class AnimNodeAdditiveBlending extends AnimNodeBlend
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var(Performance) bool bPassThroughWhenNotRendered;

// Export UAnimNodeAdditiveBlending::execSetBlendTarget(FFrame&, void* const)
native function SetBlendTarget(float BlendTarget, float BlendTime);

defaultproperties
{
    bPassThroughWhenNotRendered=true
    Child2Weight=1.0000000
    Child2WeightTarget=1.0000000
    Children[0]=(Name="Base Anim Input",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[1]=(Name="Additive Anim Input",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
}