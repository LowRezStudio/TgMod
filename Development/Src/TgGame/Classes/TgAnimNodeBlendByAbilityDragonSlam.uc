class TgAnimNodeBlendByAbilityDragonSlam extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum EBlendDragonSlam {
    BLENDDRAGON_ReadyFlightFromGound,  // 0
    BLENDDRAGON_ReadyFlightFromAir,  // 1
    BLENDDRAGON_Flying,  // 2
    BLENDDRAGON_Punch,  // 3
    BLENDDRAGON_EndFlight,  // 4
};

function ReadyFlightFromGround() { }

function ReadyFlightFromAir() { }

function Fly() { }

function HitTarget() { }

function EndFlying() { }

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="DragonSlamAbilityBlendNode"
}
