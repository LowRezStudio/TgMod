class TgAnimNodeBlendByKnockdown extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EKnockDownChildren {
    KNOCKDOWNANIM_Input,  // 0
    KNOCKDOWNANIM_DownState,  // 1
    KNOCKDOWNANIM_GetUp,  // 2
};

var () bool m_bAdjustPlayRateByVelocity;
var () float m_fVelocityMultiplier;
var () float m_PreviewVelocity;
var TgPawn m_TgPawn;
var () name m_FaceDownAnimName;
var () name m_FaceUpAnimName;
var () name m_FaceDownRecoverAnimName;
var () name m_FaceUpRecoverAnimName;

native function SetDownStateAnim(bool bFaceDown);  // Export UTgAnimNodeBlendByKnockdown::execSetDownStateAnim(FFrame&, void* const)

defaultproperties
{
    m_bAdjustPlayRateByVelocity=true
    m_fVelocityMultiplier=0.0050000
    Children=/* Array type was not detected. */
    NodeName="KnockdownBlend"
}
