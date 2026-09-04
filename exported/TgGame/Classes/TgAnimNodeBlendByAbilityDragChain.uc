class TgAnimNodeBlendByAbilityDragChain extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object);

enum EBlendDrag
{
    BLENDCHAIN_Inactive,            // 0
    BLENDCHAIN_Throw,               // 1
    BLENDCHAIN_Hit,                 // 2
    BLENDCHAIN_MissThrow,           // 3
    BLENDCHAIN_MissInvalid,         // 4
    BLENDCHAIN_MAX                  // 5
};

function ChainThrow()
{
    SetActiveChild(1, GetBlendTime(1));
    //return;    
}

function ChainHit()
{
    SetActiveChild(2, GetBlendTime(2));
    //return;    
}

function ChainMiss()
{
    SetActiveChild(3, GetBlendTime(3));
    //return;    
}

function ChainInvalid()
{
    SetActiveChild(4, GetBlendTime(4));
    //return;    
}

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="DragChainAbilityBlendNode"
}