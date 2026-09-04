class TgDeploy_HealthNugget_TeamOnly extends TgDeploy_HealthNugget
    native(Deployable)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var int r_nTaskForceAlignment;
var float m_fNuggetSpawnTime;
var float m_fNuggetGracePeriod;

replication {
    if(bNetInitial && int(Role) == int(ENetRole.ROLE_Authority)) r_nTaskForceAlignment;
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

defaultproperties
{}
