class TgAnimBlendByFall extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object,TgAnimNodeBlendList);

enum EBlendFallTypes
{
    FBT_Up,                         // 0
    FBT_UpLoop,                     // 1
    FBT_Down,                       // 2
    FBT_PreLand,                    // 3
    FBT_Land,                       // 4
    FBT_AirJump,                    // 5
    FBT_None,                       // 6
    FBT_MAX                         // 7
};

enum EFallSource
{
    FALLSOURCE_FullJump,            // 0
    FALLSOURCE_ShortJump,           // 1
    FALLSOURCE_AnyJump,             // 2
    FALLSOURCE_Falling,             // 3
    FALLSOURCE_All,                 // 4
    FALLSOURCE_MAX                  // 5
};

var() TgAnimBlendByFall.EFallSource m_FallSource;
var const TgAnimBlendByFall.EBlendFallTypes FallState;
var Actor.EPhysics m_PreviousTickPhysics;
var const float LastFallingVelocity;
var TgPawn pOwner;
var() float m_fPrelandDistance;
var(Debug) bool m_bDebugMeasureJumpUp;
var(Debug) bool m_bDebugMeasureJumpDownToLand;
var bool m_bMeasuring;
var() bool m_bJumpOnly;
var Vector m_StartMeasureJump;
var float m_fMeasureTime;
var(Landing) float m_fLandingMovementPlayRate;
var(Landing) name m_nmNameLandingSynchGroup;

defaultproperties
{
    m_FallSource=EFallSource.FALLSOURCE_All
    FallState=EBlendFallTypes.FBT_None
    m_fLandingMovementPlayRate=2.0000000
    m_nmNameLandingSynchGroup="LandingSynch"
    PlayActiveChildExceptionList=/* Array type was not detected. */
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}