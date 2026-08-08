class TgAnimBlendPerBone extends AnimNodeBlendPerBone
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgPawn);

var () bool m_bLoopSourceChild;
var () bool m_bLoopTargetChild;
var () bool m_bPlaySourceChild;
var () bool m_bPlayTargetChild;
var () bool m_bSetStrengthFromAnimNode;
var () bool m_bInvertStrengthFromAnimNode;
var transient bool m_bInitializedCachedNodeList;
var () array<name> m_StrengthAnimNodeNameList;
var () array<TgPawn.EEmote> m_StrengthEmoteList;
var transient array<AnimNode> m_CachedNodeList;
var transient array<TgAnimNodeEmoteSequence> m_CachedEmoteSequences;

native function PlayAnim(optional bool bLoop=false, optional float Rate=1.0000000, optional float StartTime=0.0000000);  // Export UTgAnimBlendPerBone::execPlayAnim(FFrame&, void* const)

defaultproperties
{
    BlendType=ABT_Sinusoidal
}
