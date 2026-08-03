class TgSkelControlSingleBone extends SkelControlSingleBone
    native(Anim)
    hidecategories(Object,Object);

var(Controller) bool SnapStrengthFromAnimNodes;
var(Widescreen) transient bool m_bIsWidescreen;
var(Controller) float SnapStrengthThreshold;
var(Controller) array<TgPawn.EEmote> StrengthEmoteList;
var transient array<TgAnimNodeEmoteSequence> CachedEmoteSequences;
var(Widescreen) Vector m_WidescreenBoneTranslationOffset;
var(Widescreen) Rotator m_WidescreenBoneRotationOffset;
var(Widescreen) float m_WidescreenBoneScaleOffset;
