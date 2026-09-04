class TgAnimNodeBlendByAbilitySmash extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object);

enum EBlendMakoaSmash
{
    BLENDSMASH_ChargeUp,            // 0
    BLENDSMASH_Attack,              // 1
    BLENDSMASH_MAX                  // 2
};

function BeginChargeUp()
{
    SetActiveChild(0, GetBlendTime(0));
    //return;    
}

function Attack()
{
    SetActiveChild(1, GetBlendTime(1));
    //return;    
}

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="MakoaSmashBlendNode"
}