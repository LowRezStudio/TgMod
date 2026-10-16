class InterpGroupCamera extends InterpGroup
    native(Interpolation)
    collapsecategories
    hidecategories(Object,Object);

struct native CameraPreviewInfo
{
    var() Class<Pawn> PawnClass;
    var() array<AnimSet> PreviewAnimSets;
    var() name AnimSeqName;
    var editconst Vector Location;
    var editconst Rotator Rotation;
    var transient Pawn PawnInst;

    structdefaultproperties
    {
        PawnClass=none
        PreviewAnimSets=none
        AnimSeqName="None"
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Rotation=(Pitch=0,Yaw=0,Roll=0)
        PawnInst=none
    }
};

var transient CameraAnim CameraAnimInst;
var() float CompressTolerance;

defaultproperties
{
    CompressTolerance=5.0000000
}