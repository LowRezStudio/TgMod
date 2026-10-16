class TgDeploy_ShieldMakoa extends TgDeploy_Shield
    native(ChampMakoa)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var TgPawn m_CachedPawnOwner;
var repnotify int r_nCarapaceBonusHealth;
var bool r_bHasBarrierReef;
var int m_nBarrierReefDamage;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bHasBarrierReef, r_nCarapaceBonusHealth;
}

native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);  // Export UTgDeploy_ShieldMakoa::execMitigateHealthDamage(FFrame&, void* const)

defaultproperties
{}
