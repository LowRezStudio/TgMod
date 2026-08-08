class TgAnimNodeAdditiveBlending extends AnimNodeAdditiveBlending
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgPawn);

var () bool m_bSetStrengthFromAnimNode;
var () bool m_bInvertStrengthFromAnimNode;
var transient bool m_bInitializedCachedNodeList;
var () array<name> m_StrengthAnimNodeNameList;
var () array<TgPawn.EEmote> m_StrengthEmoteList;
var transient array<AnimNode> m_CachedNodeList;
var transient array<TgAnimNodeEmoteSequence> m_CachedEmoteSequences;
