class TgAnimNodeBlendByAbilityReversal extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EBlendReversal {
    BLENDREVERSAL_Inactive,  // 0
    BLENDREVERSAL_Buildup,  // 1
    BLENDREVERSAL_Fire,  // 2
    BLENDREVERSAL_Miss,  // 3
};

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="ReversalAbilityBlendNode"
}
