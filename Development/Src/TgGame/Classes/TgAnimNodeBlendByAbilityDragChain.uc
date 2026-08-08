class TgAnimNodeBlendByAbilityDragChain extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EBlendDrag {
    BLENDCHAIN_Inactive,  // 0
    BLENDCHAIN_Throw,  // 1
    BLENDCHAIN_Hit,  // 2
    BLENDCHAIN_MissThrow,  // 3
    BLENDCHAIN_MissInvalid,  // 4
};

function ChainThrow() { }

function ChainHit() { }

function ChainMiss() { }

function ChainInvalid() { }

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="DragChainAbilityBlendNode"
}
