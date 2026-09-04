class TgAnimNodeBlendByAbilitySmash extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EBlendMakoaSmash {
    BLENDSMASH_ChargeUp,  // 0
    BLENDSMASH_Attack,  // 1
};

function BeginChargeUp() { }

function Attack() { }

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="MakoaSmashBlendNode"
}
