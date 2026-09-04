class DistributionVectorUniform extends DistributionVector
    native
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() Vector Max;
var() Vector Min;
var bool bLockAxes;
var() bool bUseExtremes;
var() DistributionVector.EDistributionVectorLockFlags LockedAxes;
var() DistributionVector.EDistributionVectorMirrorFlags MirrorFlags[3];

defaultproperties
{
    MirrorFlags[0]=EDistributionVectorMirrorFlags.EDVMF_Different
    MirrorFlags[1]=EDistributionVectorMirrorFlags.EDVMF_Different
    MirrorFlags[2]=EDistributionVectorMirrorFlags.EDVMF_Different
}