class AnimNodeBlendPerBone extends AnimNodeBlend
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() const bool bForceLocalSpaceBlend;
var() array<name> BranchStartBoneName;
var array<float> Child2PerBoneWeight;
var array<byte> LocalToCompReqBones;

// Export UAnimNodeBlendPerBone::execSetBlendTarget(FFrame&, void* const)
native function SetBlendTarget(float BlendTarget, float BlendTime);

defaultproperties
{
    Children[0]=(Name="Source",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    Children[1]=(Name="Target",Anim=none,Weight=0.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
}