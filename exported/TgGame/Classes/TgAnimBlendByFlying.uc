class TgAnimBlendByFlying extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EFlyDirTypes
{
    FDir_Forward,                   // 0
    FDir_Back,                      // 1
    FDir_Left,                      // 2
    FDir_Right,                     // 3
    FDir_Up,                        // 4
    FDir_Down,                      // 5
    FDir_UpMidair,                  // 6
    FDir_None,                      // 7
    FDir_MAX                        // 8
};

var(Animations) bool bAdjustRateByVelocity;
var(Animations) bool m_bAdjustRateByAcceleration;
var(Animations) editoronly transient bool m_bPreviewJetpackPerBoneBlend;
var bool m_bIsUsingHandsFreeJetpack;
var(Animations) float m_fUpLoopStartTime;
var const TgAnimBlendByFlying.EFlyDirTypes LastDirection;
var(Animations) name m_nmHandsFreeJetpackPerBoneBlendNodeName;
var AnimNodeBlendPerBone m_HandsFreeJetpackPerBoneBlendNode;
var(Animations) float m_fHandsFreeJetpackBlendBias;
var(Animations) name m_nmHandsFreeJetpackBiasBlendNodeName;
var AnimNodeBlend m_HandsFreeJetpackBiasBlendNode;
var TgPawn m_TgPawn;

defaultproperties
{
    LastDirection=EFlyDirTypes.FDir_None
    Children=/* Array type was not detected. */
}