class TgAnimNodeBlendByAbilityVine extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EBlendVine {
    BLENDVINE_Inactive,  // 0
    BLENDVINE_Throw,  // 1
    BLENDVINE_ThrowLoop,  // 2
    BLENDVINE_Pull,  // 3
    BLENDVINE_HitPostFire,  // 4
    BLENDVINE_MissPostFire,  // 5
};

function VineThrow() { }

function VinePull() { }

function VineHitPost() { }

function VinePost() { }

function VineInactive() { }

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="VineAbilityBlendNode"
}
