class DistributionVectorUniformCurve extends DistributionVector
    native
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() InterpCurveTwoVectors ConstantCurve;
var bool bLockAxes1;
var bool bLockAxes2;
var() bool bUseExtremes;
var() DistributionVector.EDistributionVectorLockFlags LockedAxes[2];
var() DistributionVector.EDistributionVectorMirrorFlags MirrorFlags[3];

defaultproperties
{
    MirrorFlags[0]=EDistributionVectorMirrorFlags.EDVMF_Different
    MirrorFlags[1]=EDistributionVectorMirrorFlags.EDVMF_Different
    MirrorFlags[2]=EDistributionVectorMirrorFlags.EDVMF_Different
}