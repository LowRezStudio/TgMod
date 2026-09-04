class TgAnimNodeBlendByAbilityDrag extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EBlendDrag
{
    BLENDDRAG_Inactive,             // 0
    BLENDDRAG_Throw,                // 1
    BLENDDRAG_Hit,                  // 2
    BLENDDRAG_PrePullLoop,          // 3
    BLENDDRAG_Pull,                 // 4
    BLENDDRAG_PullLoop,             // 5
    BLENDDRAG_EndPull,              // 6
    BLENDDRAG_MissThrow,            // 7
    BLENDDRAG_MissThrowEnd,         // 8
    BLENDDRAG_MissInvalid,          // 9
    BLENDDRAG_MissInvalidEnd,       // 10
    BLENDDRAG_CloseRangeEnd,        // 11
    BLENDDRAG_MAX                   // 12
};

function ThrowHook()
{
    SetActiveChild(1, GetBlendTime(1));
    //return;    
}

function HookHit()
{
    SetActiveChild(2, GetBlendTime(2));
    //return;    
}

function HookPull()
{
    SetActiveChild(4, GetBlendTime(4));
    //return;    
}

function HookEnd()
{
    SetActiveChild(6, GetBlendTime(6));
    //return;    
}

function HookMissNotHit()
{
    SetActiveChild(7, GetBlendTime(7));
    //return;    
}

function HookEndMissNoHit()
{
    SetActiveChild(8, GetBlendTime(8));
    //return;    
}

function HookMissInvalid()
{
    SetActiveChild(9, GetBlendTime(9));
    //return;    
}

function HookEndMissInvalid()
{
    SetActiveChild(10, GetBlendTime(10));
    //return;    
}

function HookCloseRangeEnd()
{
    SetActiveChild(11, GetBlendTime(11));
    //return;    
}

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="DragAbilityBlendNode"
}