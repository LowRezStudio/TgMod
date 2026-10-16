class TgAnimBlendByDirection extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EBlendDirTypes
{
    FBDir_Forward,                  // 0
    FBDir_Back,                     // 1
    FBDir_Left,                     // 2
    FBDir_Right,                    // 3
    FBDir_ForwardRight,             // 4
    FBDir_ForwardLeft,              // 5
    FBDir_BackRight,                // 6
    FBDir_BackLeft,                 // 7
    FBDir_Standing,                 // 8
    FBDir_None,                     // 9
    FBDir_MAX                       // 10
};

enum EBlendByDirectionSpeedType
{
    EBBDST_Velocity,                // 0
    EBBDST_Accel,                   // 1
    EBBDST_MAX                      // 2
};

var TgPawn m_TgPawn;
var(Animations) TgAnimBlendByDirection.EBlendByDirectionSpeedType m_SpeedType;
var const TgAnimBlendByDirection.EBlendDirTypes LastDirection;
var(Animations) bool bAdjustRateByVelocity;
var() bool bNoDirectionIsEnabled;
var() bool bResetLooping;
var() bool m_bDelayBlendOutToPlayAnim;
var bool m_bIsAllowedToBlendOut;
var() bool m_bMirrorDirectionsWhenPawnMirrored;
var() bool m_bStopChildrenOnCeaseRelevant;

defaultproperties
{
    LastDirection=EBlendDirTypes.FBDir_None
    bNoDirectionIsEnabled=true
    bResetLooping=true
    m_bIsAllowedToBlendOut=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}