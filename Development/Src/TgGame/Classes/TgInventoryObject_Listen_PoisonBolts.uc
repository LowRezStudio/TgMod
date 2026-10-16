class TgInventoryObject_Listen_PoisonBolts extends TgInventoryObject_Listen_AbilityProcBase
    native(Inventory)
    config(Engine);

struct PoisonBoltInfo {
    var TgPawn PawnTarget;
    var TgDeployable DeployableTarget;
    var bool bEffectActive;
    structdefaultproperties {}
};

var array<PoisonBoltInfo> m_PoisonBoltTargets;
var const int m_EffectGroupID;

defaultproperties
{
    m_EffectGroupID=55144
}
