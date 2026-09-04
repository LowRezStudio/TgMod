class TgAnimNodeBlendByAbilityDragonSlam extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object);

enum EBlendDragonSlam
{
    BLENDDRAGON_ReadyFlightFromGound,// 0
    BLENDDRAGON_ReadyFlightFromAir, // 1
    BLENDDRAGON_Flying,             // 2
    BLENDDRAGON_Punch,              // 3
    BLENDDRAGON_EndFlight,          // 4
    BLENDDRAGON_MAX                 // 5
};

function ReadyFlightFromGround()
{
    SetActiveChild(0, GetBlendTime(0));
    //return;    
}

function ReadyFlightFromAir()
{
    SetActiveChild(1, GetBlendTime(1));
    //return;    
}

function Fly()
{
    SetActiveChild(2, GetBlendTime(2));
    //return;    
}

function HitTarget()
{
    SetActiveChild(3, GetBlendTime(3));
    //return;    
}

function EndFlying()
{
    SetActiveChild(4, GetBlendTime(4));
    //return;    
}

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="DragonSlamAbilityBlendNode"
}