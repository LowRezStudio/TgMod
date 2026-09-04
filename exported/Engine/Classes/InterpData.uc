class InterpData extends SequenceVariable
    native(Sequence)
    hidecategories(Object);

struct native AnimSetBakeAndPruneStatus
{
    var() editconst string AnimSetName;
    var() editconst bool bReferencedButUnused;
    var() bool bSkipBakeAndPrune;
    var() bool bSkipCooking;

    structdefaultproperties
    {
        AnimSetName=""
        bReferencedButUnused=false
        bSkipBakeAndPrune=false
        bSkipCooking=false
    }
};

var float InterpLength;
var float PathBuildTime;
var export array<export InterpGroup> InterpGroups;
var export InterpCurveEdSetup CurveEdSetup;
var float EdSectionStart;
var float EdSectionEnd;
var() bool bShouldBakeAndPrune;
var() editfixedsize array<AnimSetBakeAndPruneStatus> BakeAndPruneStatus;
var transient InterpGroupDirector CachedDirectorGroup;

defaultproperties
{
    InterpLength=5.0000000
    EdSectionEnd=1.0000000
    ObjName="Matinee Data"
}