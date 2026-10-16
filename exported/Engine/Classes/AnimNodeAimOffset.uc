class AnimNodeAimOffset extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EAnimAimDir
{
    ANIMAIM_LEFTUP,                 // 0
    ANIMAIM_CENTERUP,               // 1
    ANIMAIM_RIGHTUP,                // 2
    ANIMAIM_LEFTCENTER,             // 3
    ANIMAIM_CENTERCENTER,           // 4
    ANIMAIM_RIGHTCENTER,            // 5
    ANIMAIM_LEFTDOWN,               // 6
    ANIMAIM_CENTERDOWN,             // 7
    ANIMAIM_RIGHTDOWN,              // 8
    ANIMAIM_MAX                     // 9
};

enum EAimID
{
    EAID_LeftUp,                    // 0
    EAID_LeftDown,                  // 1
    EAID_RightUp,                   // 2
    EAID_RightDown,                 // 3
    EAID_ZeroUp,                    // 4
    EAID_ZeroDown,                  // 5
    EAID_ZeroLeft,                  // 6
    EAID_ZeroRight,                 // 7
    EAID_CellLU,                    // 8
    EAID_CellCU,                    // 9
    EAID_CellRU,                    // 10
    EAID_CellLC,                    // 11
    EAID_CellCC,                    // 12
    EAID_CellRC,                    // 13
    EAID_CellLD,                    // 14
    EAID_CellCD,                    // 15
    EAID_CellRD,                    // 16
    EAID_MAX                        // 17
};

struct native atomicwhencooked immutablewhencooked AimTransform
{
    var() Quat Quaternion;
    var() Vector Translation;

    structdefaultproperties
    {
        Quaternion=(X=0.0000000,Y=0.0000000,Z=0.0000000,W=0.0000000)
        Translation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct native atomicwhencooked immutablewhencooked AimComponent
{
    var() name BoneName;
    var() AimTransform LU;
    var() AimTransform LC;
    var() AimTransform LD;
    var() AimTransform CU;
    var() AimTransform CC;
    var() AimTransform CD;
    var() AimTransform RU;
    var() AimTransform RC;
    var() AimTransform RD;

    structdefaultproperties
    {
        BoneName="None"
        LU=/* ERROR: System.ArgumentException */
        LC=/* ERROR: System.ArgumentException */
        LD=/* ERROR: System.ArgumentException */
        CU=/* ERROR: System.ArgumentException */
        CC=/* ERROR: System.ArgumentException */
        CD=/* ERROR: System.ArgumentException */
        RU=/* ERROR: System.ArgumentException */
        RC=/* ERROR: System.ArgumentException */
        RD=/* ERROR: System.IO.EndOfStreamException */
    }
};

struct native atomicwhencooked immutablewhencooked AimOffsetProfile
{
    var() const editconst name ProfileName;
    var() Vector2D HorizontalRange;
    var() Vector2D VerticalRange;
    var array<AimComponent> AimComponents;
    var() name AnimName_LU;
    var() name AnimName_LC;
    var() name AnimName_LD;
    var() name AnimName_CU;
    var() name AnimName_CC;
    var() name AnimName_CD;
    var() name AnimName_RU;
    var() name AnimName_RC;
    var() name AnimName_RD;

    structdefaultproperties
    {
        ProfileName="Default"
        HorizontalRange=(X=-1.0000000,Y=1.0000000)
        VerticalRange=(X=-1.0000000,Y=1.0000000)
        AimComponents=none
        AnimName_LU="None"
        AnimName_LC="None"
        AnimName_LD="None"
        AnimName_CU="None"
        AnimName_CC="None"
        AnimName_CD="None"
        AnimName_RU="None"
        AnimName_RC="None"
        AnimName_RD="None"
    }
};

var() Vector2D Aim;
var() Vector2D AngleOffset;
var() bool bForceAimDir;
var() bool bBakeFromAnimations;
var(Performance) bool bPassThroughWhenNotRendered;
var(Editor) bool bSynchronizeNodesInEditor;
var(Performance) int PassThroughAtOrAboveLOD;
var() AnimNodeAimOffset.EAnimAimDir ForcedAimDir;
var transient array<byte> RequiredBones;
var transient array<byte> AimCpntIndexLUT;
var transient AnimNodeAimOffset TemplateNode;
var() editfixedsize array<AimOffsetProfile> Profiles;
var() const editconst int CurrentProfileIndex;

// Export UAnimNodeAimOffset::execSetActiveProfileByName(FFrame&, void* const)
native function SetActiveProfileByName(name ProfileName);

// Export UAnimNodeAimOffset::execSetActiveProfileByIndex(FFrame&, void* const)
native function SetActiveProfileByIndex(int ProfileIndex);

defaultproperties
{
    bSynchronizeNodesInEditor=true
    PassThroughAtOrAboveLOD=1000
    ForcedAimDir=EAnimAimDir.ANIMAIM_CENTERCENTER
    Children[0]=(Name="Input",Anim=none,Weight=1.0000000,BlendWeight=0.0000000,bMirrorSkeleton=false,bIsAdditive=false)
    bFixNumChildren=true
}