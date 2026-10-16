class TgInventoryObject_Listen_DeployOnAbility extends TgInventoryObject_Listen_AbilityProcBase
    native(Inventory)
    config(Engine);

enum EDeployOnAbilityType {
    DEPLOYON_STARTFIRE,  // 0
    DEPLOYON_FIRE,  // 1
    DEPLOYON_STOPFIRE,  // 2
};

var const TgInventoryObject_Listen_DeployOnAbility.EDeployOnAbilityType m_eDeployType;

defaultproperties
{
    m_eDeployType=DEPLOYON_FIRE
}
