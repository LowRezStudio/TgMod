class TgAnimNodeBlendByAbilityDrag extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EBlendDrag {
    BLENDDRAG_Inactive,  // 0
    BLENDDRAG_Throw,  // 1
    BLENDDRAG_Hit,  // 2
    BLENDDRAG_PrePullLoop,  // 3
    BLENDDRAG_Pull,  // 4
    BLENDDRAG_PullLoop,  // 5
    BLENDDRAG_EndPull,  // 6
    BLENDDRAG_MissThrow,  // 7
    BLENDDRAG_MissThrowEnd,  // 8
    BLENDDRAG_MissInvalid,  // 9
    BLENDDRAG_MissInvalidEnd,  // 10
    BLENDDRAG_CloseRangeEnd,  // 11
};

function ThrowHook() { }

function HookHit() { }

function HookPull() { }

function HookEnd() { }

function HookMissNotHit() { }

function HookEndMissNoHit() { }

function HookMissInvalid() { }

function HookEndMissInvalid() { }

function HookCloseRangeEnd() { }

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="DragAbilityBlendNode"
}
