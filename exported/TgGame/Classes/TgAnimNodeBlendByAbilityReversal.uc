class TgAnimNodeBlendByAbilityReversal extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EBlendReversal
{
    BLENDREVERSAL_Inactive,         // 0
    BLENDREVERSAL_Buildup,          // 1
    BLENDREVERSAL_Fire,             // 2
    BLENDREVERSAL_Miss,             // 3
    BLENDREVERSAL_MAX               // 4
};

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="ReversalAbilityBlendNode"
}