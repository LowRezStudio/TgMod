class TgDeviceForm_LongbowInhand extends TgDeviceForm
    native(ChampLongbow)
    config(Engine);

var bool m_bImpalerArrowFXIsActive;
var bool m_bBowDrawing;
var float m_fBowDrawPercentage;
var float m_fBowDrawStartPercentage;
var float m_fBowDrawTime;
var float m_fBowDrawTotalDuration;
var TgPawn_Longbow m_LongbowOwner;
var array<TgAnimBlendByPercent> m_BlendByPct1P;
var array<TgAnimBlendByPercent> m_BlendByPct3P;
var TgSkelControlSingleBone m_ArrowSkelControl1P;
var TgSkelControlSingleBone m_ImpalerSkelControl1P;

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event Generic1(optional byte byExtraData) { }

event DoInterrupt() { }

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive) { }

simulated event SetToggleState(bool IsActive) { }
