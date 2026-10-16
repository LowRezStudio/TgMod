class TgAnimNodeBlendByKnockdown extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EKnockDownChildren
{
    KNOCKDOWNANIM_Input,            // 0
    KNOCKDOWNANIM_DownState,        // 1
    KNOCKDOWNANIM_GetUp,            // 2
    KNOCKDOWNANIM_MAX               // 3
};

var() bool m_bAdjustPlayRateByVelocity;
var() float m_fVelocityMultiplier;
var() float m_PreviewVelocity;
var TgPawn m_TgPawn;
var() name m_FaceDownAnimName;
var() name m_FaceUpAnimName;
var() name m_FaceDownRecoverAnimName;
var() name m_FaceUpRecoverAnimName;

// Export UTgAnimNodeBlendByKnockdown::execSetDownStateAnim(FFrame&, void* const)
native function SetDownStateAnim(bool bFaceDown);

defaultproperties
{
    m_bAdjustPlayRateByVelocity=true
    m_fVelocityMultiplier=0.0050000
    Children=/* Array type was not detected. */
    NodeName="KnockdownBlend"
}